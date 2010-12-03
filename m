From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: BUG: git pull --rebase on detatched head prints a lot of usage warnings
Date: Fri, 3 Dec 2010 21:23:54 +0100
Message-ID: <AANLkTikwdqQpmyxZu-kp7UHjYnKuVxs8urxM=9c=66H0@mail.gmail.com>
References: <AANLkTimyCG6zVhc4znWPWwipd0bn-YT2FrOT=T0AgHNW@mail.gmail.com>
 <20101203190050.GB14049@burratino> <AANLkTin-9pb7cxsAvDqWj3So47_zq5co9TZRWux9ezxz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 21:24:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POcB3-0003Zj-Ms
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 21:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448Ab0LCUYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 15:24:16 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:38006 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753205Ab0LCUYP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 15:24:15 -0500
Received: by qyk11 with SMTP id 11so1269315qyk.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 12:24:15 -0800 (PST)
Received: by 10.229.82.70 with SMTP id a6mr1690587qcl.9.1291407854998; Fri, 03
 Dec 2010 12:24:14 -0800 (PST)
Received: by 10.229.59.42 with HTTP; Fri, 3 Dec 2010 12:23:54 -0800 (PST)
In-Reply-To: <AANLkTin-9pb7cxsAvDqWj3So47_zq5co9TZRWux9ezxz@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162844>

On Fri, Dec 3, 2010 at 8:05 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
>
> On Fri, Dec 3, 2010 at 20:00, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Does the following take care of it?
>
> Yes.

I also think it fixes, but I wonder if it's the best fix. One thing is
that show-branch is an ancillary command, and not a plumbing command
(but there is already a call to show-branch, but it should probably be
change to merge-base now that it handles three commit as arguments).

The problem is that many parts of git-pull.sh/git-parse-remote.sh
assume that you are not in a detached HEAD. Can you confirm that the
following patch fixes it?

diff --git i/git-parse-remote.sh w/git-parse-remote.sh
index 5f47b18..6d0a5de 100644
--- i/git-parse-remote.sh
+++ w/git-parse-remote.sh
@@ -68,7 +68,7 @@ get_remote_merge_branch () {
            test -z "$origin" && origin=$default
            curr_branch=$(git symbolic-ref -q HEAD)
            [ "$origin" = "$default" ] &&
-           echo $(git for-each-ref --format='%(upstream)' $curr_branch)
+           echo $(git for-each-ref --format='%(upstream)' HEAD)
            ;;
        *)
            repo=$1

I'm wondering if most of $curr_branch should be changed to HEAD, I'll check it.

HTH,
Santi
