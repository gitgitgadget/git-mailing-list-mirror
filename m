From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: [PATCH] Fix t7004 which fails with retarded sed
Date: Fri, 16 Nov 2007 18:58:21 +0100
Message-ID: <6E925AF7-FCCB-4793-936F-7BC513272E75@lrde.epita.fr>
References: <20071116165944.GB29272@glandium.org> <1195233971-12288-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-42-32853023"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Nov 16 18:59:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1It5TJ-0001qS-Ai
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 18:59:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761008AbXKPR6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 12:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762095AbXKPR6f
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 12:58:35 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:50190 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758377AbXKPR6f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 12:58:35 -0500
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1It5Sb-0005OP-O9; Fri, 16 Nov 2007 18:58:33 +0100
In-Reply-To: <1195233971-12288-1-git-send-email-mh@glandium.org>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65235>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-42-32853023
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Nov 16, 2007, at 6:26 PM, Mike Hommey wrote:

> Brown paper bag fix to avoid test failure with retarded sed. The test
> by itself didn't catch what it was supposed to, anyways.
>
> So now, we test whether the editor gets at least an empty line, some
> commented lines, and doesn't get anything else.
>
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>  t/t7004-tag.sh |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 096fe33..3813f23 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -1007,7 +1007,9 @@ test_expect_failure \
>  test_expect_success \
>  	'message in editor has initial comment' '
>  	GIT_EDITOR=cat git tag -a initial-comment > actual || true &&
> -	test $(sed -n "/^\(#\|\$\)/p" actual | wc -l) -gt 0
> +	grep -e "^$" actual > /dev/null 2>&1 &&
> +	grep -e "^#" actual > /dev/null 2>&1 &&
> +	! grep -e "^[^#]" actual > /dev/null 2>&1
>  '
>
>  get_tag_header reuse $commit commit $time >expect

If your system has a retarded `sed', it will most likely also have a  
brain-dead `/bin/sh' which doesn't handle `! command'.  So I suggest  
you rewrite the last line as:
   grep -ve "^[^#]" actual > /dev/null 2>&1

Cheers,

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-42-32853023
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHPdo9wwE67wC8PUkRAiK/AKCwWCeUNF/UJiKkP2tAIFrlCFSjEQCgyfFI
aVrLOO1k8FOdnUUSO02cvyE=
=B9XF
-----END PGP SIGNATURE-----

--Apple-Mail-42-32853023--
