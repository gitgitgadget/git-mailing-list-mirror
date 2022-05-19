Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3826CC433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 09:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbiESJRG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 05:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbiESJRE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 05:17:04 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444E45BE56
        for <git@vger.kernel.org>; Thu, 19 May 2022 02:17:03 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id c10so6245037edr.2
        for <git@vger.kernel.org>; Thu, 19 May 2022 02:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=4nbcng8Pykrf/fiUtwmMJgiv35LlkZIMANmCpSS8rc0=;
        b=UhHAEw/6pEhoPrgQMc5RKw1TADfl7I73ePRW8xpChf7PSfR6odU2E8JAg+vHDrbyAa
         GzIDbc8yXrIJxXu2afR8QncQcYrg4AIWl0sQ27/H42NZmw7nlsAo41w4JV7HE9tqg/J7
         j0aCdgUAo6azT7ITWO8h70eVfCfAwKwS/7KyX0QJAnOqeRYVqdYl7E2Xz0f79U3xFOmG
         ZTnOWoY1Yd1gVMvV2ZViwch1BJJ2dy7jNhB+Bzo2hLiIBp105ZtJBICNeeIKTFEtPEfB
         mjhk2y1MuZqk3ADB2LZHJRec38TwyMOVAsSw/ZhurLkd9CKCU6JPCrudgAwtK72l9JbA
         MXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=4nbcng8Pykrf/fiUtwmMJgiv35LlkZIMANmCpSS8rc0=;
        b=hgpvMCAZQHicJ0P4ZTTOJtJ2oGkFKjDHQDwmLx0JdYOvVqGkBLQQHq+N8TjkmRcGCN
         EY4ZpCfgZ33AqzXzNTfwulT+IEQE4Es/D2uc/weqRJf/MOysl4jKI4NeFq/2hhZ+Z5Iz
         NEHeAfKb0a8ECyMMgVc32m1tA0E1DlTuGayCnEpJ9/hm7nsIVYJVFf9ilfMEVgmg9aTs
         xXWONJcLmVFRhmO2tFms6V6fRkrtQYg3uTMqRKRrUuuoQPn3MuJaXUnjzH4OdyNfikZE
         a9qTJ0S5AJmD08NycvcCWo6l2ESIJcbELYAN3BXp3+L6aKG7By6ILd9FI+u6DuwBlBTr
         8zcg==
X-Gm-Message-State: AOAM532kp41oyFzP2cLjdE/m9TvmwuAU5yiylBip1ZxLvXwF9y7ClOFM
        ML7PLFOoJTjOSUI6bTDaWbI=
X-Google-Smtp-Source: ABdhPJxVlJoPp0sTOMIaj3mnL6CFMGaXn7S57kIxyCT9vlYNyt4B6/O1TkSXeLrFpXqgvMUB46ZqlA==
X-Received: by 2002:a05:6402:5189:b0:42b:4b8:32e7 with SMTP id q9-20020a056402518900b0042b04b832e7mr1319178edd.177.1652951821536;
        Thu, 19 May 2022 02:17:01 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id n27-20020a17090673db00b006fe7ca9d105sm1938075ejl.44.2022.05.19.02.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 02:17:00 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nrcHD-0021Ea-DB;
        Thu, 19 May 2022 11:16:59 +0200
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
Subject: Re: [PATCH v2 1/9] Makefile: sort "po/git.pot" by file location
Date:   Thu, 19 May 2022 10:53:51 +0200
References: <20220503132354.9567-1-worldhello.net@gmail.com>
 <20220519081548.3380-2-worldhello.net@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220519081548.3380-2-worldhello.net@gmail.com>
Message-ID: <220519.86tu9l6fw4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 19 2022, Jiang Xin wrote:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> Before feeding xgettext with more C souce files which may be ignored
> by various compiler conditions, add new option "--sort-by-file" to
> xgettext program to create stable message template file "po/git.pot".
>
> With this update, the newly generated "po/git.pot" will has the same
> entries while in a different order. We won't checkin the newly generated
> "po/git.pot", because we will remove it from tree in a later commit.
>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Makefile b/Makefile
> index f8bccfab5e..83e968e2a4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2706,6 +2706,7 @@ XGETTEXT_FLAGS = \
>  	--force-po \
>  	--add-comments=TRANSLATORS: \
>  	--msgid-bugs-address="Git Mailing List <git@vger.kernel.org>" \
> +	--sort-by-file \
>  	--from-code=UTF-8
>  XGETTEXT_FLAGS_C = $(XGETTEXT_FLAGS) --language=C \
>  	--keyword=_ --keyword=N_ --keyword="Q_:1,2"

I'm not opposed to this change, but between this and 2/9 I'm still
unsure what the aim is exactly, and if the results are desired.

In 2/9 you correctly point out that we have messages we've missed due to
LOCALIZED_C being platform-specific.

That should never happen (although your implementation in 2/9 may have
some small issues, I'll reply there separately), i.e. we should always
have "make pot" generate the same po/git.pot from the same commit
whether you're on linux, mac os x etc.

But AFAICT we have a "stable" sort order now, it's in whatever order we
feed the files to xgettext, which ultimately comes down to e.g. the list
of $(LIB_OBJS) in the Makefile.

I've been looking over the libintl documentation to see what exactly
these sort options do, and how they differ from the default, and it's
not really described.

AFAICT the xgettext behavior we have now is that we'll process the files
we have in order, and for those files extract the messages we have as we
see them.

One fringe benefit of that is that e.g. "make pot
XGETTEXT_INCLUDE_TESTS=Y" (which I think I've only ever used, and
probably only ~10 years ago) will get added at the end, but now it'll be
added wherever t/t0200 sorts.

Then because compose the builtin objs and lib objs by concatenation, but
don't $(sort) them in the Makefile most of this change is due to us
e.g. sorting builtin/* before parse-options.c or whatever.

But oddly we also have cases like this:

        strbuf_addf(&header, print_file_item_data.modified_fmt,
                    _("staged"), _("unstaged"), _("path"));

Before this we'd list those in that order in the git.pot, but now
because of --sort-by-file we'll list any messages on the same line in
sorted msgid order, not in the orderd they appear in. Another example is
e.g. this in builtin/blame.c:

    OPT_STRING_LIST(0, "ignore-rev", &ignore_rev_list, N_("rev"), N_("ignore <rev> when blaming"))

Where before we'd list them in that order, but now it's with "ignore.."
before "rev".

I think this change would be easier to follow & explain if you first
made this change:
	
	diff --git a/Makefile b/Makefile
	index 61aadf3ce88..3726fe8064a 100644
	--- a/Makefile
	+++ b/Makefile
	@@ -2715,10 +2715,9 @@ XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
	 	--keyword=gettextln --keyword=eval_gettextln
	 XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
	 	--keyword=__ --keyword=N__ --keyword="__n:1,2"
	-LOCALIZED_C = $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
	-LOCALIZED_SH = $(SCRIPT_SH)
	-LOCALIZED_SH += git-sh-setup.sh
	-LOCALIZED_PERL = $(SCRIPT_PERL)
	+LOCALIZED_C = $(sort $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H))
	+LOCALIZED_SH = $(sort $(SCRIPT_SH) git-sh-setup.sh)
	+LOCALIZED_PERL = $(sort $(SCRIPT_PERL))
	 
	 ifdef XGETTEXT_INCLUDE_TESTS
	 LOCALIZED_C += t/t0200/test.c

Which would sort things within C, SH and Perl files (but not among
them). Then this change would AFAICT only:

 * Change that "within one line" sort order, as noted above
 * Sort across C/SH/Perl.

I'm mostly "meh" on the result, but it's also because I genuinely don't
get what the goal was. Is it because in 2/9 you'll end up using
$(FOUND_C_SOURCES), which we derive from either "git ls-files" or
"find", the latter of which has an unstable sort order?

Even if that's the case a smaller change is to just use $(sort) as noted
above. I like that a tiny bit more because then the "--join-existing" we
do for SH/Perl is an append, whereas now we'll re-sort the whole thing.

I also don't think it matters much either way, so whatever you're happy
with, the above all came from trying to follow along...
