From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] show-branch: show all local heads when only giving one
 rev along --topics
Date: Tue, 17 Mar 2015 08:50:48 +0900
Message-ID: <20150316235048.GA23824@glandium.org>
References: <1426495086-31507-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 17 00:51:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXemm-0002ZQ-4k
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 00:51:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314AbbCPXu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 19:50:59 -0400
Received: from ks3293202.kimsufi.com ([5.135.186.141]:35788 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754084AbbCPXu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 19:50:57 -0400
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YXemW-00074d-UQ; Tue, 17 Mar 2015 08:50:48 +0900
Content-Disposition: inline
In-Reply-To: <1426495086-31507-1-git-send-email-mh@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265600>

On Mon, Mar 16, 2015 at 05:38:06PM +0900, Mike Hommey wrote:
> "git show-branch --topics <rev> <revs>..." displays ancestry graph, only
> considering commits that are in all given revs, except the first one.
> 
> "git show-branch" displays ancestry graph for all local branches.
> 
> Unfortunately, "git show-branch --topics <rev>" only prints out the rev
> info for the given rev, and nothing else, e.g.:
> 
>   $ git show-branch --topics origin/master
>   [origin/master] Sync with 2.3.3
> 
> While there is an option to add all remote-tracking branches (-r), and
> another to add all local+remote branches (-a), there is no option to add
> only local branches. Adding such an option could be considered, but a
> user would likely already expect that the above command line considers
> the lack of rev other than for --topics as meaning all local branches,
> like when there is no argument at all.
> 
> Moreover, when using -r and -a along with --topics, the first local or
> remote-tracking branch, depending on alphabetic order is used instead of
> the one given after --topics (any rev given on the command line is
> actually simply ignored when either -r or -a is given). And if no rev is
> given at all, the fact that the first alphetical branch is the base of
> topics is probably not expected by users (Maybe --topics should always
> require one rev on the command line?)
> 
> This change makes
>   "show-branch --topics $rev"
> act as
>   "show-branch --topics $rev $(git for-each-ref refs/heads
>                                --format='%(refname:short)')"
> 
>   "show-branch -r --topics $rev ..."
> act as
>   "show-branch --topics $rev ... $(git for-each-ref refs/remotes
>                                    --format='%(refname:short)')"
> instead of
>   "show-branch --topics $(git for-each-ref refs/remotes
>                           --format='%(refname:short)')"
> 
> and
>   "show-branch -a --topics $rev ..."
> act as
>   "show-branch --topics $rev ... $(git for-each-ref refs/heads refs/remotes
>                                    --format='%(refname:short)')"
> instead of
>   "show-branch --topics $(git for-each-ref refs/heads refs/remotes
>                           --format='%(refname:short)')"

Sorry, this was missing:
Signed-off-by: Mike Hommey <mh@glandium.org>

Mike
