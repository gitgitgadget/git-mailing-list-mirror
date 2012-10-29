From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: merge --squash strange error
Date: Mon, 29 Oct 2012 14:37:00 +0100
Message-ID: <CAB9Jk9DSrvsOp8++q87y6oMVrTSNcKyoM_vKJyWih96y4tG+fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 29 14:37:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSpWn-0008Pp-Lq
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 14:37:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757199Ab2J2NhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 09:37:03 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43379 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757076Ab2J2NhB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 09:37:01 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4269420pbb.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 06:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=6w2EfbI/GMqjREbwsVWG53cAjSHoEwuNiDApHUPd7pI=;
        b=Zcwe2DEzQBTCdEeof5y0pWjatE3Fq0YgUUXFJ3W66uIWw13UoClRcJVthZNY+2GsAE
         bCf0OOaKvKV6luQ2JKhd9NewE9BSkGd12FcJ7H+DtBFMepDubPTXJ43CDG8JlXeQAHUi
         hSjlmKb3CunPW4KOT0JPvZss10TAzI0A3qaDqmRYf4b1mQLNX5fGPJA9PPZpLmb9Y7Cr
         +nBrXQ/QOSQWzEwNH1smcnGFL06WCNO1QicfQyV7cGXbIKYhNL/fMVROCnazLdkfAfsg
         taUfgNaPsNDI6wPlOflXf3YI5gLCE2SZlDVni08Kg+5Ph/wEzHVG/1ly9Ki42H2BPQIH
         0teg==
Received: by 10.68.200.231 with SMTP id jv7mr92320479pbc.140.1351517820704;
 Mon, 29 Oct 2012 06:37:00 -0700 (PDT)
Received: by 10.67.3.101 with HTTP; Mon, 29 Oct 2012 06:37:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208624>

Hello,

I have got a case in which merge --squash issues an error that does
not exist. I hope I am wrong, though.
Consider the following example:

rm -rf public.git
rm -rf private
git init --bare public.git
git clone public.git private
cd private
touch f1; git add f1; git commit -m A
git checkout -b b1
touch f2; git add f2; git commit -m B
git checkout master
git checkout -b b2
touch f3; git add f3; git commit -m C
git checkout master
git checkout -b b3
touch f4; git add f4; git commit -m D

--- at this point we have

     A (f1)             master
      |--B (f1,f2)     b1
      |--C (f1,f3)     b2
      `--D (f1,f4)     *b3

git merge --squash b1
git merge --squash b2

The first merge adds f2 to the workspace, which then contains f1, f2 and f4.
The second merge should add f3, and instead it complains:

error: Your local changes to the following files would be overwritten by merge:
        f2
Please, commit your changes or stash them before you can merge.
Aborting

Why should it overwrite f2, and with what?

-Angelo
