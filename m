Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78127C4332F
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 19:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiKOT7O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 14:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiKOT7H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 14:59:07 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA112C665
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 11:59:02 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id bj12so38722818ejb.13
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 11:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nkuHH3OmBfWOqVRj1w0ErXe6s5nz3fHlURwrITmdAXw=;
        b=Y/9gq0ZgWC50cu5V3sJgwgrrnB9Jg3IDtZWqXh4bX4suj8b/mQQD2jZPucOKSxB3Ly
         DJP8nubUx+nd9HNO1qQu2SQ+D5Y7MlJAhSbPgK+tlW4oJalvPdbrGc0h3xraqqxK5x9K
         b/LwyHhtljK+ExAHj4Shyb+eYlMDoJUCx/ADsSH7mvlj4GNdGo8SExsGMJGqSZF8R6Da
         xmjk51uMnxVd5H3GXJzA13Uyd7NFp1h8uLdLLCDgKiwRKExv/tVmjWzGbM/F4VakgLQT
         nv1LEzgd9g35d4GGtejzWuxBgkqFC9k2aeyu1c5FzzwBb0lx8LyUb+6mD8cR9bvkO8B1
         re7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkuHH3OmBfWOqVRj1w0ErXe6s5nz3fHlURwrITmdAXw=;
        b=tIIS3hO/lWKKemp5LBQXlGfMcmiJHbgenjnrdjxYomxtFlo+PzZkrQWkS0HyET3bwb
         dWHxZ2hynZ7vqp3DBMDTUdyAvjZfqPGI5jbD4TcjyoSILy1vSBFOgn14lMa1UC8WI6Ai
         N+9s8ToWumAPx38VYW0DG1BWJoLljbkyEj3yGadVauJLZw4ufj6ebaRhX69gdWQ47o/d
         AMgeUw/q4n37DAj/5FnJr27uEBGVc4fJzWEMBBcZ36XOzqVBFGN29RWqBSNV5Kam3eH1
         ZdWRGYSoZYcfQAGrXE4LPlT4qbNjmCKsUHN9LZfrgfLJrs0KEGlQG/eEc9ysO+MjFmEs
         f+kQ==
X-Gm-Message-State: ANoB5pl1SzPKtLyP0eqIWTUay0UmBPMbDuGmgIBlLLOJKpnd/MocKZNq
        jR8636ZWRuETBD4NLI33yts=
X-Google-Smtp-Source: AA0mqf7rUqkLO9yLk0WEXzhstcHt+GQs7FxeKrw4auUEUdCh9m+u6FSqQO0NvP5cYLx3mXZk3Vw5Yw==
X-Received: by 2002:a17:906:414d:b0:781:951:2fb with SMTP id l13-20020a170906414d00b00781095102fbmr15284716ejk.64.1668542340412;
        Tue, 15 Nov 2022 11:59:00 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906210200b007aee7ca1199sm4518186ejt.10.2022.11.15.11.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 11:58:59 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ov25D-003j0A-0W;
        Tue, 15 Nov 2022 20:58:59 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        git-security@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ronan Pigott <ronan@rjp.ie>
Subject: Re: [PATCH] builtin/gc.c: fix use-after-free in
 maintenance_unregister()
Date:   Tue, 15 Nov 2022 20:51:26 +0100
References: <2cbead254b77cb02d219bca8f628dc4362c045b0.1668538355.git.me@ttaylorr.com>
 <d8b732c9-ae41-bf1b-3bb1-6682493bee70@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <d8b732c9-ae41-bf1b-3bb1-6682493bee70@github.com>
Message-ID: <221115.86mt8sj8fw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 15 2022, Derrick Stolee wrote:

> On 11/15/2022 1:53 PM, Taylor Blau wrote:
>> While trying to fix a move based on an uninitialized value (along with a
>> declaration after the first statement), be0fd57228
>> (maintenance --unregister: fix uninit'd data use &
>> -Wdeclaration-after-statement, 2022-11-15) unintentionally introduced a
>> use-after-free.
>> 
>> The problem arises when `maintenance_unregister()` sees a non-NULL
>> `config_file` string and thus tries to call
>> git_configset_get_value_multi() to lookup the corresponding values.
>> 
>> We store the result off, and then call git_configset_clear(), which
>> frees the pointer that we just stored. We then try to read that
>> now-freed pointer a few lines below, and there we have our
>> use-after-free:
>
> Makes sense why this needs to be pulled out to a larger scope, but
> also why it's so easy to make this mistake.

Yeah, the config API's full of foot-guns, although here we return a
"const struct string_list *", not a "struct string_list *", so in
retrospect this should be rather obvious...

But still, we should probably as #leftoverbits make it behave
consistently wrt naming. I.e. in this case it's
git_configset_get_value_multi() really behaves like a
git_configset_get_string_tmp(), and there's no equivalent of a
git_configset_get_string() (i.e. xstrdup()'d) for *_multi().

>> +	struct config_set cs = { { 0 } };
>> 
>>  	argc = parse_options(argc, argv, prefix, options,
>>  			     builtin_maintenance_unregister_usage, 0);
>> @@ -1551,12 +1552,9 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
>>  				   options);
>> 
>>  	if (config_file) {
>> -		struct config_set cs;
>> -
>>  		git_configset_init(&cs);
>>  		git_configset_add_file(&cs, config_file);
>>  		list = git_configset_get_value_multi(&cs, key);
>> -		git_configset_clear(&cs);
>
> That the list depends on the configset and not exist as an
> independent entity is non-obvious, but I'm sure is rooted
> in some kind of memory-saving optimization.

Yes, and it's probably worth keeping that, but I haven't benchmarked
etc. This is only a problem in practice if you're constructing your own
configset, e.g. here because we have a custom config file. So for most
users this API is safe in general, i.e. we free() it, but it's the
config that's in "the_repository" normally, so it outlives any "normal"
code.

>>  	} else {
>>  		list = git_config_get_value_multi(key);
>>  	}
>> @@ -1592,6 +1590,7 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
>>  		die(_("repository '%s' is not registered"), maintpath);
>>  	}
>> 
>> +	git_configset_clear(&cs);
>>  	free(maintpath);
>>  	return 0;
>>  }
>
> Thanks for drilling down on this. LGTM.

On the related subject of config API foot-guns, it would be great if you
could look over the in-flight series I have to make related parts of the
config API safe by default [1].

8/9 there fixes 6 segfaults, 3 of which are git blame'd to you :), and
9/9 a foot-gun-y interaction with the strvec API, which you'll also
probably find interesting...

1. https://lore.kernel.org/git/cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com/
