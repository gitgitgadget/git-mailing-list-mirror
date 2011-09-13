From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC/PATCH] t9159-*.sh: Don't use the svn '@<rev>' syntax
Date: Tue, 13 Sep 2011 07:57:26 +0000
Message-ID: <20110913075726.GA15066@dcvr.yhbt.net>
References: <4E21D295.7020600@ramsay1.demon.co.uk>
 <7vvcuy82kn.fsf@alter.siamese.dyndns.org>
 <4E269AB6.8070207@drmicha.warpmail.net>
 <4E27098B.906@vilain.net>
 <4E6BA0FA.9070103@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>, mhagger@alum.mit.edu
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Sep 13 09:57:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3Ns8-0000VG-Tu
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 09:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755308Ab1IMH52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 03:57:28 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34917 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755188Ab1IMH51 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 03:57:27 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC1CF1F432;
	Tue, 13 Sep 2011 07:57:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4E6BA0FA.9070103@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181272>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> wrote:
> Hmm, I was hoping that someone would say something like:
> 
>    "This test does not depend on the difference between the peg revision
> and the operative revision, because the history represented in the test
> repo is so simple that there *is* no difference, so Acked By: ... "

Unfortunately, I remain perpetually confused w.r.t peg revisions vs "-r"
and how it's handled differently between different SVN versions.

> But, since that didn't happen, maybe the patch given below would be more
> acceptable? (I personally prefer the original patch ...)

I'm much more comfortable with your below patch as it won't break
on newer (and increasingly more widely-used) versions.

> Given that I didn't quite follow Sam's explanation, I still don't know
> if t9104-git-svn-follow-parent.sh needs to be changed (again, this test
> *passes* for me), so ... :-P

> Subject: [PATCH] t9159-*.sh: Add an svn version check

How about something along the lines of:

  Subject: [PATCH] t9159-*.sh: skip for mergeinfo test for svn <= 1.4

  t9159 relies on the command-line syntax of svn >= 1.5.
  Given the declining install base of older svn versions,
  it is not worth our time to support older svn syntax.

  Acked-by: Eric Wong <normalperson@yhbt.net>
  Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

?

> diff --git a/t/t9159-git-svn-no-parent-mergeinfo.sh b/t/t9159-git-svn-no-parent-mergeinfo.sh
> index 85120b7..69e4815 100755
> --- a/t/t9159-git-svn-no-parent-mergeinfo.sh
> +++ b/t/t9159-git-svn-no-parent-mergeinfo.sh
> @@ -2,6 +2,14 @@
>  test_description='git svn handling of root commits in merge ranges'
>  . ./lib-git-svn.sh
>  
> +svn_ver="$(svn --version --quiet)"
> +case $svn_ver in
> +0.* | 1.[0-4].*)
> +	skip_all="skipping git-svn test - SVN too old ($svn_ver)"
> +	test_done
> +	;;
> +esac
> +
>  test_expect_success 'test handling of root commits in merge ranges' '
>  	mkdir -p init/trunk init/branches init/tags &&
>  	echo "r1" > init/trunk/file.txt &&
> -- 
