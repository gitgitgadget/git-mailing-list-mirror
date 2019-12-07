Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833A5C2D0C4
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 17:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511C7217BA
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 17:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0Qp+qbT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfLGRr5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Dec 2019 12:47:57 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:41635 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfLGRrz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Dec 2019 12:47:55 -0500
Received: by mail-wr1-f41.google.com with SMTP id c9so11318233wrw.8
        for <git@vger.kernel.org>; Sat, 07 Dec 2019 09:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OS5efDlzdZteNOo7RSoCHPJVXI1UrPtxfmlVrDV6KqQ=;
        b=J0Qp+qbT69WETi+baOibqnO4+6X5W1A7Uv1l6pnSrtIpVerSYNqDp4MTor5zfNVZOJ
         QxOU0zlJ3ugc6uvBin9Xb2kN7nBTxF7pcmb6pA+9qOOW52sceaXsPq1hQ7RSmG4oYa59
         bXRNDwFPBfIfFjSE+FVtNgwW8+lUbU9DDtbPBiPF5cUKnLivD9Nyqizu06JJ3jUiplwT
         H5bEPq0Amt+8/ZBgTfLS/oeu7GqJLYs/SOsxGCQzO5nE7fL6OtzCaXxmP1F9TGGexEqk
         WHEcr33XaL4+cxEv102dQo6cVvEADYcX8Qj1YY/ALpoqw1vE36/YH5yUoekrdDeCqfec
         J1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OS5efDlzdZteNOo7RSoCHPJVXI1UrPtxfmlVrDV6KqQ=;
        b=CfWJXT+UVZDgqWtlvBrTLYA9ds6nyXN8J+rDUb4hIScPwoygKPzRRojDguIEXXwVQq
         jYREFz7EHf9Dj1kWe1ABPoWEZOoPj1tWQXYVRilnAaYIyuQfEaUCZfhWJdFkuPi46x7K
         miLPt3ZCGw93BFrWwMo0xwlF9Vlzmgih+51bsi3CiXOu6qpzxqqz4bZBk1EkyMo8hyUw
         HmIUZyIT5YvgA8uPFJD2Ke6V/6Q2m/SH1hDyWbRjURf+590528i7qtdDFfuWLwZYRNcj
         w+FVWZJxIu0FpCXu3M+k/bycZDmRzsM47ZmBQqVuoCdBWxox51C40aXQRjAaGFLys7PC
         VCkA==
X-Gm-Message-State: APjAAAVE7KJMQ46MCaEByCfIBANfe0WavHi2lCBi1pBgZQZO8lLTVwFm
        VzwwcGs8klgSePilF6ThB8JdxL5h
X-Google-Smtp-Source: APXvYqwamq5KdV2Tw/yJS0eS+QZA59GHwGTe8K+yx+sxvFDI6XPCbQoQxDsNoCfmZHN99YHZMzfwjA==
X-Received: by 2002:a5d:66c3:: with SMTP id k3mr20607497wrw.370.1575740873263;
        Sat, 07 Dec 2019 09:47:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l13sm7322482wmh.12.2019.12.07.09.47.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2019 09:47:52 -0800 (PST)
Message-Id: <d22ada16143ac67551c089ff44ab1832b791dd46.1575740863.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
References: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
        <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 07 Dec 2019 17:47:39 +0000
Subject: [PATCH v5 11/15] git-p4: add Py23File() - helper class for stream
 writing
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

This is a preparatory commit that does not change current behavior.
It adds a new class Py23File.

Following the Python recommendation of keeping text as unicode
internally and only converting to and from bytes on input and output,
this class provides an interface for the methods used for reading and
writing files and file like streams.

A new class was implemented to avoid requiring additional dependencies.

Create a class that wraps the input and output functions used by the
git-p4.py code for reading and writing to standard file handles.

The methods of this class should take a Unicode string for writing and
return unicode strings in reads.  This class should be a drop-in for
existing file like streams

The following methods should be coded for supporting existing read/write
calls:
  * write - this should write a Unicode string to the underlying stream
  * read  - this should read from the underlying stream and cast the
            bytes as a unicode string
  * readline - this should read one line of text from the underlying
            stream and cast it as a unicode string
  * readline - this should read a number of lines, optionally hinted,
            and cast each line as a unicode string

The expression "cast as a unicode string" is used because the code
should use the as_bytes() and as_string() functions instead of
cohercing the data to actual unicode strings or bytes.  This allows
Python 2 code to continue to use the internal "str" data type instead
of converting the data back and forth to actual unicode strings. This
retains current Python 2 support while Python 3 support may be
incomplete.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index 1838045078..03829f796d 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -4187,6 +4187,72 @@ def run(self, args):
             print("%s <= %s (%s)" % (branch, ",".join(settings["depot-paths"]), settings["change"]))
         return True
 
+class Py23File():
+    """ Python2/3 Unicode File Wrapper
+    """
+
+    stream_handle = None
+    verbose       = False
+    debug_handle  = None
+
+    def __init__(self, stream_handle, verbose = False):
+        """ Create a Python3 compliant Unicode to Byte String
+            Windows compatible wrapper
+
+            stream_handle = the underlying file-like handle
+            verbose       = Boolean if content should be echoed
+        """
+        self.stream_handle = stream_handle
+        self.verbose       = verbose
+
+    def write(self, utf8string):
+        """ Writes the utf8 encoded string to the underlying
+            file stream
+        """
+        self.stream_handle.write(as_bytes(utf8string))
+        if self.verbose:
+            sys.stderr.write("Stream Output: %s" % utf8string)
+            sys.stderr.flush()
+
+    def read(self, size = None):
+        """ Reads int charcters from the underlying stream
+            and converts it to utf8.
+
+            Be aware, the size value is for reading the underlying
+            bytes so the value may be incorrect. Usage of the size
+            value is discouraged.
+        """
+        if size == None:
+            return as_string(self.stream_handle.read())
+        else:
+            return as_string(self.stream_handle.read(size))
+
+    def readline(self):
+        """ Reads a line from the underlying byte stream
+            and converts it to utf8
+        """
+        return as_string(self.stream_handle.readline())
+
+    def readlines(self, sizeHint = None):
+        """ Returns a list containing lines from the file converted to unicode.
+
+            sizehint - Optional. If the optional sizehint argument is
+            present, instead of reading up to EOF, whole lines totalling
+            approximately sizehint bytes are read.
+        """
+        lines = self.stream_handle.readlines(sizeHint)
+        for i in range(0, len(lines)):
+            lines[i] = as_string(lines[i])
+        return lines
+
+    def close(self):
+        """ Closes the underlying byte stream """
+        self.stream_handle.close()
+
+    def flush(self):
+        """ Flushes the underlying byte stream """
+        self.stream_handle.flush()
+
 class HelpFormatter(optparse.IndentedHelpFormatter):
     def __init__(self):
         optparse.IndentedHelpFormatter.__init__(self)
-- 
gitgitgadget

