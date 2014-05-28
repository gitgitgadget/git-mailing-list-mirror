From: Noam Postavsky <npostavs@users.sourceforge.net>
Subject: [BUG] git diff --(src|dst)-prefix=// causes spurious "(new|deleted)
 file mode"
Date: Tue, 27 May 2014 21:55:29 -0400
Message-ID: <CAM-tV-9vQPPj+TemYnzjRMTjaHqwo3qq=WWJ89VnRMAeYXHZZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 28 03:55:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpT5a-0005Mc-6a
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 03:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237AbaE1Bza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 21:55:30 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:65067 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbaE1Bz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 21:55:29 -0400
Received: by mail-qg0-f46.google.com with SMTP id q108so15431337qgd.5
        for <git@vger.kernel.org>; Tue, 27 May 2014 18:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=MWCV3WqNZd3B8mveRwkhKzyDotm+MBnEkjucWz2bIvA=;
        b=Y/ZY16xtTUkzMDelFumrJp7JRV7j8t84ZcFwzGlq16dZUc6bT47eOqTjH8oRz3j2bk
         i4EVj0hYmPEh/xDkJzh8sSedSKEReUYzeodHg8Ayv3NdiKDQthQbGjNzQiy2o9dplzW+
         BfbSkT3GEW5aP0GT8QTYf31JtStoXTb/Ns1mGaGLyEujG/rtkTCcWMvVobv6yrZOJOOw
         pkE6d2O8EaTRH2KmcoYDT+7Vs8BFmmGZXd7psdTz+Fg32Je8n3101L9AoxlyncuFRCq8
         skU3oFhS8wpaKy1NGDCYvZTNX5Oj/S8mCt+/pkvellWxyFrUVLumm/xoUFRWI126q9+p
         OnuA==
X-Received: by 10.140.82.113 with SMTP id g104mr46869354qgd.55.1401242129038;
 Tue, 27 May 2014 18:55:29 -0700 (PDT)
Received: by 10.224.61.196 with HTTP; Tue, 27 May 2014 18:55:29 -0700 (PDT)
X-Google-Sender-Auth: njqP-1HE_Bslhb1snxdQyds99q4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250255>

% git init
Initialized empty Git repository in /home/npostavs/tmp/scratch/.git/
% echo foo > x
% git add x
% git commit -m x
[master (root-commit) 41be1f2] x
 1 file changed, 1 insertion(+)
 create mode 100644 x
% echo bar > x
% git diff  | head -3
diff --git i/x w/x
index 257cc56..5716ca5 100644
--- i/x
% git diff --dst-prefix=// | head -3
diff --git i/x //x
deleted file mode 100644
index 257cc56..5716ca5 100644
% git diff --src-prefix=// | head -3
diff --git //x w/x
new file mode 100644
index 257cc56..5716ca5 100644
% git diff --src-prefix=// --dst-prefix=// | head -3
diff --git //x //x
new file mode 100644
index 257cc56..5716ca5 100644
% git --version
git version 1.9.2

Background: trying to find a prefix that can't show up in file names
in order to make parsing easier.
https://github.com/magit/magit/pull/1379
https://github.com/magit/magit/pull/1383
