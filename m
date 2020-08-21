Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38FCC433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFE702076E
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvwHD2Q7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgHUVG0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgHUVGV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 17:06:21 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FE2C061574
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:06:21 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 83so3098314wme.4
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5LTkrvhYfKwhVtFUpdkdge37SOZJ7R/e1FHA1Cu3b28=;
        b=hvwHD2Q7b7rc42LDLrTF0WbhhytGRc6uYY/K1ZxCQT8rEpAfyLjmRbnIBPcDzJa+8g
         GwD8D5RZevphJZVLobyT8PDdJMpqOjH4xQ0XjbfSZsuaqd85NRWXaUs52YmSy2HZoD9F
         zRzzRWCSadxF533JWYTiIhTHVHeh+HZI6Z0Qp3HQIPTQ22q/E8xvY+v4hW5vtejWAbUG
         ct2rg4RpCTjTIq/f/mhnX8fjo2iF6cmIgl3obpF6HddM9S2m83tKguEnp8adsezDGIzH
         gFPSmrOc15pJbb+PAPMfkOMVZZG4s/RBiXXb9ukHOGtS62wkamMsVjvOzwrOfGsak9XF
         lHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5LTkrvhYfKwhVtFUpdkdge37SOZJ7R/e1FHA1Cu3b28=;
        b=K3+JyZgf8OPAU+umD+fsSo6+/cu+buT4rfytqqosHbsYh4uj+cjeFgev0WCnU2UXdP
         d8BWElV+EwEVRxo3MikExsjsSb6itfLyuTxFx5G/JUZXUbQH44MCdlMRgNGEX0wD/g7V
         RU6mxvileTgeM7r/awxtYhpTsstMjAg7gCV7r4mr/QBcc+TMyAVrOyWjNUvzmrx5BQoR
         T6urtykV7MSNcF8yMx5HOD8unxtvcKElJZkibZ5QLLj0VTuWHG0nQsdHCVoslaCT2wV5
         C2Pf53L1nBkATw3y0hAtLYZBkwiebUX2mnh1W8g8/Dph4/cPosthZ+55uDsYu1C46tw2
         JdCQ==
X-Gm-Message-State: AOAM532lL/yO9OLzoWCz+mupEIwggSxXrADSgAeVB2t4oBx5IIop1EVn
        Pn8Wmyuk5ptXStumHFzMI023BdXyQzQ=
X-Google-Smtp-Source: ABdhPJwhEeCzGHCQ6rKc/Yati5lMpujh/0bdTx5brydbz29e5CdJ5Cv34McAXxW56E7rFBlsTYOUyg==
X-Received: by 2002:a1c:4c0e:: with SMTP id z14mr5465982wmf.54.1598043977313;
        Fri, 21 Aug 2020 14:06:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v67sm8086143wma.46.2020.08.21.14.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 14:06:16 -0700 (PDT)
Message-Id: <pull.707.v3.git.1598043976.gitgitgadget@gmail.com>
In-Reply-To: <pull.707.v2.git.1598004663.gitgitgadget@gmail.com>
References: <pull.707.v2.git.1598004663.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Aug 2020 21:06:12 +0000
Subject: [PATCH v3 0/4] [GSoC] Fix trailers atom bug and improved tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, there exists a bug in 'contents' atom. It does not show any error
if used with modifier 'trailers' and semicolon is missing before trailers
arguments. This small patch series is focused on fixing that bug and also
unified 'trailers' and 'contents:trailers' tests. Thus, removed duplicate
code from t6300 and made tests more compact.

Change log since v2:

 * Used simplified logic as per suggested by Eric (here 
   https://public-inbox.org/git/CAPig+cRxCvHG70Nd00zBxYFuecu6+Z6uDP8ooN3rx9vPagoYBA@mail.gmail.com/
   )
 * Unified trailer formatting logic for pretty.c and ref-filter.c

Hariom Verma (4):
  t6300: unify %(trailers) and %(contents:trailers) tests
  ref-filter: 'contents:trailers' show error if `:` is missing
  pretty.c: refactor trailer logic to `format_set_trailers_options()`
  ref-filter: using pretty.c logic for trailers

 Documentation/git-for-each-ref.txt |  36 ++++++--
 Hariom Verma via GitGitGadget      |   0
 pretty.c                           |  83 +++++++++++-------
 pretty.h                           |  11 +++
 ref-filter.c                       |  43 +++++-----
 t/t6300-for-each-ref.sh            | 133 ++++++++++++++++++++++-------
 6 files changed, 219 insertions(+), 87 deletions(-)
 create mode 100644 Hariom Verma via GitGitGadget


base-commit: 675a4aaf3b226c0089108221b96559e0baae5de9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-707%2Fharry-hov%2Ffix-trailers-atom-bug-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-707/harry-hov/fix-trailers-atom-bug-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/707

Range-diff vs v2:

 1:  4816aa3cfa = 1:  383476b177 t6300: unify %(trailers) and %(contents:trailers) tests
 2:  39aa46bce7 ! 2:  659b9835dc ref-filter: 'contents:trailers' show error if `:` is missing
     @@ Commit message
          ref-filter: 'contents:trailers' show error if `:` is missing
      
          The 'contents' atom does not show any error if used with 'trailers'
     -    atom and semicolon is missing before trailers arguments.
     +    atom and colon is missing before trailers arguments.
      
          e.g %(contents:trailersonly) works, while it shouldn't.
      
     @@ Commit message
      
          Let's fix this bug.
      
     +    Acked-by: Eric Sunshine <sunshine@sunshineco.com>
          Mentored-by: Christian Couder <chriscool@tuxfamily.org>
          Mentored-by: Heba Waly <heba.waly@gmail.com>
          Signed-off-by: Hariom Verma <hariom18599@gmail.com>
      
       ## ref-filter.c ##
     -@@ ref-filter.c: static int trailers_atom_parser(const struct ref_format *format, struct used_ato
     - 	return 0;
     - }
     - 
     -+static int check_format_field(const char *arg, const char *field, const char **option)
     -+{
     -+	const char *opt;
     -+	if (skip_prefix(arg, field, &opt)) {
     -+		if (*opt == '\0') {
     -+			*option = NULL;
     -+			return 1;
     -+		}
     -+		else if (*opt == ':') {
     -+			*option = opt + 1;
     -+			return 1;
     -+		}
     -+	}
     -+	return 0;
     -+}
     -+
     - static int contents_atom_parser(const struct ref_format *format, struct used_atom *atom,
     - 				const char *arg, struct strbuf *err)
     - {
      @@ ref-filter.c: static int contents_atom_parser(const struct ref_format *format, struct used_ato
       		atom->u.contents.option = C_SIG;
       	else if (!strcmp(arg, "subject"))
     @@ ref-filter.c: static int contents_atom_parser(const struct ref_format *format, s
      -	else if (skip_prefix(arg, "trailers", &arg)) {
      -		skip_prefix(arg, ":", &arg);
      -		if (trailers_atom_parser(format, atom, *arg ? arg : NULL, err))
     -+	else if (check_format_field(arg, "trailers", &arg)) {
     ++	else if (!strcmp(arg, "trailers")) {
     ++		if (trailers_atom_parser(format, atom, NULL, err))
     ++			return -1;
     ++	} else if (skip_prefix(arg, "trailers:", &arg)) {
      +		if (trailers_atom_parser(format, atom, arg, err))
       			return -1;
       	} else if (skip_prefix(arg, "lines=", &arg)) {
     @@ t/t6300-for-each-ref.sh: test_expect_success '%(trailers) rejects unknown traile
       '
       
      +test_expect_success 'if arguments, %(contents:trailers) shows error if semicolon is missing' '
     -+	# error message cannot be checked under i18n
      +	cat >expect <<-EOF &&
      +	fatal: unrecognized %(contents) argument: trailersonly
      +	EOF
 -:  ---------- > 3:  712ab9aacf pretty.c: refactor trailer logic to `format_set_trailers_options()`
 -:  ---------- > 4:  d491be5d10 ref-filter: using pretty.c logic for trailers

-- 
gitgitgadget
