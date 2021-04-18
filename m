Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6ED2C433ED
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 07:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD2536120C
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 07:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhDRHN1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Apr 2021 03:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhDRHN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Apr 2021 03:13:26 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FD5C06174A
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 00:12:59 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id h10so36950415edt.13
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 00:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:message-id:in-reply-to
         :date:mime-version;
        bh=JuiT/ay0Rt/Yum42s9HrXDv1PMdK/qw5tSAEauaK+Oo=;
        b=aasvlBD0ovzIwqPnJXaCe/sO8JkpHLEkRlp4a8JPd/gCb3KWfOEjNfsE4ezuJXyXkK
         NhvZpKRwawqSQ6SNBgEkd/gnOr5gV8SHEF4RGy9fSgblIQZcuCzY5WvlZmY12KIuaDuf
         +PDsjbJbTWD3eIz4mU3AI/8Senv2+syfmSDpjhYj1cTJmnXcuyqB3HSYVwBqhXTcOY0Q
         Y7uUnaU89T1sboNvpMIorsKkW/8wwHsrjWvocaNd6NYIa1JiTE0s5DZNjx9Z5pRKRW4J
         Ah1VIO6dn32vJyk1fWqwo3HXZVNCTdzlrw3EYemoMyxJzdN5JH0XRuOLudeqo0pfLlx3
         Jh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :message-id:in-reply-to:date:mime-version;
        bh=JuiT/ay0Rt/Yum42s9HrXDv1PMdK/qw5tSAEauaK+Oo=;
        b=He9Kt1hDBn2rmfnKPPa5ymP2N6elb7JZ21b8Jx0gPNbcmGIoE1hLAVaM8p61CjbEZy
         YV7FQ4Ayvb6HvJvzZVcUAsdgrUnD7in8Zivp3BFYBi8IXb5adoa1UvnIywlgT63jRga1
         f/9o0ld9l2t40Ffxizw9HudpDr5WGflosLU76VXWGRM1EoxqegCV9E9ri4KBKHT3TVoX
         asGN8JKYkovme4Q4NQcsO7/8Gob4n+3L7s4OXb/IPVNh59IpqWMpSzslqIbUYznUUeLY
         INaaO3AbW3o64UJDDKWy1ZbKLx0hX8VGGI2PGCR0GwcYvyiXNO27RBYavT3AVIaDRL6m
         L5gg==
X-Gm-Message-State: AOAM533GWyaRCHAvVslrVNirt+ueZOK5oktFKDlgfaq+vQ0IUrerVwcw
        5uAyP8gbTno+uCRJg7feHtU=
X-Google-Smtp-Source: ABdhPJy4rqyUQcr2Kh0pnH1pc3fCRBn4Oz586hKiXdCKk3D8xje1CQ0gQkiWrIAZTM49eSi7UeGkMw==
X-Received: by 2002:a50:eb8f:: with SMTP id y15mr19235500edr.115.1618729977767;
        Sun, 18 Apr 2021 00:12:57 -0700 (PDT)
Received: from cpm12071.fritz.box ([79.140.115.143])
        by smtp.gmail.com with ESMTPSA id o20sm9925288eds.65.2021.04.18.00.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 00:12:56 -0700 (PDT)
References: <20210414191403.4387-3-rafaeloliveira.cs@gmail.com>
 <20210415010454.4077355-1-jonathantanmy@google.com>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] repack: avoid loosening promisor pack objects in
 partial clones
Message-ID: <gohp6ktuo4m6zt.fsf@cpm12071.fritz.box>
In-reply-to: <20210415010454.4077355-1-jonathantanmy@google.com>
Date:   Sun, 18 Apr 2021 09:12:55 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Jonathan Tan <jonathantanmy@google.com> writes:

>> For a partial
>> clone, that contains unreferenced objects, this results in unpacking
>> all "promisor" objects and deleting them right after, which
>> unnecessarily increases the `repack` execution time and disk usage
>> during the unpacking of the objects.
>
> I think that the commit message also needs to explain that we're
> deleting the promisor objects immediately because they happen to be in a
> promisor pack. So perhaps this whole part could be written as follows:
>
>   When "git repack -Ad" is run in a partial clone, "pack-objects" is
>   invoked twice: once to repack all promisor objects, and once to repack
>   all non-promisor objects. The latter "pack-objects" invocation is with
>   --exclude-promisor-objects and --unpack-unreachable, which loosens all
>   unused objects. Unfortunately, this includes promisor objects.
>
>   Because the "-d" argument to "git repack" subsequently deletes all
>   loose objects also in packs, these just-loosened promisor objects will
>   be immediately deleted. But this extra disk churn is unnecessary in
>   the first place.
>

Thanks for suggesting this message, obviously it's much better than
mine specially because removes the confusion that I made when writing
the message about the `pack-objects` and `prune-packed`.

I'll update patch's message on the next revision.

>> For instance, a partially cloned repository that filters all the blob
>> objects (e.g. "--filter=blob:none"), `repack` ends up unpacking all
>> blobs into the filesystem that, depending on the repo size, makes
>> nearly impossible to repack the operation before running out of disk.
>> 
>> For a partial clone, `git repack` calls `git pack-objects` twice: (1)
>> for handle the "promisor" objects and (2) for performing the repack
>> with --exclude-promisor-objects option, that results in unpacking and
>> deleting of the objects. Given that we actually should keep the
>> promisor objects, let's teach `repack` to tell `pack-objects` to
>> --keep the old "promisor" pack file.
>
> It's not this call (2) that results in any deleting of the objects, but
> the later call to prune_packed_objects(). Also, promisor objects are
> kept regardless of what we pass to "pack-objects" here (the keeping is
> done separately). Maybe write (continuation from my suggestion above):
>
>   In order to avoid this extra disk churn, pass the names of the
>   promisor packfiles as "--keep-pack" arguments to this
>   second invocation of "pack-objects". This informs "pack-objects" that
>   the promisor objects are already in a safe packfile and, therefore, do
>   not need to be loosened.
>

You're right, the second call only loosens the object and the deleting
comes after it, which makes my message misleading. 

The suggested paragraph explain better the situation, thanks for
suggesting it and will replace mine in the next revision.

>> @@ -533,7 +533,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>>  	}
>>  
>>  	packdir = mkpathdup("%s/pack", get_object_directory());
>> -	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, (int)getpid());
>> +	packtmp_name = xstrfmt(".tmp-%d-pack", (int)getpid());
>> +	packtmp = mkpathdup("%s/%s", packdir, packtmp_name);
>>  
>>  	sigchain_push_common(remove_pack_on_signal);
>>  
>
> Normally I would be concerned that packtmp_name is not freed, but in
> this case, it's a static variable (same as packtmp).
>

Indeed.

>> @@ -576,6 +577,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>>  		repack_promisor_objects(&po_args, &names);
>>  
>>  		if (existing_packs.nr && delete_redundant) {
>> +			for_each_string_list_item(item, &names) {
>> +				strvec_pushf(&cmd.args, "--keep-pack=%s-%s.pack",
>> +					     packtmp_name, item->string);
>> +			}
>
> Git style is to not have braces for single-statement loops.
>

I preferred to keep the braces simply because the
for_each_string_list_item() is macro instead of a normal for-loop
statement. 

>> +test_expect_success 'repack does not loose all objects' '
>> +	rm -rf client &&
>> +	git clone --bare --filter=blob:none "file://$(pwd)/srv.bare" client &&
>> +	test_when_finished "rm -rf client" &&
>> +	git -C client repack -A -l -d --no-prune-packed &&
>> +	git -C client count-objects -v >object-count &&
>> +	grep "^prune-packable: 0" object-count
>> +'
>
> s/loose all objects/loosen promisor objects/
>
> Also, add a comment describing why we have "--no-prune-packed" there
> (probably something about not pruning any loose objects that are already
> in packs, so that we can verify that no redundant loose objects are
> being created in the first place).

Thanks for the reviewing and helping clarify the patch intentions. I'll
address this comments on the next revision.

-- 
Thanks
Rafael
