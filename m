From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [ANNOUNCE] GIT 1.5.5.1
Date: Mon, 21 Apr 2008 19:23:10 -0500
Message-ID: <480D2FEE.3010904@nrlssc.navy.mil>
References: <7vej8yako4.fsf@gitster.siamese.dyndns.org> <20080421235610.GB2631@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 02:24:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jo6Is-0005kl-G8
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 02:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757606AbYDVAXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 20:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756896AbYDVAXW
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 20:23:22 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:43614 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756545AbYDVAXV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 20:23:21 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m3M0NBax022751;
	Mon, 21 Apr 2008 19:23:11 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 21 Apr 2008 19:23:11 -0500
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <20080421235610.GB2631@dpotapov.dyndns.org>
X-OriginalArrivalTime: 22 Apr 2008 00:23:11.0681 (UTC) FILETIME=[0C3C6B10:01C8A40F]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15862003
X-TM-AS-Result: : Yes--7.937000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtMTA2NDIwLTcwNTEwMi03MDMzOTMtNzAwNzU2LTcwMTYxOS03?=
	=?us-ascii?B?MDkyOTEtNzAxNjE4LTcwMzQ2OC03MDA2OTMtNzA0OTI3LTcwODU1?=
	=?us-ascii?B?OC03MDI5MjAtNzAyNzM3LTcwNDQxMC03MDcxMTktMTg4MDE5LTE4?=
	=?us-ascii?B?ODE5OC03MDA4NDktNzAyMzU4LTcwMTQ1NS03MTE0MzItNzAyMDIw?=
	=?us-ascii?B?LTcxMTk1My03MDQ0OTYtNzA2MjQ5LTcwNjE1MC03MDc0NTEtNzA2?=
	=?us-ascii?B?NzM3LTcwNDA0OS0xMDU3MDAtNzAxNzE5LTcwNTU4NC03MDkxMzct?=
	=?us-ascii?B?NzAwNDgxLTcwNzIyNS03MDE0NTAtNzA4MzI4LTcwNzMyNS0xNDgw?=
	=?us-ascii?B?MzktMTQ4MDUxLTIwMDQy?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80048>

Dmitry Potapov wrote:

> Johannes' patch removed this option, which IMHO was a significant user
> interface improvement.

Unless I missed something, this option has not been removed. The original
purpose for its existence (which was to cause git-gc to call git-prune)
has been removed. The call to git-prune within git-gc will remove _loose_
unreferenced objects, but _packed_ unreferenced objects are removed by
repack. The --prune option to git-gc is still used to adjust the call to
git-repack so that packed unreferenced objects are discarded.

> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index 9758243..c1bf814 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -65,10 +65,12 @@ OPTIONS
>  +
>  *NOTE*: this is a possibly dangerous operation; do *not* use
>  it unless you understand what it does. If you clone your
> -repository using this option, then delete branches in the
> -source repository and then run linkgit:git-gc[1] using the
> -'--prune' option in the source repository, it may remove
> -objects which are referenced by the cloned repository.
> +repository using this option and then delete a branch or use
> +any other git command that makes any previous existing commit
> +unreachable, then after some time linkgit:git-gc[1] may remove
> +unreachable objects, and this will break the cloned repository.
> +Because some git commands may run git-gc, it may happen at any
> +time after gc.pruneExpire time since commits became unreachable.

I agree that something should be said here about shared repositories,
but I think this wording is a little complicated (disclosure: I also
submitted some text for this a few weeks ago :). Of course something
is better than nothing.

Here's the blurb I submitted if you're interested:
+repository using this option and then delete branches in the
+source repository, some objects may become unreferenced (or dangling).
+These objects may be removed by normal git operations (such as git-commit[1])
+which automatically call git-gc[1]. If these objects are removed and
+were referenced by the cloned repository, then the cloned repository
+will become corrupt.

-brandon
