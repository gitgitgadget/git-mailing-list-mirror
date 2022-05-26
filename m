Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADB7C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 04:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238409AbiEZEDJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 00:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbiEZEDF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 00:03:05 -0400
Received: from pb-sasl-trial20.pobox.com (pb-sasl-trial20.pobox.com [173.228.157.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9D6C038B
        for <git@vger.kernel.org>; Wed, 25 May 2022 21:03:03 -0700 (PDT)
Received: from pb-sasl-trial20.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial20.pobox.com (Postfix) with ESMTP id 5CF4B2F35B;
        Thu, 26 May 2022 00:03:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tb9Ll6b5xy8BxzYQv0IuwecH5lQ=; b=NGwpdk
        PL1xgFmsda/yN4y2mutjBMeRvxTuorV/MStsqeVUOqyfb9oYuWIGxOHltjq+3Eo/
        YrWOYgIgwIcPGp1Uov1hQFfKypOzAZxpb3/lWc4QUaZz/J0hpGmKW2dtlrUakf+4
        91gaFDkLQlVFcUzoJ35naT/I8e46cqkHRyix8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tahx3IIW9uhCk+R3Rig1RNcN4brML59j
        71zvSGlUNpgFwqv8Cjee36SzTnH86YVLB8ghq1R1VgwGwmBPlMUzBevG0yBYNq7I
        EJtIF5WL8PuYeyoDbOiijny+Qc6PvBG0LmbP4qdKNdbCcaZjIB9MvH93eFlqoFKQ
        H6+UKCLXPKg=
Received: from pb-smtp21.sea.icgroup.com (pb-smtp21.pobox.com [10.110.30.21])
        by pb-sasl-trial20.pobox.com (Postfix) with ESMTP id 408D22F35A;
        Thu, 26 May 2022 00:03:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CA7C619915A;
        Thu, 26 May 2022 00:02:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [PATCH] Makefile: dedup git-ls-files output to prevent
 duplicate targets
References: <xmqqtu9d45f7.fsf@gitster.g>
        <20220526021540.2812-1-worldhello.net@gmail.com>
Date:   Wed, 25 May 2022 21:02:57 -0700
In-Reply-To: <20220526021540.2812-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Thu, 26 May 2022 10:15:40 +0800")
Message-ID: <xmqqo7zl2b66.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BAD09EB2-DCA8-11EC-AF65-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> If there are unresolved conflicts left in the working tree, "make" may
> report warnings as follows:
>
>     Makefile:xxxx: target '.build/pot/po/FOO.c.po' given more than once
>                    in the same rule
>
> The duplicate targets are introduced by the following pattern rule we
> added in the preceding commit for incremental build of "po/git.pot",
>
>     $(LOCALIZED_C_GEN_PO): .build/pot/po/%.po: %
>
> and the duplicate entries in $(LOCALIZED_C_GEN_PO) come from the
> "git ls-files" command in SOURCES_CMD.
>
> We can pass the option "--deduplicate" to git-ls-files to suppress
> duplicate entries for unresolved conflicts.

Thanks for a quick response.

We certainly can say "your SOURCES_CMD MUST NOT produce duplicates"
and passing the --deduplicate option is one valid way to fix this
specific case.

But I wonder if a more future-proof solution is to dedup the output
of the SOURCES_CMD ourselves on the Makefile side.  That way, even
if we update SOURCES_CMD in a way that could contain duplicates, we
won't have to worry about duplicates.

---

It feels way overkill to "sort" the list just to dedup its elements,
but that is what GNU Make documentation info page recommends us to
do, and we already do use it for deduplication in our Makefile
twice.

'$(sort LIST)'
     Sorts the words of LIST in lexical order, removing duplicate words.
     The output is a list of words separated by single spaces.  Thus,

          $(sort foo bar lose)

     returns the value 'bar foo lose'.

     Incidentally, since 'sort' removes duplicate words, you can use it
     for this purpose even if you don't care about the sort order.


diff --git i/Makefile w/Makefile
index 2b61f66259..1d3d3deba1 100644
--- i/Makefile
+++ w/Makefile
@@ -860,7 +860,7 @@ SOURCES_CMD = ( \
 		-o \( -name '*.sh' -type f -print \) \
 		| sed -e 's|^\./||' \
 	)
-FOUND_SOURCE_FILES := $(shell $(SOURCES_CMD))
+FOUND_SOURCE_FILES := $(sort $(shell $(SOURCES_CMD)))
 
 FOUND_C_SOURCES = $(filter %.c,$(FOUND_SOURCE_FILES))
 FOUND_H_SOURCES = $(filter %.h,$(FOUND_SOURCE_FILES))

