From: Fairuzan Roslan <fairuzan.roslan@gmail.com>
Subject: odb_mkstemp's 0444 permission broke write/delete access on AFP
Date: Tue, 17 Feb 2015 01:54:33 +0800
Message-ID: <A403BFCC-D66F-49BD-B54C-BB86B467F1A1@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu.Moy@imag.fr, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 16 18:54:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNPsZ-00082r-Qi
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 18:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697AbbBPRyk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Feb 2015 12:54:40 -0500
Received: from mail-pd0-f177.google.com ([209.85.192.177]:38635 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490AbbBPRyj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Feb 2015 12:54:39 -0500
Received: by pdbfp1 with SMTP id fp1so33636213pdb.5
        for <git@vger.kernel.org>; Mon, 16 Feb 2015 09:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :cc:to:mime-version;
        bh=OGSuQB/ucrEHiH5HV8NukC7Wf6FOKJJ4sGWXkATAlKQ=;
        b=KDgic9d/SpqGhqmoHjYf1uIn141pHm7Ake1ea56nOM+1ePGI+E3uX5+IJncCgWgWat
         TU1q/hEeLDtj7mz298tgtdJNTnDz1bZOcIUza8XGo3LG0mSWGHF9QyfJ+gKMD8tUuWB6
         2K0fzgFOI/GmI54W+8g56WusmtUZqw6EHIFP5XmXEin7o2BPCR+UxHWDaErQS8+GqDbP
         KD/55rXlDXcqz9Pph8seRE6DpWcnfkq90QgQSrUUANgnL4HoUsdFKu1ra+l+a6MeYYAc
         +2hs1wdNX+ovmRPoc5Lw//MJEXrFCQkTxf1OGk7xXx4H+i1uQ8upMTy7kO4+m+kIla8m
         XwLA==
X-Received: by 10.66.224.164 with SMTP id rd4mr41768708pac.12.1424109278653;
        Mon, 16 Feb 2015 09:54:38 -0800 (PST)
Received: from [192.168.88.200] (brk-24-241.tm.net.my. [202.188.24.241])
        by mx.google.com with ESMTPSA id ki2sm15384985pdb.33.2015.02.16.09.54.36
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 16 Feb 2015 09:54:37 -0800 (PST)
X-Mailer: Apple Mail (2.2070.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263905>

Hi,

Somehow the =E2=80=9Cint mode =3D 0444;=E2=80=9D in odb_mkstemp (enviro=
nment.c) are causing a lot of issues (unable to unlink/write/rename) to=
 those people who use AFP shares.

In order to be able to write/unlink/delete/rename a file on AFP filesys=
tem the owner of the file must have at least a u+w access to it.

The issue was first introduced in https://github.com/git/git/blob/f80c7=
ae8fe9c0f3ce93c96a2dccaba34e456e33a/wrapper.c line 284.

To fix these issues the permission need to be adjusted to =E2=80=9Cint =
mode =3D 0644;=E2=80=9D in odb_mkstemp (environment.c)

Please let me know if you need further detail.

Regards,
=46airuzan