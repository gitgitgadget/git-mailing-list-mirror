Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BTC_ID,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B17C2D0BE
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA1220661
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLYDdcFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfLDW3q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 17:29:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40571 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbfLDW3o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 17:29:44 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so1109107wrn.7
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 14:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DzCCkTzgUyIYBFSfzj6iOR0jXzzfHfA2nkvr+WW+YTg=;
        b=OLYDdcFDY3eYTY+kyIJE+WcC81H2vJfV5GmabrM/60a7g5yQ+Ak1b2qy2HisIai2lz
         HfiTRX3u5iKUZA0ZBsJuMn5PtcpM0nmVhXlryDSDYtRqbb8UDGbW4a5SHK2xygoDjFj2
         FNifTTNQ4GGZgq7ugvJpP+KuoCtcZ+5eeW4w3qmyeDV+8JUc1CwIyuivcCKUgG1U4vy5
         ggmTKrmPyW4kMIX8Ro2gM0SmhQ+Ix1Ae0ZR90J2LUv4U44cqL5Vgu2Oa6hwnyAcADxDt
         BVsZsfPBc4Yoak4ETlF/3mLOthPq/RFTI2LZuT1uWw4EXz+QFiQavVgCuYFAmGFJCQwh
         w1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DzCCkTzgUyIYBFSfzj6iOR0jXzzfHfA2nkvr+WW+YTg=;
        b=GHLrqqjGi5aEI6bCGJmdQfdZB2Hfzd4anFC235grA4/swkKPG2CeaQmk120LGJQ5wK
         w6J2LhUnw1Yx99haNpwLYnJJVX3RD1jn30i3uek9ekyzA071sOWH0Rta4M1RAz9M4aeE
         rcF1JQpo3ZxOjYke/Mo/v8UVcbvs627drzDHStg8wROLT1ACqbQX3U9687xf4HT+pXRR
         Adwz+HxgsLbUPQ72Qlg7vkeeBylU3nattcziALWcza6GRF2lGxbFfzbLgyFJ9pv3LNwR
         ZE+VfoAzjevyxJ/tquHWqg8quWU/8grVNv33sqaKx0pTn5EXFR8ug8/S2sn+VWFLbZXN
         Hwlw==
X-Gm-Message-State: APjAAAVm8dH7IzfI5X7jet7XlB0ZKvfWl9wzF94N+HmFfjxVyWSN9uHH
        ah9Urfw6LgWih2U2+/mbtXDxp/nK
X-Google-Smtp-Source: APXvYqwuWk4wADZCTIgjkblSDgMklOH+iNWyCpa3DK84qNFHnhBvzC1kxwmY9i2Fdh3imNUOgZr/8w==
X-Received: by 2002:a5d:50d2:: with SMTP id f18mr6564178wrt.366.1575498581993;
        Wed, 04 Dec 2019 14:29:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p5sm9495990wrt.79.2019.12.04.14.29.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 14:29:41 -0800 (PST)
Message-Id: <f0e658b984ca009c575368e661016f785922f970.1575498577.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
References: <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
        <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Dec 2019 22:29:29 +0000
Subject: [PATCH v4 03/11] git-p4: add new helper functions for python3
 conversion
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

Python 3+ handles strings differently than Python 2.7.  Since Python 2 is reaching it's end of life, a series of changes are being submitted to enable python 3.7+ support. The current code fails basic tests under python 3.7.

Change the existing unicode test add new support functions for python2-python3 support.

Define the following variables:
- isunicode - a boolean variable that states if the version of python natively supports unicode (true) or not (false). This is true for Python3 and false for Python2.
- unicode - a type alias for the datatype that holds a unicode string.  It is assigned to a str under python 3 and the unicode type for Python2.
- bytes - a type alias for an array of bytes.  It is assigned the native bytes type for Python3 and str for Python2.

Add the following new functions:

- as_string(text) - A new function that will convert a byte array to a unicode (UTF-8) string under python 3.  Under python 2, this returns the string unchanged.
- as_bytes(text) - A new function that will convert a unicode string to a byte array under python 3.  Under python 2, this returns the string unchanged.
- to_unicode(text) - Converts a text string as Unicode(UTF-8) on both Python2 and Python3.

Add a new function alias raw_input:
If raw_input does not exist (it was renamed to input in python 3) alias input as raw_input.

The AS_STRING and AS_BYTES functions allow for modifying the code with a minimal amount of impact on Python2 support.  When a string is expected, the as_string() will be used to convert "cast" the incoming "bytes" to a string type. Conversely as_bytes() will be used to convert a "string" to a "byte array" type. Since Python2 overloads the datatype 'str' to serve both purposes, the Python2 versions of these function do not change the data, since the str functions as both a byte array and a string.

basestring is removed since its only references are found in tests that were changed in the previous change list.

Signed-off-by: Ben Keene <seraphire@gmail.com>
(cherry picked from commit 7921aeb3136b07643c1a503c2d9d8b5ada620356)
---
 git-p4.py | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 66 insertions(+), 4 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 0f27996393..93dfd0920a 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -32,16 +32,78 @@
     unicode = unicode
 except NameError:
     # 'unicode' is undefined, must be Python 3
-    str = str
+    #
+    # For Python3 which is natively unicode, we will use 
+    # unicode for internal information but all P4 Data
+    # will remain in bytes
+    isunicode = True
     unicode = str
     bytes = bytes
-    basestring = (str,bytes)
+
+    def as_string(text):
+        """Return a byte array as a unicode string"""
+        if text == None:
+            return None
+        if isinstance(text, bytes):
+            return unicode(text, "utf-8")
+        else:
+            return text
+
+    def as_bytes(text):
+        """Return a Unicode string as a byte array"""
+        if text == None:
+            return None
+        if isinstance(text, bytes):
+            return text
+        else:
+            return bytes(text, "utf-8")
+
+    def to_unicode(text):
+        """Return a byte array as a unicode string"""
+        return as_string(text)    
+
+    def path_as_string(path):
+        """ Converts a path to the UTF8 encoded string """
+        if isinstance(path, unicode):
+            return path
+        return encodeWithUTF8(path).decode('utf-8')
+    
 else:
     # 'unicode' exists, must be Python 2
-    str = str
+    #
+    # We will treat the data as:
+    #   str   -> str
+    #   bytes -> str
+    # So for Python2 these functions are no-ops
+    # and will leave the data in the ambiguious
+    # string/bytes state
+    isunicode = False
     unicode = unicode
     bytes = str
-    basestring = basestring
+
+    def as_string(text):
+        """ Return text unaltered (for Python3 support) """
+        return text
+
+    def as_bytes(text):
+        """ Return text unaltered (for Python3 support) """
+        return text
+
+    def to_unicode(text):
+        """Return a string as a unicode string"""
+        return text.decode('utf-8')
+    
+    def path_as_string(path):
+        """ Converts a path to the UTF8 encoded bytes """
+        return encodeWithUTF8(path)
+
+
+ 
+# Check for raw_input support
+try:
+    raw_input
+except NameError:
+    raw_input = input
 
 try:
     from subprocess import CalledProcessError
-- 
gitgitgadget

