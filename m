Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74750C433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 10:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbiESKUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 06:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbiESKUm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 06:20:42 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39787A7E21
        for <git@vger.kernel.org>; Thu, 19 May 2022 03:20:36 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id i27so8984454ejd.9
        for <git@vger.kernel.org>; Thu, 19 May 2022 03:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=3mec5V4pYCAp2lSfGa+z0brmX1pY1rrN/8KVAdP+Oec=;
        b=fjFFiDvSk9DBrr9Jq/4Gvf1nLvYDA8gss6WVVgfQF/yEwWo+nkP4fqCS1M1zvHBiPx
         2WGlpupqNOfPr345afUlS3qmeYiMs4isS+DU+SfYBM3e4E62sffVO1yGJD9rJkQEIRvK
         iR2cNM47M2wwI+RtJ+iPxwx8g5XzcfaYHOSWJyDockg4vzROa/pliyBZXe/F3TrRpGsX
         iuviJOm+l/x4Jl6lS7ykAs5ac8ZJno3KxAnOUzu6YbsfHwDOy06aYnAq+WUDZqxyclqV
         u9Xeab9AISwt7REtA3Ggpj5t2QTX/J1VOYGlg2taMe5AcHBb18hUeq61j+XjajAKu/A0
         /GLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=3mec5V4pYCAp2lSfGa+z0brmX1pY1rrN/8KVAdP+Oec=;
        b=Lv3ItvmMANz/tFzIPiGkzvd9co95WBVSSkKOSv7XITVedZyPk5wAZuR5tlDNgvmyNF
         TG+BEBSNb0q0KpY8JsShdKOPi8SN77cr0cUptl1KnkItG9WOqrwHCgFLoXi9mCofJwhR
         PTHGcRlIIe4uL8CLLIj3cZBIe+JkGQFEh8pAKytLFevCymt69IGxVgAaTP5c6/AmN8lp
         VUXGd+39/F829+cbAC4BEVPewx3YXUAglSzeccbCPdR7B2Lr8iBH8PkBPoqZMlVBOJ6E
         Q4Qsn8Go95m4EPYHAs8vP7bfQTCOA3l8HF7727Se4K/QS4uVgr1eFAhXSK+y2nwvAnCf
         wIyw==
X-Gm-Message-State: AOAM531op60gDlCJU8g+3Xaw7ZJDImmkbZV0Rw3YzFQMVXdlTc6Wthzy
        gIK/xuj+Z1mrDSc6rcfByfc=
X-Google-Smtp-Source: ABdhPJwmhSK6WcPOsE1KVOxjaCjpy9Ex3cvuvyxtt37cmXPI4RgYEY9GrW5vn+27RkdFStuKlvbFtQ==
X-Received: by 2002:a17:907:8a1f:b0:6fa:88cf:c31c with SMTP id sc31-20020a1709078a1f00b006fa88cfc31cmr3590526ejc.484.1652955634742;
        Thu, 19 May 2022 03:20:34 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id h24-20020a1709070b1800b006f3ef214e5csm100722ejl.194.2022.05.19.03.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 03:20:34 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nrdGi-0023KY-LZ;
        Thu, 19 May 2022 12:20:32 +0200
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
Subject: Re: [PATCH v2 7/9] Makefile: add "po-update" rule to update po/XX.po
Date:   Thu, 19 May 2022 12:07:09 +0200
References: <20220503132354.9567-1-worldhello.net@gmail.com>
 <20220519081548.3380-8-worldhello.net@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220519081548.3380-8-worldhello.net@gmail.com>
Message-ID: <220519.86czg96cy7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 19 2022, Jiang Xin wrote:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> Since there is no longer a "po/git.pot" file in tree, a l10n team leader
> has to run several commands to update their "po/XX.po" file:
>
>     $ make pot
>     $ msgmerge --add-location --backup=off -U po/XX.po po/git.pot
>
> To make this process easier, add a new rule so that l10n team leaders
> can update their "po/XX.po" with one command. E.g.:
>
>     $ make po-update PO_FILE=po/zh_CN.po
>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Makefile   | 18 ++++++++++++++++++
>  shared.mak |  1 +
>  2 files changed, 19 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 34904b90d2..edebd44d5c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -571,6 +571,7 @@ TCLTK_PATH = wish
>  XGETTEXT = xgettext
>  MSGCAT = msgcat
>  MSGFMT = msgfmt
> +MSGMERGE = msgmerge
>  CURL_CONFIG = curl-config
>  GCOV = gcov
>  STRIP = strip
> @@ -2716,6 +2717,7 @@ XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
>  XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
>  	--keyword=__ --keyword=N__ --keyword="__n:1,2"
>  MSGCAT_FLAGS = --sort-by-file
> +MSGMERGE_FLAGS = --add-location --backup=off --update

Ok, we'd like to have the location in the po/*.po files still. We're
just getting rid of po/git.pot.

I had some patches to also do it for the po/XX.po files, thinking that
we'd only check in the "meaningful" data. We'd then offer translators
some targets to add the locations to the file for working on them, and
then flip back before they did a "git commit" etc. etc.

But none of that needs to happen now, and this series is already quite
large, so just leaving things here seems like a good stopping point.

I also tested with --no-location (updated all to have no location), and
a subsequent --add-location run repairs it. It also fixes a manually
edited nonsense location for a valid msgid. So this all seems OK to me.

>  LOCALIZED_C = $(FOUND_C_SOURCES) $(SCALAR_SOURCES) \
>  	      $(FOUND_H_SOURCES) $(GENERATED_H)
>  LOCALIZED_SH = $(SCRIPT_SH)
> @@ -2787,6 +2789,22 @@ po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO)
>  .PHONY: pot
>  pot: po/git.pot
>  
> +define check_po_file_envvar
> +	$(if $(PO_FILE), \
> +		$(if $(filter po/%.po,$(PO_FILE)), , \
> +			$(error PO_FILE should match pattern: "po/%.po")), \
> +		$(error PO_FILE is not defined))
> +endef
> +
> +.PHONY: po-update
> +po-update: po/git.pot
> +	$(check_po_file_envvar)
> +	@if test ! -e $(PO_FILE); then \
> +		echo >&2 "error: $(PO_FILE) does not exist"; \
> +		exit 1; \
> +	fi
> +	$(QUIET_MSGMERGE)$(MSGMERGE) $(MSGMERGE_FLAGS) $(PO_FILE) po/git.pot

Nit: better to put the $(QUIET_MSGMERGE) in place of that @, i.e. V=1
will give you the full debug dump.

This is fine too I suppose, but we tend to use $(QUIET_*) like that
elsewhere...

>  .PHONY: check-pot
>  check-pot: $(LOCALIZED_ALL_GEN_PO)
>  
> diff --git a/shared.mak b/shared.mak
> index 50d4596f0d..8cd170a7e7 100644
> --- a/shared.mak
> +++ b/shared.mak
> @@ -63,6 +63,7 @@ ifndef V
>  	QUIET_LNCP     = @echo '   ' LN/CP $@;
>  	QUIET_XGETTEXT = @echo '   ' XGETTEXT $@;
>  	QUIET_MSGFMT   = @echo '   ' MSGFMT $@;
> +	QUIET_MSGMERGE = @echo '   ' MSGMERGE $@;
>  	QUIET_GCOV     = @echo '   ' GCOV $@;
>  	QUIET_SP       = @echo '   ' SP $<;
>  	QUIET_HDR      = @echo '   ' HDR $(<:hcc=h);

