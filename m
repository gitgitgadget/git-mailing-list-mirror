Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0788C35669
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 21:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48DF2073A
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 21:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/Je/oc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbgBUVgv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 16:36:51 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52965 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgBUVgu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 16:36:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so3240117wmc.2
        for <git@vger.kernel.org>; Fri, 21 Feb 2020 13:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=p56gSG1dGjp/TZyIXuqzbEJiQkt+erjvlh9gz7GwWTo=;
        b=e/Je/oc0910nqb5VdHmL7k3UwlfzqUgONzQLHIaDD1wlIGFK38hZmSx9Dfx1E8Uy3E
         mamSKUyUPXaNw3PZvuB0Lw1WbgLs+PgJyDDtixZ55U254Kj4U2xkfZvsQDtpsVKbx617
         ARO7CcHIgFT1du4dyTyK1+Z2d3yWeA2q3Sxv47GIGPLyy9ElCAoxVtcHnRUvQ+FZwPeT
         wmcOXOVRvvJVieaw4Y6Ohq/aGvcyGqN2/AJKEwHjFVJScsFmUQTiIxHQ6iEtSjPxJQhs
         ubJikYTN/mWld9NIgDLLHm/5R9O1eHE6ckViOsKfo0R89Ec1RU55rFb9bsVtXBkBFksX
         WXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=p56gSG1dGjp/TZyIXuqzbEJiQkt+erjvlh9gz7GwWTo=;
        b=dgLSe1o7pCGd9ersUI13EvdK91gMEJ+QxbliuIaZO9hyt8HmR8fe+k/U8g428XVJHA
         +UMX79yI6EfSFxfSYwTOmEb4I+b9EKk/gdWbk9AGIrYh7rIWQxzUKFZW5+J4R+XrTcyI
         k63QiMIaEHc91mVkJy7psX5cYp4Du6ZGzcQ+3Id2aewaRPjllzCWzOopqF8v8Gir8lnH
         dA8ptuuYDx4oovMQqsUamL0kB/q1vHFuB8qOJ7RmqDccfh7NAkivg363MBG98ma9LAW6
         o2Ya3x9K1+7pwRg16ZxpGZ/RrWeopp5kEhwQXkH2ZE795LtL1KmlHcJSEqKnXxtX5OWp
         bKXA==
X-Gm-Message-State: APjAAAW1g0NEwyoPLogFMh2z1UHIdEaSZlivWZHb1frDBBo6UHvmGS+F
        QN9xwP8FzBzPckICSLdPww96ecx5
X-Google-Smtp-Source: APXvYqwFlT0XkO0t3KKthB13O0wYlsOIqhaFCTxBbYIrbjxvcbZ8/bmTK8I1rm/s0HSvOJ/OkdjEUQ==
X-Received: by 2002:a1c:a752:: with SMTP id q79mr5533023wme.64.1582321005998;
        Fri, 21 Feb 2020 13:36:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b16sm5129353wmj.39.2020.02.21.13.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 13:36:45 -0800 (PST)
Message-Id: <583fdd0fe9b94c6031be40749d36ff61d55b55e3.1582321003.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.559.git.1582321003.gitgitgadget@gmail.com>
References: <pull.559.git.1582321003.gitgitgadget@gmail.com>
From:   "Jorge Lopez Silva via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Feb 2020 21:36:43 +0000
Subject: [PATCH 2/2] config: documentation for HTTPS proxy client cert.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jorge <JALopezSilva@gmail.com>,
        Jorge Lopez Silva <jalopezsilva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jorge Lopez Silva <jalopezsilva@gmail.com>

The commit adds 4 options, client cert, key, key password and CA info.
The CA info can be used to specify a different CA path to validate the
HTTPS proxy cert.

Signed-off-by: Jorge Lopez Silva <jalopezsilva@gmail.com>
---
 Documentation/config/http.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index e806033aab8..7e704687e87 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -29,6 +29,20 @@ http.proxyAuthMethod::
 * `ntlm` - NTLM authentication (compare the --ntlm option of `curl(1)`)
 --
 
+http.proxycert::
+	File indicating a client certificate to use to authenticate with an HTTPS proxy.
+
+http.proxykey::
+	File indicating a private key to use to authenticate with an HTTPS proxy.
+
+http.proxykeypass::
+	When communicating to the proxy using TLS (using an HTTPS proxy), use this
+	option along `http.proxykey` to indicate a password for the key.
+
+http.proxycainfo::
+	File containing the certificates to verify the proxy with when using an HTTPS
+	proxy.
+
 http.emptyAuth::
 	Attempt authentication without seeking a username or password.  This
 	can be used to attempt GSS-Negotiate authentication without specifying
-- 
gitgitgadget
