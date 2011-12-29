From: Tanaka Akira <akr@fsij.org>
Subject: git-log --pretty=format:'[%x00]%w(0,0,1)' doesn't print NUL and "]"
Date: Fri, 30 Dec 2011 03:41:20 +0900
Message-ID: <CANjopZFqiy+Ai4u6QYYnza5J7A3NAt-f17yR9AsYok-g3Hbb3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 29 19:41:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RgKut-0003eE-I5
	for gcvg-git-2@lo.gmane.org; Thu, 29 Dec 2011 19:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063Ab1L2SlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Dec 2011 13:41:22 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:52502 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab1L2SlV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Dec 2011 13:41:21 -0500
Received: by wibhm6 with SMTP id hm6so6470213wib.19
        for <git@vger.kernel.org>; Thu, 29 Dec 2011 10:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=Cru7O7yNms/itstTHKh8e0zwdvuATabPiOEaDIR3k14=;
        b=CDHnZXdB4zCApg7+UiZj932VZzOyEFEfkZv6j9Cn6MngvhW7/6PI2rnsB8tOIqiDpH
         yBwqoMbU6+72ORvlK9q1ncbfIDc+u/Z8cqMKx9vLCGcReytnpD5OZINRmNcklSxBe+5U
         fisGMFTP2pZJabEhT8oCOrMR4W8a02vBMd660=
Received: by 10.181.13.17 with SMTP id eu17mr80947810wid.12.1325184080336;
 Thu, 29 Dec 2011 10:41:20 -0800 (PST)
Received: by 10.180.94.35 with HTTP; Thu, 29 Dec 2011 10:41:20 -0800 (PST)
X-Google-Sender-Auth: y9V_DA6GazSfIrAiDOZ2WK_XtmQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187782>

I found that git-log doesn't print characters in --pretty option as follows.

  % git log --pretty=format:'[%x00]%w(0,0,1)' |od -c
  0000000   [  \n   [  \n   [  \n   [  \n   [  \n   [  \n   [  \n   [  \n
  *
  0022320   [  \n   [  \n   [  \n   [
  0022327

I think NUL and "]" should be printed.

Note that git log works as I expected if I use %w(0,0,0) instead of %w(0,0,1),
I don't use %w(0,0,1) or I use %x01 instead of %x00.

  % git log --pretty=format:'[%x00]%w(0,0,0)' |od -c
  0000000   [  \0   ]  \n   [  \0   ]  \n   [  \0   ]  \n   [  \0   ]  \n
  *
  0044640   [  \0   ]  \n   [  \0   ]  \n   [  \0   ]  \n   [  \0   ]
  0044657
  % git log --pretty=format:'[%x00]' |od -c
  0000000   [  \0   ]  \n   [  \0   ]  \n   [  \0   ]  \n   [  \0   ]  \n
  *
  0044640   [  \0   ]  \n   [  \0   ]  \n   [  \0   ]  \n   [  \0   ]
  0044657
  % git log --pretty=format:'[%x01]%w(0,0,1)' |od -c
  0000000   [ 001   ]  \n   [ 001   ]  \n   [ 001   ]  \n   [ 001   ]  \n
  *
  0044640   [ 001   ]  \n   [ 001   ]  \n   [ 001   ]  \n   [ 001   ]
  0044657

I used git 1.7.8.2.

  % git --version
  git version 1.7.8.2
-- 
Tanaka Akira
