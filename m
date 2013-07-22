From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH v8 0/4] config: add support for http.<url>.* settings
Date: Mon, 22 Jul 2013 05:56:40 -0700
Message-ID: <3c7fc982841069ce79faf227e007815@f74d39fa044aa309eaea14b9f57fe79>
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
X-From: git-owner@vger.kernel.org Mon Jul 22 14:57:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1Ffe-0001WX-PR
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 14:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754635Ab3GVM4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 08:56:55 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55054 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754207Ab3GVM4x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 08:56:53 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so7073550pbb.33
        for <git@vger.kernel.org>; Mon, 22 Jul 2013 05:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=qPpBJcgrbDZQcqEN+J2dEr7I/RS4lNJXk1+bOTHeOPs=;
        b=rUmitxaLlXVswsUn2ypT+UqAhdjqSZLDRdc9hdByHdBLUn7/rSDPvfmorJkWjFCP5J
         gCoGdZIq0bQQznBdiLUk1SbOf4HbbP0KtjsAHBcHS8+0ZjYDd803PxyejVNpp59RIQ9v
         yfEnT4BSjdyA8NeUepXGf/07Ogn7nSK0uJJAScNxnqRYS9JVlFO/ZXkbKjbeU+2jMOw3
         9pDOceqm+s101zp2Mw05kx+mcCg9irO0FoDGfqretKSdA2HbWWp0JPLDytjKYlWxrJs0
         7fk1XD7x9hzVq6litcUCUkhdpVNl3iUUxt7RfRR1sI0UbrbhyIC41JF0eCgGfy396ZTK
         82pQ==
X-Received: by 10.68.138.170 with SMTP id qr10mr30334199pbb.158.1374497813455;
        Mon, 22 Jul 2013 05:56:53 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id x8sm35698437pbb.39.2013.07.22.05.56.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 22 Jul 2013 05:56:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230977>

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

Differences from v7:

1/4 - No changes since v7's 1/4

2/4 - No changes since v7's 2/4

3/4 - Updated from v7's 3/4:

* Add a binary attribute for the url-* files (feedback-jh)
* Make test-url-normalize.c able to run http_options (feedback-jh)
* Add additional tests and corresponding config files (as t/t5200/config-*)
* Remove extraneous comment from t5200-url-normalize.sh (feedback-jh)

4/4 - Updated from v7's 4/4:

* Update http.<url>.* documentation with another example (feedback-jh)
* Add another url normalization config test to match the new example


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
 Documentation/config.txt |  25 ++
 Makefile                 |   5 +
 http.c                   | 666 +++++++++++++++++++++++++++++++++++++++++++++--
 t/.gitattributes         |   1 +
 t/t5200-url-normalize.sh | 199 ++++++++++++++
 t/t5200/README           |  18 ++
 t/t5200/config-1         |   8 +
 t/t5200/config-2         |   3 +
 t/t5200/config-3         |   4 +
 t/t5200/url-1            | Bin 0 -> 20 bytes
 t/t5200/url-10           | Bin 0 -> 23 bytes
 t/t5200/url-11           | Bin 0 -> 25 bytes
 t/t5200/url-2            | Bin 0 -> 20 bytes
 t/t5200/url-3            | Bin 0 -> 23 bytes
 t/t5200/url-4            | Bin 0 -> 23 bytes
 t/t5200/url-5            | Bin 0 -> 23 bytes
 t/t5200/url-6            | Bin 0 -> 23 bytes
 t/t5200/url-7            | Bin 0 -> 23 bytes
 t/t5200/url-8            | Bin 0 -> 23 bytes
 t/t5200/url-9            | Bin 0 -> 23 bytes
 test-url-normalize.c     | 132 ++++++++++
 22 files changed, 1045 insertions(+), 17 deletions(-)
 create mode 100755 t/t5200-url-normalize.sh
 create mode 100644 t/t5200/README
 create mode 100644 t/t5200/config-1
 create mode 100644 t/t5200/config-2
 create mode 100644 t/t5200/config-3
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
