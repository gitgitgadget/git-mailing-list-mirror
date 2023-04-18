Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55030C6FD18
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 23:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjDRX3b (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 19:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjDRX3a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 19:29:30 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5330976A1
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 16:29:29 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1a67d2601b3so20207405ad.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 16:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681860569; x=1684452569;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WFvaOZnn9KPtryqx5FnpNNdsL5+OpUfslwKQmjUnYfw=;
        b=dzY8W5uCQHGnlnFuczA5SfAZ5hss89v0maWUcXwLFicSMKO7GdnyxBz423uo2FYJgn
         J6tDXlD/eBs46Jz+0JCIj4hDtDCHayvaiiE9H4qH6musBwnc/sySBkkL8yukU0UnFXg/
         6GqoJnuIzPBpHlyoI//Ow25MRD87AWJxsyHpg3W2LYzzC8WuAUZg4NpJkGqHS8p4HLx3
         iH2selyK/OKwOUbV3121ZmNBAl21bCF5e+jISyH++p887jUnpqhkLDkU3vPIjioFPCVL
         ZEEuRzzwguPyFRasRIQOgOk3qEtBwXpgrNuT1pxAhCTaiVsj2uo/AnkkMpXROE0XVFiy
         Qq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681860569; x=1684452569;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFvaOZnn9KPtryqx5FnpNNdsL5+OpUfslwKQmjUnYfw=;
        b=PWb3nCQgshj6LuUGhrAHSxpjZhgimyZ2XFFge+/O0U790jkQXxZZk99sFN4crIRpor
         4/TLLeQ7qvkbswJ9lL84QCFHC17itpvJ4FirT62RAVH2H7Ywtq+Km/q7lxkclq6bCVN+
         pQy85QNybWqj5fB5wm5JHGmlolaPPJ8F/Bo3HBhJ3Mcv+PVqm7A3ArwYCqvXpT0/K218
         s7Mo/aGikI4jKlWnByBj5eNFTsFLmyr86Wao8t0QQAEctqXo6BVOF/EsKTxYSy2gvM4c
         VqrlQGf5EQPDyWU+DZDFv6UcWI3qDWacwW/Iv+pS8fttLv0GlosvQQfZzzd1MxJjA58w
         Vhzg==
X-Gm-Message-State: AAQBX9faPgwTup6OlxA/YrbbCXz+6OsUnHScMMcTUHdb31p5puiXdtPU
        Bzls8ZGJ90EW9FMwHM9i340=
X-Google-Smtp-Source: AKy350YjU2HsEeW6tTsPBb2Y7vcd6A5OgPeuTXOrs4DRUZbH/iQD5lMiRJ+d+tIXqvIFMwAOMBA9ow==
X-Received: by 2002:a17:902:9b81:b0:1a5:1f13:67fc with SMTP id y1-20020a1709029b8100b001a51f1367fcmr2867569plp.31.1681860568687;
        Tue, 18 Apr 2023 16:29:28 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id d22-20020a170902b71600b001a67759f9f8sm3860844pls.106.2023.04.18.16.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 16:29:28 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 14/23] hash.h, repository.h: reverse the order of these
 dependencies
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
        <1c6989ae456c86850761b079384f1505735e317a.1681614206.git.gitgitgadget@gmail.com>
        <ad90e716-ba23-040f-66be-4c4faff02ea8@github.com>
Date:   Tue, 18 Apr 2023 16:29:28 -0700
Message-ID: <xmqqedogbwh3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> This is the first patch in the series where I don't immediately agree
> with the patch. This is a big list of methods that don't seem like
> they fit in repository.h:
>
>> diff --git a/repository.h b/repository.h
>> +static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
>> +static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)
>> +static inline int hasheq(const unsigned char *sha1, const unsigned char *sha2)
>> +static inline int oideq(const struct object_id *oid1, const struct object_id *oid2)
>> +static inline int is_null_oid(const struct object_id *oid)
>> +static inline void hashcpy(unsigned char *sha_dst, const unsigned char *sha_src)
>> +static inline void oidcpy_with_padding(struct object_id *dst,
>> +				       const struct object_id *src)
>> +static inline void hashclr(unsigned char *hash)
>> +static inline void oidclr(struct object_id *oid)
>> +static inline void oidread(struct object_id *oid, const unsigned char *hash)
>> +static inline int is_empty_blob_sha1(const unsigned char *sha1)
>> +static inline int is_empty_blob_oid(const struct object_id *oid)
>> +static inline int is_empty_tree_sha1(const unsigned char *sha1)
>> +static inline int is_empty_tree_oid(const struct object_id *oid)
>
> The goal to remove repository.h from hash.h and object.h makes sense
> as a goal, but is there another way to do it?

Indeed.

All of the above sit very well in hash simply because they are all
about hashes.  It does not have much to do with "repository", not
more than "well, hashes we use to identify objects, and objects are
stored in repositories".

From the point of view of somebody who needs to use these macros, it
is utterly unnatural that they have to include "repository.h" (as
opposed to, say, "hash.h") just to be able to compare two hash
values.  Most of our programs interact with only one repository, and
it is understandable to include a header "repository.h" if your
program needs to interact with an extra repository other than the
"current" one.  But this feels backwards and not quite satisfactory,
even though inlines are special and I can fully sympathize with the
author who felt that this patch was necessary.

