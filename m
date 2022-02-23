Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2223AC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 14:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241450AbiBWOOY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 09:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241433AbiBWOOX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 09:14:23 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FCAB12F1
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:13:55 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id k13-20020a4a948d000000b003172f2f6bdfso22428685ooi.1
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=vXSFOvzYwc2lEW5g/01HhCAlzU9IYB7YVIgbjPDEkuA=;
        b=VW3JGph4ZseKO10OqiCVKBdpGtSSEgX+BAEbkRl3vxXmFe04FtQX9uh755TYIGQ4cI
         OS1FUYrvYhn6GqyrpmB5ACvx73UDU+FX1eXvh2YE5FXTpPPD+W1fMXd8ywfzQOwHt9n9
         v5MGq/bh7a0MbS6bjXBtNpZk3s6gUwLSgYDeqeemxqPZn7IifEMaK2LtMokbADARyp03
         FPGifYOYQEgk7+LpKGW2ciIhV4HxaT0L9T79HXV72tyulJMkhfb1mdpx39l0TIKLdYGd
         aYO/SIr6ky6FgxIFly+nvznpdN8J092rq07o7XZv7tMY0amrHmFtmMxf9WzPyKwhtdeo
         fNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vXSFOvzYwc2lEW5g/01HhCAlzU9IYB7YVIgbjPDEkuA=;
        b=YhQ+e9de53AweySb0jEc87kHncvqKgj+5T9zsy36ptTYq70RkwMnyPy4Ifzwuy7weh
         UEVOr2Aq1RL5elk+UwIzVkKTN7cNdSWNHSiUHx8IL7sOWd2jvn0S7VFrAni7uRPlQI5z
         9Lf4mixbyRBbZiu8pGm9DKWIKp/Sluy0fKysz7YhzIESoL3XirYfWC0mf0U/w2tFnbNW
         Je4hkZhb9QNktOrcReZXaCExIDAAm7a5olHnNrK0gqzTPjkroeF5nkx6LKH5xUWxouei
         F9b0g3QXEM0sO5fOjMpbfdTtc3ABNtFZn2Sv70faURQ/UATiesF6rJS+/ZLare0UZEer
         wL4Q==
X-Gm-Message-State: AOAM532b6tGjiWHLSeZZqfshwNsMdlYIYV8pZkKpc+qMQXFn6p5Yz45T
        vIOkkSo2rgyO3PhtGWbikPOGA2+d6kEU
X-Google-Smtp-Source: ABdhPJx+RLPW0S6Ulx/3aqJqiu0vBKUo17lWHu4Z+wvk0n0tloB+LHMCpoY1yPxAPDsSCxeKt1tRLg==
X-Received: by 2002:a05:6870:2a41:b0:d3:473b:3e96 with SMTP id jd1-20020a0568702a4100b000d3473b3e96mr3858784oab.38.1645625634690;
        Wed, 23 Feb 2022 06:13:54 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id x17sm7547554oop.1.2022.02.23.06.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 06:13:54 -0800 (PST)
Message-ID: <ddb91a1d-6ddf-ba25-f1af-ba3f4c18726e@github.com>
Date:   Wed, 23 Feb 2022 09:13:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/5] upload-pack: look up "want" lines via commit-graph
Content-Language: en-US
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1645619224.git.ps@pks.im>
 <ca5e136cca495c7d927e99f5ae8a672d93823eea.1645619224.git.ps@pks.im>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ca5e136cca495c7d927e99f5ae8a672d93823eea.1645619224.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/23/2022 7:35 AM, Patrick Steinhardt wrote:

> The following benchmark is executed in a repository with a huge number
> of references. It uses cached request from git-fetch(1) as input and
> contains about 876,000 "want" lines:
> 
>     Benchmark 1: git-upload-pack (HEAD~)
>       Time (mean ± σ):      7.113 s ±  0.028 s    [User: 6.900 s, System: 0.662 s]
>       Range (min … max):    7.072 s …  7.168 s    10 runs
> 
>     Benchmark 2: git-upload-pack (HEAD)
>       Time (mean ± σ):      6.622 s ±  0.061 s    [User: 6.452 s, System: 0.650 s]
>       Range (min … max):    6.535 s …  6.727 s    10 runs
> 
>     Summary
>       'git-upload-pack (HEAD)' ran
>         1.07 ± 0.01 times faster than 'git-upload-pack (HEAD~)'

Nice!

> -		o = parse_object(the_repository, &oid);
> +		commit = lookup_commit_in_graph(the_repository, &oid);
> +		if (commit)
> +			o = &commit->object;
> +		else
> +			o = parse_object(the_repository, &oid);
> +

This is a neat trick. I see that we've also done this trick in
revision.c:get_reference(). Perhaps it is worth creating a helper,
maybe named parse_probably_commit()?

>  		if (!o) {
>  			packet_writer_error(writer,
>  					    "upload-pack: not our ref %s",
> @@ -1434,7 +1440,7 @@ static int parse_want_ref(struct packet_writer *writer, const char *line,
>  	if (skip_prefix(line, "want-ref ", &refname_nons)) {
>  		struct object_id oid;
>  		struct string_list_item *item;
> -		struct object *o;
> +		struct object *o = NULL;
>  		struct strbuf refname = STRBUF_INIT;
>  
>  		strbuf_addf(&refname, "%s%s", get_git_namespace(), refname_nons);
> @@ -1448,7 +1454,15 @@ static int parse_want_ref(struct packet_writer *writer, const char *line,
>  		item = string_list_append(wanted_refs, refname_nons);
>  		item->util = oiddup(&oid);
>  
> -		o = parse_object_or_die(&oid, refname_nons);
> +		if (!starts_with(refname_nons, "refs/tags/")) {
> +			struct commit *commit = lookup_commit_in_graph(the_repository, &oid);
> +			if (commit)
> +				o = &commit->object;
> +		}
> +
> +		if (!o)
> +			o = parse_object_or_die(&oid, refname_nons);
> +

Even here, we _could_ use a parse_probably_commit() helper
inside the if (!starts_with(...)) block, even though we would
still need the if (!o) check later.

Thanks,
-Stolee
