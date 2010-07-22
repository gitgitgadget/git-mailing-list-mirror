From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t7002: test git grep --no-index from a bare repository
Date: Thu, 22 Jul 2010 02:02:19 -0500
Message-ID: <20100722070219.GA6577@burratino>
References: <1279715018-24225-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 09:03:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Obpoc-0003Ij-9W
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 09:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354Ab0GVHD2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jul 2010 03:03:28 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60860 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585Ab0GVHD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 03:03:27 -0400
Received: by gyg10 with SMTP id 10so500379gyg.19
        for <git@vger.kernel.org>; Thu, 22 Jul 2010 00:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=eqStUUmDyWX7ptcU2c94PuV6dcvRnia54mRdBY/kBM8=;
        b=iA2IQOyiwJAjyQ7jy1b+uIgOdrzS97ckqX6f54bNnAjnSBzJfMEstSinRB1USTWiCZ
         tAQMGna59JeXDu2sa+HortFf+/xuhDwSLEzu467ZCBeQ7G9Ldwzdq/aJX5QwXKhx/k4a
         8FbxLbAojaB1oZ1Mte3cz8nE9zqxyLpAg/Orc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=l9HAQikEPRU7qg0+trDAP1Sa0ntjjSu3Glgw+TNHV9DlfIzIO6fxP6Nsw46J7VwT03
         KEUSd6XBEFvprpxj59aTiy37ZjTrF1DHr9495YWeZbjDMA33aWqph2DcJl5Jxnfq9uT/
         644MfmQeChxUAUsB+d9cqMRI08Pjt9L8QiVZI=
Received: by 10.90.90.16 with SMTP id n16mr2052198agb.118.1279782206729;
        Thu, 22 Jul 2010 00:03:26 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id e8sm29627438ibb.8.2010.07.22.00.03.24
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 22 Jul 2010 00:03:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1279715018-24225-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151443>

Hi Duy,

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Subject: [PATCH] t7002: test git grep --no-index from a bare reposito=
ry

It=E2=80=99s t7810 now (to keep t7811 company).

>  There is an interesting thing about this command. Back in tp/setup
>  series, there is a patch that changes the current behavior,
>  "calculate prefix even if no worktree is found". grep is interesting
>  because it depends on the current behavior, i.e. prefix being NULL
>  in bare repo, while it still needs true prefix to do chdir()
>  stuff in run_pager().

Yes, sorry to let this hang for so long.  I liked your setup series
for many reasons and am happy to see pieces of it coming back to life.

> +++ b/Documentation/git-grep.txt
> @@ -28,8 +28,9 @@ SYNOPSIS
>  DESCRIPTION
>  -----------
>  Look for specified patterns in the tracked files in the work tree, b=
lobs
> -registered in the index file, or blobs in given tree objects.
> -
> +registered in the index file, or blobs in given tree objects. By def=
ault
> +it will only search tracked files within the current directory (or f=
ull
> +tree if in bare repository).

Probably deserves more detail.

	Searches for lines matching the specified patterns in the
	work tree, the index, or a specified tree.

	By default, 'git grep' only examines tracked files in the
	subtree of the work tree rooted at the current working
	directory.  Output consists of matching lines preceded with
	the corresponding filename and a colon.

	With `--cached`, 'git grep' does the same search in the
	version scheduled for the next commit in the index.

	With `--no-index`, 'git grep' pays no mind to the index
	file and reports *all* matching files under the working
	directory.

	Given a commit name, 'git grep' does the same search in that
	historical version.  More generally, given a tree name, 'git
	grep' searches the subtree of that tree object corresponding
	to the path to the current directory from the root of the work
	tree (or the entire tree if there is no work tree, as in a
	bare repository).

> =20
>  OPTIONS
>  -------
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 597f76b..e8abdc7 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -1109,6 +1109,8 @@ int cmd_grep(int argc, const char **argv, const=
 char *prefix)
> =20
>  	if (use_threads)
>  		hit |=3D wait_all();
> +
> +	/* FIXME prefix is NULL in bare repo, no matter where cwd is */
>  	if (hit && show_in_pager)
>  		run_pager(&opt, prefix);

This comment seems kind of unhelpful.  Maybe something like

	/*
	 * NOTE NOTE NOTE: Even in a bare repository, the user
	 * probably expected the command specified with -O to run in
	 * the current directory, but when --no-index is supplied, we
	 * are passing it paths relative to the .git directory.
	 * Until that changes, this needs not to chdir() in that case.
	 */

Do I understand correctly?

-- 8< --
Subject: grep documentation: flesh out description

As Duy noticed, it is not always obvious what directory =E2=80=98git gr=
ep=E2=80=99
is going to search in.  Add some other details to the description,
too.

Inspired by http://gitster.livejournal.com/27674.html

Cc: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-grep.txt |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 5474dd7..d6cfbc6 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -27,9 +27,26 @@ SYNOPSIS
=20
 DESCRIPTION
 -----------
-Look for specified patterns in the tracked files in the work tree, blo=
bs
-registered in the index file, or blobs in given tree objects.
-
+Searches for lines matching the specified patterns in the work
+tree, the index, or the specified tree objects.
+
+By default, 'git grep' only examines tracked files in the subtree
+of the work tree rooted at the current working directory.  Output
+consists of matching lines preceded with the corresponding
+filename and a colon.
+
+With `--cached`, 'git grep' does the same search in the version
+scheduled for the next commit in the index.
+
+With `--no-index`, 'git grep' pays no mind to the index file and
+reports *all* matching files under the working directory.
+
+When passed a commit name, 'git grep' does the same search but in
+that historical version.  More generally, given a tree name,
+'git grep' searches the subtree of that tree object corresponding
+to the path to the current directory from the root of the work tree
+(or the entire tree if there is no work tree, as in a bare
+repository).
=20
 OPTIONS
 -------
--=20
1.7.2.rc3
