Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6233BC433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 19:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbiJZT2u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 15:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbiJZT2s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 15:28:48 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940538768D
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 12:28:47 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id 13so24279944ejn.3
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 12:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=52sqZQMRibGeQhSmL/BoOZXjuUeXHZQOI4xoagXgDh0=;
        b=CvH1yHoB0pOe74KaB3TjdegCZhH/ayvbzKnO25tO9EI0XOpWy9x+35MGZYKAIUdzFC
         IAot/L692w9CdZWu/YzPQ5MWNOwWpSiSpgYolBvbsquVl7GuMOau2KkuFp+Qc24RgWFP
         8DgK9bfSIIWtc1Q9ioH73LcBm+O4W8TTjyF6tEiRE5c1KFaerEpcC0a+JIwEAcAW+IyC
         iUvzFoTrRvNwtdsejNO0QUwu879+l2HpzCgU9BLOUkzdcNUcFk5+MP+80xYAXp4Qppsl
         6z/lhOTek9TLE9UOzW4nwv3fdGeS5gyDoaRoZBP7236cg9laR+y+SUKubejbBO5UKnD6
         Q1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=52sqZQMRibGeQhSmL/BoOZXjuUeXHZQOI4xoagXgDh0=;
        b=yY2xHPkh57IqZM7dzCYO4/uQLPcPyt0+uxN4aej/5k0tHO25AY8Z1CrX8Rjkcah2Kt
         Jva1mRRxewoz1c2Ml6JaLMnfNDBxkc01KIgQzzjiAkahWeVR1tve3aiAqZZaHJYPj6AT
         UwDqRSeo42F14iDvpuvxp8E7yg75SUI1Y+SeucbjhwqVZmEWIQYVWbMF4mvWyM/uWts2
         xcQCg+L+ATWfrezkP3WkejrNX8jpM1wH5qdE4FN6FpOvvNFyUA7pqz6uw/URG4IRwd7Q
         DbWy/4XuwOzRkNzu7MqONksh7ELdZ/mXfhhkSDX6YJ3/D/e5tGMfERnTxdGryd4vTRr2
         Zagw==
X-Gm-Message-State: ACrzQf3J+oEnupBRgz0u1aw0aV4ZXAR72+weU323Iu0Ph25z1LXMdesQ
        oSR37BQiUjdJAs69A0J8/Ic=
X-Google-Smtp-Source: AMsMyM7w1ozAJWLMMjlByv2ipN6w8pxeGmgVzO/CXdJuWdnhV6FAMzJJr5ZmCFnTrR6nAK85ewYYEA==
X-Received: by 2002:a17:906:1ec5:b0:78d:b3d1:183b with SMTP id m5-20020a1709061ec500b0078db3d1183bmr38801736ejj.709.1666812525961;
        Wed, 26 Oct 2022 12:28:45 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709061da900b0078135401b9csm3416007ejh.130.2022.10.26.12.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:28:45 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1onm4y-008rZT-2Y;
        Wed, 26 Oct 2022 21:28:44 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 3/3] Makefile: simplify $(test_bindir_programs) rule
 by splitting it up
Date:   Wed, 26 Oct 2022 21:14:29 +0200
References: <cover-0.5-00000000000-20220901T130817Z-avarab@gmail.com>
 <cover-v2-0.3-00000000000-20221026T143533Z-avarab@gmail.com>
 <patch-v2-3.3-400f487e30d-20221026T143534Z-avarab@gmail.com>
 <xmqqr0yuh144.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqr0yuh144.fsf@gitster.g>
Message-ID: <221026.86tu3qbd03.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 26 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> -test_bindir_programs :=3D $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS=
_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
>> +define cmd_munge_bin_wrappers_script
>> +sed \
>> +	-e $(call cmd_munge_script_sed_shell_path_arg) \
>> +	-e 's|@@BUILD_DIR@@|$(shell pwd)|' \
>> +	-e 's|@@PROG@@|$(2)$(1)$(3)|' \
>> +	<$< >$@ && \
>> +	chmod +x $@
>> +endef

[Re-arranged your question a bit for the reply...]

> We've talked about relying on another feature of GNU make (which we
> already depend on) to automatically remove the target build artifact
> when a rule to build it fails, [...]  What happens when a rule that
> uses the above fails in the middle?  Do we correctly remove the
> half-built target?

Are you asking if "define"'s execute in some context outside the purview
of rules, so that if you $(call) one from within a rule and it errors,
that we won't clean up the file?

No, that won't happen, they'll be cleaned up properly. First, these are
basically macros, but secondly it wouldn't matter if they
weren't. E.g. you can execute an arbitrary program that happens to write
to a file that matches your $@.

The only thing that matters is that we carry forward the exit code,
which we do here. I.e. the "&&" after the $(call).

(Even then we'd still error properly, unless you ran "make -i" to ignore
errors in the rule, the && is more in service of the $(QUIET_*) in our
Makefile).

> but I see quite a many old world best practice pattern "generate >$@+
> && chmod +x $@+ && mv $@+ $@" still in today's Makefile.

Those are mostly there because nobody's cleaned them up, we don't need
them anymore.

"Mostly" because one thing they still do is not replace the file until
it's ready, we had a previous discussion on a related topic in reply to
https://lore.kernel.org/git/patch-1.6-3330cdbccc0-20210329T161723Z-avarab@g=
mail.com/
(it didn't go in).

>> -all:: $(test_bindir_programs)
>> +define bin_wrappers_template
>> +
>> +## bin_wrappers_template
>> +# 1 =3D $(1)
>> +# 2 =3D $(2)
>> +# 3 =3D $(3)
>> +# 4 =3D $(4)
>
> Whatever the above comment wants to convey to readers, it seems to
> fail to do so at least to me, while ...

I can drop them, FWIW I've found it quite handy to add these to ad-hoc
debug templates. E.g. you can run:
=09
	$ make -f /dev/null -E '$(eval $(file <Makefile))' -E '$(error $(call bin_=
wrappers_template,a,b,c,d))'
	make: ***=20
	## bin_wrappers_template
	# 1 =3D a
	# 2 =3D b
	# 3 =3D c
	# 4 =3D d
	BW_a =3D $(a:%=3Dbin-wrappers/%)
	BIN_WRAPPERS +=3D $(BW_a)
	all:: $(BW_a)
	$(BW_a): bin-wrappers/% : c%d
	$(BW_a): wrap-for-bin.sh
	        $(call mkdir_p_parent_template)
	        $(QUIET_GEN)$(call cmd_munge_bin_wrappers_script,b,c,d).  Stop.

So you see what the parameters expand to. Maybe just changing the
heading to:

	## bin_wrappers_template: $(1..N) below for manual "$(error $(call ..." de=
ubgging

?
