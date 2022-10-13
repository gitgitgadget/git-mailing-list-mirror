Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69160C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 19:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJMTNO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 15:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJMTMm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 15:12:42 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189D4159D57
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 12:12:41 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id y14so5953806ejd.9
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 12:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s+3uEWvzhsavsGGQqPi89MfhdMzjNnIv7HBfuDHNKyw=;
        b=FlUBUBNooWJ0xnekv9SxMso2kcaPxQoPcdqI7fKaoKVzzqGtIhXO8PnPFiQ5+AcXoK
         SlZnaS+T4Q8M6kryt0oBjypqa9RIvEq0ulZfTFzSGhp25nqglaIQEtE/o7qN0HQB7Edr
         WQymq3EPAhCWp68ebGnrljoY15W1+6S452tBcYXeWMbbtkIGJtfWSt03fQOc8lvPzaRN
         1JO/1me9cPLWGCNZPzVBRvpehQg/CRH280B8S1EuPqDPth6WB1NLu++BhHg45tjmbSfm
         fIiGcye8Cg7LkeqWV94x+ml1WlNvnPsLxMQigvptRg1yWR7KaC7vy6LGVH0kOhO/4pZz
         pPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+3uEWvzhsavsGGQqPi89MfhdMzjNnIv7HBfuDHNKyw=;
        b=J4t/KgF8MFEA4uK/Rhhr/FCE4fSrOVYm50gR3Xvxmewk5NQHMCPmKC5NBaIXOjRoAN
         hJpli26BRBfMj5WcwJUJOTyAL0pu9FP+3WAthI5AxWlmGZN/K3jf6g8zQUFCilZeaaBZ
         F+73L8T9BxPf2K7dzjb2WIGfIV6gwqREaeKKfP4y4M4eABqCM5V46aEr+d9epuGPTxMq
         WyNXmgCKEMbkG+V3UaFGL8H2P0OWWhXnAldAZCkuOGcjWS4CHOrGWvrwjIKBjB5oKyHr
         XA8SauUkaQWN/ooiAMqOrdeTDRyxcKXgq/Qh9CMmkldYUnWylllAUnHkNZZmOTgAbl0p
         Q7kQ==
X-Gm-Message-State: ACrzQf0CqyT4Mud/8RgRS1r6+wke/BLf7k5UmGxzBXL/Y36QQ8Opu6gs
        HOk6yFp2IHydtQYQ3KN4PoKuVE45NbuDXg==
X-Google-Smtp-Source: AMsMyM5fEyEiBZakx+NZ4VeenHfruAzHFVy/wqwN79QzcXpVl0k18nOORiXEU/gwk+DyfF0+cboYDw==
X-Received: by 2002:a17:906:58cc:b0:78d:ce9c:3787 with SMTP id e12-20020a17090658cc00b0078dce9c3787mr865075ejs.715.1665688359110;
        Thu, 13 Oct 2022 12:12:39 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id c22-20020a50d656000000b004533fc582cbsm349259edj.21.2022.10.13.12.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 12:12:38 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oj3dF-004vng-0U;
        Thu, 13 Oct 2022 21:12:37 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 3/8] rebase: be stricter when reading state files
 containing oids
Date:   Thu, 13 Oct 2022 21:10:53 +0200
References: <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
 <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
 <1fd58520253420fbe870a8528540dbc9e2178e3f.1665650564.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <1fd58520253420fbe870a8528540dbc9e2178e3f.1665650564.git.gitgitgadget@gmail.com>
Message-ID: <221013.86fsfrleqi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 13 2022, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> The state files for 'onto' and 'orig_head' should contain a full hex
> oid, change the reading functions from get_oid() to get_oid_hex() to
> reflect this.

This seems sensible, but isn't "full hex oid" the tip of the iceberg in
get_oid() v.s. get_oid_hex() differences? The former allowing
e.g. :-syntax, ^-syntax etc.

> @@ -431,7 +431,7 @@ static int read_basic_state(struct rebase_options *opts)
>  	opts->head_name = starts_with(head_name.buf, "refs/") ?
>  		xstrdup(head_name.buf) : NULL;
>  	strbuf_release(&head_name);
> -	if (get_oid(buf.buf, &oid))
> +	if (get_oid_hex(buf.buf, &oid))

The change looks sensible, maybe a commit message update + assuring
ourselves that we don't care about anyone manually manipulating these
files (e.g. a script with OID abbreviation that would "echo" to these.

>  		return error(_("could not get 'onto': '%s'"), buf.buf);
>  	opts->onto = lookup_commit_or_die(&oid, buf.buf);
>  
> @@ -448,7 +448,7 @@ static int read_basic_state(struct rebase_options *opts)
>  	} else if (!read_oneliner(&buf, state_dir_path("head", opts),
>  				  READ_ONELINER_WARN_MISSING))
>  		return -1;
> -	if (get_oid(buf.buf, &opts->orig_head))
> +	if (get_oid_hex(buf.buf, &opts->orig_head))
>  		return error(_("invalid orig-head: '%s'"), buf.buf);

Not a new issue, but this error() is much more sensible than the above,
we could get "onto", we just didn't like its contents on error(), oh
well...
