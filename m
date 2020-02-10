Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F414C352A3
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 16:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7367C20838
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 16:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581352885;
	bh=liXq17+qr6Hy5MeURNsHF3gFnA5M9+yVIlUBTHY3NDM=;
	h=Date:From:To:Subject:List-ID:From;
	b=Df2DtqoTFAnpcjPyqolKcATm20ows7KJbsaHoAHVqbSVHpXH8h1FNuR/le7bsrDZu
	 i8yy3hhzAAwUOYYBm1QLj0VzV1sB9SlMFB7wH1jjHrD+MdiNTjfIEtZS9nwnkc5oeY
	 BXnvWg7PlTNyhA1emUEOCj2zvibEwrfdin11aRNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgBJQlY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:41:24 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:35129 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgBJQlY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 11:41:24 -0500
Received: by mail-wr1-f52.google.com with SMTP id w12so8632156wrt.2
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 08:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=54eHx56+I4sZtJtqwLGFAjAteAhuKLNTGYDkRbsMBpg=;
        b=Ll/RjwsnHJ0IqZefXm1cUgX7Mo2JvnTOkfNrYQhhCWBRrjrkOFO8QhdHxpzmKElheL
         N2MpQjvVEK7q9eXL7pBJcghIspxno/rywPz28AxBsLKi7buZZBI57lvA+Gp6SrbrEaBi
         MhR/3G1SZO1YnvhUyYFhqBjkCgeOIwEmxi/zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition;
        bh=54eHx56+I4sZtJtqwLGFAjAteAhuKLNTGYDkRbsMBpg=;
        b=QBIokxg+R+iH8iOP42HnUYVUkpon91QLHTNU6KEiVrMA4YXnb/cWp2j3dPfr4Ud2VA
         7pXmzWdFwIqf05WPTz3zWaAvAX/Nj+wQBVxsMgJjdE+bkMgz4dT2dJXMlMgK5bPCvbQs
         9DQmWGVQydepoc+gK1+NecT771RCHTCnR7VQ+qG30R5la6r+bmlU1s9CVt8kqqxi77fZ
         Yff++AOKS77kKWKC0mNTiXumOA7p6BXbHk1QIZcFLATOUwb06LW0ew/24y8Wif3xmQS1
         4n781e5xA+TYpvJJUBfp0cfpBBCq3kLgtpsFFx9LtArjVb+sRssWzvIYYbWRHKy7KLB4
         kvNQ==
X-Gm-Message-State: APjAAAXA/WsNVojDCcclgGhUxhx1e3GdZ5utW79jUX2Lj5PQAswPUuMJ
        5eLgTBX5KzoPGB1CCATJ1qi4GzPtKflATw==
X-Google-Smtp-Source: APXvYqw9t/gCk4nHgErzTi6d6KRzHyEwZpl3U89bzfbo5AUot1pQxs1RprJ69mUbSKKJDGeW4SyWAg==
X-Received: by 2002:a05:6000:1251:: with SMTP id j17mr3057717wrx.210.1581352881268;
        Mon, 10 Feb 2020 08:41:21 -0800 (PST)
Received: from chatter.i7.local (tor-exit-16.zbau.f3netze.de. [185.220.100.243])
        by smtp.gmail.com with ESMTPSA id w20sm1168957wmk.34.2020.02.10.08.41.18
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 08:41:19 -0800 (PST)
Date:   Mon, 10 Feb 2020 11:41:15 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     git@vger.kernel.org
Subject: git-patch-id and syntactically significant whitespace
Message-ID: <20200210164115.x4gciujyjisivfgi@chatter.i7.local>
Mail-Followup-To: git@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello:

Git patch-id is often used as convenient way to represent patches based 
on their content. It accomplishes this by attempting to normalize a 
patch before producing a hash of the result -- most notably, by trimming 
a lot of whitespace.

Unfortunately, this does not work well with syntactically-significant 
whitespace languages, notably Python and Make. For example, the 
following two patches produce identical patch-id's, but one of them is 
actually malicious.

Benign:

diff --git a/file1.py b/file1.py
index e574c49..6aa1937 100644
--- a/file1.py
+++ b/file1.py
@@ -1,3 +1,13 @@
 #!/usr/bin/python

+def is_logged_in(cookie):
+    if cookie:
+        print('User is logged in')
+        return True
+
+    return False
+
+if is_logged_in(True):
+    print('You are logged in')
+
 print('Hello!')

Malicious ("return True" is unindented, which results in is_logged_in() 
always returning "True"):

diff --git a/file1.py b/file1.py
index e574c49..6aa1937 100644
--- a/file1.py
+++ b/file1.py
@@ -1,3 +1,13 @@
 #!/usr/bin/python
 
+def is_logged_in(cookie):
+    if cookie:
+        print('User is logged in')
+    return True
+
+    return False
+
+if is_logged_in(True):
+    print('You are logged in')
+
 print('Hello!')

This mostly becomes a problem if we try to build any kind of patch 
indexing/retrieval systems that rely on patch-id to identify patches.  
While this is not a high-impact problem by any means, it's not a 
theoretical concern: git-format-patch includes functionality to provide 
patch dependencies via prerequisite-patch-id trailers [1]. An automated 
system attempting to auto-fetch dependencies can potentially retrieve 
and apply the malicious version of the patch.

I'm not sure what the solution here is, since changing git-patch-id to 
not discard whitespace is obviously going to defeat its entire purpose 
of "not ever changing". I mostly wanted to share my findings in case 
someone has thoughts on how to best approach this.

-K

[1] https://git-scm.com/docs/git-format-patch#_base_tree_information
