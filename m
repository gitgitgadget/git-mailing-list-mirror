Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AB8C48BCF
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 16:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19933610F8
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 16:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbhFIQIS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 12:08:18 -0400
Received: from mail-ej1-f43.google.com ([209.85.218.43]:35646 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbhFIQIR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 12:08:17 -0400
Received: by mail-ej1-f43.google.com with SMTP id h24so39293081ejy.2
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 09:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=qK+4uTDMD2peaPkufJUdDmyNjYgx9FQrqJYdkk5cojw=;
        b=PbE9+Lbzsa5NEfxROsvACPAmWNY0/G7M5npjMVn1gRimh6Tc4M6TCygl+NuBG1v7f3
         2laNHrs7dFo7fRN4hwdEu+I+xtZIQ/LgfDkkqSVFjjWFkGKmjpImsZFqgbJpfXbU/C0R
         zohUV5J/wtnma1noA+yh1wXd+B9i0OOR/QrrPGSpDhyrO/XEpeUpcThyb9T9pUGJodgQ
         9D2VmsXXWK0WfCaPn8mPmnyYYM7GfoaaQN0uGYp8hMhcmq4eUrhGsVJTxBrnXuMUbaes
         qF8VPWmaNcf6Ai9a10ZkHepsw9WC4n7FkYnHxfe6ZFAKrrOaV8ZixtPb5AtL4J/nF/ru
         E/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=qK+4uTDMD2peaPkufJUdDmyNjYgx9FQrqJYdkk5cojw=;
        b=AhOzNsQKyWWnAqA1TdyU/oZ9beDoeGSOnzhqsVhBy4ETWInC2w1zflt1avO/U/WY+t
         dCKZnkUrMRlGV2IsK/d1Lo5oAIt4uHVAP8m57v3iRh2TiFFQsBgckHlXGub8ee6a+VkY
         89aEzeCZTVtiTPmkenHSjhIYAHhcAQWMVWKWszsd7yyIEHKoCIR8wx4CdZRYr0tWSYZd
         SqgFmuRVuSv05+rDXDCBwb784AkgnDYkmLW2YU0WTTJukveY/vjbDMHGVDG9vl/RQAky
         S1sLSkL/+xwf+ba1r+2pYAFshYna58BVbU05Yd+1m9JEpClSfTo7LuU3K+4r+CD7ccNu
         7Dww==
X-Gm-Message-State: AOAM533j5juETmaB1aeBG+A41YEM3lmuotq55JabhC/OiBt4ieaU4y2N
        NxGrtonP9ES4KFyzV2QoZyMTozJdhKQ=
X-Google-Smtp-Source: ABdhPJx1rgUKffbNg7tqY1dlyIBRGtwvfQjzrlv63pibca2SX6nsTpsbsC+W+9unhl8wnzqHh3mIBg==
X-Received: by 2002:a17:906:1f90:: with SMTP id t16mr560533ejr.297.1623254706924;
        Wed, 09 Jun 2021 09:05:06 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n5sm84434edd.40.2021.06.09.09.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 09:05:06 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, stolee@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/4] Use singular "they" when appropriate
Date:   Wed, 09 Jun 2021 17:44:59 +0200
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
Message-ID: <87a6nz2fda.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 09 2021, Derrick Stolee via GitGitGadget wrote:

> Updates in v2
> =============
>
>  * Some edits were removed because they were in contrib/ or
>    Documentation/howto/ and these are now listed as exclusions in the
>    message of Patch 4.

Thanks.

>  * Several recommendations to improve the edits in the documentation and
>    code comments were incorporated. Those who recommended these edits are
>    credited with "Helped-by" tags.

I think a v2 is a bit premature with all the active discussion on the v1
thread, a lot of which isn't addressed by the v2 or this CL, e.g. many
point I[1] and others raised.

My main objection of extending this to commit messages and thus making
e.g. non-native speakers be on their toes when contributing to the
project is gone, so that's good.

I'm still not in favor of this change because I think an active
recommendation like "Refer to an anonymous user in a gender neutral way"
probably isn't needed if we simply document that our preferred prose is
to avoid the issue entirely, which is the case in most of our
documentation.

The below for-show patch[2] shows an alternate approach that I think is
a better direction than this series.

It shows how some of the s/he|she/they/g search-replacements you did
could IMO be better if we simply reduced the amount of prose, e.g. in
strbuf.h changing:

    passes a context pointer, which can be used by the programmer of the
    callback as she sees fit.

To:

    passes a `void *context` to the callback `fn`

Is a better change than a mere s/she/they/g. Nobody needs all this
verbosity to understand the common pattern of passing a user-controlled
'void *` to a callback. It's implicitly understood by the technical
level of the reader this documentation is targeted at.

So much of this just seems premature, e.g. your change to git-push.txt
of s/her/they/.

If we look more carefully at that we can see that the "her" was added in
28f5d17611 (remote.c: add command line option parser for
"--force-with-lease", 2013-07-08), and then since fddfaf8a22
(git-push.txt: clean up force-with-lease wording, 2015-03-26) the
paragraph right after that discusses "other people", instead of
continuing with the example already provided.

Having it be s/her/they/ -> other people isn't much of an overall
improvement, and just seems like blind search-replacement.

Perhaps my WIP rewrite isn't much better, but it at least tries to make
forward progress on not having two paragraphs that read like different
semi-related pages in a book.

There's a reason your patch series isn't bigger than it is, this sort of
prose is the rare exception in our documentation, and for reasons that
trump any perceived sensitivity to specific pronouns from some people:
It's overly verbose.

1. https://lore.kernel.org/git/875yyp4fun.fsf@evledraar.gmail.com/
2.
diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index e3af089ecf..204935186e 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -551,6 +551,31 @@ Writing Documentation:
  documentation, please see the documentation-related advice in the
  Documentation/SubmittingPatches file).
 
+ Prefer succinctness and matter-of-factly describing functionality in
+ the abstract. E.g.:
+
+     --short:: Emit output in the short-format.
+
+ Not something like these overly verbose alternatives:
+
+     --short:: Use this to emit output in the short-format.
+     --short:: You can use this to get output in the short-format.
+     --short:: A user who prefers shorter output could....
+     --short:: Should a person and/or program want shorter output, he
+               she/they/it can...
+
+ When it becomes awkward to stick to this style prefer "you" when
+ addressing the the hypothetical user, and possibly "we" when
+ discussing how the program might react to the user.
+
+     You can use this option instead of --xyz, but we might remove
+     support for it in future versions.
+
+  While keeping in mind that you can probably be less verbose, e.g.:
+
+     Use this instead of --xyz. This option might be removed in future
+     versions.
+
  Every user-visible change should be reflected in the documentation.
  The same general rule as for code applies -- imitate the existing
  conventions.
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index a953c7c387..47d0cdf7cc 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -240,17 +240,17 @@ already exists on the remote side.
 This option overrides this restriction if the current value of the
 remote ref is the expected value.  "git push" fails otherwise.
 +
+When collaborating with others this is safer than using the `--force` option.
 Imagine that you have to rebase what you have already published.
-You will have to bypass the "must fast-forward" rule in order to
-replace the history you originally published with the rebased history.
-If somebody else built on top of your original history while you are
-rebasing, the tip of the branch at the remote may advance with her
-commit, and blindly pushing with `--force` will lose her work.
-+
-This option allows you to say that you expect the history you are
-updating is what you rebased and want to replace. If the remote ref
-still points at the commit you specified, you can be sure that no
-other people did anything to the ref. It is like taking a "lease" on
+By using `--force` you might inadvertently clobber commits that
+someone else pushed on top of branch.
++
+
+Unlike `--force`, `--force-with-lease` will transmit the expected
+object ID to the remote server (similar to linkgit:git-update-ref[1]'s
+`<oldvalue>`, and thus provides a safeguard against inadvertently
+clobbering remote refs which have changed since you retrieved them
+with `git fetch`. Using this option has the effect of taking a "lease" on
 the ref without explicitly locking it, and the remote ref is updated
 only if the "lease" is still valid.
 +
diff --git a/config.h b/config.h
index 9038538ffd..a2200f3111 100644
--- a/config.h
+++ b/config.h
@@ -450,8 +450,8 @@ void git_configset_init(struct config_set *cs);
 /**
  * Parses the file and adds the variable-value pairs to the `config_set`,
  * dies if there is an error in parsing the file. Returns 0 on success, or
- * -1 if the file does not exist or is inaccessible. The user has to decide
- * if he wants to free the incomplete configset or continue using it when
+ * -1 if the file does not exist or is inaccessible. The caller decides
+ * whether to free the incomplete configset or continue using it when
  * the function returns -1.
  */
 int git_configset_add_file(struct config_set *cs, const char *filename);
diff --git a/strbuf.h b/strbuf.h
index 223ee2094a..c7c67cfe14 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -337,8 +337,8 @@ const char *strbuf_join_argv(struct strbuf *buf, int argc,
  * placeholder is unknown, then the percent sign is copied, too.
  *
  * In order to facilitate caching and to make it possible to give
- * parameters to the callback, `strbuf_expand()` passes a context pointer,
- * which can be used by the programmer of the callback as she sees fit.
+ * parameters to the callback, `strbuf_expand()` passes a
+ * `void *context` to the callback `fn`
  */
 typedef size_t (*expand_fn_t) (struct strbuf *sb,
 			       const char *placeholder,
