From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH 4/4] gitweb: Fix broken blob action parameters on blob/commitdiff
 pages
Date: Tue, 09 Apr 2013 17:25:59 +0200
Message-ID: <51643307.9090603@gmail.com>
References: <m2vc7wbx76.fsf@blackdown.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?SsO8cmdlbiBLcmVpbGVkZXI=?= <jk@blackdown.de>
X-From: git-owner@vger.kernel.org Tue Apr 09 17:26:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPaR2-0000UX-Br
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 17:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764683Ab3DIP0H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Apr 2013 11:26:07 -0400
Received: from mail-ee0-f43.google.com ([74.125.83.43]:42607 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761532Ab3DIP0G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 11:26:06 -0400
Received: by mail-ee0-f43.google.com with SMTP id e50so3009247eek.2
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 08:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=nip8BK4ms2SLe2B+oWlvS8FPUXJ6U07SCq9f/14a3QM=;
        b=Dvy2QcBJqz5Q9q/z6e1Y7sYSdePDLdIzEZVMzUEiCkIK0W4lOtwEwDVdLokhB1rbOO
         CmrYRAwPrI/TyK8yNJp0K1x8AcvSq24N597NOuA4oPrk98Q6aeL/sNI4ICyHNQv7LcQ9
         B7/SvoJ0CgVNxonk0p/7hWQEhDra3ynXBL0tgw205K9vfUUcJOjlHOmhvKyzVqIX95PY
         v/z3fcA2CETj+6hpJcKIxun5FugmvMTxa2HsOlnXV4QSZB/tiCPUIXgnDMxjBRisORSI
         uVDO4QFzv4rEFivFhMVhnUVNnSfghJIGe+s26tAOid/IPWWG00rFjETvskbc/kYGQAtP
         zkEA==
X-Received: by 10.14.179.5 with SMTP id g5mr61057132eem.41.1365521164874;
        Tue, 09 Apr 2013 08:26:04 -0700 (PDT)
Received: from [192.168.1.14] (dce9.neoplus.adsl.tpnet.pl. [83.23.56.9])
        by mx.google.com with ESMTPS id bj2sm13827651eeb.1.2013.04.09.08.26.02
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 08:26:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <m2vc7wbx76.fsf@blackdown.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220578>

W dniu 08.04.2013 22:10, J=C3=BCrgen Kreileder pisze:

> Fix broken blob action parameters on blobdiff and commitdiff pages by
> explicitly passing variables instead of relying on global ones.

Do I understand it correctly that those variables (e.g. $hash variable
in git_patchset_body in second chunk below, after this change passed
as parameter to format_diff_cc_simplified()) can be filled in then,
or at least adjusted correctly?

> (The broken parameters on blob links lead to blob pages which show th=
e
> blob but with a hash instead of a commit message and have broken
> blob_plain (404 - Cannot find file) and tree links (404 - Reading tre=
e
> failed))
>=20
> Signed-off-by: J=C3=BCrgen Kreileder <jk@blackdown.de>

I wonder how we missed this.  Does this happen always, or in some
specific conditions?

Anyway, this change is a good change.  Internal subroutines should not
use global variables.

I hope that in the future we would get rid of most global variables...

Acked-by: Jakub Narebski <jnareb@gmail.com>

[not tested]

>  # create note for patch simplified by combined diff
>  sub format_diff_cc_simplified {
> -	my ($diffinfo, @parents) =3D @_;
> +	my ($diffinfo, $hash, @parents) =3D @_;
>  	my $result =3D '';
> =20
>  	$result .=3D "<div class=3D\"diff header\">" .
[...]
> @@ -5404,7 +5405,7 @@ sub git_patchset_body {
> =20
>  		# generate anchor for "patch" links in difftree / whatchanged part
>  		print "<div class=3D\"patch\" id=3D\"patch". ($patch_idx+1) ."\">\=
n" .
> -		      format_diff_cc_simplified($diffinfo, @hash_parents) .
> +		      format_diff_cc_simplified($diffinfo, $hash, @hash_parents) .
>  		      "</div>\n";  # class=3D"patch"
> =20
>  		$patch_number++;
>=20


--=20
Jakub Nar=C4=99bski
