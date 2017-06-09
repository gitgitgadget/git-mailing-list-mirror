Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFB1C1F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 18:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751671AbdFISSC (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 14:18:02 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34512 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751584AbdFISSC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 14:18:02 -0400
Received: by mail-wr0-f193.google.com with SMTP id u101so8436815wrc.1
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 11:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Pvu8pc8eR70RfdplsRl8L168B8FS7XaEceBXrPYACA=;
        b=MSctDdxBehiagMGWq0/D2vzL3pcNUtqi7PQmtxRSx5T+ObVebmIGUj5QAHQeontsIG
         Dg9hQ7o788cGsltEQBXvfT0sHZrz4r3jOEoGlDdlfcu2ICGepRjV6TDL3hGvQ1iTWSvd
         L7nO29kZ4AUGlNmmiUWl/XpMg8FvqlwOqTr7sCRanQNPrsOVkSTlfozuZUHvt4JVDfOz
         XJyWfvcXlWPSQSI0XHH54rRRplm0999y+CwwBqDYqRye4b+QHxn2rwlVN+YMKX7GPZCP
         ZZoE1zD5tEftopakDIiQjokKSBNFIXTNAbW1O2eres/O3WZ5V4y+oXGzBNkqG90pgQzN
         NObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Pvu8pc8eR70RfdplsRl8L168B8FS7XaEceBXrPYACA=;
        b=Id9uCG8yB1NXxjiIZz+AUdzowwd5svQAgzAHpvJL2PrN4nx8qkJEQFgWpW87+x7qma
         UyRh6gYoRgfDNvAcFekoQS4Hmi5RVPdf5Eu5Yv2mYOTS2LfPBaLDwTKsx2remTMm17Ce
         H/TdTnS9yyspVRFLotsHBqhTrlonSYsSvgwFpK139MX4DOQ3eQEJL3Mt2PTFNn7EAOI7
         LMITlcfqniDWG/cCn5VJM6u9rNnpvXFpT+N5pL7P6izW3YCoOkS05QKA6GgU21vs92Gt
         uE+pWsn9D85uSLVTA5QF88UFSfIySYxJXOaj2QIj22MkNJKPSZBLTI3fZyECOpoc8yMy
         w5WQ==
X-Gm-Message-State: AODbwcDDarJwMhQJAmjVflBUMtwZagiTYX5T03cnijcHfRPSqJ2TxG3b
        UE6VCNA1vBQEaQ==
X-Received: by 10.223.145.195 with SMTP id 61mr15162wri.43.1497032280474;
        Fri, 09 Jun 2017 11:18:00 -0700 (PDT)
Received: from localhost.localdomain (x590e0f24.dyn.telefonica.de. [89.14.15.36])
        by smtp.gmail.com with ESMTPSA id g46sm3485851wrg.69.2017.06.09.11.17.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 11:17:59 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 2/3] revision.c: use skip_prefix() in handle_revision_opt()
Date:   Fri,  9 Jun 2017 20:17:28 +0200
Message-Id: <20170609181733.6793-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.13.0.420.g54001f015
In-Reply-To: <20170602201143.6avkhp224no3dukb@sigill.intra.peff.net>
References: <20170602201143.6avkhp224no3dukb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 2, 2017 at 10:11 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jun 02, 2017 at 09:10:09PM +0200, SZEDER Gábor wrote:
>
>> @@ -1785,15 +1785,15 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>>       } else if (!strcmp(arg, "--author-date-order")) {
>>               revs->sort_order = REV_SORT_BY_AUTHOR_DATE;
>>               revs->topo_order = 1;
>> -     } else if (starts_with(arg, "--early-output")) {
>> +     } else if (skip_prefix(arg, "--early-output", &optarg)) {
>>               int count = 100;
>> -             switch (arg[14]) {
>> +             switch (*optarg) {
>>               case '=':
>> -                     count = atoi(arg+15);
>> +                     count = atoi(optarg + 1);
>>                       /* Fallthrough */
>>               case 0:
>>                       revs->topo_order = 1;
>> -                    revs->early_output = count;
>> +                     revs->early_output = count;
>>               }
>
> What happens if I say "--early-output-foobar"? There should probably be
> a "default" here that rejects it. Though we'd probably to goto to get to
> the unknown block, yuck.

I don't even know what should happen when I say '--early--output', as
it's not mentioned anywhere in 'git help log' :)
And it's broken anyway...  see the first patch in v2.

As it is, 'git log' would act as if '--early-output-foobar' wasn't
specified at all: the switch statement only looks for '=' and '\0',
that '-' it gets is neither and there is no default:, so it takes no
action and the control flow resumes after the switch statement.

Anyway, this option should be rejected, of course.

Embarrassingly, the code handling '--show-linear-break' did the right
thing and refused '--show-linear-break-foo' until I came along and
with the switch to skip_prefix() I modelled its control flow after
that of '--early-output'.  So with this patch it too would ignore such
a bogus option.

> Alternatively, a helper like:
>
>   int match_opt(const char *have, const char *want, const char **argout)
>   {
>         const char *arg;
>         if (!skip_prefix(have, want, &arg))
>                 return 0;
>         if (!*arg)
>                 *argout = NULL;
>         else if (*arg == '=')
>                 *argout = arg + 1;
>         else
>                 return 0;
>         return 1;
>   }
>
> would let us do:
>
>   if (match_opt(arg, "--early-output"), &optarg)) {
>         int count = optarg ? atoi(optarg) : 100;
>         ...
>   }
>
> which is a little nicer and could maybe help other options (I didn't see
> any, though).

Besides '--show-linear-break' and '--pretty', other options that could
benefit from this, i.e. long options with an optional argument, are
'--expand-tabs', '--abbrev' and '--no-walk'.  These are handled
differently than '--early--output' and '--show-linear-break': each is
covered by two if branches, one with and one without the optional 
argument, i.e.:

  } else if (!strcmp(arg, "--option")) {
    ...
  } else if (starts_with(arg, "--option=")) {
    ...
  } else ...

'--pretty=' couldn't benefit, though, because it is special in that
it's equivalent with '--format=', and the two are handled in the same
branch.

So inherently there are a few repeated option names and variable
assignments, and that's not so good.  However, refactoring these to
use match_opt() adds 40% more lines than it removes and, more
importantly, increases the number of nested conditions.  Subjectively
I don't think it's better, so I went with the "follow the conventions
of the surrounding code" rule for the update.

> If we're going to go that route, though, I suspect there
> may be some helpers we already have. Looks like parse_long_opt() is
> almost there, but doesn't handle options. I wonder if we could reuse
> bits of parse-options here (or even better, just parse-optify many of
> these).

Well, parse-optifying this many options would be a tad too much for
something that started out as a little while-at-it when I tried to
make sense of --format='%p', --parents/--children, -L:func:file and
their various combinations :)

As far as I can tell, parse-options doesn't handle options with an
optional argument by itself, but only with callback functions, so it
is no help here as it is.


So, here comes v2.  The interdiff is below, the changes since v1 are:

 - Patch 1/5 is new to fix a more fundamental problem with
   '--early-output'.
 - Patch 3/5 is new to fix this '--early-output-foo' issue and also
   to tighten up the parsing of its integer argument, while at it.
 - A fix for '--show-linear-break-foo' in v1.
 - A little cleanup in the handling of '--show-notes/--notes'.


SZEDER Gábor (5):
  revision.h: turn rev_info.early_output back into an unsigned int
  revision.c: stricter parsing of '--no-{min,max}-parents'
  revision.c: stricter parsing of '--early-output'
  revision.c: use skip_prefix() in handle_revision_opt()
  revision.c: use skip_prefix() in handle_revision_pseudo_opt()

 revision.c | 87 +++++++++++++++++++++++++++++---------------------------------
 revision.h |  5 ++--
 2 files changed, 44 insertions(+), 48 deletions(-)

-- 
2.13.0.420.g54001f015

diff --git a/revision.c b/revision.c
index ab0279572..12a44189e 100644
--- a/revision.c
+++ b/revision.c
@@ -1785,16 +1785,13 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--author-date-order")) {
 		revs->sort_order = REV_SORT_BY_AUTHOR_DATE;
 		revs->topo_order = 1;
-	} else if (skip_prefix(arg, "--early-output", &optarg)) {
-		int count = 100;
-		switch (*optarg) {
-		case '=':
-			count = atoi(optarg + 1);
-			/* Fallthrough */
-		case 0:
-			revs->topo_order = 1;
-			revs->early_output = count;
-		}
+	} else if (!strcmp(arg, "--early-output")) {
+		revs->early_output = 100;
+		revs->topo_order = 1;
+	} else if (skip_prefix(arg, "--early-output=", &optarg)) {
+		if (strtoul_ui(optarg, 10, &revs->early_output) < 0)
+			die("'%s': not a non-negative integer", optarg);
+		revs->topo_order = 1;
 	} else if (!strcmp(arg, "--parents")) {
 		revs->rewrite_parents = 1;
 		revs->print_parents = 1;
@@ -1923,14 +1920,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->show_signature = 1;
 	} else if (!strcmp(arg, "--no-show-signature")) {
 		revs->show_signature = 0;
-	} else if (skip_prefix(arg, "--show-linear-break", &optarg)) {
-		switch (*optarg) {
-		case '=':
-			revs->break_bar = xstrdup(optarg + 1);
-			break;
-		case 0:
-			revs->break_bar = "                    ..........";
-		}
+	} else if (!strcmp(arg, "--show-linear-break")) {
+		revs->break_bar = "                    ..........";
+		revs->track_linear = 1;
+		revs->track_first_time = 1;
+	} else if (skip_prefix(arg, "--show-linear-break=", &optarg)) {
+		revs->break_bar = xstrdup(optarg);
 		revs->track_linear = 1;
 		revs->track_first_time = 1;
 	} else if (skip_prefix(arg, "--show-notes=", &optarg) ||
@@ -1938,12 +1933,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		struct strbuf buf = STRBUF_INIT;
 		revs->show_notes = 1;
 		revs->show_notes_given = 1;
-		if (starts_with(arg, "--show-notes=")) {
-			if (revs->notes_opt.use_default_notes < 0)
-				revs->notes_opt.use_default_notes = 1;
-			strbuf_addstr(&buf, optarg);
-		} else
-			strbuf_addstr(&buf, optarg);
+		if (starts_with(arg, "--show-notes=") &&
+		    revs->notes_opt.use_default_notes < 0)
+			revs->notes_opt.use_default_notes = 1;
+		strbuf_addstr(&buf, optarg);
 		expand_notes_ref(&buf);
 		string_list_append(&revs->notes_opt.extra_notes_refs,
 				   strbuf_detach(&buf, NULL));
diff --git a/revision.h b/revision.h
index a91dd3d5d..f96e7f7f4 100644
--- a/revision.h
+++ b/revision.h
@@ -74,8 +74,9 @@ struct rev_info {
 	/* topo-sort */
 	enum rev_sort_order sort_order;
 
-	unsigned int	early_output:1,
-			ignore_missing:1,
+	unsigned int early_output;
+
+	unsigned int	ignore_missing:1,
 			ignore_missing_links:1;
 
 	/* Traversal flags */
