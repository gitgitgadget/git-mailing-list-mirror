Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7150CC433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 02:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJUCkA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 22:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJUCj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 22:39:59 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67366B2775
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 19:39:57 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id p16so1227042iod.6
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 19:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MVDG9nm5o8aG+JB6MTZsT7+aYMaBg89GnYtqO3E4ZBI=;
        b=HDQ7DtkNJYYui/NCKi3nbfRaAzUZJP8N7cZRGvQroyLqRmiztblHgIX43zPlw1Lc6t
         CFDR6vD7UFEZhtsx58ttrtMBs+VW/SxiLVNWKacLeLJOGD4y1DSub/5A0uFkpttC6DiS
         cSNMkGwwY9IPk9fde1s/xmyir1u7zFkJoJ4sY/MN2VQlGfYDIXa/EtzRBp7PA2RZEAdG
         eIOv3LchSKwGRMle1V26ke4p/y1cQOL+lJkOwTnhkgi3EWOCwSgnH5jlVRjsuvzNuim7
         UL9gzV2ndOc+JfYJGKKvwBVTtllNr1T4Lvw30bQezWIa5tsXsVXkgaahqhcWR1e7N+yw
         7LUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVDG9nm5o8aG+JB6MTZsT7+aYMaBg89GnYtqO3E4ZBI=;
        b=NTYdN1xzoHfG0mbWqv/U1IEnwsvRmrURtQ4XFjujJlbUz3jyyQGqHd3+D4aOCQKRYc
         9619kygk4VXWnU1RFUPGzLULoJWfuyJyQx03xcejencQjPBuY7ITn4FJJ4yT/0grQoZj
         UFIyDVb4AVBiiEQxHgneWtD/iKTDjw1duE5E2TD1pb2ut86dpsKt2efkT0GWLdXK/v4A
         JLEpJ1FPpmTtTW/ZIWXtq77f0HHhyLBtUtwEVFTw0RxGEUKWoS69L7dpvQsG/SG1jyQR
         8tLHvviTW/nUNZO+ZlQZEtnqEYubASmS3RLs07rfa58HN2XMz3MySR47qJpLsg2wp+XV
         /G/A==
X-Gm-Message-State: ACrzQf1IYS3VwKL49m+jvDRn8NfeUNFVlAjxyWJshi9TFTK4H/D4yl1J
        EnblkDAbc55yZF26pb9eYIJ0qgjqC+LrwHfg
X-Google-Smtp-Source: AMsMyM7Wx5/UI6FS2JqhRm0p6vPtIWAigvpWhNZRGO6U1WSzPpiLFMra9bZwBdMasbpm8nPUzQeQCw==
X-Received: by 2002:a05:6638:12c5:b0:364:1291:3645 with SMTP id v5-20020a05663812c500b0036412913645mr11431341jas.316.1666319996681;
        Thu, 20 Oct 2022 19:39:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j20-20020a6bf914000000b006a25a193a7bsm4075251iog.20.2022.10.20.19.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 19:39:55 -0700 (PDT)
Date:   Thu, 20 Oct 2022 22:39:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, gitster@pobox.com
Subject: Re: [PATCH 4/7] shortlog: support arbitrary commit format `--group`s
Message-ID: <Y1IGeuudJj18sDPz@nand.local>
References: <cover.1665448437.git.me@ttaylorr.com>
 <6f38990cc2ea8460ce37437e0770784d9b712dab.1665448437.git.me@ttaylorr.com>
 <Y0TDDvzeCxIMFbG5@coredump.intra.peff.net>
 <Y0TF0M6UzLS9r6iM@nand.local>
 <Y0TOpVF+Y70YJHzx@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0TOpVF+Y70YJHzx@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2022 at 10:02:13PM -0400, Jeff King wrote:
> > >   - since the multiple-option behavior is so subtle, maybe show a case
> > >     where two formats partially overlap. A plausible one is "--group=%aN
> > >     --group=%cN", but the test setup might need tweaked to cover both.
> > >     There's an existing "multiple groups" test that might come in handy.
> >
> > Interesting. I was starting to write that test up, but then realized
> > that this will be covered by the end of the series, since the
> > `--group=trailer` machinery is reimplemented in terms of the new format
> > group.
>
> True, if we follow through on that. ;)

So, obviously we ended up not following through on that ;-).

I tried to leverage the existing test as much as possible, to the point
that the new test is pretty hacky. But I think that the result is cute,
and it does save us from having to modify the downstream tests (or
create unreachable commits, initialize another repository, etc).

It looks something like this:

--- 8< ---
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 0abe5354fc..566d581e1b 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -356,6 +356,19 @@ test_expect_success 'shortlog can match multiple groups' '
 	test_cmp expect actual
 '

+test_expect_success 'shortlog can match multiple format groups' '
+	cat >expect <<-\EOF &&
+	     2	User B <b@example.com>
+	     1	A U Thor <author@example.com>
+	     1	User A <a@example.com>
+	EOF
+	git shortlog -ns \
+		--group="%(trailers:valueonly,separator=%0x00,key=some-trailer)" \
+		--group="%(trailers:valueonly,separator=%0x00,key=another-trailer)" \
+		-2 HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'set up option selection tests' '
 	git commit --allow-empty -F - <<-\EOF
 	subject
--- >8 ---

The gross bit there really is the 'separator=%0x00' thing, since the
"trailers" pretty format gives us a NL character already. I suppose that
you could do something like this on top instead:

--- >8 ---
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 566d581e1b..13ac0bac64 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -363,9 +363,10 @@ test_expect_success 'shortlog can match multiple format groups' '
 	     1	User A <a@example.com>
 	EOF
 	git shortlog -ns \
-		--group="%(trailers:valueonly,separator=%0x00,key=some-trailer)" \
-		--group="%(trailers:valueonly,separator=%0x00,key=another-trailer)" \
-		-2 HEAD >actual &&
+		--group="%(trailers:valueonly,key=some-trailer)" \
+		--group="%(trailers:valueonly,key=another-trailer)" \
+		-2 HEAD >actual.raw &&
+	grep -v "^$" actual.raw >actual &&
 	test_cmp expect actual
 '
--- 8< ---

which I think I prefer slightly.

If this is all too hacky for your (or anybody's!) taste, let me know.
But I think ultimately this results in a smaller, more easily digestible
diff overall.

Thanks,
Taylor
