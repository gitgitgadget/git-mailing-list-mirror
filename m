From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] config.c: drop local variable
Date: Wed, 27 Apr 2016 14:30:39 -0700
Message-ID: <1461792640-18898-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Apr 27 23:31:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avX2w-0004eb-1U
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 23:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751AbcD0Var (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 17:30:47 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34027 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738AbcD0Vap (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 17:30:45 -0400
Received: by mail-pa0-f53.google.com with SMTP id r5so24234454pag.1
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 14:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Il3sBPx3RDsVdGQ1s6yOGZ9wvUSNb0U/rVMdarTV+wg=;
        b=poHM4H5Kt5YRcZbRtS63qSLN1Vw5B8GpzveanR6Jf8+g7Gf8j2jE2uSFYPr5Ge7DuA
         xmkA0xI2NpTXXtU442FTJ1h+czCiAoFWsLUUoMYmG3BhRyifvahNuhG1NJDudQZgZ9m6
         NC80XBFhGq+npm+hokY4NBUjNwcZN1aFNIWUsUvW9ZPXYG1kpKrqBSHRuZX0mAbVwZ7y
         ilDijrFi84sA9zfcgc4WeB3oPTaOW14skFWnoqGdlSFi3uuSMeqUxo40XkZ8wmWNhJ0+
         8aFUE7Q4+oQSrdJ+BAdTQGQSrhnhJoE5GwUqsSfcxap4mkooM/Rh+9Fw7xZURvGfTCNP
         W+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Il3sBPx3RDsVdGQ1s6yOGZ9wvUSNb0U/rVMdarTV+wg=;
        b=NQzi1fnDDmfXF1WImar3rWsc2pR8tHkSY+sSZ3j6Gl5EUprfO+n935UHochmJmGwx5
         2Yo4aBqDohzVKnpidbOFcjM/9na8rnVDKVR+3uvTPGSzuGdaipKzpVvjAuxDNMLqB7TE
         jQRtyW96oHVnDlwqf4fMjFix9BtmznY6nXkVDvDigJvvaPB13+p6uaPSufSV4M9sDqq2
         Y71SobOExQv0R4fLZsROsqlsC0IhGxuTxIb8XqhOhuYYA5l4JNRQ7qdTv/ugsMasQfWW
         gAipjln4RGzFeHD0hgifQCSdbYf7LJVt4Hiki0av3/ysafZa6Lm0nD9JNj3q4lcQuwRn
         dwEw==
X-Gm-Message-State: AOPr4FV6FYdK4BqkEk3m5z8oc9HaevxrvAgeQFkTJ5kzTELHuuUruwPTFEncN4yeQVPVCjMm
X-Received: by 10.66.193.202 with SMTP id hq10mr14953039pac.6.1461792644532;
        Wed, 27 Apr 2016 14:30:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:95db:80a2:4fac:5374])
        by smtp.gmail.com with ESMTPSA id yp9sm9181950pab.42.2016.04.27.14.30.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 27 Apr 2016 14:30:43 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.41.g0ac0153.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292830>

As `ret` is not used for anything except determining an early return,
we don't need a variable for that. Drop it.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

While reading config code, I found 2 nits. Both improve readability,
no bugfix or feature.

As it is generally discouraged to have cleanup patch churn,
I checked master..pu to see any possible topics in flight conflicting
on config.c or submodule-config.c and there is nothing close by.

Thanks,
Stefan

 config.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/config.c b/config.c
index 10b5c95..262d8d7 100644
--- a/config.c
+++ b/config.c
@@ -1309,14 +1309,11 @@ static struct config_set_element *configset_find_element(struct config_set *cs,
 	struct config_set_element k;
 	struct config_set_element *found_entry;
 	char *normalized_key;
-	int ret;
 	/*
 	 * `key` may come from the user, so normalize it before using it
 	 * for querying entries from the hashmap.
 	 */
-	ret = git_config_parse_key(key, &normalized_key, NULL);
-
-	if (ret)
+	if (git_config_parse_key(key, &normalized_key, NULL))
 		return NULL;
 
 	hashmap_entry_init(&k, strhash(normalized_key));
-- 
2.8.0.41.g0ac0153.dirty
