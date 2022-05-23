Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E56DC433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 08:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiEWITk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 04:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiEWITi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 04:19:38 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFF619299
        for <git@vger.kernel.org>; Mon, 23 May 2022 01:19:36 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id c10so18108330edr.2
        for <git@vger.kernel.org>; Mon, 23 May 2022 01:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=3Kb7wh+kH7H5+VvsFf23epyc2XKGA8jfQ5KJrQnFv74=;
        b=NVlQlu4TiOTA7uf4MEeyZkpIOePpo/VgDNGBVqWhsUEFlUS76U1WQbOQExujqfroYb
         SowvcPbIn2NLG1/AzsUYGBmtt/u0lrpp761HCj2XsaEMIpDW4YE3r2nHgqySwFHb+Iol
         /L4dtLfJ7pK3xlc2h4WVNmt/qDvdzpWqOIZzBnKxJ0k323tVxoZEJ5mxXpKF/04CIBVo
         kwbfe40YuR8PqVBn+M58/724wSE2ntLGriKrv9u0WSoHpw4OMn+W5CwWa1eAkvG8oax6
         JA6g8coMfRi37jWi/cNTlO7nd2PfaclgPj8xsSc4iNXsbU/tVgCdCc22GKWiwgk3A4J2
         c5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=3Kb7wh+kH7H5+VvsFf23epyc2XKGA8jfQ5KJrQnFv74=;
        b=WhKNXbl8uPWVTngvAOMn/n6RMxRoIRhQ2Gz3DBgsmxvwu2pec7n8+0uv22PeAvFm/W
         YLrX71w5C0Wi5dmYsbcr313QPTbLue/3/g6YWXG+0vZIvKwdoF4touw3Kn9H1BO33ue1
         o0XCZ10FKBJKakQ+RGfUpxmz7do1jn0GeswZ7YgBjFB8afq3cB21zp38n70WZeb4WHAG
         5lSD7WCuPRKn1xIGyqLT3E4IPbKfMxoaVR5JHaTS+LNJUfNm67kzmFiu2rzVjyh0G8D9
         Ztea5SwmufoSJKfJzFaME1dT+CucOUwWY3Gpxywu2sbln4Gv4JbNkZ546brSvJSIRpOL
         72qA==
X-Gm-Message-State: AOAM530hD4/pbmxW9ugak4meOdTGJm/oXH+ap0AoGcTcLRXzy12lqMT3
        NUiv9Sly66HwoJnY8jrfaco=
X-Google-Smtp-Source: ABdhPJxwT29kCGEjia0P+UGrdxM4vzslTtBgqSdGKvrkXUmjR5W7GZr5LGVRKP3dYBeqo2wj10P4vg==
X-Received: by 2002:aa7:c14a:0:b0:42a:9ddd:2019 with SMTP id r10-20020aa7c14a000000b0042a9ddd2019mr22443540edp.43.1653293974470;
        Mon, 23 May 2022 01:19:34 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id q10-20020aa7da8a000000b0042617ba637fsm8040300eds.9.2022.05.23.01.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 01:19:33 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nt3Hp-002oZ9-3a;
        Mon, 23 May 2022 10:19:33 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
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
Subject: Re: [PATCH v3 0/9] Incremental po/git.pot update and new l10n workflow
Date:   Mon, 23 May 2022 10:12:48 +0200
References: <20220519081548.3380-1-worldhello.net@gmail.com>
 <20220523012531.4505-1-worldhello.net@gmail.com>
 <220523.86v8twzp6a.gmgdl@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <220523.86v8twzp6a.gmgdl@evledraar.gmail.com>
Message-ID: <220523.86ilpwzmne.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 23 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Mon, May 23 2022, Jiang Xin wrote:
>
>> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>>
>> A workflow change for translators are being proposed.
>>
>> Changes since v2:
>>
>>  1. Patch 1/9: reword.
>>  2. Patch 2/9: reword.
>>  3. Patch 3/9: reword, and add "FORCE" to prerequisites of "po/git.pot".
>>  4. Patch 6/9: remove "FORCE" from prerequisites of "po/git.pot".
>>  5. Patch 8/9: reword, and reuse "$(gen_pot_header)" to prepare pot
>>                header for "po/git-core.pot".
>>  6. Patch 9/9: various updates on po/README.md.
>
> From skimming this the *.c.po v.s. *.c extension is still left in
> comments. I'm not saying you need to go for my suggestions, but it would
> be very useful in CL's to note things that were suggested but not
> changed, such as that.
>
> Right now I haven't paged that v2 discussion into my brain again, so I
> don't know if that was the only thing, it's the only thing I remember
> right now...

This fix-up below implements what I suggested on v2, so now the comments
in the generated file are correct, and don't refer to our intermediate
files:
=09
	$ grep '#-#' po/git.pot
	#. #-#-#-#-#  git-add--interactive.perl  #-#-#-#-#
	#. #-#-#-#-#  add-patch.c  #-#-#-#-#
	#. #-#-#-#-#  git-add--interactive.perl  #-#-#-#-#
	#. #-#-#-#-#  branch.c  #-#-#-#-#
	#. #-#-#-#-#  object-name.c  #-#-#-#-#
	#. #-#-#-#-#  grep.c  #-#-#-#-#

I gathered that the reason you preferred the whole "grep -q PRItime" was
because you wanted to mitigate the effects of your IDE discovering these
files.

With the below you can define AGGRESSIVE_INTERMEDIATE and when you "make
pot" the generated *.c files will only exist for as long as they're
needed to generate the next step.

But if you do a subsequent "make pot" will be slower, as we'll of course
need to generate them again.

I think it's better to go in this direction, and rename that
AGGRESSIVE_INTERMEDIATE to something like
MAKE_AVOID_REAL_EXTENSIONS_IN_GITIGNORED_FILES or whatever.

I.e. our correctness shouldn't suffer because we're trying to work
around some issue in a specific (and optional) developer tooling.

There's also the fix there for the "header" dependency, but as noted in
another reply it should probably be dropped altogether...
=09
diff --git a/Makefile b/Makefile
index d3eae150de9..0b96b55b63f 100644
--- a/Makefile
+++ b/Makefile
@@ -2736,6 +2736,7 @@ endif
 ## "po/git.pot" file.
 LOCALIZED_ALL_GEN_PO =3D
=20
+LOCALIZED_C_GEN_C =3D $(LOCALIZED_C:%=3D.build/pot/po-munged/%)
 LOCALIZED_C_GEN_PO =3D $(LOCALIZED_C:%=3D.build/pot/po/%.po)
 LOCALIZED_ALL_GEN_PO +=3D $(LOCALIZED_C_GEN_PO)
=20
@@ -2745,26 +2746,19 @@ LOCALIZED_ALL_GEN_PO +=3D $(LOCALIZED_SH_GEN_PO)
 LOCALIZED_PERL_GEN_PO =3D $(LOCALIZED_PERL:%=3D.build/pot/po/%.po)
 LOCALIZED_ALL_GEN_PO +=3D $(LOCALIZED_PERL_GEN_PO)
=20
-## Gettext tools cannot work with our own custom PRItime type, so
-## we replace PRItime with PRIuMAX.  We need to update this to
-## PRIdMAX if we switch to a signed type later.
-$(LOCALIZED_C_GEN_PO): .build/pot/po/%.po: %
+ifdef AGGRESSIVE_INTERMEDIATE
+.INTERMEDIATE: $(LOCALIZED_C_GEN_C)
+endif
+$(LOCALIZED_C_GEN_C): .build/pot/po-munged/%: %
 	$(call mkdir_p_parent_template)
-	$(QUIET_XGETTEXT) \
-	    if grep -q PRItime $<; then \
-		(\
-			sed -e 's|PRItime|PRIuMAX|g' <$< \
-				>.build/pot/po/$< && \
-			cd .build/pot/po && \
-			$(XGETTEXT) --omit-header \
-				-o $(@:.build/pot/po/%=3D%) \
-				$(XGETTEXT_FLAGS_C) $< && \
-			rm $<; \
-		); \
-	    else \
-		$(XGETTEXT) --omit-header \
-			-o $@ $(XGETTEXT_FLAGS_C) $<; \
-	    fi
+	$(QUIET_GEN)sed -e 's|PRItime|PRIuMAX|g' <$< >$@
+
+$(LOCALIZED_C_GEN_PO): .build/pot/po/%.po: .build/pot/po-munged/%
+	$(call mkdir_p_parent_template)
+	$(QUIET_XGETTEXT)( \
+		cd $(<D) && \
+		$(XGETTEXT) $(XGETTEXT_FLAGS_C) --omit-header -o - $(<F) \
+	) >$@
=20
 $(LOCALIZED_SH_GEN_PO): .build/pot/po/%.po: %
 	$(call mkdir_p_parent_template)
@@ -2786,11 +2780,24 @@ sed -e 's|charset=3DCHARSET|charset=3DUTF-8|' \
 echo '"Plural-Forms: nplurals=3DINTEGER; plural=3DEXPRESSION;\\n"' >>$@
 endef
=20
-.build/pot/git.header: $(LOCALIZED_ALL_GEN_PO)
+.build/pot/git.header:
 	$(call mkdir_p_parent_template)
 	$(QUIET_GEN)$(gen_pot_header)
=20
-po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO)
+# We go through this dance of having a prepared
+# e.g. .build/pot/po/grep.c.po and copying it to
+# .build/pot/to-cat/grep.c only because some IDEs (e.g. VSCode) pick
+# up on the "real" extension for the purposes of auto-completion, even
+# if the .build directiory is in .gitignore.
+LOCALIZED_ALL_GEN_TO_CAT =3D $(LOCALIZED_ALL_GEN_PO:.build/pot/po/%.po=3D.=
build/pot/to-cat/%)
+ifdef AGGRESSIVE_INTERMEDIATE
+.INTERMEDIATE: $(LOCALIZED_ALL_GEN_TO_CAT)
+endif
+$(LOCALIZED_ALL_GEN_TO_CAT): .build/pot/to-cat/%: .build/pot/po/%.po
+	$(call mkdir_p_parent_template)
+	$(QUIET_GEN)cat $< >$@
+
+po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_TO_CAT)
 	$(QUIET_GEN)$(MSGCAT) $(MSGCAT_FLAGS) $^ >$@
=20
 .PHONY: pot
