From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 1/2] git-p4: add test case for "Translation of file content failed" error
Date: Tue, 22 Sep 2015 12:09:20 +0200
Message-ID: <9F835973-7045-4AA7-A0B0-D3D3C6F25D73@gmail.com>
References: <1442829701-2347-1-git-send-email-larsxschneider@gmail.com> <1442829701-2347-2-git-send-email-larsxschneider@gmail.com> <xmqqio73abl0.fsf@gitster.mtv.corp.google.com> <E47DE9F0-6017-4E96-AC29-E6C60C4D85CB@gmail.com> <CAPig+cRV-RCdcmAHG+bRL6_yYYNCRqQPQ+v3KCXwC81StGKibg@mail.gmail.com> <xmqqbncv6yym.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>,
	=?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 12:09:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeKVs-0002G4-UZ
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 12:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754520AbbIVKJZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Sep 2015 06:09:25 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34269 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753909AbbIVKJY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Sep 2015 06:09:24 -0400
Received: by wicfx3 with SMTP id fx3so184167475wic.1
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 03:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=67ohfrpOVwblVQeczmffyLjzoM7jQ8MmEBcLkvEDJZo=;
        b=ybQQds4CL1q69iB0u+0G5g8+1RrpcEH/FqiYwSRRcIiLX36yoVHU4QUVYaTRQwGgvm
         t87eg/Xq5+nmRmvlPhbCFFiZqV5EeVPLCrG5B2EH41GDrXa3YyStesIukQqkvDdhpZ+f
         X3bs3yta0ha9VBmITI5WZOK5E9K+PCRzq9qUVAkjx/R8iDeOmo+2cg9QOxkmfNsb5STi
         6Ztky3sesVop3Hg6DdXCNAKoLKpZc/KqJ026HHvp1sCCn6vPvNBsQ2DNBa+nN0kXj0oh
         ETp6nB5q1yQpL2zxspPrqpy2iNbedzqZugZ7kneFRqya5hBMK8HnV1uVnQ6F/dVZvegK
         wMsA==
X-Received: by 10.180.108.175 with SMTP id hl15mr19702809wib.1.1442916562887;
        Tue, 22 Sep 2015 03:09:22 -0700 (PDT)
Received: from slxbook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id nf15sm2266967wic.22.2015.09.22.03.09.21
        (version=TLS1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 22 Sep 2015 03:09:22 -0700 (PDT)
In-Reply-To: <xmqqbncv6yym.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278386>


On 22 Sep 2015, at 03:10, Junio C Hamano <gitster@pobox.com> wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>=20
>> Yes, it's because $d is a variable reference, even within double
>> quotes.
>=20
> s/even/especially/ ;-)
>=20
> Here is what I queued as SQUASH???
>=20
> diff --git a/t/t9825-git-p4-handle-utf16-without-bom.sh b/t/t9825-git=
-p4-handle-utf16-without-bom.sh
> index 65c3c4e..735c0bb 100644
> --- a/t/t9825-git-p4-handle-utf16-without-bom.sh
> +++ b/t/t9825-git-p4-handle-utf16-without-bom.sh
> @@ -22,8 +22,8 @@ test_expect_success 'init depot with UTF-16 encoded=
 file and artificially remove
> 		cd "db" &&
> 		p4d -jc &&
> 		# P4D automatically adds a BOM. Remove it here to make the file inv=
alid.
> -		sed -e "$ d" depot/file1,v >depot/file1,v.new &&
> -		mv -- depot/file1,v.new depot/file1,v &&
> +		sed -e "\$d" depot/file1,v >depot/file1,v.new &&
> +		mv depot/file1,v.new depot/file1,v &&
> 		printf "@$UTF16@" >>depot/file1,v &&
> 		p4d -jrF checkpoint.1
> 	)

This works. I even tested successfully this one:

sed \$d depot/file1,v >depot/file1,v.new &&

Do we need the =93-e=94 option?

Thanks,
Lars
