Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AB9C55178
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 23:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A4D52222C
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 23:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="XLr2IdCM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409771AbgJZXwc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 19:52:32 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43281 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409751AbgJZXwa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 19:52:30 -0400
Received: by mail-qt1-f195.google.com with SMTP id f93so465382qtb.10
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 16:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p/uuWfqwyEIVQogtmP2qTkJBg//qY3b4pE5x2bWCssA=;
        b=XLr2IdCM9bczjszIoe2P1NBDaK4W203ZYGzyYZJjAcXZeO8Rev5+VOZvs6yFsLV7DJ
         xh4UQYLWRLdgGNZGH7MC8Us+/efskAxuWUCktD+Lj+Ba0NPahLFJgZmppNPgTUEYIwmM
         WIDAQMW3u3o9e00D72YOktiTWVABjXciWXo7Bh1nEppwjaURJStYM1TU1BBWywDk2G0r
         bLIWvKt1VjUFCKU45anm1o2zRzL2PEDHryW/5QxY3FgUadOpegQb2cmBl9hRYq0EUATX
         Ln9lmoW0Uj/iZ3JOKxyqlNJq9kEkDICFNcvucktkvdfSL1frh8U9z1jehjJSQR2D7S7k
         qQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p/uuWfqwyEIVQogtmP2qTkJBg//qY3b4pE5x2bWCssA=;
        b=cyudLP102Fsy7KhoOe5S+DmYhbAxpv7MfD5hx7HRl4bIVgrE5eQo1nMQTY4oYjq1le
         uFDMURI92U4aQ866PBtcVA5XfHcPB+/Fb2/eVISWb/kYkTiZMdyM2NPV/7pUnTmPiuvq
         Uep/0SCCoiugguOrV0yxQDvyyRNSu5oqGZyj0scAT02w+dF5ml8Xn+jE/Z8ngX1LsLy2
         HDM8l0alEqns8qHknfxFd05RjNP/Bwm6A4TCpKb8xSiPWMJdYS4Bu1/cTeZEdVOav3By
         f8kiUcEbFBU62bKlhO5dODsYOodT66T4fWXG4WLjDI6SpXmY8f9acA5BkxBSv69S0mUP
         G4yA==
X-Gm-Message-State: AOAM533E0kMwYL1oPaKRt+TBVVixdpmTfCxJdlqvv4G0vBgWedzst06/
        16ah+o98Tckqa4goXEVXF27W+iysVVbS6slm
X-Google-Smtp-Source: ABdhPJwNqJRjg6iuXPfv6ZpRceVT2Tr7KO+60O7xRyQJyewx8eLpJCVGyqgTuNGAkN+DgxOJ2bQ3AQ==
X-Received: by 2002:ac8:5c03:: with SMTP id i3mr4390417qti.363.1603756349304;
        Mon, 26 Oct 2020 16:52:29 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:4ce9:d5a5:b109:78ba])
        by smtp.gmail.com with ESMTPSA id d14sm7656151qtr.62.2020.10.26.16.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 16:52:28 -0700 (PDT)
Date:   Mon, 26 Oct 2020 19:52:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4] refs: implement reference transaction hook
Message-ID: <X5dhN+dsLXlKfukF@nand.local>
References: <1d1a94426f95d842e0e3ea6a1569c0c45239229c.1591086316.git.ps@pks.im>
 <55c58e9b09691dc11dea911f26424594fb3922c9.1592549570.git.ps@pks.im>
 <20201023010315.GA1542721@coredump.intra.peff.net>
 <xmqqpn59k2xw.fsf@gitster.c.googlers.com>
 <20201026074303.GA972@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201026074303.GA972@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 26, 2020 at 08:43:03AM +0100, Patrick Steinhardt wrote:
> @Taylor, given that you've already dug into the code: do you already
> have plans to post a patch for this?

You are likely in a better position to do that than I am. I am
unfamiliar enough with the refs.c code to feel confident that my change
is correct, let alone working. The combination of REF_HAVE_OLD, the lock
OID, the update OID, and so on is very puzzling.

Ordinarily, I'd be happy to post a patch after familiarizing myself, but
right now I don't have the time. So, I may come back to this in six
months, but I certainly won't feel bad if you beat me to it ;-).

In the meantime, I'd be fine to apply Peff's patch with some fix-ups,
maybe something like what's below the scissors line.

Taylor

--- >8 ---

Subject: [PATCH] t1416: specify pre-state for ref-updates

The ref-transaction hook documentation says that the expected format for
each line is:

  <old-value> SP <new-value> SP <ref-name> LF

without defining what <old-value> is. It could either be the current
state of the refs (after locking, but before committing the
transaction), or the optional caller-provided pre-state.

If <old-value> is to mean the caller-provided pre-state, than $ZERO_OID
could be taken to mean that the update is allowed to take place without
requiring the ref to be at some state. On the other hand, if <old-value>
is taken to mean "the current value of the reference", then that
requires a behavior change.

But that may only be semi-realistic, since any careful callers are
likely to pass a pre-state around anyway, and failing to meet that
pre-state means the hook will not even be invoked.

So, tweak the tests to more closely match how callers will actually
invoke this hook by providing a pre-state explicitly and then asserting
that it made its way down to the ref-transaction hook.

If we do decide to go further and implement a behavior change, it would
make sense to modify the tests to instead look something like:

  for before in "$PRE" ""
  do
    cat >expect <<-EOF &&
      $ZERO_OID $POST_OID HEAD
      $ZERO_OID $POST_OID refs/heads/master
      $PRE_OID $POST_OID HEAD
      $PRE_OID $POST_OID refs/heads/master
    EOF
    git reset --hard $PRE &&
    git update-ref HEAD POST $before &&
    test_cmp expect actual
  done

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t1416-ref-transaction-hooks.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index f6e741c6c0..74f94e293c 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -52,10 +52,10 @@ test_expect_success 'hook gets all queued updates in prepared state' '
 		fi
 	EOF
 	cat >expect <<-EOF &&
-		$ZERO_OID $POST_OID HEAD
-		$ZERO_OID $POST_OID refs/heads/master
+		$PRE_OID $POST_OID HEAD
+		$PRE_OID $POST_OID refs/heads/master
 	EOF
-	git update-ref HEAD POST <<-EOF &&
+	git update-ref HEAD POST PRE <<-EOF &&
 		update HEAD $ZERO_OID $POST_OID
 		update refs/heads/master $ZERO_OID $POST_OID
 	EOF
@@ -75,10 +75,10 @@ test_expect_success 'hook gets all queued updates in committed state' '
 		fi
 	EOF
 	cat >expect <<-EOF &&
-		$ZERO_OID $POST_OID HEAD
-		$ZERO_OID $POST_OID refs/heads/master
+		$PRE_OID $POST_OID HEAD
+		$PRE_OID $POST_OID refs/heads/master
 	EOF
-	git update-ref HEAD POST &&
+	git update-ref HEAD POST PRE &&
 	test_cmp expect actual
 '

--
2.29.1.9.g605042ee00

