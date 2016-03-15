From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 09/16] ref-filter: make "%(symref)" atom work with the ':short' modifier
Date: Tue, 15 Mar 2016 22:17:09 +0530
Message-ID: <1458060436-1215-10-git-send-email-Karthik.188@gmail.com>
References: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, jacob.keller@gmail.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 17:47:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afs8O-0000rQ-Du
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 17:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965234AbcCOQrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 12:47:48 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36216 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965097AbcCOQrp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 12:47:45 -0400
Received: by mail-pf0-f176.google.com with SMTP id u190so35746121pfb.3
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 09:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wmn/bak3WjQ7qFnZHFwRwA0Z4/ltt2BtFVfcn/zYjTk=;
        b=v8/a20SSPyHi0jRLaocXi3JvG+/EMJ5FUgIkZxiZ3yEiO6+0UQRczyepzRvgwFtEFT
         X+I1l6Y6lLxQesYYK9e1uOfiR9/au3RqqHm2gaqRpzjHw5bgQwXtp+28o+npRqqVuA2F
         xnXQQxMY0HQvGmHNGhljl2fM6jGY8ZcAd3csVrqio0UgUBbbwMKGnMzTnrO/SNXjFygF
         xOmifxDXMPKni3vonOAyRzzDv/ono7f0BZhKnmShgc0OaQM3uie+CnEOu+nzOTOvDWKm
         OZPGkpfPtpMGQVz9U7eaVQ969h7jGy8S4RviFyfrZQQzRTxffb6mS3DHXZipQfLNxuyp
         +0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wmn/bak3WjQ7qFnZHFwRwA0Z4/ltt2BtFVfcn/zYjTk=;
        b=aEUNqtkfk6fSknk9IPzFk2J32dUCqsiWNONLPHFjnfxWZnWPL2MAhoZfSjB0OWMNOs
         kTWiNOZyqRnaZHfrTqw8Ce4tIhN0n4FB19c/kiCd+ZcsHnTl2+bDV1duJ8kBuY48J73R
         f+NOrJwLXwNUiS3PScwzZ50kjHr6tSU/W/uJYGJ6sdpZOB65hHntWIhWj38AF+QlwuJZ
         KDT2Nv9vUJOIZJVYkSQKfql866fRjmMDBsDg4v2KGNR9J5ZmcPyJ+SvtPTUXP7De8DLT
         Gzn9FCY4yGV54Q+BEi+NN2Xl/DXMWYvrExstbeoFaXIy9v1ZTpYEDzd8GceQI4l9mAai
         FK0w==
X-Gm-Message-State: AD7BkJLIhUhR6EY4wA9FKEbGVQ0qVQWRkt8wx2f+ck3XOxS3HWOZ4VodJd5cFhb5Wzl+uA==
X-Received: by 10.66.150.170 with SMTP id uj10mr47244834pab.91.1458060464550;
        Tue, 15 Mar 2016 09:47:44 -0700 (PDT)
Received: from localhost.localdomain ([106.51.243.87])
        by smtp.gmail.com with ESMTPSA id i1sm40874361pfj.17.2016.03.15.09.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Mar 2016 09:47:43 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288870>

The "%(symref)" atom doesn't work when used with the ':short' modifier
because we strictly match only 'symref' for setting the 'need_symref'
indicator. Fix this by using comparing with valid_atom rather than used_atom.

Add tests for %(symref) and %(symref:short) while we're here.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c            |  2 +-
 t/t6300-for-each-ref.sh | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 8c97cdb..5c59b17 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -338,7 +338,7 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 		valid_atom[i].parser(&used_atom[at], arg);
 	if (*atom == '*')
 		need_tagged = 1;
-	if (!strcmp(used_atom[at].name, "symref"))
+	if (!strcmp(valid_atom[i].name, "symref"))
 		need_symref = 1;
 	return at;
 }
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 2c5f177..b06ea1c 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -38,6 +38,7 @@ test_atom() {
 	case "$1" in
 		head) ref=refs/heads/master ;;
 		 tag) ref=refs/tags/testtag ;;
+		 sym) ref=refs/heads/sym ;;
 		   *) ref=$1 ;;
 	esac
 	printf '%s\n' "$3" >expected
@@ -565,4 +566,27 @@ test_expect_success 'Verify sort with multiple keys' '
 		refs/tags/bogo refs/tags/master > actual &&
 	test_cmp expected actual
 '
+
+test_expect_success 'Add symbolic ref for the following tests' '
+	git symbolic-ref refs/heads/sym refs/heads/master
+'
+
+cat >expected <<EOF
+refs/heads/master
+EOF
+
+test_expect_success 'Verify usage of %(symref) atom' '
+	git for-each-ref --format="%(symref)" refs/heads/sym > actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+heads/master
+EOF
+
+test_expect_success 'Verify usage of %(symref:short) atom' '
+	git for-each-ref --format="%(symref:short)" refs/heads/sym > actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.7.3
