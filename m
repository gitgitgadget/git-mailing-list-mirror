Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFECC2BA83
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 20:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B301520838
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 20:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fIvth4EJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgBGUmf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 15:42:35 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:36101 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgBGUmf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 15:42:35 -0500
Received: by mail-pl1-f202.google.com with SMTP id bg1so280621plb.3
        for <git@vger.kernel.org>; Fri, 07 Feb 2020 12:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2EnnWVQMmfQG9ZxpdffQoY+B7HAnXXUXAz6ZQ8HdMSk=;
        b=fIvth4EJmlLrQBmmyHe4A/E3uEohb4RnYatx07ne2bnvMGTXEeca6Tz2BZAfwh8EU7
         v+4l9lDIUL5/otVWCPJ6Mar04kTmqD6GUxQw0a1/qkdvh+/THTTssIYbnVIEbb2sHjt4
         vFS47eZxsNXp3tAbSttx/jLoGoziQu/TPK1IiuCpIC/6o/yopUtx1w1uAc/Z4B1M0bT3
         +REogBxs2cTNC54DpVlDxPDmM6tS1TLuaGqrBx9S/W7fF0gEs4cCaXlecZt+zlJCqxKq
         sFaQodFDYhITqY01TBVq9LrMo6L2Va6ITGuFVFDxnOFFLi6Wd4px6RIvNoKR3zmKULtQ
         ilzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2EnnWVQMmfQG9ZxpdffQoY+B7HAnXXUXAz6ZQ8HdMSk=;
        b=K/hgMXqPE6S7msD/XnQ+B93/zkKU6xo/GMH/hGQtzv2oWwKgNFKrpwdz2A4ZmcjiuF
         O7Z/ps8JnZ5hgND3nilC8KQldkFV7KZGRxiU5oL3RBp8XOU64zFToSNy81PZ9QFAekU7
         zpAEAZ1dTLL1Hd2JiXP+hX2urZSD4Z72IPEG+fx9wApVEbJc2ZzmPJRf07Q0ORFG/m2i
         B7ojj+ZLzgt/VniMZ8t7XjnA/H3tbTmZiKverd8RlBMPnNDXic8UlaN7PIAa6d5NnhAO
         7zYcW4yyV1w3gPc+i/R90yNvgSyObSuEK+ZVhNtPDwZyGVQe6isqYBvgVaGZo+7FXFDq
         99MA==
X-Gm-Message-State: APjAAAUSdRa698jF2pJQO0zdCCp6E3KlRXr0F1ZCEDyqjhbyMA1x7W30
        Ezi9nhUKT4kmHmkHjJSN+/7DpZV8q/4T/4v3shXhtbvp7gHTLRzpUSzouosq7jR8vfWy0JOXaI2
        +SlvQTeOuVyntyQCdzJ5npauLrvoRoldbKvkUxiXzN7oz4rlmUYrScMEPRVWZI7fbrOptDSyGmQ
        ==
X-Google-Smtp-Source: APXvYqxb/sJYNYkGbIB2ExXhjOQdar7Hk02FAQrfyVLgmzZ63Vn59qqzbnWtaJtau8Z+HeeaGl5MMkRwcc0czoUlEOk=
X-Received: by 2002:a63:31d4:: with SMTP id x203mr966490pgx.229.1581108154805;
 Fri, 07 Feb 2020 12:42:34 -0800 (PST)
Date:   Fri,  7 Feb 2020 12:42:25 -0800
In-Reply-To: <20200131221800.240352-1-masayasuzuki@google.com>
Message-Id: <20200207204225.123764-1-masayasuzuki@google.com>
Mime-Version: 1.0
References: <20200131221800.240352-1-masayasuzuki@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v3] doc: describe Git bundle format
From:   Masaya Suzuki <masayasuzuki@google.com>
To:     git@vger.kernel.org
Cc:     Masaya Suzuki <masayasuzuki@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The bundle format was not documented. Describe the format with ABNF and
explain the meaning of each part.

Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
---
Changes from v2:

* Change "sender" and "receiver" to "writer" and "reader".
* Add an example of a case that a bundle can reference an object outside of the
  bundle.
* Mention that the prerequisites are different from the shallow
  boundary, and the bundle format cannot represent a shallow clone repository.


 Documentation/technical/bundle-format.txt | 48 +++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/technical/bundle-format.txt

diff --git a/Documentation/technical/bundle-format.txt b/Documentation/technical/bundle-format.txt
new file mode 100644
index 0000000000..0e828151a5
--- /dev/null
+++ b/Documentation/technical/bundle-format.txt
@@ -0,0 +1,48 @@
+= Git bundle v2 format
+
+The Git bundle format is a format that represents both refs and Git objects.
+
+== Format
+
+We will use ABNF notation to define the Git bundle format. See
+protocol-common.txt for the details.
+
+----
+bundle    = signature *prerequisite *reference LF pack
+signature = "# v2 git bundle" LF
+
+prerequisite = "-" obj-id SP comment LF
+comment      = *CHAR
+reference    = obj-id SP refname LF
+
+pack         = ... ; packfile
+----
+
+== Semantics
+
+A Git bundle consists of three parts.
+
+* "Prerequisites" lists the objects that are NOT included in the bundle and the
+  reader of the bundle MUST already have, in order to use the data in the
+  bundle. The objects stored in the bundle may refer to prerequisite objects and
+  anything reachable from them (e.g. a tree object in the bundle can reference
+  a blob that is reachable from a prerequisite) and/or expressed as a delta
+  against prerequisite objects.
+
+* "References" record the tips of the history graph, iow, what the reader of the
+  bundle CAN "git fetch" from it.
+
+* "Pack" is the pack data stream "git fetch" would send, if you fetch from a
+  repository that has the references recorded in the "References" above into a
+  repository that has references pointing at the objects listed in
+  "Prerequisites" above.
+
+In the bundle format, there can be a comment following a prerequisite obj-id.
+This is a comment and it has no specific meaning. The writer of the bundle MAY
+put any string here. The reader of the bundle MUST ignore the comment.
+
+=== Note on the shallow clone and a Git bundle
+
+Note that the prerequisites does not represent a shallow-clone boundary. The
+semantics of the prerequisites and the shallow-clone boundaries are different,
+and the Git bundle v2 format cannot represent a shallow clone repository.
-- 
2.25.0.341.g760bfbb309-goog

