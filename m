Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408C8C61DA4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 03:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjBODUM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 22:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjBODUL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 22:20:11 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC02241D6
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 19:20:10 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id kk7-20020a17090b4a0700b00234463de251so760159pjb.3
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 19:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aeeoUgM70vzt2zOWxwQAVBUO1HHhlcZ7YIMKVG1Aohs=;
        b=pNxVLBcz3EBy4ALx5QlEde0CGe1mg9W6TUh5/KVHKliO2wu4UWZeeVMyXSQRwCnUCp
         o8Hwd/o/p1scL+2tlWEZEv5GL8T21wxC8WlKHo8z3y9ap/K0xpFeqkcTc6FWerA25m7I
         ekYMZ5Tn+mAC2zlWTsYgi4z+OmL+9RB86y8mWB3/fMffQ68HA7uu4yQmMPmr4w0R2doa
         Fr3BJlIZkNrweEe1DgpvgvzrfgzqiYRgnjTwBXrjx0FJJGCiDKhR3bjxBrGmvVty8fd6
         ccTQCFqNL1XYQLQT0vM/wRgp+oN0gnBZnCEFFGa2V6nyFZjOj54OOs62eFS7KpAK1nHZ
         YJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aeeoUgM70vzt2zOWxwQAVBUO1HHhlcZ7YIMKVG1Aohs=;
        b=uaWVyLrlUx7jX3nvCx7h2fy0KvKnUz3gwywdi6Ucx2mMdGouHmfirU3h9dXgOWIBzt
         Easm3fFsZBZu7k+5XLemY/vKfkKcH9QMcebjdY4hRAmquB6n4QVCHs+D5vtH9TxUO5h3
         ZlEe7uWwBM/VUjPHS+g7DNY0Lj1ZsXdDBa16EEr9SGkSnMEG1x2HLmKvyb8ZLYtVJ6mc
         RHPizWyAm7IsWo/FULhO/46gyqndwhZJInRJNwghlfERUGiYs21YNkNpDjXkcaIhxBna
         OvGuZp90SJQKlZr0tPxJvwNmSMsLDvcBT9shan4iQ0GCf9R24aC+PI8Rxf8ix/ewNCgn
         5t6A==
X-Gm-Message-State: AO0yUKUcjDS9vdkpfQotaNCfGpJnMLIpiFwKQ4aApWN3GDFrdLs0yfPa
        yX6dQTKQZn264e+e76IPNRyI8MSZwH0=
X-Google-Smtp-Source: AK7set826xOtChDbOmc+S2HiXOZmoPxAnzsggDHjNWlVnNuULAISsRYKDGfJmF93S2QLFzoEQKEfow==
X-Received: by 2002:a17:903:200a:b0:198:fc0a:192b with SMTP id s10-20020a170903200a00b00198fc0a192bmr668179pla.64.1676431209489;
        Tue, 14 Feb 2023 19:20:09 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id v22-20020a170902e8d600b001949f21e1d2sm7311312plg.308.2023.02.14.19.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 19:20:09 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 2/2] diff: teach diff to read gitattribute
 diff-algorithm
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
        <pull.1452.v2.git.git.1676410819.gitgitgadget@gmail.com>
        <cb0305631496eb4c2d51e5b586ac0ca8580c7dc1.1676410819.git.gitgitgadget@gmail.com>
        <xmqq4jrn3ac7.fsf@gitster.g>
Date:   Tue, 14 Feb 2023 19:20:08 -0800
In-Reply-To: <xmqq4jrn3ac7.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        14 Feb 2023 18:56:40 -0800")
Message-ID: <xmqqwn4j1uon.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> diff --git a/diff.c b/diff.c
>> index 92a0eab942e..24da439e56f 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -4456,15 +4456,11 @@ static void run_diff_cmd(const char *pgm,
>>  	const char *xfrm_msg = NULL;
>>  	int complete_rewrite = (p->status == DIFF_STATUS_MODIFIED) && p->score;
>>  	int must_show_header = 0;
>> +	struct userdiff_driver *drv = userdiff_find_by_path(o->repo->index, attr_path);
>
> Do we run this look-up unconditionally, even when .allow_external
> bit is not set?  Why?

Ah, this is perfectly fine.  It used to be that this codepath can
tell that there is no need to check the diff driver when it is told
never to use any external diff driver.  Now, even when it is computing
the diff internally, it needs to check the diff driver to find out
the favoured algorithm for the path.

Strictly speaking, if we are told NOT to use external diff driver,
and if we are told NOT to pay attention to algorithm given by the
diff driver, then we know we can skip the overhead of attribute
look-up.  I.e. we could do this to avoid attribute look-up:

	struct userdiff_driver *drv = NULL;

	if (o->flags.allow_external || !o->ignore_driver_algorithm)
		drv = userdiff_find_by_path(...);

	if (drv && o->flags.allow_external && drv->external)
		pgm = drv->external;
	...
	if (pgm)
		... do the external diff thing ...
	if (one && two) {
		if (drv && !o->ignore_driver_algorithm && drv->algorithm)
			set_diff_algo(...)

I was not sure if it would be worth it before writing the above
down, but the resulting flow does not look _too_ bad.

>> @@ -4583,6 +4584,10 @@ static void run_diffstat(struct diff_filepair *p, struct diff_options *o,
>>  	const char *name;
>>  	const char *other;
>>  
>> +	struct userdiff_driver *drv = userdiff_find_by_path(o->repo->index, p->one->path);
>> +	if (drv && drv->algorithm)
>> +		set_diff_algorithm(o, drv->algorithm);
>
> Interesting.  Does external diff play a role, like in run_diff_cmd()
> we saw earlier?

As whoever wrote "diffstat" did not think of counting output from
external diff driver, of course in this codepath external diff would
not appear.  So what we see is very much expected.

Just move the blank line we see before these new lines one line
down, so that the variable decls are grouped together, with a blank
line before the first executable statement.  I.e.

	const char *name;
	const char *other;
+       struct userdiff_driver *drv;
+
+	drv = userdiff_find_by_path(...);
+	if (drv && drv->algorithm)
+		set_diff_algorithm(o, drv->algorithm);

Shouldn't this function refrain from setting algorithm from the
driver when the algorithm was given elsewhere?  E.g.

	$ git show --histogram --stat
	
or something?  IOW, shouldn't it also pay attention to
o->ignore_driver_algorithm bit, just like run_diff_cmd() did?


