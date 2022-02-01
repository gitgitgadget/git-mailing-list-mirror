Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7FEC433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 20:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbiBAU3a (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 15:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbiBAU33 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 15:29:29 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDE6C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 12:29:28 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id m11so36919414edi.13
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 12:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=nxPjiy167uk7iet8lT8o8y8wfxS+HAYxxkHOZcgNM44=;
        b=Fa5aSTenauGM251gkAhukjUK9IcdDHrEB5ORw8m3COBmNtWtPjzis0DJCWDGUQsyrn
         N8BkUjhl618oWYjD5fqDV0l69q4xl3eza863msTnXOhnHkoq9RTfsE6sxQ6CCsgnaGtn
         BP1PKSScvSxUac5HAZRM71vKkDwWTEzrMUIUUvdUxnAAxIhFfykPJix1qIXD6ctXkff7
         b/Qjyb+wMi2YgxnV9IeU+AOWPA9hhWfLQ/RtSExbFil2CbqDR8dbczk7z+6ucan+GzwB
         8zG0+GoU48vqcuyhGlVREeIYX9IxPHOW4gbV5q/hhIydEQdAET6/Zts0/BhLiCYbUJZh
         Y9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=nxPjiy167uk7iet8lT8o8y8wfxS+HAYxxkHOZcgNM44=;
        b=Dy5N3TbGWm1652wpZ1v3q1esowjI2Pjk2UF4GVGvxCnUNrlCJSfpD5ZstYvSSIDsaD
         wWDTtBUfbhHzkPhQg1mXo4x2pJrYQSJ8h5R6A2JI6AdL6Rt8zEgk3neFIVzJ79DHxZuD
         9uKhxrKYWe0tcRxg2/cqdV6ZhQRZaMnm5WOaboW7zTXcpZyOkVWhsLJ0ZwMuBRujAC3e
         obzJG4pPAg6u3bso/+FjqnHImB4NTdZSzFk0w4kFVH7X7F1wapLXoKwid65P4NRq+9q8
         98YtS9llATq21NN472U3EV2OjZKXKWmm//Ol2m3tEtcETlZ87E3sZV2/PYhB8RVKmJcN
         3XoQ==
X-Gm-Message-State: AOAM533GDM3KtMh2NaFQW0jq5DOucLhyJp9x0OTI6r1GmtIO1ZwGHTJs
        9mWh5uRvUd49xza0TFcoqp2YARA5DGKMKg==
X-Google-Smtp-Source: ABdhPJwrXkAtiVhygyTAka4K6MGHcmlFzm9TZkvH3tOBja74D8CRACufC9RY+P86tux1yvH6zHsgWA==
X-Received: by 2002:a05:6402:548:: with SMTP id i8mr26851118edx.60.1643747366806;
        Tue, 01 Feb 2022 12:29:26 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f11sm19611001edv.29.2022.02.01.12.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 12:29:26 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nEzmH-004LE9-L5;
        Tue, 01 Feb 2022 21:29:25 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2] refs.h: make all flags arguments unsigned
Date:   Tue, 01 Feb 2022 21:20:59 +0100
References: <pull.1210.git.git.1643660136530.gitgitgadget@gmail.com>
 <pull.1210.v2.git.git.1643719616840.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <pull.1210.v2.git.git.1643719616840.gitgitgadget@gmail.com>
Message-ID: <220201.86ilty9vq2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 01 2022, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> As discussed in
> https://lore.kernel.org/git/xmqqbkzrkevo.fsf@gitster.g/ , we don't
> want to treat the sign bit specially, so make all flags in refs.h
> unsigned.
>
> For uniformity, rename all variables to `flags` or `unused_flags`,
> from `flag`. In a couple of shadowing cases, use `ref_flags` for
> clarity.

For what it's worth I thought the suggestion of enums in your
https://lore.kernel.org/git/xmqqbkzrkevo.fsf@gitster.g/ made more sense,
e.g. I tried this on top:
	
	diff --git a/refs.c b/refs.c
	index 5f29775def1..dc33573f064 100644
	--- a/refs.c
	+++ b/refs.c
	@@ -265,7 +265,8 @@ int ref_resolves_to_object(const char *refname,
	 }
	 
	 char *refs_resolve_refdup(struct ref_store *refs, const char *refname,
	-			  int resolve_flags, struct object_id *oid,
	+			  enum resolve_ref_flags resolve_flags,
	+			  struct object_id *oid,
	 			  unsigned int *flags)
	 {
	 	const char *result;
	@@ -276,7 +277,8 @@ char *refs_resolve_refdup(struct ref_store *refs, const char *refname,
	 	return xstrdup_or_null(result);
	 }
	 
	-char *resolve_refdup(const char *refname, unsigned int resolve_flags,
	+char *resolve_refdup(const char *refname,
	+		     enum resolve_ref_flags resolve_flags,
	 		     struct object_id *oid, unsigned int *flags)
	 {
	 	return refs_resolve_refdup(get_main_ref_store(the_repository),
	@@ -292,7 +294,8 @@ struct ref_filter {
	 	void *cb_data;
	 };
	 
	-int read_ref_full(const char *refname, unsigned int resolve_flags,
	+int read_ref_full(const char *refname,
	+		  enum resolve_ref_flags resolve_flags,
	 		  struct object_id *oid, unsigned int *flags)
	 {
	 	int ignore_errno;
	@@ -1679,7 +1682,8 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
	 }
	 
	 const char *refs_resolve_ref_unsafe(struct ref_store *refs, const char *refname,
	-				    int resolve_flags, struct object_id *oid,
	+				    enum resolve_ref_flags resolve_flags,
	+				    struct object_id *oid,
	 				    unsigned int *flags, int *failure_errno)
	 {
	 	static struct strbuf sb_refname = STRBUF_INIT;
	@@ -1779,7 +1783,8 @@ int refs_init_db(struct strbuf *err)
	 	return refs->be->init_db(refs, err);
	 }
	 
	-const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
	+const char *resolve_ref_unsafe(const char *refname,
	+			       enum resolve_ref_flags resolve_flags,
	 			       struct object_id *oid, unsigned int *flags)
	 {
	 	int ignore_errno;
	diff --git a/refs.h b/refs.h
	index c5462b75807..8c7404eaf78 100644
	--- a/refs.h
	+++ b/refs.h
	@@ -64,24 +64,30 @@ struct worktree;
	  * type of failure encountered, but not necessarily one that came from
	  * a syscall. We might have faked it up.
	  */
	-#define RESOLVE_REF_READING 0x01
	-#define RESOLVE_REF_NO_RECURSE 0x02
	-#define RESOLVE_REF_ALLOW_BAD_NAME 0x04
	+enum resolve_ref_flags {
	+	RESOLVE_REF_READING = 1 << 0,
	+	RESOLVE_REF_NO_RECURSE = 1 << 1,
	+	RESOLVE_REF_ALLOW_BAD_NAME = 1 << 2,
	+};
	 
	 const char *refs_resolve_ref_unsafe(struct ref_store *refs, const char *refname,
	-				    int resolve_flags, struct object_id *oid,
	+				    enum resolve_ref_flags resolve_flags,
	+				    struct object_id *oid,
	 				    unsigned int *flags, int *failure_errno);
	 
	-const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
	+const char *resolve_ref_unsafe(const char *refname,
	+			       enum resolve_ref_flags resolve_flags,
	 			       struct object_id *oid, unsigned int *flags);
	 
	 char *refs_resolve_refdup(struct ref_store *refs, const char *refname,
	-			  int resolve_flags, struct object_id *oid,
	+			  enum resolve_ref_flags resolve_flags,
	+			  struct object_id *oid,
	 			  unsigned int *flags);
	-char *resolve_refdup(const char *refname, unsigned int resolve_flags,
	+char *resolve_refdup(const char *refname,
	+		     enum resolve_ref_flags resolve_flags,
	 		     struct object_id *oid, unsigned int *flags);
	 
	-int read_ref_full(const char *refname, unsigned int resolve_flags,
	+int read_ref_full(const char *refname, enum resolve_ref_flags resolve_flags,
	 		  struct object_id *oid, unsigned int *flags);
	 int read_ref(const char *refname, struct object_id *oid);

I don't mind if this goes in, but I think doing that would make this
much easier to deal with, as it would be more obvious when working on
the code just what flag you're dealing with. Even as Junio points out
downthread of that it mostly doesn't matter in C.

See though 3f9ab7ccdea (parse-options.[ch]: consistently use "enum
parse_opt_flags", 2021-10-08) where doing it this way makes debugging
much nicer to work with.

> -		int flag;
> -		char *head_ref = resolve_refdup("HEAD", 0, NULL, &flag);
> -		if (head_ref &&
> -		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new_branch_info->path)))
> +		unsigned int flags;
> +		char *head_ref = resolve_refdup("HEAD", 0, NULL, &flags);
> +		if (head_ref && (!(flags & REF_ISSYMREF) ||
> +				 strcmp(head_ref, new_branch_info->path)))

I don't think this needs a re-roll, but FWIW I think it's much easier to
review changes like these if the changes are kept apart. E.g. this
variable renaming from the type change.

> -static int add_one_refname(const char *refname,
> -			   const struct object_id *oid,
> -			   int flag, void *cbdata)
> +static int add_one_refname(const char *refname, const struct object_id *oid,
> +			   unsigned int unused_flags, void *cbdata)

And this change not mentioned in the commit message of seemingly doing
some re-flowing of argument lists while we're at it.

The post-image is better, but better done is another step IMO.

I didn't look through the rest of the diff as you sent it, but locally
with appropriate word-diff flags to hide any formatting changes.

The post-image LGTM, but I'm also a bit "meh" on the churn just for
signed->unsigned, especially given the conflict with my in-flight
ab/no-errno-from-resolve-ref-unsafe. But it's not too bad, and if Junio
hasn't complained about it...
