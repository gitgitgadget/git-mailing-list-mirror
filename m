Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC795C433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 11:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348531AbiETLaJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 07:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244015AbiETLaE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 07:30:04 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D273215A768
        for <git@vger.kernel.org>; Fri, 20 May 2022 04:30:03 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id i40so10401571eda.7
        for <git@vger.kernel.org>; Fri, 20 May 2022 04:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=DvIDxyYTFVuCIumfmPhQ/oTOAnbmtAqDu5pDPFa0HhE=;
        b=ZmGlzTdqHx7uuRPNfnAW5eDP3RMqedYICnrJLtMQkYJ6PljU0H//rr/ORlL2mwggZJ
         bcEyU+vxAKbpI+HGeLlZ7nYVwayP4DJg86+6bFrsKVIcqUhFEDQlBma5Azr4OSMxkyHz
         2M+iE4aEcbdm42WPT59B3Z3B1v4dSV9PQNU9FPorHcPjjElQIE+SvHpvEgA/NgDsPGTj
         FaO5ZcmDPXF+FLlIEvYSLaGgqTgA/EFqbtIY145Ex5qG+og0DJbfkjy/MCdaR9uuiZKN
         0FyhmPjb7mIgzfwSTTR1K1zp7oVHyp7K36BtXSqK4cmD0cCsS7zJWHa7y3c9M10ATj/K
         3RAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=DvIDxyYTFVuCIumfmPhQ/oTOAnbmtAqDu5pDPFa0HhE=;
        b=1wb2cqMrxqI9dESdG2i/w0yuXSyeCmJdaKKYGDXQ8y59PLvz349TsfmdZW1nfExXLh
         o1P1wXzKRyuayVXEVD9AQck2nmTEhQ9owoXREv3rvw5sJslhSUv1g4uJA/ZAayYqQUtf
         caG4uNgC86mowegqstcvmCPBONISBn+nPMklroNNO/YokeNHOVI1f4OvlXflhhk5c21y
         8nBmBU79xp73kSsd3xk46CCCHDcgsd/q08xU/p7PvRMtprShEOKrv3ix1mMsn05onBro
         Kx8JRKi39IALknbDtp6SAAj8e1xDqyN3W6CDNsx8lqDAcOKpKzXJmwbqyW03nuCGI7YZ
         7dlw==
X-Gm-Message-State: AOAM532e9V6bkp6h3EDsI91y4OfhnISUttN9QAYhyHiIQ7DrTWr32TNC
        oRnyTwcAKB1r5Cfv0plHlAI=
X-Google-Smtp-Source: ABdhPJye39x9dnhsrKltNltNUwC+L7f4J0DJKoLlo1T4ylhb6/jKZ8nM2jPBddona0n9BRt7qxLb4g==
X-Received: by 2002:a05:6402:5243:b0:427:caa4:f75 with SMTP id t3-20020a056402524300b00427caa40f75mr10319144edd.153.1653046202237;
        Fri, 20 May 2022 04:30:02 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id yl16-20020a17090693f000b006f3ef214e3bsm3040174ejb.161.2022.05.20.04.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 04:30:01 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ns0pU-002Vft-DR;
        Fri, 20 May 2022 13:30:00 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Frantisek Hrbata <frantisek@hrbata.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmc=?= =?utf-8?B?4buNYw==?= Duy 
        <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/2] transport: remove unnecessary indenting in
 transport_push()
Date:   Fri, 20 May 2022 13:24:28 +0200
References: <20220520081723.1031830-1-frantisek@hrbata.com>
 <20220520103507.1717236-1-frantisek@hrbata.com>
 <20220520103507.1717236-2-frantisek@hrbata.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220520103507.1717236-2-frantisek@hrbata.com>
Message-ID: <220520.86y1yw1lxj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 20 2022, Frantisek Hrbata wrote:

> Remove the big indented block for push_refs() check in transport vtable
> and let's just return error immediately. Hopefully this makes the code
> more readable.

s/push_refs/transport_push/, push_refs is the name of the field in the
callback (and there's more than just this function).

This looks good to me....

> Is there a reason to return 1 instead of -1 when push_refs() is not
> set in transport vtable? Looking at the code I think it might return
> -1 also and make it more consistent.

No, looking at it (I tried renaming the function) the only user is
builtin/push.c, which we can easily see doesn't care about the 1 v.s. -1 here.

Perhaps it's worthwhile to add this in-between the two patches you have:
	
	diff --git a/transport.c b/transport.c
	index 0b9c5a427d7..5348fac36ef 100644
	--- a/transport.c
	+++ b/transport.c
	@@ -1283,22 +1283,23 @@ int transport_push(struct repository *r,
	 	int quiet = (transport->verbose < 0);
	 	int porcelain = flags & TRANSPORT_PUSH_PORCELAIN;
	 	int pretend = flags & TRANSPORT_PUSH_DRY_RUN;
	-	int push_ret, ret, err;
	+	int push_ret, err;
	+	int ret = -1;
	 	struct transport_ls_refs_options transport_options =
	 		TRANSPORT_LS_REFS_OPTIONS_INIT;
	 
	 	*reject_reasons = 0;
	 
	 	if (transport_color_config() < 0)
	-		return -1;
	+		goto done;
	 
	 	if (!transport->vtable->push_refs)
	-		return 1;
	+		goto done;
	 
	 	local_refs = get_local_heads();
	 
	 	if (check_push_refs(local_refs, rs) < 0)
	-		return -1;
	+		goto done;
	 
	 	refspec_ref_prefixes(rs, &transport_options.ref_prefixes);
	 
	@@ -1319,7 +1320,7 @@ int transport_push(struct repository *r,
	 		match_flags |= MATCH_REFS_FOLLOW_TAGS;
	 
	 	if (match_push_refs(local_refs, &remote_refs, rs, match_flags))
	-		return -1;
	+		goto done;
	 
	 	if (transport->smart_options &&
	 	    transport->smart_options->cas &&
	@@ -1333,7 +1334,7 @@ int transport_push(struct repository *r,
	 
	 	if (!(flags & TRANSPORT_PUSH_NO_HOOK))
	 		if (run_pre_push_hook(transport, remote_refs))
	-			return -1;
	+			goto done;
	 
	 	if ((flags & (TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND |
	 		      TRANSPORT_RECURSE_SUBMODULES_ONLY)) &&
	@@ -1417,6 +1418,7 @@ int transport_push(struct repository *r,
	 	else if (!quiet && !ret && !transport_refs_pushed(remote_refs))
	 		fprintf(stderr, "Everything up-to-date\n");
	 
	+done:
	 	return ret;
	 }

Which would make your new 3/3 truly trivial, i.e. just adding the
free_refs() for the two.

*Maybe* (but probably not) it would then make sense to do this as that 3/3:
	
	diff --git a/transport.c b/transport.c
	index 5348fac36ef..d4952bf5f6a 100644
	--- a/transport.c
	+++ b/transport.c
	@@ -1291,15 +1291,17 @@ int transport_push(struct repository *r,
	 	*reject_reasons = 0;
	 
	 	if (transport_color_config() < 0)
	-		goto done;
	+		return ret;
	 
	 	if (!transport->vtable->push_refs)
	-		goto done;
	+		return ret;
	 
	 	local_refs = get_local_heads();
	 
	-	if (check_push_refs(local_refs, rs) < 0)
	+	if (check_push_refs(local_refs, rs) < 0) {
	+		remote_refs = NULL;
	 		goto done;
	+	}
	 
	 	refspec_ref_prefixes(rs, &transport_options.ref_prefixes);
	 
	@@ -1419,6 +1421,8 @@ int transport_push(struct repository *r,
	 		fprintf(stderr, "Everything up-to-date\n");
	 
	 done:
	+	free_refs(local_refs);
	+	free_refs(remote_refs);
	 	return ret;
	 }

I.e. entirely skip the NULL assignment for the two, which helps the
compiler catch if we don't init it before the later goto's, but because
of that we'd need to "return" instead of "goto done" for the early ones,
and set it for the check_push_refs() failure case.

So nah, probably best just to keep it as you have it, i.e. always "goto
done".
