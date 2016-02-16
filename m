From: Zheng Lv <lv.zheng.2015@gmail.com>
Subject: git-mv ignores gitignore file
Date: Tue, 16 Feb 2016 16:35:16 +0800
Message-ID: <56C2DF44.10309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 09:35:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVb6S-0008MD-Td
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 09:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241AbcBPIfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 03:35:21 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33550 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894AbcBPIfU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 03:35:20 -0500
Received: by mail-pa0-f46.google.com with SMTP id fl4so87744160pad.0
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 00:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=mo671dCuTonRgr2n1ti2jyl1EfSS20xEayhNwfRlBOI=;
        b=0EJQ+63KGyLkjMMinx6vbbjcT16mEQ0w47m02QJr+JeOF1Y+6ZCIIMgZKnIbXkZC7E
         nIE1Auo5O+7R//X86F2xLGTD4AIpm5aZuUKI+PR9G71pUfWBAXBrzmaF/KsmlyohDSuF
         LZNY8JbCYAsP1myXQ5MNs5CIHgPUlCUKznnh9AAqDsrhW9531QgfLHu5H2nnNlfWNKGu
         QJuFRo/cJkY8D640AzwcdOFhciukwjdcmxKuZXSEce0QifaqfyZ9l7xiY+ohgQwpHFgT
         XAMvlQjBsDtPIseZ4I0TxzRwCogJsdM0MTW4YxeQCBFtIuhUqpn3g7W0QtpgqYp4ovnB
         4vHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=mo671dCuTonRgr2n1ti2jyl1EfSS20xEayhNwfRlBOI=;
        b=cPNON7Lhn8PapyrNhbs5j+sbkW6PhQR+QOYxni/JG3QjTVI3v8fXUmUcq2V1Bq3NPw
         KcXwdBbV/M3gzGzO/8/6A92yFlCye8Tmc7/DcXkpZOHX8ErbB+TXIwGhqJkFj2IOmwzR
         IRo1nZQCAliBWhdzOkXu6nOJgdLMNgybf1i5nmN8xrMP1Ocz6EG95mRdYAI4u2BSIxQ5
         VVlXIFHWRh1vtb1fBAM88JPrGqszN582AaGr2W8A8JAKgkDuURwcpZMENqqEqxqhEzjc
         pVLUiDHkg//wUREvBkUV77xHr8g/7ZvnbRX4ALMTc8qhW+OYhjhP/jjE+7c64lhLZvUG
         UIQQ==
X-Gm-Message-State: AG10YOQ270M+8dxx+pixxlHnInUMJF7InJisAI/28mS4ZYtEDbMZkEtuUWGPsVniU1jeRQ==
X-Received: by 10.66.187.36 with SMTP id fp4mr29192163pac.47.1455611719604;
        Tue, 16 Feb 2016 00:35:19 -0800 (PST)
Received: from [0.0.0.0] ([159.203.227.210])
        by smtp.gmail.com with ESMTPSA id q16sm43740752pfi.80.2016.02.16.00.35.17
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 16 Feb 2016 00:35:18 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286328>

gitignore(5) manual says that

> A gitignore file specifies intentionally untracked files that Git 
> should ignore. Files already tracked by Git are not affected ...

> The purpose of gitignore files is to ensure that certain files not 
> tracked by Git remain untracked.

which means that the following operations are totally correct.

$ echo "b" >> .gitignore
$ echo "Something" > a
$ git add a
$ git mv a b

Equivalantly,

$ echo "b" >> .gitignore
$ echo "Something" > b
$ git add --force b

That is, doing something --force when --force it is not specified.

However, this may not be the intented behavior. The user might not want
to equivalantly add a `new' file b to the index when b should be
gitignored. Such operations are possibly oversight of users.

The ideal behavior, issue a warning when git-mv target collides with
gitignore.

Thanks.
