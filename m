From: Kirill Berezin <enelar@develop-project.ru>
Subject: git-submodule nested subrepo bug (Segmentation fault)
Date: Mon, 20 May 2013 09:32:21 +0400
Message-ID: <CAAObgf9RNyVOYD00ki347KBqMWoFA3U7-YM3DnLK4yu62SozSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 20 07:32:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeIiE-00024U-VX
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 07:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752824Ab3ETFcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 01:32:43 -0400
Received: from mail-ea0-f173.google.com ([209.85.215.173]:63784 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062Ab3ETFcm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 01:32:42 -0400
Received: by mail-ea0-f173.google.com with SMTP id n15so3793321ead.32
        for <git@vger.kernel.org>; Sun, 19 May 2013 22:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:x-originating-ip:from:date:message-id
         :subject:to:content-type:x-gm-message-state;
        bh=rzSG3kk5L6sS67OziGXajt0PH3BiVAYcT9qOLjrYJ1I=;
        b=A15zOaruuIEKbgJuDrbTc3bXCXY515SQ+p3YOUniTD98kqKFCdTEhFUcIXPd4BKHTi
         aid3o+cPmDpvBStYNfdXmCTYOLueg6RBEl8NaSgkcjMY9l+lAogzjkVMvlhMKMAUlq+O
         yNJQ70kuqKYPVfQQZc/mPNG2yYkGnrKAsHqES7Dx13m3L3CW3bElhbZQ66Q17nx8Obd0
         NtkSVELYSWIclxP0daYfbzx1F3hUCKo2KWGqdxd6dZsgy6y19CohfbggbbmBL2qNy6Yu
         7f+Kpgb+BLweeL6ZcI/xsL2baWAf2PfhrgVwBImoNikjquO0w5W34yfyM96BZFuROVgb
         YDyw==
X-Received: by 10.14.69.138 with SMTP id n10mr162219830eed.32.1369027961313;
 Sun, 19 May 2013 22:32:41 -0700 (PDT)
Received: by 10.15.81.133 with HTTP; Sun, 19 May 2013 22:32:21 -0700 (PDT)
X-Originating-IP: [213.21.7.6]
X-Gm-Message-State: ALoCoQmAeAK4xgI5nmyQtwHUlqKpP2CKzZYgQa29RwxX8YT6go8l0O03VqnaegzsNfL5unfTjoqI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224937>

When you trying to add submodule, that already has submodule, it craches.
For example you could try: git clone --recursive
http://github.com/Exsul/al_server

Its happens because git dont create `modules` directory.
al_server/.git/modules


Workaround for it wont work to:
git submodule update --init
It init only first level of subrepos.
When you do:
cd chat
git submodule update --init
It crashes cause missed `modules` directory for submodule:
al_server/.git/modules/chat/modules

Final workaround is create this directory and try last command again.
