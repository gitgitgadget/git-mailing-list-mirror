From: =?iso-8859-1?Q?Ren=E9_Haber?= <rene@habr.de>
Subject: =?iso-8859-1?Q?Bug=3A_pull_--rebase_with_=E9_in_name?=
Date: Mon, 5 Mar 2012 10:59:16 +0100
Message-ID: <FECFDD4D-6EC3-4DE1-8A08-B4477345C4AA@habr.de>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 05 10:59:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4UhT-0007Jt-Qx
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 10:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756598Ab2CEJ7U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Mar 2012 04:59:20 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:57022 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756525Ab2CEJ7T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2012 04:59:19 -0500
Received: by bkcik5 with SMTP id ik5so2938469bkc.19
        for <git@vger.kernel.org>; Mon, 05 Mar 2012 01:59:18 -0800 (PST)
Received-SPF: pass (google.com: domain of rene@habr.de designates 10.204.136.200 as permitted sender) client-ip=10.204.136.200;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of rene@habr.de designates 10.204.136.200 as permitted sender) smtp.mail=rene@habr.de; dkim=pass header.i=rene@habr.de
Received: from mr.google.com ([10.204.136.200])
        by 10.204.136.200 with SMTP id s8mr9835874bkt.97.1330941558309 (num_hops = 1);
        Mon, 05 Mar 2012 01:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=habr.de; s=habr;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        bh=2tWcQ161Jeym5d9gPGUJznJjzmJXKtPJLJqFCkYsD7s=;
        b=COxn1tzGSG0YDrU9Ly4tZGt9BwBJuuwl0bgAv9iHJWF6q3rFjoJ4YAEIoCnKOppPgd
         nsrq3W/e8pQEgbEk7Ov/UjVQtteDl+raLTigYXXVWsiqqTjHM0Ior/gDNA41rgPnXi/Y
         JVXxVa31Dq3tVNn5P4F7PNq9b9Dpzv+LUtf80=
Received: by 10.204.136.200 with SMTP id s8mr7770084bkt.97.1330941558077;
        Mon, 05 Mar 2012 01:59:18 -0800 (PST)
Received: from laptop1.physik.tu-chemnitz.de (laptop1.physik.tu-chemnitz.de. [134.109.16.58])
        by mx.google.com with ESMTPS id jc4sm24116015bkc.7.2012.03.05.01.59.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Mar 2012 01:59:17 -0800 (PST)
X-Mailer: Apple Mail (2.1084)
X-Gm-Message-State: ALoCoQkCJZ5iohM1ndSZyxtSvf8BrELFsKt99F2tUz3XfRefEGwCg/TaB3fxdlP82gWv0rcsofO8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192218>

Hello,

I'm having trouble with the following scenario:
My name contains an =C3=A9 with accent. Having set
git config --global user.name "Ren=C3=A9 Haber"
and several commits with that name in a project.
Now I wanted to pull with --rebase, which fails with:

git pull --rebase
remote: Counting objects: 9, done.
remote: Compressing objects: 100% (5/5), done.
remote: Total 5 (delta 4), reused 0 (delta 0)
Unpacking objects: 100% (5/5), done.
=46rom ____.de:repositories/kapa
   173c610..18987db  master     -> origin/master
=46irst, rewinding head to replay your work on top of it...
/sw/lib/git-core/git-am: line 675: Haber: command not found
Patch does not have a valid e-mail address.

The problem lies in .git/rebase-apply/author-script :

GIT_AUTHOR_NAME=3D'Rene'=CC=81 Haber
GIT_AUTHOR_EMAIL=3D'rene@habr.de'
GIT_AUTHOR_DATE=3D'@1330931169 +0100'

where the accent =C2=B4 is on top of the apostrophe and an apostrophe i=
s missing from the end of the GIT_AUTHOR_NAME line.
This leads to the "Haber: command not found".
As the author name is taken from the rebased commits changing the user.=
name in the .gitconfig is useless.
The only way I found around this is changing my name to "Rene Haber" an=
d first rewriting my local history up to the point of the rebase with t=
hat name.

Thanks for your help.
Ren=C3=A9 Haber