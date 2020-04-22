Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF36C55186
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 23:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5F092076E
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 23:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="dOtmu71X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgDVXje (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 19:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgDVXje (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 19:39:34 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5BBC03C1AA
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 16:39:33 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d184so1964650pfd.4
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 16:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=c2feNSXRq+RmZf6KcTuv2HAXPz35a+O9g50I9YHfnHA=;
        b=dOtmu71X6alGFi/rq8+kCY+ueJ+yEh2ftoEyOMWPzsBvTwkj4gvQt9R+SUq5zyxwKJ
         zWTJp26CCQDHsxHdDW+/X7U9ty+2QCohuFyaZiTWzqZ7Sj2gSsf9VXeQgu56G709MFuc
         kCPmZ3WNXh0oO+jVyla5LjI+n8DIPZq+hfi9dsNWvYFiNe9GaYNRKh8/bhCcrvMIbeUH
         zFCcj7nfhnfedorw6EzwTWWidnrKzFheCJkjhHw8sa5iIHOaQfvU9c5FT4uE2HreIeUD
         mw0rySjMD9g7+LROHE/pvlu8HIZZvxYzXT1+vT0VhzyoM7GixpYHOuqc5JjPf1qGPw+D
         ZLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=c2feNSXRq+RmZf6KcTuv2HAXPz35a+O9g50I9YHfnHA=;
        b=CaFErtQWNLcpWJHE7O9u14ruS5YH3nJw0WPFKhobaI1/dTm9GMFpw9WOZcmAxDCyqT
         5Bv/67JXvgxAq6mQjrAd47sDeuW0ZWunrvMo8CXtrFqs6m2AP6x0mfVPB/h0GGYyDcOC
         bcDkKhHq7E17haPxfynkCeAUuFKnZf2YxzJuEwvYmlavkWjx1a1WmlydRs0MO7nlHEZt
         sEGuUpGLn+cImwIKlvEXeZRyt+DYlf53YQOvMawFOdYNHBuAqL03Y8k9pp8GTlnf9/A0
         HuVEk6kAtQsxHytSAozsTDHHdN3dnRUpZnGErdVQlADrJf1DPujqgBaBvbC8ahSsBQ2T
         qV0A==
X-Gm-Message-State: AGi0PuYsNmSZxvhoRqmz5UouAAeSub/lTvYPo/EN0ddYgqJJmmzdH6sc
        mdALC/k8kLgklw+y4ZOh0uNQaw==
X-Google-Smtp-Source: APiQypJqdGw6JHjw1eu0953ne/5sNbCoglu+Gk6mQRNzcQffIKctpz2dS6fj8o8GoPykY+/kPiYvjg==
X-Received: by 2002:a63:d510:: with SMTP id c16mr1437360pgg.123.1587598773119;
        Wed, 22 Apr 2020 16:39:33 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id m2sm344228pjl.21.2020.04.22.16.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 16:39:32 -0700 (PDT)
Date:   Wed, 22 Apr 2020 17:39:30 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net
Subject: Re: [PATCH 7/7] commit-graph.c: introduce '--[no-]check-oids'
Message-ID: <20200422233930.GB19100@syl.local>
References: <cover.1586836700.git.me@ttaylorr.com>
 <1ff42f4c3d568dd25889d2808cda3edf38a36cb9.1586836700.git.me@ttaylorr.com>
 <20200415042930.GA11703@syl.local>
 <20200415043137.GA12136@syl.local>
 <20200422105536.GB3063@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200422105536.GB3063@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 22, 2020 at 12:55:36PM +0200, SZEDER Gábor wrote:
> On Tue, Apr 14, 2020 at 10:31:37PM -0600, Taylor Blau wrote:
> > On Tue, Apr 14, 2020 at 10:29:30PM -0600, Taylor Blau wrote:
> > > Whoops. I sent the wrong version of this patch. It should be the below:
> >
> > Double whoops. I was on the wrong branch, and hit send too early. *This*
> > is the version of the patch that I meant to send ;).
> >
> > --- >8 ---
> >
> > Subject: [PATCH] commit-graph.c: introduce '--[no-]check-oids'
> >
> > When operating on a stream of commit OIDs on stdin, 'git commit-graph
> > write' checks that each OID refers to an object that is indeed a commit.
> > This is convenient to make sure that the given input is well-formed, but
> > can sometimes be undesirable.
> >
> > For example, server operators may wish to feed the refnames that were
>
> s/the refnames/full commit object IDs pointed to by refs/
>
> or something similar.
>
> > updated during a push to 'git commit-graph write --input=stdin-commits',
> > and silently discard refs that don't point at commits.
>
> s/refs/<something along the lines of the above>/
>
> > This can be done
> > by combing the output of 'git for-each-ref' with '--format
> > %(*objecttype)', but this requires opening up a potentially large number
> > of objects.  Instead, it is more convenient to feed the updated refs to
>
> s/refs/.../
>
> > the commit-graph machinery, and let it throw out refs that don't point
>
> s/refs/.../
>
> > to commits.
> >
> > Introduce '--[no-]check-oids' to make such a behavior possible. With
> > '--check-oids' (the default behavior to retain backwards compatibility),
> > 'git commit-graph write' will barf on a non-commit line in its input.
> > With 'no-check-oids', such lines will be silently ignored, making the
>
> s/no-check-oids/--no-check-oids/
>
> > above possible by specifying this option.
> >
> > No matter which is supplied, 'git commit-graph write' retains the
> > behavior from the previous commit of rejecting non-OID inputs like
> > "HEAD" and "refs/heads/foo" as before.
>
> See? :)  This is why all those s/// are necessary.

Ah :). All good points; thanks for your suggestions.

> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> >  Documentation/git-commit-graph.txt |  5 +++++
> >  builtin/commit-graph.c             | 11 ++++++++---
> >  commit-graph.c                     |  2 +-
> >  t/t5318-commit-graph.sh            | 28 ++++++++++++++++++++++++++++
> >  4 files changed, 42 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> > index 46f7f7c573..91e8027b86 100644
> > --- a/Documentation/git-commit-graph.txt
> > +++ b/Documentation/git-commit-graph.txt
> > @@ -82,6 +82,11 @@ tip with the previous tip.
> >  Finally, if `--expire-time=<datetime>` is not specified, let `datetime`
> >  be the current time. After writing the split commit-graph, delete all
> >  unused commit-graph whose modified times are older than `datetime`.
> > ++
> > +The `--[no-]check-oids` option decides whether or not OIDs are required
> > +to be commits. By default, `--check-oids` is implied, generating an
> > +error on non-commit objects. If `--no-check-oids` is given, non-commits
> > +are silently discarded.
>
> What happens with OIDs of tags, in particular with OIDs of tags that
> can be peeled down to commit objects?  According to (my (too
> pedantic?) interpretation of) the above description they will trigger
> an error with '--check-oids' or will be ignored with
> '--no-check-oids'.  The implementation, however, accepts those oids
> and peels them down to commit objects; I think this is the right
> behaviour.

That's right, and certainly merits a mention in the documentation. I've
added that...

> What happens with OIDs that name non-existing objects?

...these are silently discarded. I think that you could make a
compelling argument in either direction on this one, but I'm slightly
swayed towards "discard these, too", since '--no-check-oids' is
literally saying "don't check these".

I guess that pushes us into the territory of whether or not "check" is
the right verb. "verify"? "scrutinize" :)? Do you have any thoughts
here?

If you're otherwise satisfied with this series, here's the updated
patch.

-- >8 --

Subject: [PATCH] commit-graph.c: introduce '--[no-]check-oids'

When operating on a stream of commit OIDs on stdin, 'git commit-graph
write' checks that each OID refers to an object that is indeed a commit.
This is convenient to make sure that the given input is well-formed, but
can sometimes be undesirable.

For example, server operators may wish to feed the full commit object
IDs pointed to by refs that were updated during a push to 'git
commit-graph write --input=stdin-commits', and silently discard any
input that doesn't point at a commit. This can be done by combing the
output of 'git for-each-ref' with '--format %(*objecttype)', but this
requires opening up a potentially large number of objects.  Instead, it
is more convenient to feed the updated object IDs to the commit-graph
machinery, and let it throw out whatever remains.  to commits.

Introduce '--[no-]check-oids' to make such a behavior possible. With
'--check-oids' (the default behavior to retain backwards compatibility),
'git commit-graph write' will barf on a non-commit line in its input.
With '--no-check-oids', such lines will be silently ignored, making the
above possible by specifying this option.

No matter which is supplied, 'git commit-graph write' retains the
behavior from the previous commit of rejecting non-OID inputs like
"HEAD" and "refs/heads/foo" as before.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-commit-graph.txt |  6 ++++++
 builtin/commit-graph.c             | 11 ++++++++---
 t/t5318-commit-graph.sh            | 28 ++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 46f7f7c573..6bdbe42766 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -82,6 +82,12 @@ tip with the previous tip.
 Finally, if `--expire-time=<datetime>` is not specified, let `datetime`
 be the current time. After writing the split commit-graph, delete all
 unused commit-graph whose modified times are older than `datetime`.
++
+The `--[no-]check-oids` option decides whether or not OIDs are required
+to be commits. By default, `--check-oids` is implied, generating an
+error on non-commit objects. If `--no-check-oids` is given, non-commits
+and non-existent objects are silently discarded. In either case, tags
+are peeled down to the object they reference.

 'verify'::

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index c69716aa7e..2d0a8e822a 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -11,7 +11,7 @@ static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
 	N_("git commit-graph write [--object-dir <objdir>] [--append] "
 	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] "
-	   "[--[no-]progress] <split options>"),
+	   "[--[no-]progress] [--[no-]check-oids] <split options>"),
 	NULL
 };

@@ -23,7 +23,7 @@ static const char * const builtin_commit_graph_verify_usage[] = {
 static const char * const builtin_commit_graph_write_usage[] = {
 	N_("git commit-graph write [--object-dir <objdir>] [--append] "
 	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] "
-	   "[--[no-]progress] <split options>"),
+	   "[--[no-]progress] [--[no-]check-oids] <split options>"),
 	NULL
 };

@@ -36,6 +36,7 @@ static struct opts_commit_graph {
 	int split;
 	int shallow;
 	int progress;
+	int check_oids;
 } opts;

 static struct object_directory *find_odb(struct repository *r,
@@ -163,6 +164,8 @@ static int graph_write(int argc, const char **argv)
 			N_("allow writing an incremental commit-graph file"),
 			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
 			write_option_parse_split),
+		OPT_BOOL(0, "check-oids", &opts.check_oids,
+			N_("require OIDs to be commits")),
 		OPT_INTEGER(0, "max-commits", &split_opts.max_commits,
 			N_("maximum number of commits in a non-base split commit-graph")),
 		OPT_INTEGER(0, "size-multiple", &split_opts.size_multiple,
@@ -173,6 +176,7 @@ static int graph_write(int argc, const char **argv)
 	};

 	opts.progress = isatty(2);
+	opts.check_oids = 1;
 	split_opts.size_multiple = 2;
 	split_opts.max_commits = 0;
 	split_opts.expire_time = 0;
@@ -227,7 +231,8 @@ static int graph_write(int argc, const char **argv)

 				oidset_insert(&commits, &oid);
 			}
-			flags |= COMMIT_GRAPH_WRITE_CHECK_OIDS;
+			if (opts.check_oids)
+				flags |= COMMIT_GRAPH_WRITE_CHECK_OIDS;
 		}

 		UNLEAK(buf);
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index e874a12696..7960cefa1b 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -49,6 +49,34 @@ test_expect_success 'exit with correct error on bad input to --stdin-commits' '
 	test_i18ngrep "invalid commit object id" stderr
 '

+graph_expect_commits() {
+	test-tool read-graph >got
+	if ! grep "num_commits: $1" got
+	then
+		echo "graph_expect_commits: expected $1 commit(s), got:"
+		cat got
+		false
+	fi
+}
+
+test_expect_success 'ignores non-commit OIDs to --input=stdin-commits with --no-check-oids' '
+	test_when_finished rm -rf "$objdir/info/commit-graph" &&
+	cd "$TRASH_DIRECTORY/full" &&
+	# write a graph to ensure layers are/are not added appropriately
+	git rev-parse HEAD~1 >base &&
+	git commit-graph write --stdin-commits <base &&
+	graph_expect_commits 2 &&
+	# bad input is rejected
+	echo HEAD >bad &&
+	test_expect_code 1 git commit-graph write --stdin-commits <bad 2>err &&
+	test_i18ngrep "unexpected non-hex object ID: HEAD" err &&
+	graph_expect_commits 2 &&
+	# update with valid commit OID, ignore tree OID
+	git rev-parse HEAD HEAD^{tree} >in &&
+	git commit-graph write --stdin-commits --no-check-oids <in &&
+	graph_expect_commits 3
+'
+
 graph_git_two_modes() {
 	git -c core.commitGraph=true $1 >output
 	git -c core.commitGraph=false $1 >expect
--
2.26.0.113.ge9739cdccc

