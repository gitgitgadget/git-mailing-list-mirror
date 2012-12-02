From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [RFC] Add basic syntax check on shell scripts
Date: Sun, 02 Dec 2012 15:30:02 +0100
Message-ID: <50BB65EA.5080805@gmail.com>
References: <201212021417.25525.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Dec 02 15:30:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfAYz-0003wx-M1
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 15:30:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630Ab2LBOaQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Dec 2012 09:30:16 -0500
Received: from mail-ea0-f174.google.com ([209.85.215.174]:37142 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab2LBOaP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2012 09:30:15 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so822357eaa.19
        for <git@vger.kernel.org>; Sun, 02 Dec 2012 06:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=GqJCADh4EakqXTU3rdvwT/jgfZ4qooN2muhvghlbuhM=;
        b=IrfS50ZjNkTYmZRShFk6gzw/0uHOP+jdJn7VETrFDlQ/fAHHTWx9k24iF2ujTH/uDg
         tzJSt70SP1zhuZmOidPfMG6oIj4IzT4nMEtWdAK/5icTTYPCJfnt1jXFCaJZsE6Iylyh
         h2np3BpIVwC7mXVt3u67NgepgXULjsExXF3qO2P7kikGK2N78Im/uz45nQy+2IW+aJUN
         bvC+VM0+IETVQAt64+XmQEMk2W+x4i+f43svq3pZPbltO1aJ/RmWZbauaYJrhmebAF/S
         lN7RiLhBoO9t/dvf8X5sihJmE04VSveVw9k9H0Fp7a7TpBHJE9n48G+L5OHzPnu1nZgC
         Fs6w==
Received: by 10.14.174.198 with SMTP id x46mr19424469eel.23.1354458613509;
        Sun, 02 Dec 2012 06:30:13 -0800 (PST)
Received: from [192.168.178.21] (host137-94-dynamic.4-87-r.retail.telecomitalia.it. [87.4.94.137])
        by mx.google.com with ESMTPS id 43sm24800218eed.10.2012.12.02.06.30.10
        (version=SSLv3 cipher=OTHER);
        Sun, 02 Dec 2012 06:30:12 -0800 (PST)
In-Reply-To: <201212021417.25525.tboegi@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211013>

On 12/02/2012 02:17 PM, Torsten B=C3=B6gershausen wrote:
> The test suite needs to be run on different platforms.
> As it may be difficult for contributors to catch syntax
> which work on GNU/linux, but is unportable, make a quick check
> for the most common problems.
> "sed -i", "echo -n" or "array in shell scripts"
> This list is not complete, and may need to be extended
>=20
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
> We add 1 second test execution time
> Is this a useful idea at all?
>=20
=46WIW, I think such an idea is useful (and also easy to implement,
so another +1 from me).

>  t/t99999-syntax-check.sh | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100755 t/t99999-syntax-check.sh
>=20
> diff --git a/t/t99999-syntax-check.sh b/t/t99999-syntax-check.sh
> new file mode 100755
> index 0000000..c4a9289
> --- /dev/null
> +++ b/t/t99999-syntax-check.sh
> @@ -0,0 +1,28 @@
> +#!/bin/sh
> +
> +test_description=3D'Basic check if shell syntax is portable'
> +
> +. ./test-lib.sh
> +
> +
> +test_expect_success 'No arrays in shell scripts' '
> +	>expected &&
> +	(grep -i -n "^[	 ]*declare[	 ][	 ]*" ../*.sh ../../git-* >actual 2>=
&1 || : ) &&
>
Here I'd simply use:

    ! grep -n "^declare[	 ][	 ]*" ../*.sh ../../*.sh

And similarly for the tests below.

In addition, the globs above still miss some files ('perf/perf-lib.sh'
and 'valgrind/analyze.sh', for example); so we might want to improve
it, using, say, "git ls-files" (or find(1), in case the test is to be
run also from distribution tarballs).

HTH,
  Stefano
