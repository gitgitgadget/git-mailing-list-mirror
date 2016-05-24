From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v8 0/3] bisect--helper: check-term-format() & write_terms()
Date: Tue, 24 May 2016 12:51:21 +0530
Message-ID: <20160524072124.2945-1-pranit.bauva@gmail.com>
References: <1464014928-31548-1-git-send-email-pranit.bauva@gmail.com>
Cc: Pranit Bauva <pranit.bauva@gmail.com>, larsxschneider@gmail.com,
	christian.couder@gmail.com, chriscool@tuxfamily.org,
	sunshine@sunshineco.com, Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 09:22:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b56fw-0003jb-8b
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 09:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbcEXHWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 03:22:44 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36057 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185AbcEXHWo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 03:22:44 -0400
Received: by mail-pf0-f196.google.com with SMTP id g132so1219545pfb.3
        for <git@vger.kernel.org>; Tue, 24 May 2016 00:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GCezls1QoavZMQJiuINwFb687L7mZ9EnTFcTX73nNU0=;
        b=qZwfyGeK2fMlblLkf79yMLmBOyGt/hNI8UThDHH94Gw4//bk0splntxCD1lCb5Yf8E
         6D/wHyLAzr4OvPFnIvza7OVkyuE5qy9nrabWs9YPCclFOaBhB3jTvAei24h/OQoSd/VB
         /88iOR0FVhU9RqfJJrfrsS1XtTZCnfWoIyCDOEL5MLfVn3+ys5d0kGRxSr1aslUuG+zu
         aydwS8q+tNtTgQqB2KF5NrIeT2wz+lv3m2UbCvIi6ldxcfrDwqtKgHmxHb9Vac32nW3k
         OW5nWjugxgbgLvjcqMQx8W4Jd/tb+NuJvzy4xbb1AOSSZ1jKAdEkyNzdY6BpK34Q12js
         vUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GCezls1QoavZMQJiuINwFb687L7mZ9EnTFcTX73nNU0=;
        b=FDw0HNPg4T/soiLNe7pcjcjuqQMsDrKhiQgWxqulCpFTVv/5zbR7LhB/FnRqsVPc0+
         XMtKYL2WW5Q2rH1aCJOtYjKyLtfxw3egbZgV+wRNckIcNDikfaDz0fmlLl/b3J8t5s7l
         T/gQK1tD2SfAKFwghoaDJsXEd9XKG4e3wzDt2qrq0vevzehJX90JJkUa9RKAaqzJaYqW
         8Ehl4ZTGfiC5kyt10xzzmuR7sdwf2cthUixHT/6Usj613RL9C9Nl/5VPEVxGIe6oOybT
         7OkTnhttFc+FOiDEbI5yCF1HzqrqGrR70MvTJYs8M70vKRbQDKIUmQE3/pf6DwjReSZO
         2Q+w==
X-Gm-Message-State: ALyK8tI7299ZB1tQKrKjHd0KxUoQTriAjQ1SS/gj8GnhHYtRInRIgRygfoMuLOsv0Gu5IA==
X-Received: by 10.98.48.71 with SMTP id w68mr4485211pfw.18.1464074563338;
        Tue, 24 May 2016 00:22:43 -0700 (PDT)
Received: from localhost.localdomain ([183.87.83.48])
        by smtp.gmail.com with ESMTPSA id a5sm2491900pat.19.2016.05.24.00.22.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 00:22:42 -0700 (PDT)
X-Mailer: git-send-email 2.8.3
In-Reply-To: <1464014928-31548-1-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295421>

Here is the link to v7[1]. This has a few modifications.

Changes wrt v7 as suggested by Eric are:

 * Include the name of the file in the error message which couldn't be opened.

 * Use error_errno() with which we can make the error message more valuable.

Pranit Bauva (3):
  bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
  bisect: rewrite `check_term_format` shell function in C
  bisect--helper: `write_terms` shell function in C

 builtin/bisect--helper.c | 96 +++++++++++++++++++++++++++++++++++++++++++++---
 git-bisect.sh            | 49 ++++--------------------
 2 files changed, 97 insertions(+), 48 deletions(-)

-- 
2.8.3
