From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] tests: test applying criss-cross rename patch
Date: Mon, 20 Apr 2009 16:11:01 +0200
Message-ID: <81b0412b0904200711p66ea2500s7cc5894aba71f641@mail.gmail.com>
References: <alpine.LFD.2.00.0904091147290.4583@localhost.localdomain>
	 <1239463584-1427-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 16:12:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvuEj-0008HJ-CZ
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 16:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755549AbZDTOLH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Apr 2009 10:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755552AbZDTOLF
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 10:11:05 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:32784 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755545AbZDTOLE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2009 10:11:04 -0400
Received: by gxk10 with SMTP id 10so547377gxk.13
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 07:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AuMSO3tDUIxMidHFEnMoYbHBZOm5KNqt3UtPtrBpDPE=;
        b=FWAMHXDO+y8Gsvw/ZVkHZUk4Mmq1QJFKNQy4xQpXfZvmcHwS3Hy4S5TbI7wdkIe7x7
         dV8HOIzRHDcgaTr8aEYoibxp9vR7sasqZY2iS99ZXHNef22HtxKPAOlvnIWyHHktHspa
         JF8bJTUMD5sPWLBWkZFmnqBf6QydHGUCKssT8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=S4OfFPJ/4MStI/TgtaWw4+smLOodweC/itfPT7L5qZEqyvowfpatJfVp6DyjGqdyPx
         gL0DP+ij7HDp6U5OHeeZykHp1wsj1aN0agJzUDjXuzLy/UNRXWGbfS8RbNhIw2R3jENm
         aJIHldAoTep7yUl1NRy/FnShxrBRXGHf4Ox1w=
Received: by 10.151.150.13 with SMTP id c13mr1942104ybo.179.1240236661912; 
	Mon, 20 Apr 2009 07:11:01 -0700 (PDT)
In-Reply-To: <1239463584-1427-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116988>

2009/4/11 Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>:
> +test_expect_success 'criss-cross rename' '
> + =C2=A0 =C2=A0 =C2=A0 mv file1 tmp &&
> + =C2=A0 =C2=A0 =C2=A0 mv file2 file1 &&
> + =C2=A0 =C2=A0 =C2=A0 mv tmp file2
> +'
> +
> +test_expect_success 'diff -M -B' '
> + =C2=A0 =C2=A0 =C2=A0 git diff -M -B > diff &&
> + =C2=A0 =C2=A0 =C2=A0 git reset --hard
> +
> +'

This cannot work on systems where ctime is not trusted:
git diff will produce no data, as there are no changes in
metadata (the files are of the same size). Either make
the file sizes different or add a "touch file1 file2".

diff --git a/t/t4130-apply-criss-cross-rename.sh
b/t/t4130-apply-criss-cross-rename.sh
index 8623dbe..1ff049a 100755
--- a/t/t4130-apply-criss-cross-rename.sh
+++ b/t/t4130-apply-criss-cross-rename.sh
@@ -14,7 +14,7 @@ create_file() {

 test_expect_success 'setup' '
 	create_file file1 "File1 contents" &&
-	create_file file2 "File2 contents" &&
+	create_file file2 "Contents of File2" &&
 	git add file1 file2 &&
 	git commit -m 1
 '
