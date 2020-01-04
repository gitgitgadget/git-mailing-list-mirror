Return-Path: <SRS0=9bkr=2Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEB4C00523
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 00:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808AD222C3
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 00:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l58pV+5I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgADANf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jan 2020 19:13:35 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45798 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgADANf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jan 2020 19:13:35 -0500
Received: by mail-pl1-f196.google.com with SMTP id b22so19563636pls.12
        for <git@vger.kernel.org>; Fri, 03 Jan 2020 16:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j6a4IYsweRkcEpta7+CZGDxIC6nVIQsImqstVcygFO8=;
        b=l58pV+5IAsvqAbEIFek8yUMFXENRsXShAra0m1jDN/MecAYpezpKYVvJB2UoBjVzV5
         W0r/3M2DqNgGt2NkUiNnrTdxOX0KOltUdQuihhklg0UoVhL71uibpN0xKx6muDUplekF
         L5vpM4sMDYcPMqFIMuVDsuup+tT/6wl1XujvkaxtFhRsoHlEJhaw5wlqlY+Fs6UM6vtk
         2UnIaC2hqXZI1I3afCjXD5GpOVUakFIPi+1xHaOOcksB6CBDbek8eN3tThI7CH5Ngwny
         W3Ukg2IQqS1d0uH+zJedcSwyxA8+YN8zB1LdE6gBZhwLOhKkLI/MzXNwyfcG65Av9oN+
         Vhnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j6a4IYsweRkcEpta7+CZGDxIC6nVIQsImqstVcygFO8=;
        b=USOcCoF1MUmX6l6I6IP/Y4lTJOQ7Mm95haNQQuwSufgz0PXktjPUITLRki65I9bWMQ
         2YgpIJPpeDsfpyGLKSBc5GfS/bm/53couZyO9ipDgZXBZBXe2ka2UCsAWwiBIdpPgXXO
         tyqnJ0hSjjoLBz/VkUjjQqcsUZ/dUe7D2uucd4+Y58joZ1+xodqNEsFS5GFSnqHPl1tY
         /DoTqpnRfusC9mdVp2/DGUixpQ/0CE0GaiEkIvBgUTlimotWOXuwx2xckajiKKD7Zmx4
         08W4UMS+ES+MlXxAPKkC0K9L2W8DALXvCStFbMUBhiPjg1GLHc+6EbQW8pyUOxW0u15/
         Q/zQ==
X-Gm-Message-State: APjAAAUZn3ETm+MCfynquefPWhr3Byb34ywq6iBTo1WcqG42SmuTIvg3
        YEQPThAmyvLPbwJs1R/Fsn/jFMhH
X-Google-Smtp-Source: APXvYqxl9W7phj4FtUjZ25ZuSbqT3ECcEulfwpB/EgrVF5a0lFFr36XF5QOmfHaOyutZratcWWQhLw==
X-Received: by 2002:a17:90a:8545:: with SMTP id a5mr30028931pjw.43.1578096814379;
        Fri, 03 Jan 2020 16:13:34 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id z22sm62047743pfr.83.2020.01.03.16.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 16:13:33 -0800 (PST)
Date:   Fri, 3 Jan 2020 16:13:31 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] sha1-file: remove OBJECT_INFO_SKIP_CACHED
Message-ID: <20200104001331.GA130883@google.com>
References: <20191230211027.37002-1-jonathantanmy@google.com>
 <20200102201630.180969-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102201630.180969-1-jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:

> In a partial clone, if a user provides the hash of the empty tree ("git
> mktree </dev/null" - for SHA-1, this is 4b825d...) to a command which
> requires that that object be parsed, for example:
>
>   git diff-tree 4b825d <a non-empty tree>
>
> then Git will lazily fetch the empty tree, unnecessarily, because
> parsing of that object invokes repo_has_object_file(), which does not
> special-case the empty tree.
>
> Instead, teach repo_has_object_file() to consult find_cached_object()
> (which handles the empty tree), thus bringing it in line with the rest
> of the object-store-accessing functions. A cost is

Lovely, thank you.

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  object-store.h |  2 --
>  sha1-file.c    | 38 ++++++++++++++++++--------------------
>  2 files changed, 18 insertions(+), 22 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

To follow up on Junio's hint in his review: callers can inject
additional cached objects by using pretend_object_file.  Junio
described how this would make sense as a mechanism for building
the virtual ancestor object, but we don't do that.  In fact, the
only caller is fake_working_tree_commit in "git blame", a read-only
code path. *phew*

-- >8 --
Subject: sha1-file: document how to use pretend_object_file

Like in-memory alternates, pretend_object_file contains a trap for the
unwary: careless callers can use it to create references to an object
that does not exist in the on-disk object store.

Add a comment documenting how to use the function without risking such
problems.

The only current caller is blame, which uses pretend_object_file to
create an in-memory commit representing the working tree state.
Noticed during a discussion of how to safely use this function in
operations like "git merge" which, unlike blame, are not read-only.

Inspired-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 object-store.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/object-store.h b/object-store.h
index 55ee639350..d0fc7b091b 100644
--- a/object-store.h
+++ b/object-store.h
@@ -208,6 +208,14 @@ int hash_object_file_literally(const void *buf, unsigned long len,
 			       const char *type, struct object_id *oid,
 			       unsigned flags);
 
+/*
+ * Add an object file to the in-memory object store, without writing it
+ * to disk.
+ *
+ * Callers are responsible for calling write_object_file to record the
+ * object in persistent storage before writing any other new objects
+ * that reference it.
+ */
 int pretend_object_file(void *, unsigned long, enum object_type,
 			struct object_id *oid);
 
-- 
2.24.1.735.g03f4e72817

