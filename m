From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] show-branch --upstream: add upstream branches to the
 list of branches to display
Date: Tue, 13 Jan 2015 10:33:49 +0900
Message-ID: <20150113013349.GA26587@glandium.org>
References: <1420708657-20811-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 02:34:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAqMs-0004TH-W1
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 02:34:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbbAMBd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2015 20:33:59 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:44767 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850AbbAMBd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2015 20:33:58 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YAqMf-0007Eq-UP; Tue, 13 Jan 2015 10:33:49 +0900
Content-Disposition: inline
In-Reply-To: <1420708657-20811-1-git-send-email-mh@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262314>

On Thu, Jan 08, 2015 at 06:17:37PM +0900, Mike Hommey wrote:
> `git show-branch --upstream` is equivalent to `git show-branch
> $(git for-each-ref refs/heads --format '%(refname:short)')
> $(git for-each-ref refs/heads --format '%(upstream:short)')`
> 
> `git show-branch --upstream foo bar` is equivalent to `git show-branch
> foo bar $(git for-each-ref refs/heads/foo refs/heads/bar
> --format '%(upstream:short)')`
> 
> Combined with --topics, it shows commits that are NOT on any of
> the upstream branches.
> 
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
> 
> Note that in the --topics --upstream case, when there are different
> upstreams branches involved, only the merge-base of all of them is
> shown. I'm not sure if it's desirable to show more. The output as it
> is works for my own use cases.

Some example output (where inbound/default and b2g-inbound/default are two
different upstream repositories):
$ git show-branch --upstream HEAD
! [HEAD] Bug 1120680 - try: -b do -p emulator,emulator-jb,emulator-kk -t none -u none
 ! [b2g-inbound/default] Bumping manifests a=b2g-bump
--
+  [HEAD] Bug 1120680 - try: -b do -p emulator,emulator-jb,emulator-kk -t none -u none
 + [b2g-inbound/default] Bumping manifests a=b2g-bump
 + [b2g-inbound/default^] Backed out changeset ffdc6e420153 (bug 1107009) for Android crashes/asserts.
 + [b2g-inbound/default~2] Bumping manifests a=b2g-bump
-- [HEAD^] Merge m-c to b2g-inbound. a=merge

$ git show-branch --upstream --topics HEAD
! [HEAD] Bug 1120680 - try: -b do -p emulator,emulator-jb,emulator-kk -t none -u none
 ! [b2g-inbound/default] Bumping manifests a=b2g-bump
--
+  [HEAD] Bug 1120680 - try: -b do -p emulator,emulator-jb,emulator-kk -t none -u none
-- [HEAD^] Merge m-c to b2g-inbound. a=merge

$ git show-branch --upstream --topics
! [bug1107677] Bug 1107677 - Enable chunk recycling for 128 chunks in jemalloc3
 ! [bug1110760] Bug 1110760 - Followup to avoid build failure with Windows SDK v7.0 and v7.0A
  ! [bug1120272] Bug 1120272 - wip
   * [bug1120680] Bug 1120680 - try: -b do -p emulator,emulator-jb,emulator-kk -t none -u none
    ! [inbound/default] Bug 762449 - Enable jemalloc 3 by default, but don' make it ride the trains yet. r=njn
     ! [b2g-inbound/default] Bumping manifests a=b2g-bump
------
   *   [bug1120680] Bug 1120680 - try: -b do -p emulator,emulator-jb,emulator-kk -t none -u none
  +    [bug1120272] Bug 1120272 - wip
 +     [bug1110760] Bug 1110760 - Followup to avoid build failure with Windows SDK v7.0 and v7.0A
+      [bug1107677] Bug 1107677 - Enable chunk recycling for 128 chunks in jemalloc3
+      [bug1107677^] Bug 1107677 - Port relevant parts from bug 1073662 part 6
+      [bug1107677~2] Bug 1107677 - Port the relevant parts from bug 1073662 part 5
+++*++ [bug1110760~183] Bug 1118950 - Fix mistyped DEBUG condition in GlobalHelperThreadState(). r=bhackett.

Mike
