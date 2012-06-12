From: konglu@minatec.inpg.fr
Subject: Re: [PATCH 3/6] Test file for git-remote-mediawiki clone
Date: Tue, 12 Jun 2012 23:34:48 +0200
Message-ID: <20120612233448.Horde.yFmTWnwdC4BP17X4iOBVZrA@webmail.minatec.grenoble-inp.fr>
References: <20120611230954.Horde.inb-aHwdC4BP1l6iLlHhZgA@webmail.minatec.grenoble-inp.fr>
 <1339535563-18958-1-git-send-email-simon.cathebras@ensimag.imag.fr>
 <1339535563-18958-3-git-send-email-simon.cathebras@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	Simon Perrat <simon.perrat@ensimag.imag.fr>,
	Charles Roussel <charles.roussel@ensimag.imag.fr>,
	Julien Khayat <julien.khayat@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@imag.fr>
To: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 12 23:34:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeYjq-0008SC-AW
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 23:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144Ab2FLVey convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jun 2012 17:34:54 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:34961 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751696Ab2FLVex (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2012 17:34:53 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 310BE1A0259;
	Tue, 12 Jun 2012 23:34:49 +0200 (CEST)
Received: from reverse.completel.net (reverse.completel.net [92.103.38.66])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Tue, 12 Jun
 2012 23:34:48 +0200
In-Reply-To: <1339535563-18958-3-git-send-email-simon.cathebras@ensimag.imag.fr>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199864>


Simon Cathebras <simon.cathebras@ensimag.imag.fr> a =E9crit=A0:

> From: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
>
> This patch provides some tests for the clone in use by
> git-remote-mediawiki.
>
> Signed-off-by: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
> Signed-off-by: Simon Perrat <simon.perrat@ensimag.imag.fr>
> Signed-off-by: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
> Signed-off-by: Charles Roussel <charles.roussel@ensimag.imag.fr>
> Signed-off-by: Julien Khayat <julien.khayat@ensimag.imag.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@imag.fr>
> ---
>  contrib/mw-to-git/t/t9360-mw-to-git-clone.sh | 238 =20
> +++++++++++++++++++++++++++
>  1 file changed, 238 insertions(+)
>  create mode 100755 contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
>
> diff --git a/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh =20
> b/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
> new file mode 100755
> index 0000000..07e1270
> --- /dev/null
> +++ b/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
> @@ -0,0 +1,238 @@
> +#!/bin/sh
> +#
> +# Copyright (C) 2012
> +#     Charles Roussel <charles.roussel@ensimag.imag.fr>
> +#     Simon Cathebras <simon.cathebras@ensimag.imag.fr>
> +#     Julien Khayat <julien.khayat@ensimag.imag.fr>
> +#     Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
> +#     Simon Perrat <simon.perrat@ensimag.imag.fr>
> +#
> +# License: GPL v2 or later
> +
> +
> +test_description=3D'Test the Git Mediawiki remote helper: git clone'
> +
> +. ./test-gitmw-lib.sh
> +. $TEST_DIRECTORY/test-lib.sh
> +
> +
> +test_check_precond
> +
> +
> +test_expect_success 'Git clone creates the git log expected with one=
 file' '
> +	wiki_reset &&
> +	wiki_editpage foo "this is not important" false -c cat -s "this =20
> must be the same" &&
> +	git clone mediawiki::http://'"$SERVER_ADDR:$PORT/$WIKI_DIR_NAME"' =20
> mw_dir_1 &&
> +	(cd mw_dir_1 &&
> +	git log --format=3D%s HEAD^..HEAD > log.tmp ) &&
> +	echo "this must be the same" > msg.tmp &&
> +	diff -b mw_dir_1/log.tmp msg.tmp
> +'

It's clearer to put it this way:

         git clone [...] &&
         (
                 cd ... &&
                 ....
         ) &&
         ....

And, about style:
     "echo one >one" and not "echo one > one"
