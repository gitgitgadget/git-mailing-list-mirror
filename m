Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEBBC74A44
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 17:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjCIRFQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 12:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjCIREx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 12:04:53 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31DE20554
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 09:00:02 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so6876459pjb.3
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 09:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678381202;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qRVxkUaxelH8YQUWcV54rQ+kzBqmQwMBBBnLgj4vddo=;
        b=EvBHrtsXpowQHIZVLMO/BdF0Uve/gCHdVKzIGnmklLjlBtpFJjh+PyEm6ZT+dTYpL4
         p7Gqu+2r4p36SfYn5cVMA920ScHv9RvPBa6v79Oc2N5v7RA3LGqGaaFs7dodMNe5yBrF
         i54hn2tLZWOrbzOKJlfFLmBJgGVSJeChpyKifTdHLtqpVniwmFFR2pZxHvbEDTXXyjdP
         of0Lp1UBgRs/zSsinCASAsc5fUIDO1dU2SwyGJ4lmBcKbNjFYjqqyu8YVNN4JDIqhRwV
         qA9SnB9KFZ7gGX3ZJA/GfZZp986bho/UmTSzBimeUgWjBVZlFB1Tq0QDbTpLjWu5onze
         h04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678381202;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qRVxkUaxelH8YQUWcV54rQ+kzBqmQwMBBBnLgj4vddo=;
        b=rQ8ofEGiiOltTNXAG+qD7llDNKX+nF2HYUWNtUmtd6YqEONn4HHGAMvAija7fIwFG3
         yUUos05SwyNFlmD2iXbtxFLDNgvIY//cggx9RAIkf++Dgs3+bX1plSQIVHqQ1YoqsG3J
         NsjZPzoUBdpyyDa5QIcPXgwbYBjvZrMDxcDWBahOY2zEDnkZDKOapSWERTFKTLwL0rB5
         slgFnsJgXUacXcLHeROBb7wCpds68z9QCSzQg160qDjRW3BNiSaSXCunmmXyikxpVg60
         B7aDabemYeH6o3s+IesjmlhNIidzmHDw12JS8eCkmEJI1/R0gBcgfuS4il1TKvBAHPVa
         mwTQ==
X-Gm-Message-State: AO0yUKVumejYoDg7dqulWWdkdrs3GvaLc0g9etkvU9Ic6gTtReoRjh4c
        wUZkvCHlF5Z922XrLRqUojCyrBYlF64=
X-Google-Smtp-Source: AK7set/+/LvdGcj5PJ9XZeESEYGXWbLdVavALrS008IFrkI46j9y7opU5x1GsbmoqfKyh/Xd5o6xSg==
X-Received: by 2002:a17:902:6a81:b0:19d:20f7:daf5 with SMTP id n1-20020a1709026a8100b0019d20f7daf5mr18935770plk.28.1678381202003;
        Thu, 09 Mar 2023 09:00:02 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id f18-20020a170902ce9200b0019c93ee6902sm11800574plg.109.2023.03.09.09.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 09:00:01 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] format-patch: add format.noprefix option
References: <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>
        <ZAl41V7n77ej844x@coredump.intra.peff.net>
Date:   Thu, 09 Mar 2023 09:00:01 -0800
In-Reply-To: <ZAl41V7n77ej844x@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 9 Mar 2023 01:12:37 -0500")
Message-ID: <xmqq5yb9dfn2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> A more backwards-compatible way of doing the transition would be to have
> format.noprefix default to diff.noprefix when it's not set. But that
> doesn't really help the "accidental" problem; people would have to
> manually set format.noprefix=false. And it's unlikely that anybody
> really wants format.noprefix=true in the first place. I'm adding it here
> mostly as an escape hatch, not because anybody has expressed any
> interest in it.

I tend to agree that this is closing the barn door after the horse
escaped for projects who did use diff.noprefix because it is their
preference to exchange prefix-free patches.

The other direction we could go is to tie the default p-value
specified centrally for both producer and consumer.  If the project
wants no-prefix patches so much that the contributors use it in
their own diff by setting diff.noprefix in their configuration, the
project would be perfectly happy if format-patch sent prefix-less
patches honoring the configuration, and if apply took prefix-less
patches honoring the configuration, all honoring diff.noprefix.

But that is the other extreme.

I wonder if the consumer side should be made configurable for
completeness, though.

Here is how "apply.pValue" configuration variable would look like.
Projects whose members want diff.noprefix set can standardise on
using that and then receiving end configured to match with this.

---
 apply.c       | 5 +++++
 cache.h       | 1 +
 environment.c | 1 +
 3 files changed, 7 insertions(+)

diff --git c/apply.c w/apply.c
index 5cc5479c9c..20645fc9af 100644
--- c/apply.c
+++ w/apply.c
@@ -33,6 +33,7 @@ static void git_apply_config(void)
 {
 	git_config_get_string("apply.whitespace", &apply_default_whitespace);
 	git_config_get_string("apply.ignorewhitespace", &apply_default_ignorewhitespace);
+	git_config_get_int("apply.pValue", &apply_default_p_value);
 	git_config(git_xmerge_config, NULL);
 }
 
@@ -112,6 +113,10 @@ int init_apply_state(struct apply_state *state,
 		return -1;
 	if (apply_default_ignorewhitespace && parse_ignorewhitespace_option(state, apply_default_ignorewhitespace))
 		return -1;
+	if (0 <= apply_default_p_value) {
+		state->p_value = apply_default_p_value;
+		state->p_value_known = 1;
+	}
 	return 0;
 }
 
diff --git c/cache.h w/cache.h
index 12789903e8..05efa9dc52 100644
--- c/cache.h
+++ w/cache.h
@@ -967,6 +967,7 @@ extern int assume_unchanged;
 extern int prefer_symlink_refs;
 extern int warn_ambiguous_refs;
 extern int warn_on_object_refname_ambiguity;
+extern int apply_default_p_value;
 extern char *apply_default_whitespace;
 extern char *apply_default_ignorewhitespace;
 extern const char *git_attributes_file;
diff --git c/environment.c w/environment.c
index 1ee3686fd8..b82ad370b4 100644
--- c/environment.c
+++ w/environment.c
@@ -38,6 +38,7 @@ const char *git_commit_encoding;
 const char *git_log_output_encoding;
 char *apply_default_whitespace;
 char *apply_default_ignorewhitespace;
+int apply_default_p_value = -1; /* unspecified */
 const char *git_attributes_file;
 const char *git_hooks_path;
 int zlib_compression_level = Z_BEST_SPEED;



