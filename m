Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC86A211B3
	for <e@80x24.org>; Fri, 30 Nov 2018 04:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbeK3PfT (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 10:35:19 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62213 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeK3PfS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 10:35:18 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 48667111FB4;
        Thu, 29 Nov 2018 23:27:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Wsek1TMbHyhIHA3i2IXUMwoulMQ=; b=M9+1Ki
        x8ktEZYAGotR73cnVf4a6JCVuoh/0n1ecHwjcgWjgCSd+AJjKCjt2bJg2fchGrNa
        ks+0hNw+e0Dqe8xCqEuu11o7qs0SnuZZtdxO1F0ZdAkAntm2jf1rq2LGaysDsGHp
        O+hpuDkj6Laso10Bp87VY7I0v2w4CGsATav/I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iJvD4+HFvsLpaRSVKBm160jjuxR+BwR4
        WYGaCGdyjF2ZNPRMkNWNwkopJGi/lcB3TzpV7CGYnhEQE5+Fw+5VesWCPw8kQY80
        nVuPlwJuUehs+GSQz+pAIlVElOeKHD7X3coKpo0Z0Inhj/j9joE0a3ausx+rV6EK
        vPN41OeKK94=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3EF2A111FB2;
        Thu, 29 Nov 2018 23:27:13 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6AC26111FB1;
        Thu, 29 Nov 2018 23:27:12 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] format-patch: do not let its diff-options affect --range-diff
 (was Re: [PATCH 2/2] format-patch: allow for independent diff & range-diff options)
References: <xmqqk1l32jo2.fsf@gitster-ct.c.googlers.com>
        <20181128201852.9782-3-avarab@gmail.com>
        <nycvar.QRO.7.76.6.1811291103190.41@tvgsbejvaqbjf.bet>
        <8736rkyy4h.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.1811291307070.41@tvgsbejvaqbjf.bet>
        <871s74yms3.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.1811291641090.41@tvgsbejvaqbjf.bet>
        <87tvjzyiph.fsf@evledraar.gmail.com>
        <xmqq7egvmh54.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 30 Nov 2018 13:27:11 +0900
In-Reply-To: <xmqq7egvmh54.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 30 Nov 2018 11:30:15 +0900")
Message-ID: <xmqqwoovkx5s.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 355EEE3C-F458-11E8-A31F-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> In any case, I tend to agree with the conclusion in the downthread
> by Dscho that we should just clearly mark that invocations of the
> "format-patch --range-diff" command with additional diff options is
> an experimental feature that may not do anything sensible in the
> upcoming release, and declare that the UI to pass diff options to
> affect only the range-diff part may later be invented.  IOW, I am
> coming a bit stronger than Dscho's suggestion in that we should not
> even pretend that we aimed to make the options used for range-diff
> customizable when driven from format-patch in the upcoming release,
> or aimed to make --range-diff option compatible with other diff
> options given to the format-patch command.
>
> I had to delay -rc2 to see these last minute tweaks come to some
> reasonable place to stop at, and I do not think we want to delay the
> final any longer or destablizing it further by piling last minute
> undercooked changes on top.

So how about doing this on top of 'master' instead?  As this leaks
*no* information wrt how range-diff machinery should behave from the
format-patch side by not passing any diffopt, as long as the new
code I added to show_range_diff() comes up with a reasonable default
diffopts (for which I really would appreciate extra sets of eyes to
make sure), this change by definition cannot be wrong (famous last
words).

-- >8 --
Subject: format-patch: do not let its diff-options affect --range-diff

Stop leaking how the primary output of format-patch is customized to
the range-diff machinery and instead let the latter use its own
"reasonable default", in order to correct the breakage introduced by
a5170794 ("Merge branch 'ab/range-diff-no-patch'", 2018-11-18) on
the 'master' front.  "git format-patch --range-diff..." without any
weird diff option started to include the "range-diff --stat" output,
which is rather useless right now, that made the whole thing
unusable and this is probably the least disruptive way to whip the
codebase into a shippable shape.

We may want to later make the range-diff driven by format-patch more
configurable, but that would have to wait until we have a good
design.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-format-patch.txt | 5 +++++
 builtin/log.c                      | 2 +-
 log-tree.c                         | 2 +-
 range-diff.c                       | 6 +++++-
 range-diff.h                       | 5 +++++
 5 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index aba4c5febe..27304428a1 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -250,6 +250,11 @@ feeding the result to `git send-email`.
 	feature/v2`), or a revision range if the two versions of the series are
 	disjoint (for example `git format-patch --cover-letter
 	--range-diff=feature/v1~3..feature/v1 -3 feature/v2`).
++
+Note that diff options passed to the command affect how the primary
+product of `format-patch` is generated, and they are not passed to
+the underlying `range-diff` machinery used to generate the cover-letter
+material (this may change in the future).
 
 --creation-factor=<percent>::
 	Used with `--range-diff`, tweak the heuristic which matches up commits
diff --git a/builtin/log.c b/builtin/log.c
index 0fe6f9ba1e..5ac18e2848 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1096,7 +1096,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	if (rev->rdiff1) {
 		fprintf_ln(rev->diffopt.file, "%s", rev->rdiff_title);
 		show_range_diff(rev->rdiff1, rev->rdiff2,
-				rev->creation_factor, 1, &rev->diffopt);
+				rev->creation_factor, 1, NULL);
 	}
 }
 
diff --git a/log-tree.c b/log-tree.c
index 7a83e99250..b243779a0b 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -762,7 +762,7 @@ void show_log(struct rev_info *opt)
 		next_commentary_block(opt, NULL);
 		fprintf_ln(opt->diffopt.file, "%s", opt->rdiff_title);
 		show_range_diff(opt->rdiff1, opt->rdiff2,
-				opt->creation_factor, 1, &opt->diffopt);
+				opt->creation_factor, 1, NULL);
 
 		memcpy(&diff_queued_diff, &dq, sizeof(diff_queued_diff));
 	}
diff --git a/range-diff.c b/range-diff.c
index 767af8c5bb..8e52a85c19 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -460,7 +460,11 @@ int show_range_diff(const char *range1, const char *range2,
 		struct diff_options opts;
 		struct strbuf indent = STRBUF_INIT;
 
-		memcpy(&opts, diffopt, sizeof(opts));
+		if (diffopt)
+			memcpy(&opts, diffopt, sizeof(opts));
+		else
+			repo_diff_setup(the_repository, &opts);
+
 		if (!opts.output_format)
 			opts.output_format = DIFF_FORMAT_PATCH;
 		opts.flags.suppress_diff_headers = 1;
diff --git a/range-diff.h b/range-diff.h
index 190593f0c7..08a50b6e98 100644
--- a/range-diff.h
+++ b/range-diff.h
@@ -5,6 +5,11 @@
 
 #define RANGE_DIFF_CREATION_FACTOR_DEFAULT 60
 
+/*
+ * Compare series of commmits in RANGE1 and RANGE2, and emit to the
+ * standard output.  NULL can be passed to DIFFOPT to use the built-in
+ * default.
+ */
 int show_range_diff(const char *range1, const char *range2,
 		    int creation_factor, int dual_color,
 		    struct diff_options *diffopt);


