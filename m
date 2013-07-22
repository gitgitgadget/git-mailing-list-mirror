From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH v7 0/4] config: add support for http.<url>.* settings
Date: Sun, 21 Jul 2013 20:18:34 -0700
Message-ID: <f1109cf05979890ea9441fae7881586@f74d39fa044aa309eaea14b9f57fe79>
Cc: David Aguilar <davvid@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 22 05:18:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V16eD-0004dI-2J
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 05:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754980Ab3GVDSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jul 2013 23:18:49 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:57586 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754743Ab3GVDSs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jul 2013 23:18:48 -0400
Received: by mail-pb0-f52.google.com with SMTP id xa12so6465544pbc.39
        for <git@vger.kernel.org>; Sun, 21 Jul 2013 20:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=eLdaPwwkqaURDJipDZIUYyVa+94iehUtuz+3ZaNF0E4=;
        b=dRwf8ymP8cGM5ynXf/qhnnxQfnfVmyAQIACchgN153Pk8jFb6H7ldPUtIYxyH7K4BG
         PGlW2PQmFnXSnQOelSX+vJc3hVB9JOWadS3AvetLCbjCFVpO4YitDp9KTigE2Hge/hcs
         GN8DJE6GhkVgD2720zRaLvmFpbbKiv6air+kKp9nkiR3TdVKD5fcKq/mgNmtUKvDQACK
         bKWYk0qhS7cKtO7NJuAZ3YH0KwHufdJHPdBIeHx9+i2CfPcUHN9+C9+Y3hKRTY3GayJi
         RHZxRobIQuMEd7kHxWjQXyF37zYwxFAdzn1O2kxNN8y3BtL+wvVFgZmKtUa0dwWnfMLh
         ABLw==
X-Received: by 10.68.2.69 with SMTP id 5mr28491417pbs.124.1374463127738;
        Sun, 21 Jul 2013 20:18:47 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id fl2sm36325047pab.23.2013.07.21.20.18.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Jul 2013 20:18:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230952>

NOTE: This patch requires the following preparatory change:

 f1ff763 http.c: fix parsing of http.sslCertPasswordProtected variable

which is currently in pu.


This patch series adds support for http.<url>.* settings.  The patch is
organized as a series of improvements on the functionality:

1/4 - adds basic textual matching support
2/4 - adds URL normalization before matching
3/4 - adds a test for the URL normalization function
4/4 - adds any user matching


With-Feedback-From-jh: Junio C Hamano <gitster@pobox.com>

Differences from v6:

1/4 - Updated from v6's 1/4:

* Added an http_init memset for http_option_max_matched_len (feedback-jh)

2/4 - Updated from v6's 2/4:

* Reduce use of strchr (feedback-jh)
* Correctly handle characters with high bit set during normalization
* Detect some additional invalid scheme names

3/4 - Updated from v6's 3/4:

* Add several additional tests for high bit set characters and invalid schemes

4/4 - Updated from v6's 4/4:

* Added an http_init memset for http_option_user_matched (feedback-jh)


Applicable comments from earlier cover:

To better support matching URLs that are equivalent but spelled differently, a
url_normalize function has been added.  Currently this patch leaves it in
http.c as http_options_url_normalize as I am unclear whether it should go into
url.{h,c} at this time since only http.c uses it.

Since the url_normalize function's behavior is non-trivial, it is presented as
a separate patch on top of the basic http.<url>.* settings support.  A new test
for it has also been included as a separate patch.  I am unclear on the proper
number for this test, but have gone ahead and put it with the other http tests
since this patch series places the url_normalize function into http.c.


Kyle J. McKay (4):
  config: add support for http.<url>.* settings
  config: improve support for http.<url>.* settings
  tests: add new test for the url_normalize function
  config: allow http.<url>.* any user matching

 .gitignore               |   1 +
 Documentation/config.txt |  19 ++
 Makefile                 |   5 +
 http.c                   | 666 +++++++++++++++++++++++++++++++++++++++++++++--
 t/t5200-url-normalize.sh | 182 +++++++++++++
 t/t5200/README           |   9 +
 t/t5200/url-1            |   1 +
 t/t5200/url-10           |   1 +
 t/t5200/url-11           |   1 +
 t/t5200/url-2            |   1 +
 t/t5200/url-3            |   1 +
 t/t5200/url-4            |   1 +
 t/t5200/url-5            |   1 +
 t/t5200/url-6            |   1 +
 t/t5200/url-7            |   1 +
 t/t5200/url-8            |   1 +
 t/t5200/url-9            |   1 +
 test-url-normalize.c     |  62 +++++
 18 files changed, 938 insertions(+), 17 deletions(-)
 create mode 100755 t/t5200-url-normalize.sh
 create mode 100644 t/t5200/README
 create mode 100644 t/t5200/url-1
 create mode 100644 t/t5200/url-10
 create mode 100644 t/t5200/url-11
 create mode 100644 t/t5200/url-2
 create mode 100644 t/t5200/url-3
 create mode 100644 t/t5200/url-4
 create mode 100644 t/t5200/url-5
 create mode 100644 t/t5200/url-6
 create mode 100644 t/t5200/url-7
 create mode 100644 t/t5200/url-8
 create mode 100644 t/t5200/url-9
 create mode 100644 test-url-normalize.c

-- 
1.8.3
