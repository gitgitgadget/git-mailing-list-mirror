From: Yi EungJun <semtlenori@gmail.com>
Subject: [PATCH v6 0/1] http: Add Accept-Language header if possible
Date: Tue, 23 Dec 2014 01:44:17 +0900
Message-ID: <1419266658-1180-1-git-send-email-eungjun.yi@navercorp.com>
References: <CAO2U3QjG2rUgUrM5odX0UOnHsENnYTfwaRLhHv8gka7qj4XWdw@mail.gmail.com>
Cc: Yi EungJun <eungjun.yi@navercorp.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Blume <blume.mike@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 22 17:44:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y365u-0003Eq-Ri
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 17:44:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755362AbaLVQo0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 11:44:26 -0500
Received: from mail-pd0-f175.google.com ([209.85.192.175]:45050 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755357AbaLVQoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 11:44:25 -0500
Received: by mail-pd0-f175.google.com with SMTP id g10so6123263pdj.6
        for <git@vger.kernel.org>; Mon, 22 Dec 2014 08:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iYhZ1MSFnbX9HMKWHw6cctQ+HBbVI0KXYaZISiN9vJM=;
        b=HOW2+XrpnCN9cI4WsAzRGrLpAf2keN1r8eY+Nk9KFX6RLEeiJitzmlgYZP/RaI7WuT
         eCxmdxFTZ5ArXGHyc3nCLg3vVOpUgUGRiPAOSK5JvGd1M/MTfx/jSKDPzRvbkfGBNzKJ
         rMsTmCszAJ4rvF1VbhINknJWUyuoYkJUwRljR40hKjRpxIIo6zE7aCn45sBa+TrlHVP6
         g35QfO0QO/Um1Wzgee18bk/dgQ+veFWpovob9RxG00BYdvVbN0GFtIEN9QbUjBybWFAW
         JajmGANpbpmc7Rq3uHTK3+LLLJHUfP2j37b5PH9jUkiM9AwafHzrfapQWcOgG1TlEvqe
         Va8g==
X-Received: by 10.68.220.196 with SMTP id py4mr36359272pbc.33.1419266664595;
        Mon, 22 Dec 2014 08:44:24 -0800 (PST)
Received: from gmail.com ([222.234.94.10])
        by mx.google.com with ESMTPSA id bx13sm17732247pdb.19.2014.12.22.08.44.21
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Dec 2014 08:44:23 -0800 (PST)
X-Google-Original-From: Yi EungJun <eungjun.yi@navercorp.com>
X-Mailer: git-send-email 2.2.0.375.gcd18ce6.dirty
In-Reply-To: <CAO2U3QjG2rUgUrM5odX0UOnHsENnYTfwaRLhHv8gka7qj4XWdw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261648>

Changes since v5

>From Junio C Hamano's review:

* The tests use `ls-remote` instead of `clone` for tests; I copied the test
  code from ba8e63dc30a80656fddc616f714fb217ad220c04.

* Set cached_accept_langauge to NULL after free it.

>From Eric Sunshine's review:

* get_accept_language() returns a pointer to const char instead of strbuf; the
  type of cached_accept_language also has been changed to char* from strbuf*

* write_accept_language(), which is extracted from get_accept_language(),
  respects MAX_SIZE_OF_HEADER.

* The for-loop in write_accept_language() works correctly if lang_begin points
  an empty string.

>From Jeff King's advice:

* get_preferred_languages() considers LC_MESSAGES only if NO_GETTEXT is not
  defined.

* Remove the tests for LC_MESSAGES, LANG and LC_ALL.

Yi EungJun (1):
  http: Add Accept-Language header if possible

 http.c                     | 173 +++++++++++++++++++++++++++++++++++++++++++++
 remote-curl.c              |   2 +
 t/t5550-http-fetch-dumb.sh |  32 +++++++++
 3 files changed, 207 insertions(+)

-- 
2.2.0.375.gcd18ce6.dirty
