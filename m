From: Duy Nguyen <pclouds@gmail.com>
Subject: pthread_sigmask() on windows (wine actualy)
Date: Sun, 1 May 2016 18:06:07 +0700
Message-ID: <CACsJy8BrKsasiXZcc3=mm9Pq=qz_h6pi8edzpmT_7mKxwjnAqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git-for-windows <git-for-windows@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 01 13:15:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpLT-0006dd-Py
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbcEALGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2016 07:06:39 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36562 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbcEALGi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:06:38 -0400
Received: by mail-lf0-f66.google.com with SMTP id y84so22306520lfc.3
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ZufhboTtTHi4z5QKocyRv5fHMpVM8NzxWexaR76drCA=;
        b=QkWexq2J/t46HHdd4bDFcXhbB8rI4rKAtMTwFIcZnJmsJDsPMv2NSnb693NGTNZtX6
         Yoag8S9kj9jp5iThDGxCtT9ApZh6h+UIMgckqMdEhEQSRXKOXkfFH/iVyDzoMYsbTNf1
         36IGI9Nb7kQQlEjJKp+DHcLe84NVaIsILd7n9kNzhjScnfTMuBSuVaMQ/DU/ZsIgSES8
         12eR4IlD3ZpjBnJlb+kJb6j3ZJPRFcqH6yVab+1TtpdU4qwOP+bOguC2ghTSRccjeAio
         BlBmfzM7vRFQ9R6MC2mkmCRLlTHnwyvVU01MtRo2JD1965HJ8ebsSeZ9yP0hw8Sf4Bed
         viRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZufhboTtTHi4z5QKocyRv5fHMpVM8NzxWexaR76drCA=;
        b=PbHk1qS/o857+0cqGWPEN8RcOFqMCFV7Gy0fYc8Xt4dAfuKjj4VbqyJq4xZcApGQ+y
         DH8t2iOwtMmf/OXDV3D6rJBVZdH3M8gFS1mktGzVsS2Um5nIhrpiDK9EGLigkQXG+MSt
         cyspkfwYdyhocXKp7tq21YMO5gA9X7H5d6hK5uO9yU3kGSD++7BNFV4/TWT8qgaROInn
         3DncoOyYJaMZQADGnb6y/pCQFjk7+Cn5jeyHB2e+LCCpZkuDgdNkpuFE53t2tYtMf/Yv
         IMy4sRpSQfQ4wQnNGNFqQlTgLH6Z5ffntGAYToqHOrhzQw9uaUNL/siG6n49i/OiHOJy
         TglA==
X-Gm-Message-State: AOPr4FW6hUAjDkSFkVf9mC9R3Nxpj0bX3856InrPgaiD5JGonjDk4P2JwcExF0zYLRrWDbKlkbeQr3cEFAGzdA==
X-Received: by 10.25.165.135 with SMTP id o129mr13089247lfe.162.1462100796828;
 Sun, 01 May 2016 04:06:36 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Sun, 1 May 2016 04:06:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293149>

I got this while compiling master today using mingw32 cross toolchain

    CC run-command.o
run-command.c: In function 'run_thread':
run-command.c:596:3: warning: implicit declaration of function
'pthread_sigmask' [-Wimplicit-function-declaration]
run-command.c:596:23: error: 'SIG_BLOCK' undeclared (first use in this function)
run-command.c:596:23: note: each undeclared identifier is reported
only once for each function it appears in

This is added in c792d7b (run-command: teach async threads to ignore
SIGPIPE - 2016-04-19). From the look of it, wrapping #ifndef
GIT_WINDOWS_NATIVE is probably enough? I checked gfw/master too to see
how gfw deals with it, but the commit has not been merged there yet.
-- 
Duy
