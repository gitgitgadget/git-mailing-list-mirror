Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7805AC678D4
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 17:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjCGRdy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 12:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjCGRd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 12:33:28 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262FE99243
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 09:29:06 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so12573421pjp.2
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 09:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678210145;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/VHX2KGWYFpStTUAucn+lozsEigpjJ5xWB4kNImvQI=;
        b=MTaLadAJlgkNEhhUwSqjOWOHua3F9d+3ysxCgI1hw/45AWDj3mcPIkm6L05nvSLNBc
         hY5+eOm8vPpBJYYVobiXtreAhSMeOAz8TimqPVSY4HISciO33t+F17wdZ0XKFWAdBGZ/
         XCBj/5WXMUIR+I/qAziLBbe2B6spZWgFCyy9lcZ8WOeJXHkXJXKtwmQpYvod6GcecoHD
         FV6+qDJFzVYSTBz+aEySzcR67LaN7jh/inbo0PsWsFWc+4k/sE50k513d9cYtGy/MjFh
         Q+Lg0dMrlE5PyFqxMZISaVAdoFMjoBJnBovAxCr7jbbPdqCBBbMZnxXqe8Jl1kDLGv66
         OaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678210145;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n/VHX2KGWYFpStTUAucn+lozsEigpjJ5xWB4kNImvQI=;
        b=JwG0Cgx8r6wKYvfyRtM5P/ikC6aZscgM9TiZdphbBa4x6Io9JO5i/7Osv3w8ngrYUl
         P3moNDgiddZG4RMOYCl8TKDG5R+f8A0SymNiyRk8Ogai1z6XamfIyNdI0TjfbJcdLhpG
         Pp0f9UxZhn11jOlaadLD6MfeSeAAkm1As3i52TxtcBhukIBhXQO3GobHDPQtzfcaqf+a
         Elmjt5ajYtEyhOZPUhWkCBI3vcqRX3b1H5qMb5q8tFKmaau2fjMdP3qjUs4wmYIalrmx
         j5nbGlQ3KY/D933Zihag8UwvWVYeFp+pfSA5UAirkcxsH8X/HvAwylHjQTkjBnx2pWw+
         hnIg==
X-Gm-Message-State: AO0yUKVJkOJ3jZ7G6EIas9E19w1aHjXljAiKg8B/XIsbiwVd6gR9Ax+x
        qao81ksRGh3Ny1UTffQglLUrTLMItI0=
X-Google-Smtp-Source: AK7set8MRUmDD1ee0HM63Wl7NpVf7ah+v3JNvyvAwpNVgh7PGORaAZ7N+OEhr/Lp2RtAiuYL74IupQ==
X-Received: by 2002:a17:902:b781:b0:19c:eb9a:770d with SMTP id e1-20020a170902b78100b0019ceb9a770dmr13072568pls.53.1678210145467;
        Tue, 07 Mar 2023 09:29:05 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id ks3-20020a170903084300b0019c901c207dsm8668570plb.177.2023.03.07.09.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 09:29:04 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] object-file: reprepare alternates when necessary
References: <pull.1490.git.1678136369387.gitgitgadget@gmail.com>
        <230307.861qm0235d.gmgdl@evledraar.gmail.com>
Date:   Tue, 07 Mar 2023 09:29:04 -0800
In-Reply-To: <230307.861qm0235d.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 07 Mar 2023 12:28:44 +0100")
Message-ID: <xmqqttyw1ndr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> But in fact we've been doing the locking since 6c307626f1e (grep:
> protect packed_git [re-]initialization, 2020-01-15). So the only thing
> that really needs justification here is that putting the alternates
> re-reading under the same lock
>
> There is a really interesting potential caveat here which you're not
> discussing, which is...
>> ...
>> +void reprepare_alt_odb(struct repository *r)
>> +{
>> +	r->objects->loaded_alternates = 0;
>> +	prepare_alt_odb(r);
>> +}
>> +
>> ...
> This seems reasonable, but wouldn't this do the same without introducing
> an API function just for this one use-case?
>
> That's of course a nit, and you seem to have been adding this for
> consistency with reprepare_packed_git(), but it already "owns" the
> "approximate_object_count_valid" and "packed_git_initialized" flags in
> "struct raw_object_store".
>
> So as we'll only need this from reprepare_packed_git() isn't it better
> to declare that "loaded_alternates" is another such flag?

I am not sure I got what you want to say 100%, but if you are saying
that this "drop the 'loaded' flag and force prepare_*() function to
redo its thing" must not be done only in reprepare_packed_git(), and
that inlining the code there without introducing a helper function
that anybody can casually call without thinking its consequenced
through, then I tend to agree in principle.  But it is just as easy
to lift two lines of code from the rewritten/inlined code to a new
place---to ensure people follow the obj_read_lock() rule, the
comment before it may have to be a bit stronger, I wonder?

> Perhaps not, but as the resulting patch is much shorter it seems worth
> considering.
>
> ...but to continue the above, the *really* important thing here (and
> correct me if I'm wrong) is that we really need to *first* prepare the
> alternates, and *then* do the rest, as our new alternates might point to
> new loose objects and packs.

Yes, and as Derrick explained in another message, we only have to
worry about new ones getting added, not existing ones going away.

> So with both of the above (the same could be done with your new helper)
> something like this would IMO make that much clearer:
>
> 	diff --git a/packfile.c b/packfile.c
> 	index 79e21ab18e7..50cb46ca4b7 100644
> 	--- a/packfile.c
> 	+++ b/packfile.c
> 	@@ -1008,6 +1008,13 @@ void reprepare_packed_git(struct repository *r)
> 	 	struct object_directory *odb;
> 	 
> 	 	obj_read_lock();
> 	+	/*
> 	+	 * New alternates might point to new loose & pack dirs, so we
> 	+	 * must first read those.
> 	+	 */
> 	+	r->objects->loaded_alternates = 0;
> 	+	prepare_alt_odb(r);
> 	+
> 	 	for (odb = r->objects->odb; odb; odb = odb->next)
> 	 		odb_clear_loose_cache(odb);
>
> And, I think this is an exsiting edge case, but we're only locking the
> ODB of the "parent" repository in this case, so if we have alternates in
> play aren't we going to racily compute the rest here, the loose objects
> and packs of the alternates we're about to consult aren't under the same
> lock?
