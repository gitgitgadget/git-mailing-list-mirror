Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C86C49EA6
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 15:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B43661C4D
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 15:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhFZPOe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Jun 2021 11:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhFZPOc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jun 2021 11:14:32 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA12C061574
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 08:12:10 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id y4so6812338qvs.10
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 08:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=lDuXyT0z4h7iSIkc2Lzf15FJaG8D7Be89DzUoLrDWKQ=;
        b=KJ6Ddi+lliwire04GzELScDL4wyRPXPBXD1sNMqw1tf0uDVrkDIrfZQkFBiGsCdK3c
         MJAgCu3inRNpZHa+NiA/8Nkgz6VWtXqjbTg3WpyhfjotRynI1ktwGvvtasK/1O3d8wV7
         pKckCGw+J2ShgPY+EbX/iTMZpxanomCDv/cOe/ATp539GfebosgKgjjeTO7KuTLHBpkg
         qupwF4LQgMBExNQQTm47m88KPU2NXWlTqKU/am83nb/OE/Ko5Msh9BTpG/HS98mtke39
         gI2Gji3mshAq9rAIBSKvtHneYvjiFvPiF/WPjPEV/IiARkGDikKs2trxRNTIwT8twbJL
         Jgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lDuXyT0z4h7iSIkc2Lzf15FJaG8D7Be89DzUoLrDWKQ=;
        b=k989Afo+UpnnIcJNzte3DbVKoqFzR6oihtFdKypoqUJEMrzrZ67yZrrVIhEjeY5x7J
         7oF304RDuVWLhkeIT7WaGpPv3F3Tu9GPbo00xeTbK6r72pW+Yx5CCkTtbTxSJ/oMo/64
         g0jU6BHBGp1xvon5xux1z/f48/BPsx2xcKf15uCNbweS25eAj98HUsdlVpFyLQahpuRL
         rN2Mt5CT+8KBtXvHpNFTlZVx5Oab1azgDvGNueW/xneETuSnbB/VoUCd6j8Pfz8rWrD0
         qEj7CAOzxirWfJiSZPoBkMuNvAHcKVIevyaFXAfDgfXay/9aWkcLNRaUFK7eYaK7R4Rr
         dCbw==
X-Gm-Message-State: AOAM530NWM69nKUUXRcIPPHDpGXQX2EbOE+tpHPWyn7X5G79VUyUi3s4
        /gUZiFROTgQ8qALrZYo8+mA=
X-Google-Smtp-Source: ABdhPJz4Dj001MczotL7cgO8vv/qFcVb9uI2jaq3NPB0i5LZf+OesCcpuCqgq92ZzpE+TGrQb4rMmA==
X-Received: by 2002:a0c:ef8b:: with SMTP id w11mr16740372qvr.37.1624720329694;
        Sat, 26 Jun 2021 08:12:09 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id l23sm5700905qtp.28.2021.06.26.08.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jun 2021 08:12:08 -0700 (PDT)
Subject: Re: [PATCH] submodule: mark submodules with update=none as inactive
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Rose Kunkel <rose@rosekunkel.me>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <YMvgRjwyrwyLz4SC@camp.crustytoothpaste.net>
 <20210619214449.2827705-1-sandals@crustytoothpaste.net>
 <56b5c722-8baf-9f9c-cc9f-5b5ed49d7fc3@gmail.com>
 <YNZgoS9R1qam+62C@camp.crustytoothpaste.net>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <67a6e80e-6eb6-10c2-2dcd-0610343884cd@gmail.com>
Date:   Sat, 26 Jun 2021 11:12:07 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNZgoS9R1qam+62C@camp.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

Le 2021-06-25 à 19:02, brian m. carlson a écrit :
> On 2021-06-22 at 03:45:45, Philippe Blain wrote:
>>> That will make us properly ignore the submodule
>>> when performing recursive operations.
>>>
>>> Note that we only do this when the --require-init option is passed,
>>> which is only passed during clone.  That's because the update-clone
>>> submodule helper is also invoked during a user-invoked git submodule
>>> update, where we explicitly indicate that we override the configuration
>>> setting, so we don't want to set such a configuration option then.
>>
>> I'm not sure what you mean here by 'where we explicitely indicate that we
>> override the configuration setting'. For me, as I wrote above,
>> 'git clone --recurse-submodules' and 'git clone' followed by
>> 'git submodule update --init' should lead to mostly [*] the same end result.
>>
>> If you mean 'git submodule update --checkout', that indeed seems to sometimes override the 'update=none'
>> configuration (a fact which is absent from the documentation), 

Note that I'm taking back that statemnt about the doc; the description of 'git submodule update'
states:

"The "updating" can be done in several ways depending on command line options
and the value of submodule.<name>.update configuration variable. The command line
option takes precedence over the configuration variable."

I was somehow under the impression that 'none' was a special case, but it's not.

then it's true that we
>> would not want to write 'active=false' at that invocation. As an aside, in my limited testing
>> I could not always get 'git submodule update --checkout' to clone and checkout 'update=none' submdules;
>> it would fail with "fatal: could not get a repository handle for submodule 'sub1'" because
>> 'git checkout/reset --recurse-submodules' leaves a bad .git/modules/sub1/config file
>> with the core.worktree setting when the command fails (this should not happen)...
> 
> Yes, that's what I meant.
> 
>> In any case, that leads me to think that maybe the right place to write the 'active' setting
>> would be during 'git submodule init', thus builtin/submodule--helper.c::init_submodule ?
>> This way it would lead to the same behaviour if the clone was recursive or not,
>> and it would not interfere with 'git submodule update --checkout'.
> 
> Let me take a look at some other approaches and see if I can come up
> with something a little bit better.

I tested the following and it fixes the bug (for both recursive clone and
normal clone followed by 'git submodule update --init') and
t7406-submodule-update.sh still passes:

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d55f6262e9..a4cd86c72f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -686,6 +686,13 @@ static void init_submodule(const char *path, const char *prefix,
  
  		if (git_config_set_gently(sb.buf, upd))
  			die(_("Failed to register update mode for submodule path '%s'"), displaypath);
+
+		/* Mark update=none submodules as inactive */
+		if (sub->update_strategy.type == SM_UPDATE_NONE) {
+			strbuf_reset(&sb);
+			strbuf_addf(&sb, "submodule.%s.active", sub->name);
+			git_config_set_gently(sb.buf, "false");
+		}
  	}
  	strbuf_release(&sb);
  	free(displaypath);

> 
> My apologies for the delay in response; I'm in the process of moving at
> the moment and my attention has been directed elsewhere than the list.
> 

No problem of course!

Philippe.


[1] https://git-scm.com/docs/git-submodule#Documentation/git-submodule.txt-update--init--remote-N--no-fetch--no-recommend-shallow-f--force--checkout--rebase--merge--referenceltrepositorygt--depthltdepthgt--recursive--jobsltngt--no-single-branch--ltpathgt82308203
