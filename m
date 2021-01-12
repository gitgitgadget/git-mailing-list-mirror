Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7C4C433E6
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 18:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F1A2225AC
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 18:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406187AbhALSld (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 13:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729952AbhALSlc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 13:41:32 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF3AC061786
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 10:40:52 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id l14so1379783qvh.2
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 10:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xv5ewCMrccvg/WqbrGWmeq15kVMadj1ZHkarNUQr/wo=;
        b=gkBbKhzwXJbFPa8H9cy9QsDbgGrtkGXynX2FU5SQGTS4P04JxW/2lxw1GW34Kzgcf5
         Spt0vq9Kntc8XWvpAyTxsm7MbJ8ERv51f3IW42wtcwrN5T6e5VZvZ+LVAqE/RrqojfwD
         TypCdsdv6ViZzmrhxVi9eJVFc+Re/VduSpDrJ6CACD+rR9D5CpI4BfCWozNPqo2VJrnS
         YYiV4I3EFfFBJ3WUF2sgB/aDx7aW7WnYsYQADuIGJPEEupjGfmjUjtIwZIegixWc7NUE
         qrxuij9skg2hzZUV/llDMCokalQV4NGvjbcUoRVweQPvXbk3VnIYAoudXJbG7POTaC+h
         gLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xv5ewCMrccvg/WqbrGWmeq15kVMadj1ZHkarNUQr/wo=;
        b=r8vtd2MvZ9/KYBqPYRTSShCE+p7gIPsSf1CaPt7F1BjkU8frYOVnzQJ79K8RNj8tyV
         hEhoZGA6HTm0S8KWuf2gPMguu/iuVuNtEQ8PrJ/rRDSFA+b7i5erAF/I7OXY/WJrbZsA
         VQOOnSVrG5y/XcTld+cdcvuafPv+59qwDOUnGgjURyNT+ZuDxPaOkpubVNNKdc+uaMb6
         /Fz82gt0mdHJUKvuzlr8lwQUXuhZokSd0u5oUkNvCFIxm7zZeUYLPDm0rM+4t3lOClLh
         llZvYlmNzk5kpQStjfzxqZ8/sJzTXZ6Un8Hk7KT54SQUoC81oPnyLWk+28WZFEMJGqfP
         6VBQ==
X-Gm-Message-State: AOAM5300NLv1uQd2xuLvuqmcJUmGF/m/QMcyUyXPI/+FXtPDKjLNSjlD
        D2IvN5J6hUnttrwSQ4tlCzRzNw==
X-Google-Smtp-Source: ABdhPJzcMHTi2J/t6t2xwRbIi3VgBG6gCLHFUoyNBZoMrTWDmPHVpVmv+Hr+MZ6zAYQuiCAQjqSvRA==
X-Received: by 2002:a05:6214:4c7:: with SMTP id ck7mr776998qvb.7.1610476851721;
        Tue, 12 Jan 2021 10:40:51 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f17c:3911:cace:ed91])
        by smtp.gmail.com with ESMTPSA id l204sm1785924qke.56.2021.01.12.10.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 10:40:51 -0800 (PST)
Date:   Tue, 12 Jan 2021 13:40:48 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com
Subject: Re: [PATCH 6/8] t: prepare for GIT_TEST_WRITE_REV_INDEX
Message-ID: <X/3tMHdgS7tmMduS@nand.local>
References: <cover.1610129989.git.me@ttaylorr.com>
 <2288571fbeb83d6bd98917f4788c3221aa973c81.1610129989.git.me@ttaylorr.com>
 <878s8y5bdn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878s8y5bdn.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,

Your suggestions are quite helpful, and I'm glad to apply them,
especially if it means that this "clean up" patch can actually harden us
from similar changes in the future.

On Tue, Jan 12, 2021 at 06:11:00PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
> On Fri, Jan 08 2021, Taylor Blau wrote:
>
> > For now, sprinkle these locations with a 'grep -v "\.rev$"' to ignore
> > them. Once the pack.writeReverseIndex option has been thoroughly
> > tested, we will default it to 'true', removing GIT_TEST_WRITE_REV_INDEX,
> > and making it possible to revert this patch.
>
> Maybe some of it we can change/revert, but some of it just seems to be
> test warts we can fix:
>
> > diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> > index 297de502a9..9696f88c2f 100755
> > --- a/t/t5319-multi-pack-index.sh
> > +++ b/t/t5319-multi-pack-index.sh
> > @@ -710,7 +710,7 @@ test_expect_success 'expire respects .keep files' '
> >  		PACKA=$(ls .git/objects/pack/a-pack*\.pack | sed s/\.pack\$//) &&
> >  		touch $PACKA.keep &&
> >  		git multi-pack-index expire &&
> > -		ls -S .git/objects/pack/a-pack* | grep $PACKA >a-pack-files &&
> > +		ls -S .git/objects/pack/a-pack* | grep $PACKA | grep -v "\.rev$" >a-pack-files &&
>
> This seems to be testing "a *.keep file made my pack not expire". Can't
> it just check for *.{pack,idx,keep} or even just *.pack?

Yeah, and I think the simplest thing to do here is just check that these
files exist at all. Something like:

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 9696f88c2f..f5e50508c9 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -710,7 +710,9 @@ test_expect_success 'expire respects .keep files' '
 		PACKA=$(ls .git/objects/pack/a-pack*\.pack | sed s/\.pack\$//) &&
 		touch $PACKA.keep &&
 		git multi-pack-index expire &&
-		ls -S .git/objects/pack/a-pack* | grep $PACKA | grep -v "\.rev$" >a-pack-files &&
+		test_is_file .git/objects/pack/pack-a-$PACKA.idx &&
+		test_is_file .git/objects/pack/pack-a-$PACKA.keep &&
+		test_is_file .git/objects/pack/pack-a-$PACKA.pack &&
 		test_line_count = 3 a-pack-files &&
 		test-tool read-midx .git/objects | grep idx >midx-list &&
 		test_line_count = 2 midx-list

> > diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
> > index 2f7be23044..d064426d03 100755
> > --- a/t/t5604-clone-reference.sh
> > +++ b/t/t5604-clone-reference.sh
> > @@ -318,7 +318,7 @@ test_expect_success SYMLINKS 'clone repo with symlinked or unknown files at obje
> >  		test_cmp T.objects T$option.objects &&
> >  		(
> >  			cd T$option/.git/objects &&
> > -			find . -type f | sort >../../../T$option.objects-files.raw &&
> > +			find . -type f | grep -v \.rev$ | sort >../../../T$option.objects-files.raw &&
> >  			find . -type l | sort >../../../T$option.objects-symlinks.raw
>
> There's an existing loop just below that where we grep out
> /commit-graph/, /multi-pack-index/ etc. whith other test modes add to
> the objects directory with sed. Seems like this belongs there, not in
> the find above it.

Much cleaner! Thank you.

> > diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> > index 7d5b17909b..9ebf045739 100755
> > --- a/t/t5702-protocol-v2.sh
> > +++ b/t/t5702-protocol-v2.sh
> > @@ -848,7 +848,7 @@ test_expect_success 'part of packfile response provided as URI' '
> >  	test -f h2found &&
> >
> >  	# Ensure that there are exactly 6 files (3 .pack and 3 .idx).
> > -	ls http_child/.git/objects/pack/* >filelist &&
> > +	ls http_child/.git/objects/pack/* | grep -v \.rev$ >filelist &&
> >  	test_line_count = 6 filelist
> >  '
>
> Maybe just check *.{pack,idx,keep}. I was looking at that code the other
> day and it's really just being overly specific. It really just cares
> about the *.pack files.

I think here and in t6500 as well as t9300 the easiest thing to do is
just

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 9ebf045739..73cd9e3ff6 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -848,8 +848,10 @@ test_expect_success 'part of packfile response provided as URI' '
 	test -f h2found &&

 	# Ensure that there are exactly 6 files (3 .pack and 3 .idx).
-	ls http_child/.git/objects/pack/* | grep -v \.rev$ >filelist &&
-	test_line_count = 6 filelist
+	ls http_child/.git/objects/pack/*.pack >packlist &&
+	ls http_child/.git/objects/pack/*.idx >idxlist &&
+	test_line_count = 3 idxlist &&
+	test_line_count = 3 packlist
 '

> > diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> > index 308c1ef42c..100df52a71 100755
> > --- a/t/t9300-fast-import.sh
> > +++ b/t/t9300-fast-import.sh
> > @@ -1629,7 +1629,7 @@ test_expect_success 'O: blank lines not necessary after other commands' '
> >  	INPUT_END
> >
> >  	git fast-import <input &&
> > -	test 8 = $(find .git/objects/pack -type f | grep -v multi-pack-index | wc -l) &&
> > +	test 8 = $(find .git/objects/pack -type f \( -name "*.idx" -o -name "*.pack" \) | wc -l) &&
>
> Yay, there the existing multi-pack-index case is amended in a
> future-proof way :)

Here's actually a spot where I'm unhappy with the resulting complexity,
and I think that it would be much cleaner if we did the same
packlist+idxlist thing and then checked the line count of each.

Thanks,
Taylor
