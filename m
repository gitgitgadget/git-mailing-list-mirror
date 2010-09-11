From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 8/8] tree_entry_interesting(): support negative pathspec
Date: Sat, 11 Sep 2010 11:33:42 -0600
Message-ID: <AANLkTimxbkVBEMhNbieP9ST1CEupFaR=xBxRNssOdLU6@mail.gmail.com>
References: <1283961023-4491-1-git-send-email-pclouds@gmail.com>
	<1283961023-4491-9-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 11 19:33:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuTxa-0000Cz-4l
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 19:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754085Ab0IKRdp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Sep 2010 13:33:45 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37887 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493Ab0IKRdo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Sep 2010 13:33:44 -0400
Received: by bwz11 with SMTP id 11so3293150bwz.19
        for <git@vger.kernel.org>; Sat, 11 Sep 2010 10:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kjT9Y4XMTuGb0vbMfImo1lZEH27SYQ5Dcc/F/E6rKq4=;
        b=ryUNfgXSXtnq1yUycNOkn7nUjPpco8/CiNHlKYZ95udpSRcfcRcC9jZ1sISyYYpuGy
         HH2jj5Nz8fsNxW/U/cTDHWohmxJnVebArueZa5pzNi/Bx5gDK8LqGgascqrFYJ0LW59c
         iXgTKblHaw3OTdz0PU2Y34UMyTXE8y4PKGpdY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Az06NYycxFHCyQpRMzW4PAgusF2TPPXlZsyeomvowHDoeyp6Rl+ZT7HmYXKT5LzKl6
         +ilh1LaDXiKiIG48Zwyz2ZEBV/+HdygqmyT6vVFqTJr9A6+Ds74v/euJWWmv+Cbh73gX
         9xEF+5WLFhSE7Z51LyfU9qNdBL5J8H6PqEWmc=
Received: by 10.204.50.206 with SMTP id a14mr1703141bkg.65.1284226422917; Sat,
 11 Sep 2010 10:33:42 -0700 (PDT)
Received: by 10.204.126.198 with HTTP; Sat, 11 Sep 2010 10:33:42 -0700 (PDT)
In-Reply-To: <1283961023-4491-9-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156000>

Hi,

2010/9/8 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>:
> +
> +test_expect_success 'diff' '
> + =C2=A0 =C2=A0 =C2=A0 cat >expected <<-\EOF &&
> +:100644 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 d00491fd7e5b=
b6fa28c517a0bb32b8b506539d4d M =C2=A0 =C2=A0 one/file
> +:100644 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 d00491fd7e5b=
b6fa28c517a0bb32b8b506539d4d M =C2=A0 =C2=A0 one/two/file
> +:100644 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 d00491fd7e5b=
b6fa28c517a0bb32b8b506539d4d M =C2=A0 =C2=A0 one/zoo
> +EOF
> + =C2=A0 =C2=A0 =C2=A0 git diff-tree -r HEAD^ HEAD -- one >result &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expected result
> +'

Having the full mode & sha1sum seems to make the test harder to read
than necessary.  Perhaps you could use printf or git ls-files together
with --name-only to simplify and shorten these a bit?  Example
alternative versions for three of your testcases:

test_expect_success 'diff' '
	git ls-files one >expected &&
	git diff --name-only HEAD^ HEAD -- one >result &&
	test_cmp expected result
'

test_expect_success 'diff one ^one/two' '
	git ls-files one | grep -v one/two >expected &&
	git diff --name-only HEAD^ HEAD -- one ^one/two >result &&
	test_cmp expected result
'

test_expect_success 'diff ^one/two' '
	printf "file\none/file\none/zoo\n" >expected &&
	git diff --name-only HEAD^ HEAD -- ^one/two >result &&
	test_cmp expected result
'

Thoughts?
