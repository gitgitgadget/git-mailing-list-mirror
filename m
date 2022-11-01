Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2BBFA3741
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 01:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiKABzn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 21:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiKABzm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 21:55:42 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E6E15FDC
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:55:39 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ud5so33845946ejc.4
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vE5pz35j9qS3RaEW3L9dz/tQsxYkYGWNIDt6nAF1v58=;
        b=bF9nBsaRKmI3Y14NIX52MaM/K8lBqFlTn+q3Ybjf8dDALXp2S7ZaMFTITwFDdujIwV
         SkujgCRONh+gCkQxjcz8RLVobAwA/fspCIINY/+9jbi1qIdEWf6z+jMOnsyMNHsdU7j0
         gZeyE2TZTsxtX/l5Dv/8q3H4OAoRAA7aGYR1Sm4tiLDMm6jqg0E10nBjvxJ+02bksMJ+
         6fdwxpWItP9JancAdYqEmqyl46A4QmHpaQrgmQk/OyA9pj7uSCNnoeeks0yF8aEb5xer
         p5eeXZvitq8m+kTkT9vwfQtL2h3zIuWnmivfY5wWfrpgpmRSfhWHzzRakJ82aRR7+dEJ
         sCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vE5pz35j9qS3RaEW3L9dz/tQsxYkYGWNIDt6nAF1v58=;
        b=MmmI2kHb/kHIDDKL+LS+SgbbD4GQLmI2DP0zI25fAiDT3gAYdexv/5BQZrkruu4vy4
         c445DCY3FSF6RZZCMVULlslkb7Sh7+rrovvBXbzMT6N+SNgD9rpE0usDnYbdVQimMUIw
         rIbBwkj5StJhZkPwd565dUh12DrD8iAYfSbJFQVtt/+Q4LuKDu2TSZTaKvSti+VGLJgz
         egNC9gQ+mzvXrRZbGCRFBwVeJH0GE1mCg1u4Ymc0DB6FQVDLcOvYjSprnWNlZYU6g6k5
         uMW98P+larLMwAr+s2l5FJDDydfIvq3wnXtgtry6NpPTfuxzf4FrMg0ODhc/OBXC222O
         M8LQ==
X-Gm-Message-State: ACrzQf0Qa7FSSYzdfo7JrjeRxvhk3PXBOJsZ+KJDh9p4K16fzvh6Z6IM
        QGyfOIPuCZzCAb1Eiw1ksDY=
X-Google-Smtp-Source: AMsMyM64jN6ySHOysx5cVv1ciGW1UyFIPCeHF0xuTn4FSkt8J9kFeLDx/a7CrN6QXUqRKL7sgY/JTg==
X-Received: by 2002:a17:907:743:b0:740:ef93:2ffc with SMTP id xc3-20020a170907074300b00740ef932ffcmr15870811ejb.514.1667267738309;
        Mon, 31 Oct 2022 18:55:38 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id e16-20020a170906315000b0077a1dd3e7b7sm3612499eje.102.2022.10.31.18.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 18:55:37 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1opgV7-00Az68-0D;
        Tue, 01 Nov 2022 02:55:37 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 0/4] Makefile: untangle bin-wrappers/% rule complexity
Date:   Tue, 01 Nov 2022 02:29:40 +0100
References: <cover-v2-0.3-00000000000-20221026T143533Z-avarab@gmail.com>
 <cover-v3-0.4-00000000000-20221031T222249Z-avarab@gmail.com>
 <Y2BgRU+HnJjWPzkn@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y2BgRU+HnJjWPzkn@nand.local>
Message-ID: <221101.86edun5tgn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 31 2022, Taylor Blau wrote:

> On Mon, Oct 31, 2022 at 11:28:05PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (4):
>>   Makefile: factor sed-powered '#!/bin/sh' munging into a variable
>>   Makefile: define "TEST_{PROGRAM,OBJS}" variables earlier
>>   Makefile: rename "test_bindir_programs" variable, pre-declare
>>   Makefile: simplify $(test_bindir_programs) rule by splitting it up
>>
>>  Makefile | 70 +++++++++++++++++++++++++++++++++++++++++---------------
>>  1 file changed, 51 insertions(+), 19 deletions(-)
>
> Thanks. I replaced the earlier round with this one and pushed the result
> out to ttaylorr/git.
>
> But having read the topic over again, I have to say that I also find the
> pre-existing behavior to be as expected. "make bin-wrappers/git"
> produces its target as expected, but the target is useless because the
> relationship it has with "git" is a runtime dependency, not a Make-time
> dependency.
>
> So I'm not inclined to pick this one up, honestly. Perhaps other
> reviewers feel differently.

I'm fine with changing that. The part where it makes:

	make clean &&
	make bin-wrappers/git &&
	./git ...

work is a 1-line change to remove, i.e.:

	diff --git a/Makefile b/Makefile
	index d7ab68e3db8..d3c0a66b4b4 100644
	--- a/Makefile
	+++ b/Makefile
	@@ -3089,7 +3089,6 @@ define bin_wrappers_template
	 # 4=3D'$(4)'
	 BW_$(1) =3D $$($(1):%=3Dbin-wrappers/%)
	 BIN_WRAPPERS +=3D $$(BW_$(1))
	-$$(BW_$(1)): bin-wrappers/% : $(3)%$(4)
	 $$(BW_$(1)): wrap-for-bin.sh
	 	$$(call mkdir_p_parent_template)
	 	$$(QUIET_GEN)$$(call cmd_munge_bin_wrappers_script,$(2),$(3),$(4))

This topic is mainly about untangling the dense $(filter) mess in the
existing rule, which last came up as we need do to special-case
"scalar", and we'd need to special-case any future binaries.

But I see it's my own fault for making that clear, the "as seen in the
range-diff below" in v2's CL [1] was meant to refer to "here's what's
new in v2", not the topic's reason for existing.

So, while I'm happy to re-roll it and remove that one line (and the
associated part of the commit message) I'm surprised that there's such a
hang-up about this aspect of it, to the point where I think I'm missing
something.

Nothing depends on "bin-wrappers/%" now, so having this harms nothing,
but just seems to me to nicely tie off a loose end.

I'm aware that e.g. git-submodule which depends on git-submodule.sh
doesn't depend on e.g. "submodule--helper" being built, so in that sense
this is inconsistent with the rest of our shellscripts.

But in the case of wrap-for-bin.sh its generation is driven by the
Makefile, and it's *only* there to to exec() the target binary (at least
some of those other *.sh's can serve up -h on their own).

And if we don't include that line, then (like on "master"):

	$ make clean >/dev/null; make bin-wrappers/git; ./git; echo $?
	GIT_VERSION =3D 2.38.GIT-dev
	    MKDIR -p bin-wrappers
	    GEN bin-wrappers/git
	bash: ./git: No such file or directory
	127

But *shrug*, I just don't see how it's useful, when it's so easy to make
it do something useful.

1. https://lore.kernel.org/git/cover-v2-0.3-00000000000-20221026T143533Z-av=
arab@gmail.com/
