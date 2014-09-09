From: Harry Jeffery <harry@exec64.co.uk>
Subject: [PATCH] pretty-format: add append line-feed format specifier
Date: Tue, 09 Sep 2014 19:09:50 +0100
Message-ID: <540F426E.6080908@exec64.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 09 20:09:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRPrN-0003Cd-4z
	for gcvg-git-2@plane.gmane.org; Tue, 09 Sep 2014 20:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbaIISJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 14:09:37 -0400
Received: from mail-we0-f179.google.com ([74.125.82.179]:64092 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbaIISJg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 14:09:36 -0400
Received: by mail-we0-f179.google.com with SMTP id u56so3397714wes.10
        for <git@vger.kernel.org>; Tue, 09 Sep 2014 11:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=eEsp6satJlaAEOly5Es31E1Q5gkddAnf6kCGAxh9i2I=;
        b=arvD6cZ1+zmeLMoUhC4blJ7cvfqCfKH/IfM+2llb1NQs8/RE3FKJ3yfokPbADOr6Nf
         A51o500OW9kMnhgzq+5AIbqYtbKFn7kCEDN3ST11Ttuy32MHxaFg7VGc664c6sBVEUYY
         L7HaxdTMjp/q6ubxpS2JHQ4I8uSF+BR2jepGPtJdKGo5yMNCI/O56k6EZDAZxmfs489P
         TQzhyQXo7N7ml9iikq8HTdYCY0SkiJXL533Yo9xgvziexX6qtsNMLBcfP75yKk5+bHw3
         GoLLCdMfxCajiIbJZysd0SyQ6vUheQt/6lEYWeV4JEmtWWKt7H8nxd7PASe+RwA1fF/3
         2MIQ==
X-Gm-Message-State: ALoCoQlI9WGzVQDEPDxZ1GoMvQG3mlBfQtP0rz+dVWAhMHgSLpV5cevExdsqQLc2TMyyIg0lOVYl
X-Received: by 10.194.94.196 with SMTP id de4mr45714060wjb.86.1410286172510;
        Tue, 09 Sep 2014 11:09:32 -0700 (PDT)
Received: from [192.168.0.14] (cpc69047-oxfd25-2-0-cust267.4-3.cable.virginm.net. [81.109.93.12])
        by mx.google.com with ESMTPSA id y5sm15747131wje.32.2014.09.09.11.09.30
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Sep 2014 11:09:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256699>

Add a new format prefix `_` that causes a line-feed to be inserted
immediately after an expansion if the expansion expands to a non-empty
string. This is useful for when you would like a line for an expansion
to be prepended, but only when the expansion expands to a non empty
string, such as inserting a '%_d' expansion before a commit to show any
refs pointing towards it.

Signed-off-by: Harry Jeffery <harry@exec64.co.uk>
---
  Documentation/pretty-formats.txt |  4 ++++
  pretty.c                         | 10 ++++++++--
  2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/pretty-formats.txt 
b/Documentation/pretty-formats.txt
index 85d6353..842cd17 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -197,6 +197,10 @@ If you add a ` ` (space) after '%' of a 
placeholder, a space
  is inserted immediately before the expansion if and only if the
  placeholder expands to a non-empty string.

+If you add a `_` (underscore) after '%' of a placeholder, a line-feed
+is inserted immediately after the expansion if and only if the
+placeholder expands to a non-empty string.
+
  * 'tformat:'
  +
  The 'tformat:' format works exactly like 'format:', except that it
diff --git a/pretty.c b/pretty.c
index 44b9f64..ddb930d 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1416,7 +1416,8 @@ static size_t format_commit_item(struct strbuf 
*sb, /* in UTF-8 */
  		NO_MAGIC,
  		ADD_LF_BEFORE_NON_EMPTY,
  		DEL_LF_BEFORE_EMPTY,
-		ADD_SP_BEFORE_NON_EMPTY
+		ADD_SP_BEFORE_NON_EMPTY,
+		ADD_LF_AFTER_NON_EMPTY
  	} magic = NO_MAGIC;

  	switch (placeholder[0]) {
@@ -1429,6 +1430,9 @@ static size_t format_commit_item(struct strbuf 
*sb, /* in UTF-8 */
  	case ' ':
  		magic = ADD_SP_BEFORE_NON_EMPTY;
  		break;
+	case '_':
+		magic = ADD_LF_AFTER_NON_EMPTY;
+		break;
  	default:
  		break;
  	}
@@ -1449,6 +1453,8 @@ static size_t format_commit_item(struct strbuf 
*sb, /* in UTF-8 */
  	} else if (orig_len != sb->len) {
  		if (magic == ADD_LF_BEFORE_NON_EMPTY)
  			strbuf_insert(sb, orig_len, "\n", 1);
+		else if (magic == ADD_LF_AFTER_NON_EMPTY)
+			strbuf_addch(sb, '\n');
  		else if (magic == ADD_SP_BEFORE_NON_EMPTY)
  			strbuf_insert(sb, orig_len, " ", 1);
  	}
@@ -1460,7 +1466,7 @@ static size_t userformat_want_item(struct strbuf 
*sb, const char *placeholder,
  {
  	struct userformat_want *w = context;

-	if (*placeholder == '+' || *placeholder == '-' || *placeholder == ' ')
+	if (*placeholder == '+' || *placeholder == '-' || *placeholder == ' ' 
|| *placeholder == '_')
  		placeholder++;

  	switch (*placeholder) {
-- 
2.1.0
