From: Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH 0/5] protocol v2 for upload-pack
Date: Fri, 27 Feb 2015 17:01:53 -0800
Message-ID: <1425085318-30537-1-git-send-email-sbeller@google.com>
References: <CAGZ79ka8Zg86qqvWByNiP3F6a9QggO-bNY3ZZ9g+A-MdKYQ7NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, gitster@pobox.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 02:02:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRVnY-0003gA-0E
	for gcvg-git-2@plane.gmane.org; Sat, 28 Feb 2015 02:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbbB1BCD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2015 20:02:03 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:43326 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbbB1BCB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2015 20:02:01 -0500
Received: by igbhn18 with SMTP id hn18so4921870igb.2
        for <git@vger.kernel.org>; Fri, 27 Feb 2015 17:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=rheUyUgNseWTTO8HWMenrIYxJH8t80caCAYEUsT7nZg=;
        b=IRQo57eR0QQVvT2fggeoNLCoBdAd0+c8C6QLJKM2Et/JXPyqN3tBijDzc8oQxx79a8
         JXKqmuAg0Zx7/lj1CaFrG+AX7V2sVrPuVXcECa+7B2csBD5lnx226E5Io4jA5l0QQfA3
         8B9GRip/AmCz1qTnyPuFImcvDD8SylHjmd3K6Hyq7UodusItYz5XUncScQCev9G27zJj
         nZzGH58YuirRUnP/ggCzS0SoLq728pLLsoWb8Og8v3PYkwB4S41HTow53UZ/lL/bcgXx
         J2jLXJNtsWJ/TbH2AX0t/3t0HfIWUPowVZXKcOhV3rdJdIhvCviUOIxlJIwXXyGVSk0t
         GHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=rheUyUgNseWTTO8HWMenrIYxJH8t80caCAYEUsT7nZg=;
        b=GY7Olz5mYf1X9vuvI3Bzvpli0NTGfvF0petsTLaH6/iexVi8vMXBqkw27F0OBEJUYS
         3DtnGpQ4vTVLV65rGWrCsZPgiUSmcYy4+rLio5EV0S4xF7Ehu/7TplyV1qfzTupQJ/8w
         BvJZih8Favi3QHSa3OH54X/JDIMpW87jm2JQoNn962mvtWIt1F7CGnnKU5UIVT0tJet7
         2clbPm8cWM+rJVMdtE2lMy1XnwO+ngM6Z2Y4PG3/L1miSAVKWMso0ki+zKT6NNwOKYJx
         rujuOrUlRCmhBn7Mz60c2LECjcvsikYKrmEWntvCbl6HXXrTdO2r1r3VYT3Xk0e+jE7Z
         TeVA==
X-Gm-Message-State: ALoCoQlr/EROLpFOGnDez8wOUEIfM4pbSOZUr0Kb9ux0iQb+g0TGqeu7DvO2wZ/9Akm9HCkKjIJV
X-Received: by 10.107.169.42 with SMTP id s42mr22414101ioe.46.1425085321084;
        Fri, 27 Feb 2015 17:02:01 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:700c:d3d2:5834:b5cc])
        by mx.google.com with ESMTPSA id u13sm3341808ioi.6.2015.02.27.17.02.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Feb 2015 17:02:00 -0800 (PST)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <CAGZ79ka8Zg86qqvWByNiP3F6a9QggO-bNY3ZZ9g+A-MdKYQ7NQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264523>

Heavily inspired by the ideas of Duy, who wrote the first
patches nearly a year ago.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  upload-pack: only accept capabilities on the first "want" line
  upload-pack: support out of band client capability requests

Stefan Beller (3):
  connect.c: connect to a remote service with some flags
  daemon.c: accept extra service arguments
  WIP/Document the http protocol change

 Documentation/git-upload-pack.txt                 | 10 +++++-
 Documentation/technical/http-protocol.txt         |  4 +--
 Documentation/technical/protocol-capabilities.txt |  4 +++
 builtin/fetch-pack.c                              |  2 +-
 builtin/send-pack.c                               |  2 +-
 connect.c                                         | 21 ++++++------
 connect.h                                         |  2 +-
 daemon.c                                          | 37 +++++++++++++--=
------
 transport.c                                       |  3 +-
 upload-pack.c                                     | 39 +++++++++++++++=
++------
 10 files changed, 86 insertions(+), 38 deletions(-)

--=20
2.3.0.81.gc37f363
