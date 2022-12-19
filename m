Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2565DC4167B
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 08:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiLSI7f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 03:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiLSI7d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 03:59:33 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652515F71
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 00:59:31 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s5so11832187edc.12
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 00:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JJ2iudIDjLqzlAaUn3I/FN4BVeT7lm2U25qmirc5dpc=;
        b=Oc85dIyAhRMajZQN9rsllha3gbVVagCCiEn5e4pReNB7lwgzHfJgaGR1cpadhOwoN3
         ep/LFnhpd1Qd3JdkXriJraXD+qIdKBoPHc8hYHPGSByHTGMoWH9t7yO3udXMNjoNogur
         ZLOpDoqZZ4O8PBN3EKi2uD8D28mc3kGzHdzLK/VwYdDCaphSo8SoI+dejXbLY6zVxCgp
         uzccRQQ1OPgHpCZfh69SIPGOaK0wUXndVguWxu1kPqFngBZtvIjtaNAVOZRKDxubH0JJ
         hYPv988z3SRHru/lQ44wDACfw5eDwTou0kbF95WNbknBI3v0j204vi/Ad6B9ZnrxGNGI
         lMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JJ2iudIDjLqzlAaUn3I/FN4BVeT7lm2U25qmirc5dpc=;
        b=2vHfW/WMlegfFNN3UQhXhBNgAB/ukXqWOoqLBHP9OV32SQpz317gYqqKQJ9l5HY5qs
         gdpnUX0Cw3hOle1jscVvk22pE3fH72sOu3SEPBCCL8f+UjwR5eDmYXaM8eaAaWOZyrt5
         6TGCVg7NF/MZh16tyxzOSwPR/MtCXks8XZY559MTYBYnfHMD0+EebmwWEDkWNqnziAWM
         Kttc5p0Z6ZkArgk5/gXPWhigAQwqKPmLVj9xlWw8GzQOn479Q4E/9+MUBAyR4nTY8syn
         YSBh2q7faa+dHKnp05eOMvmBijZVEV4KrGjyjCkPFp2WijGVs6uGIOvXSXPhWr3OzbPN
         HE/A==
X-Gm-Message-State: ANoB5pkKg97KmTpgZIPDiOmnYB1HNNiNTk3vfrib+2QfDcQT0pB7ODYu
        luf87AmE0uqbGAnU7HBKR6g=
X-Google-Smtp-Source: AA0mqf6pP6wLmwzRNKLqYUBwxR5i7DkyM4Qp5Xra9NPvTYxp4Y5aFJRrs+fU41G1iFkPuxSaqtsdtA==
X-Received: by 2002:a50:ee89:0:b0:46c:6bdc:4116 with SMTP id f9-20020a50ee89000000b0046c6bdc4116mr37028702edr.33.1671440369836;
        Mon, 19 Dec 2022 00:59:29 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id g9-20020a056402180900b004781169b0desm2657699edy.51.2022.12.19.00.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 00:59:29 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p7Bzc-006Tiv-1v;
        Mon, 19 Dec 2022 09:59:28 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
        toon@iotcl.com
Subject: Re: [PATCH v3 0/2] check-attr: add support to work with revisions
Date:   Mon, 19 Dec 2022 09:45:34 +0100
References: <20221216093552.3171319-1-karthik.188@gmail.com>
 <221216.86k02r1fcl.gmgdl@evledraar.gmail.com> <xmqq7cyrm0tr.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqq7cyrm0tr.fsf@gitster.g>
Message-ID: <221219.86fsdb22hb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Dec 17 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> So we could invent that as this series currently does with:
>>
>> 	git check-attrs --revision <rev> <attr>... <path>...
>>
>> Or, as I suggested:
>>
>>         git check-attr [<rev>:]<attr>... -- <path>...
>
> What does <rev>:<attr> really mean?  As the syntax for the proposed
> feature, I do not think it makes much sense.  For example:
>
>   $ git check-attr HEAD:text HEAD^:text -- README.txt
>
>  - With which README.txt are we checking the attribute?  The one
>    taken from HEAD or HEAD^ or the index or the working tree?

All of them, but I do think this rightly points out that the "rev before
path" part of this doesn't make sense, but shouldn't we be making this
work like "git grep" with <rev>/<path> combinations? I.e.:
=09
	$ git -P grep -m 1 oid HEAD~:cache.h v2.26.0:cache.h v1.6.0:cache.h
	HEAD~:cache.h:#include "oid-array.h"
	v2.26.0:cache.h:void git_inflate_init(git_zstream *);
	v1.6.0:cache.h:static inline void copy_cache_entry(struct cache_entry *dst=
, struct cache_entry *src)

I.e. we currently support:

	git check-attr [-a | --all | <attr>...] [--] <pathname>...
	git check-attr --stdin [-z] [-a | --all | <attr>...]

So if we add to that:

	git check-attr --stdin [-z] <rev>:<pathname>...

We'd have this do the right thing:
=09
	$ git check-attr diff -- README.md HEAD:git-send-email.perl v1.6.0:git-sen=
d-email.perl
	README.md: diff: unspecified
	HEAD:git-send-email.perl: diff: perl
	v1.6.0:git-send-email.perl: diff: perl

Which would technically break backwards compatibility, as we now
"support" it (we just interpret the whole thing as a path), but I think
such revision-looking paths aren't worth worrying about

>  - When we say "README.txt has the text attribute", how does the
>    user tell which "text" applies to the path?  From HEAD?  From
>    HEAD^?

Regardless of what I'm suggesting here, the "git check-attr" output
already has a one-to-one line output correspondance with its input, so
just as it does now we'd print both.

This looks like a bug though (on master, the missing "\n" is there in
the output):

	$ ./git check-attr diffgit-send-email.perl foo.perl git-send-email.perl
	foo.perl: diffgit-send-email.perl: unspecified
	git-send-email.perl: diffgit-send-email.perl: unspecified

>  - Does the same attribute 'text' have different meaning when coming
>    from two different tree-ish?

Yes, just like "git grep", we'd need to parse & apply the .gitattributes
for that revision. Whether we call it "<rev>:<path>", "--revision <rev>
<path>" or whatever we'd always want to do that, otherwise what's the
point?
