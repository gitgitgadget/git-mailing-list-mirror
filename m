From: "Anatol Pomozov" <anatol.pomozov@gmail.com>
Subject: Incorrect git-blame result if I use full path to file
Date: Sun, 2 Dec 2007 16:52:36 -0800
Message-ID: <3665a1a00712021652tbdfe9d1tdc4575d225bfed36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 03 01:53:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyzYa-00078v-4T
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 01:53:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbXLCAwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 19:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbXLCAwr
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 19:52:47 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:61173 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbXLCAwq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 19:52:46 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4660221wah
        for <git@vger.kernel.org>; Sun, 02 Dec 2007 16:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=S+A0AZuN8MhQR2XgxDkYx2rrAhbwQIRuwjENguVOLt0=;
        b=ZQzf+UPvg1OGLqP+y1DZ/YPshouab9zNJ21eFgkja69qMiFgvLTu91/3PtGYKs7H0I3TKSiJ815ViEZ/LYdFVqSqJsPDb5us50DyHh8DsOFF7jJZcedmUUhM9q+KeRZw9AaXx8N0wtqydeZK++5A3/CrbfJdPfhq7dqUFsOZRi0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Fb/342xjYSH+0qUUAS6X3dHHi4AZJ+t60ukRU9bUjS2d9jAlNucYf658lNwm7ubDO5TZz2dfzsA7FpfAzK9ICfqZ/oe5Mqh8n9X28h7Tgic0cMxPFmqnjeas2z1G+6o4skiX1AeYqDjDgh7N8vYqzXUhFyhhcZpfZUy9R+zffvc=
Received: by 10.115.89.1 with SMTP id r1mr2973450wal.1196643161336;
        Sun, 02 Dec 2007 16:52:41 -0800 (PST)
Received: by 10.115.89.14 with HTTP; Sun, 2 Dec 2007 16:52:36 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66839>

Hi, all.

I just start learning git and I found a bug (but sorry if the
functionality I am trying to blame as a bug not actually bug and it
was made by intention)

The problem is that git-blame returns incorrect result if you use full
path for files.

Here is an example script that generates repo.

#go to empty dir
git init
echo "On master" >> master.txt
git add master.txt
git commit -m "First commit"
echo "On master" >> master.txt
git commit -a -m "Second commit"
echo "On master" >> master.txt


Now lets do blame for master.txt
anatol:repo $ git blame master.txt
^69bce74 (Anatol Pomozov    2007-12-02 16:44:07 -0800 1) On master
4e2bbde4 (Anatol Pomozov    2007-12-02 16:44:15 -0800 2) On master
00000000 (Not Committed Yet 2007-12-02 16:44:27 -0800 3) On master

It is exaclty what we expect. But lets try full path for master.txt
$pwd
/personal/sources/learn/gitea/repo
$git blame /personal/sources/learn/gitea/repo/master.txt
^69bce74 (Anatol Pomozov 2007-12-02 16:44:07 -0800 1) On master
^69bce74 (Anatol Pomozov 2007-12-02 16:44:07 -0800 2) On master
^69bce74 (Anatol Pomozov 2007-12-02 16:44:07 -0800 3) On master


Now git shows that all lines in the file were changed by the first
commit and that it does not true.

-- 
anatol
