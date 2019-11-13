Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B2441F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 15:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfKMPBm (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 10:01:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35319 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfKMPBm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 10:01:42 -0500
Received: by mail-wm1-f67.google.com with SMTP id 8so2376552wmo.0
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 07:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LPuPrOxEBUuCc34N0O5elleGHPPwTT//T8LsTGF/7iU=;
        b=f3D1VhyB31OiG162A9y0VbEsGM8u6TCC2ALSMptrwkPIJbg+ucGh9nl2RCXrmH8H9K
         Bk4y0r0dm2gdV5tnw1m/Ev6Hhj4KITg5qrXWoy8rsK5QKAgox+J5kUR6VPRHrRSq9blC
         vEhZqCkEcNAIFC7kwl/pA/A1rYWwxj0AFfRRzWR5vMOCLQ1tg3ozobC6qlnkbiJY2ZIX
         8eCQHeQpqenF7AZXVcoBD5rsdXPLeo3KIhGay+VYpDOsQQ/5FAK32LeSWkL8ysM9ovtX
         cYN6paZRH/NGY/13MEoRbmsxlQTHEOR62iDjctbu60RX44fm5oL8aWnEh6v/h4DqUgEM
         eYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LPuPrOxEBUuCc34N0O5elleGHPPwTT//T8LsTGF/7iU=;
        b=tAfx66+zr65i/h1VyOeB20p4q1Ve65UrakrQZ17tTPPgeMqI5od52KxesBDnaY6+5l
         A3Eyz2WPBu0Mgz1r3VDmr1iZum7uqwDD8SQjfp2oT/gDeePBK5JVnqRCJqBDNIDHLavj
         m5zvS9U1juPiYyqeIdjdiKiILFj4dDgeRmTd4DNXXKCqvr98475+12cOfrv3GofOo/3w
         GayGpChDD25jr8uQaOvsN/mEwCGxlr7VFuPbJMiEyTk0D444cmXWQBq8cNn/VN7GA4xO
         ySH4uDoY202oTpjUCQAJW7nw/pDWvjnu5Hg0qm77ZSxF5LHQhANoiQXIu+m7nUnC7iQx
         ME4w==
X-Gm-Message-State: APjAAAXQLRQojMoA5eHumjp5kROV6ExlXCfgWJBfAaYVrUVBMMDj9WwL
        zNllpc5yLTqWAlFPaSpAvUk=
X-Google-Smtp-Source: APXvYqzB/mug+7w3i8PDU3TM5Ym/8FMJ5iQqE3eRs8WE31YyQCneCEbG5Y1bNUtt5+/r0BHn1+1QNw==
X-Received: by 2002:a7b:c408:: with SMTP id k8mr3370204wmi.67.1573657298987;
        Wed, 13 Nov 2019 07:01:38 -0800 (PST)
Received: from localhost ([62.253.227.125])
        by smtp.gmail.com with ESMTPSA id g133sm2612385wme.42.2019.11.13.07.01.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Nov 2019 07:01:37 -0800 (PST)
Date:   Wed, 13 Nov 2019 15:01:36 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Grzegorz Rajchman <rayman17@gmail.com>, git@vger.kernel.org
Subject: [PATCH v3] stash: make sure we have a valid index before writing it
Message-ID: <20191113150136.GB3047@cat>
References: <CAMcnqp22tEFva4vYHYLzY83JqDHGzDbDGoUod21Dhtnvv=h_Pg@mail.gmail.com>
 <20191107184912.GA3115@cat>
 <xmqq7e4bp06l.fsf@gitster-ct.c.googlers.com>
 <20191108165929.GB3115@cat>
 <xmqqk188l0pn.fsf@gitster-ct.c.googlers.com>
 <20191111195641.GC3115@cat>
 <xmqqftitfz5u.fsf@gitster-ct.c.googlers.com>
 <20191113111539.GA3047@cat>
 <xmqq4kz7c37i.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4kz7c37i.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/13, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> >> ...  This may want to become
> >> 
> >> 	git rev-parse --verify :file &&
> >> 
> >> or
> >> 
> >> 	git show :file >actual && echo bar >expect &&
> >> 	test_cmp expect actual &&
> >> 
> >> perhaps?
> >
> > Hmm I just copy-pasted this from somewhere else in this test file.
> > I'll add a preparatory patch getting rid of "$(git command substitution)"
> > as I don't believe Denton got to t3903 yet.
> >
> > There's some more opportunities for modernization of this test file,
> > but I refrained from doing that to not blow up this bug fix series too
> > much.
> 
> It is very much appreciated that you aimed to keep the topic focused
> on the fixing.  What I meant was merely to avoid making things worse
> by adding more of $(git command substitution), not cleaning up the
> existing ones.

I misunderstood then because the other case you had pointed out wasn't
introduced in my patch, but was just in the context. I have already
sent the series with the preparatory cleanup.  I'm happy to just go
without the cleanup though.  Since I'm already sending this email,
I'll just add the patch doing just that below.

--- >8 ---
Subject: [PATCH v3] stash: make sure we have a valid index before writing it

In 'do_apply_stash()' we refresh the index in the end.  Since
34933d0eff ("stash: make sure to write refreshed cache", 2019-09-11),
we also write that refreshed index when --quiet is given to 'git stash
apply'.

However if '--index' is not given to 'git stash apply', we also
discard the index in the else clause just before.  We need to do so
because we use an external 'git update-index --add --stdin', which
leads to an out of date in-core index.

Later we call 'refresh_and_write_cache', which now leads to writing
the discarded index, which means we essentially write an empty index
file.  This is obviously not correct, or the behaviour the user
wanted.  We should not modify the users index without being asked to
do so.

Make sure to re-read the index after discarding the current in-core
index, to avoid dealing with outdated information.  Instead we could
also drop the 'discard_cache()' + 'read_cache()', however that would
make it easy to fall into the same trap as 34933d0eff did, so it's
better to avoid that.

We can also drop the 'refresh_and_write_cache' completely in the quiet
case.  Previously in legacy stash we relied on 'git status' to refresh
the index after calling 'git read-tree' when '--index' was passed to
'git apply'.  However the 'reset_tree()' call that replaced 'git
read-tree' always passes options that are equivalent to '-m', making
the refresh of the index unnecessary.

Reported-by: Grzegorz Rajchman <rayman17@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/stash.c  | 7 +++----
 t/t3903-stash.sh | 7 ++++++-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index ab30d1e920..372fbdb7ac 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -481,13 +481,12 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 		if (ret)
 			return -1;
 
+		/* read back the result of update_index() back from the disk */
 		discard_cache();
+		read_cache();
 	}
 
-	if (quiet) {
-		if (refresh_and_write_cache(REFRESH_QUIET, 0, 0))
-			warning("could not refresh index");
-	} else {
+	if (!quiet) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 
 		/*
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 392954d6dd..9de1c3616a 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -232,8 +232,11 @@ test_expect_success 'save -q is quiet' '
 	test_must_be_empty output.out
 '
 
-test_expect_success 'pop -q is quiet' '
+test_expect_success 'pop -q works and is quiet' '
 	git stash pop -q >output.out 2>&1 &&
+	echo bar >expect &&
+	git show :file >actual &&
+	test_cmp expect actual &&
 	test_must_be_empty output.out
 '
 
@@ -242,6 +245,8 @@ test_expect_success 'pop -q --index works and is quiet' '
 	git add file &&
 	git stash save --quiet &&
 	git stash pop -q --index >output.out 2>&1 &&
+	git diff-files file2 >file2.diff &&
+	test_must_be_empty file2.diff &&
 	test foo = "$(git show :file)" &&
 	test_must_be_empty output.out
 '
-- 
2.24.0.155.gd9f6f3b619

