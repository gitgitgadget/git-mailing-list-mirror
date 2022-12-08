Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E641AC4332F
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 18:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiLHSNs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 13:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiLHSNo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 13:13:44 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305E676833
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 10:13:43 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b3so3284868lfv.2
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 10:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wy+NyRdvUv4qZnhtz5UtZIpOToRcIFATMd7jgrxzvug=;
        b=O082X2Kt5WqAZAr1xVbN+R+oLkaxfUzuNw9cfDCOIOeIYBIKgLxnz5ofvm05831MID
         mJILD2N0v9+TpxuXHzvNOMjpKyi65aGxIgy9DjbAqTo9Z4Py2s1+GVnIzg6hsIhRV18h
         7f11LKqkDuS1dgmMv1641EqfT+ia9gNEqlP5n/xFJtyr7zV9lkeyeSR5MM0M67HjEDIi
         n5qH2foKz5o/aj67LoCLIA5YsEWFFvq7fbZX02N4AqIhQrjaorZMWPgkQi5I6gI1Ea74
         Qaxp/ZMdPPxKO7N8/qPfcbwaBaHwRmvU6yqZM7jJIGxAw3z4Z9OcJpjZ2hyz1k2AieOl
         Mvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wy+NyRdvUv4qZnhtz5UtZIpOToRcIFATMd7jgrxzvug=;
        b=gKZGGSI3n1awA+dSQ0CcnqzEYCa0w6qfy2aPNekjI3to6ey9Jh15zIoAXASv/2vqTm
         uRQALOjPVOWMGZsQfezk5zwkU9I3laLR9vCPWEOQTAGpFURQSahk7keV97wjcKJNpXOr
         7m5EEyWIo4P9609RrM5NElB+ychU67UzpYCuDMWXm015DMCye0dkvr5CO/ApPV8h4Msr
         /8ETiZxBl5cWK5gWtcVj0CcHFg/jRJ3sSFaJBbR6epGTlZrwVFuBEG8YQPI6cGWmL/+M
         s20zku7mgTbocWqA4oK3IN0OYRAcIlR68RuupNn4utnurtt+Yf3GBe7OTghlPSgjgozI
         DErg==
X-Gm-Message-State: ANoB5pk0jHzFvyXATnyUzQ9DS/yC3QZpXXZYyRvhihKKdr6s1e2gtMWN
        XW0JaJujoxBmZtVDYJykrzXAgxblHiw=
X-Google-Smtp-Source: AA0mqf45oOrN3FqafOo2s22hc15H8F81QTtF6ddkFnrIXXdlS0ELv0ZXrX7S8GQJXpBjG4+mCWTu+Q==
X-Received: by 2002:ac2:4119:0:b0:4b5:7f15:aa21 with SMTP id b25-20020ac24119000000b004b57f15aa21mr983294lfi.52.1670523221005;
        Thu, 08 Dec 2022 10:13:41 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id e26-20020ac2547a000000b004b585ff1fcdsm798341lfn.273.2022.12.08.10.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 10:13:40 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/5] diff-merges: implement [no-]hide option and
 log.diffMergesHide config
References: <20221127093721.31012-1-sorganov@gmail.com>
        <20221127093721.31012-2-sorganov@gmail.com>
        <kl6lfsdqep25.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Thu, 08 Dec 2022 21:13:38 +0300
In-Reply-To: <kl6lfsdqep25.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Wed, 07 Dec 2022 16:06:58 -0800")
Message-ID: <87zgbxahm5.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> @@ -49,10 +49,11 @@ ifdef::git-log[]
>>  --diff-merges=m:::
>>  -m:::
>>  	This option makes diff output for merge commits to be shown in
>> -	the default format. `-m` will produce the output only if `-p`
>> -	is given as well. The default format could be changed using
>> +	the default format. The default format could be changed using
>>  	`log.diffMerges` configuration parameter, which default value
>>  	is `separate`.
>> ++
>> +	`-m` is a shortcut for '--diff-merges=on --diff-merges=hide'
>>  +
>
> I found this description difficult to parse, since
>
> a) it wasn't clear that multiple "--diff-merges" would all be respected
> b) I had to read the --diff-merges=hide documentation to understand what
>    this means
>
> Keeping the plain english description would help, something like:
>
>   `-m` only produces the output if `-p` is also given, i.e. it is a
>   shortcut for '--diff-merges=on --diff-merges=hide'.

Thanks, I'll review the documentation if we decide all this stuff is
useful.

>
>> diff --git a/builtin/log.c b/builtin/log.c
>> index 56e2d95e869d..e031021e53b2 100644
>> --- a/builtin/log.c
>> +++ b/builtin/log.c
>> @@ -581,6 +581,8 @@ static int git_log_config(const char *var, const char *value, void *cb)
>>  	}
>>  	if (!strcmp(var, "log.diffmerges"))
>>  		return diff_merges_config(value);
>> +	if (!strcmp(var, "log.diffmergeshide"))
>> +		return diff_merges_hide_config(git_config_bool(var, value));
>>  	if (!strcmp(var, "log.showroot")) {
>>  		default_show_root = git_config_bool(var, value);
>>  		return 0;
>
> Since we have log.diffmergeshide that is different from log.diffmerges,
> it seems like it would be more consistent to have '--diff-merges-hide'
> as a separate flag.

I'd rather drop log.diffmergeshide, as log.diffMerges=hide does the same
thing. I'm just not sure if multiple instances of the same
log.diffMerges config are simple enough to manage through "git config"
interface.

This is independent of --diff-merges-hide suggestion, that, if
implemented, I'd prefer to read as --diff-merges-flags=[no-]hide, to
provide space for future flags, even though I still prefer a syntax
inside existing "--diff-merges" namespace. Something like:

  --diff-merges=<format>[,<flag>[,...]]

<format>: on|off|c|cc|remerge|...
<flag>:   [no-]hide|...

>
>> @@ -69,6 +87,10 @@ static diff_merges_setup_func_t func_by_opt(const char *optarg)
>>  {
>>  	if (!strcmp(optarg, "off") || !strcmp(optarg, "none"))
>>  		return set_none;
>> +	if (!strcmp(optarg, "hide"))
>> +		return set_hide;
>> +	if (!strcmp(optarg, "no-hide"))
>> +		return set_no_hide;
>>  	if (!strcmp(optarg, "1") || !strcmp(optarg, "first-parent"))
>>  		return set_first_parent;
>>  	if (!strcmp(optarg, "separate"))
>> @@ -105,7 +127,19 @@ int diff_merges_config(const char *value)
>>  	if (!func)
>>  		return -1;
>>  
>> -	set_to_default = func;
>> +	if (func == set_hide)
>> +		hide = 1;
>> +	else if (func == set_no_hide)
>> +		hide = 0;
>> +	else
>> +		set_to_default = func;
>> +
>> +	return 0;
>> +}
>
> The code is also simpler if we took a separate CLI flag, e.g. we could
> get rid of this special casing of "(func == X)".

I foresee complications elsewhere. Overall complexity won't be that
different either way, I think.

Thanks,
-- 
Sergey Organov
