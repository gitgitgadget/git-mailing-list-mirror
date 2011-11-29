From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Output valid utf8 in git_blame_common('data')
Date: Tue, 29 Nov 2011 11:46:56 -0800 (PST)
Message-ID: <m3d3calnip.fsf@localhost.localdomain>
References: <CAKD0Uuxq+wLdRy5r_hz9qgjHkDmFHHbeAVkb07HizX9xaGMptw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: =?iso-8859-15?q?J=FCrgen_Kreileder?= <jk@blackdown.de>
X-From: git-owner@vger.kernel.org Tue Nov 29 20:47:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVTdw-0001JP-JJ
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 20:47:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755886Ab1K2Tq7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Nov 2011 14:46:59 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54360 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753668Ab1K2Tq7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2011 14:46:59 -0500
Received: by bkas6 with SMTP id s6so938349bka.19
        for <git@vger.kernel.org>; Tue, 29 Nov 2011 11:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=pAwosWB43LvlHDlMO0TXmQiA7cd5FGMql1dJ3v1gn5g=;
        b=NS4Bx3TR1OwrVCFYSfDTWDo4a5Z2ZCGLW+HEuEJhPuybKWfe1UDXTB+rcFkcUbMZDl
         RTGsyz637VXYm2+Z5mmNjlT2zYwKypdsfEHz2fTPmelcyWxtrZbm7SYprPFtpz2sHBo4
         aPvGltj9k7FYNIMIthOdMfuJOMWX+xeN+xNfA=
Received: by 10.205.127.77 with SMTP id gz13mr38472168bkc.76.1322596017634;
        Tue, 29 Nov 2011 11:46:57 -0800 (PST)
Received: from localhost.localdomain (abvz161.neoplus.adsl.tpnet.pl. [83.8.223.161])
        by mx.google.com with ESMTPS id l5sm35718990bkv.9.2011.11.29.11.46.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Nov 2011 11:46:56 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pATJktJP002208;
	Tue, 29 Nov 2011 20:46:56 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pATJkswK002205;
	Tue, 29 Nov 2011 20:46:54 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CAKD0Uuxq+wLdRy5r_hz9qgjHkDmFHHbeAVkb07HizX9xaGMptw@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186077>

J=FCrgen Kreileder <jk@blackdown.de> writes:

> With javascript-actions enabled gitweb showed broken author names in
> the tooltips on blame pages.
>=20
> Signed-off-by: Juergen Kreileder <jk@blackdown.de>
> ---
>  gitweb/gitweb.perl |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 4f0c3bd..c863afe 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -6107,7 +6107,9 @@ sub git_blame_common {
>  			-type=3D>"text/plain", -charset =3D> "utf-8",
>  			-status=3D> "200 OK");
>  		local $| =3D 1; # output autoflush
> -		print while <$fd>;
> +		while (my $line =3D <$fd>) {
> +			print to_utf8($line);
> +		}
>  		close $fd
>  			or print "ERROR $!\n";
>=20
> --=20

Thanks.  ACK.


BTW. all those troubles with not forgetting to call to_utf8() make me
wonder if we wouldn't be better to forget about supporting
$fallback_encoding and just put

  use open qw(:encoding(UTF-8) :std);=20

at the beginning of gitweb, c.f. http://training.perl.com/OSCON2011/ind=
ex.html


Or

  use open qw(:utf8 :std);=20

though then we simply discard errors.

--=20
Jakub Nar=EAbski
