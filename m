Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E549FC43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 12:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B799A20803
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 12:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6sLtpcy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfLDM7l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 07:59:41 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42959 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfLDM7l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 07:59:41 -0500
Received: by mail-pf1-f195.google.com with SMTP id 4so78707pfz.9
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 04:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d1B/eW83O5+UXTJi9QC4VXyS3n33OJ69Kjmz7IT6g9o=;
        b=e6sLtpcytg3d/enyFQzX32yuU4fo9j8UZ+y5WxEyKjYXJ5B27COgT1tHlZI3hsJpbs
         vRoh9PtETI5K0/HyPQaJ7cG1cWr9/BISftf19IdNNIy3zoPdV0XTLnp23OSU6i7DJNKe
         SraryAzXFKko4HkVVaAGxxGrwzTufr2KtQZtHGEIONSu5xfgrrwcSb7qe1VcQYKKQJDm
         hidjqo1OamLnluWQBhFLDgDOD5H+2JQ9bPhcKsT6CqoTpWPP0nlAxP2o/3gepFerPQx5
         fBCSEf6QJ+uP+7ExZST1NHTvMqnw02I6KSMRceTJ105krxlrQE+6MXGxsRa/B9eZbQ5I
         AIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d1B/eW83O5+UXTJi9QC4VXyS3n33OJ69Kjmz7IT6g9o=;
        b=jD7r1CJCBmH7DTyeU+XEQWe7mykP2yifrpl0qorKo3w8QGcmQo9w30+z+TSdIDSw3O
         RdzWhtG06oWvNCKCmSuE8BCLKUnl23it2h7iNwp+rcMbpOql92/bnTmFHVsFQOmkUHif
         /FBgbCS9xYgjSLvmRBZAX0WCeCW5CRKpt0R9xjxBl0hDpZ1SxE+8rPdLSQQ20bJeJf+l
         8ULs/NpR6L2lNpYcd63U7KjmzrQZbE3L5dY8Vw5Me9LubEGPTl0dtJBMnzKDJ/42Y1C6
         ayKqp2EubjphZ4kAPqdI/GbV/jnpcG1jfEavi56+7xOpHWKr1ZPWzkAffDXasyw6dcN/
         IuJQ==
X-Gm-Message-State: APjAAAWrwIGeMtjaGowEX1z9mUnKm6Kg7ETSbnRw1qSMY9KFoEiGrWg5
        g9NF55X/UAkB5gWoTKnS/RU=
X-Google-Smtp-Source: APXvYqwv0Srvdw4/nbiIbk3j7kyxjSyXFauXL57wGF11/YSSZ5fHVnKz8Pi7od9JqSuAJaPy0JFifg==
X-Received: by 2002:a63:4b24:: with SMTP id y36mr3376411pga.176.1575464380470;
        Wed, 04 Dec 2019 04:59:40 -0800 (PST)
Received: from generichostname ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id q9sm7068645pjb.27.2019.12.04.04.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 04:59:39 -0800 (PST)
Date:   Wed, 4 Dec 2019 04:59:37 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Danh Doan <congdanhqx@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: t: remove inappropriate uses of test_must_fail(), was Re: [PATCH v5
 26/26] t7700: stop losing return codes of git commands
Message-ID: <20191204125937.GA798672@generichostname>
References: <cover.1574731022.git.liu.denton@gmail.com>
 <cover.1574884302.git.liu.denton@gmail.com>
 <1f6d9a80ad45fd9f51c8cffe9ce3721fce9b80c0.1574884302.git.liu.denton@gmail.com>
 <20191130104812.GA18401@danh.dev>
 <CAPig+cQ38J_0wHLw0CuhSdWBBEP-RuAchgG014GPHiSp6QOpsQ@mail.gmail.com>
 <xmqqv9r12tbb.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv9r12tbb.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

On Sat, Nov 30, 2019 at 09:00:08AM -0800, Junio C Hamano wrote:
>  * Or perhaps we can detect its use on anything that is not "git"
>    automatically?  This is merely to illustrate the idea (the
>    exemption of "env" shown here is too broad for production use)
> 
>    diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
>    index b299ecc326..7ab113cd50 100644
>    --- a/t/test-lib-functions.sh
>    +++ b/t/test-lib-functions.sh
>    @@ -828,6 +828,10 @@ test_must_fail () {
>                    _test_ok=
>                    ;;
>            esac
>    +	case "$1" in
>    +	git|test-tool|env) ;;
>    +	*) echo >&7 "warning: test_must_fail $*???" ;;
>    +	esac
>            "$@" 2>&7
>            exit_code=$?
>            if test $exit_code -eq 0 && ! list_contains "$_test_ok" success

I've been cooking a series that gets rid of inappropriate uses
test_must_fail() for a while now. As a finishing touch, I implemented
the idea Junio suggested above and it seems to be working well.

It's a pretty hefty series, weighing in at 46 patches. After the dust
settles on 'dl/test-cleanup' (once it gets merged to master), I'll
probably start sending out this test_must_fail() series around 10
patches at a time.

An advanced preview can be found here[1]. Or, if you'd like me to
privately mail you the series, I can do that too. Early comments would
be very appreciated.

Thanks,

Denton

[1]: https://github.com/Denton-L/git/commits/ready/cleanup-test-must-fail
