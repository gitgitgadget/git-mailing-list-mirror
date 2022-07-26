Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51581C04A68
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 13:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239138AbiGZN7S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 09:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239212AbiGZN7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 09:59:16 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A66BF53
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 06:59:15 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t3-20020a17090a3b4300b001f21eb7e8b0so16795673pjf.1
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 06:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tVn8Gvxh2/Mk0E0/TumGhvzTUpc1I8TYTQwXhIZLpC4=;
        b=fyTOmSJUx1FwS12mNWW6+pW7CB4vQXjtPcXzgYbyJxnRuGr/nRmjHvvc3fJ+aGr2Hi
         XYhUrLg2EWydbQjigks0SfabnrOg7tIbe54WEzEgl4bNuRt1vEVj9hfMbWSsiq041Jjb
         WDGLU1z5JG2wi4VSBHtDAEFTU2CjbkTNvuUoBsCfC066u+l7EHWKosOoB+ZrJXrYZnOR
         zfMFiv/62q8A/2DWn1eQ6zfbNEIv2cyFVbkwbmbqRpjI+CNhZyo226N3D0iZAaqGL4Yc
         n7Qa9nx/12nMSkGpa3SYS4zMj0D/QxkkoB3gSuGJlfEAANiva+We/gR5Se4FzTgcQsEU
         InJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tVn8Gvxh2/Mk0E0/TumGhvzTUpc1I8TYTQwXhIZLpC4=;
        b=6su1dkI/md7hifTFnrJQOJ+ot2n4GYTJQvhNfCQvGxCPAuG/oUvT3vGZTPaTHtPHmP
         4ngiScY6fugySvnYQq8vVXElozrRmyu5bXwWRVnnOrO0NMU1Ot1f5HUVt/lnGmOfOw3J
         69bRLyFLBLf2wgP287ZFyW1ccmUveFv5sIHlK+/R8sGHKMdcoZtT5gM7nCjUQnBTlmnD
         TjYUZj+tAkUcxYfLJHbXaGDouw4C49A9iNT+WDX7uA/6k0qJmT9XPuAu2so7azaJcive
         RlF2+iN6ovG1WyyoURdJ7QhA2uDQsS4JT//LqvRSNElKO16AfFGNR3LDluD92H3mI/hx
         zOHw==
X-Gm-Message-State: AJIora/jJP1Mix6hXrWo9I84RCv01ZesE//BFGCs1rVyMv2nHzGgTehm
        xu/J3Vu4S6bLufMgHTMQSt4=
X-Google-Smtp-Source: AGRyM1tvctJQkUpp24rpsL/VD3goJQ19LhT9MDSotKfM8qpEhY/phfwaPc/zlK3BEkxfuyPepXUo9A==
X-Received: by 2002:a17:90b:38c4:b0:1f2:c238:37fc with SMTP id nn4-20020a17090b38c400b001f2c23837fcmr9151448pjb.166.1658843954766;
        Tue, 26 Jul 2022 06:59:14 -0700 (PDT)
Received: from jrouhaud (2001-b011-1006-9ae2-bc69-b20c-442f-a7da.dynamic-ip6.hinet.net. [2001:b011:1006:9ae2:bc69:b20c:442f:a7da])
        by smtp.gmail.com with ESMTPSA id 202-20020a6302d3000000b003db7de758besm10389115pgc.5.2022.07.26.06.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 06:59:14 -0700 (PDT)
Date:   Tue, 26 Jul 2022 21:59:11 +0800
From:   Julien Rouhaud <rjuju123@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] gitweb: improve title shortening heuristics
Message-ID: <20220726135911.ycvgwbkixb3ei6w3@jrouhaud>
References: <20220724061231.jddhqns7bqx5c2xm@jrouhaud>
 <xmqqfsiq6ksb.fsf@gitster.g>
 <20220725020534.x33hso22ab2dwyo7@jrouhaud>
 <220725.86czdtrayy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220725.86czdtrayy.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Jul 25, 2022 at 07:54:34AM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> Please "inline" your patches, see "Sending your patches" in
> Documentation/SubmittingPatches (I.e. send it with git-send-email, or
> similar). I see this as:
>
> > [2. text/plain; v2-0001-gitweb-Remove-title_short-shortening-heuristics.patch]...

Ah I'm sorry about that.  For the archives sake (and to make sure that I
correctly configured my MUA), I'm reattaching the v2 inline.

> This looks good to me, The one thing I'd add is that we're just running:
>
> 	 git rev-list --parents --header  --max-count=1 HEAD
>
> And parsing that, but if we're truncating things perhaps we should just
> run "git log" or "git show" with the "%<(<N>[,trunc|ltrunc|mtrunc])"
> syntax or similar.
>
> That's obviously a follow-up, but if anyone's interested in deleting
> even more code here...

Note that I didn't try to do anything about that.  I have the feeling that
gitweb isn't wildly used nowadays, especially for bigger projects, so it didn't
seems worth spending too much efforts.

From ea4f31c0a2276f042322a11e258e55223863cd35 Mon Sep 17 00:00:00 2001
From: Julien Rouhaud <julien.rouhaud@free.fr>
Date: Sun, 24 Jul 2022 13:17:19 +0800
Subject: [PATCH v2] gitweb: Remove title_short shortening heuristics

Those heuristics are way outdated and too general to be useful outside of
kernel.org.  Since kernel.org doesn't use gitweb anymore and at least one
project complained about incorrect behavior, entirely remove them.

Signed-off-by: Julien Rouhaud <julien.rouhaud@free.fr>
---

Notes:
    Patch re-submitted inline rather than in attachment, sorry about the
    previous attachments.

 gitweb/gitweb.perl | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1835487ab2..e66eb3d9ba 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3560,23 +3560,6 @@ sub parse_commit_text {
 		$title =~ s/^    //;
 		if ($title ne "") {
 			$co{'title'} = chop_str($title, 80, 5);
-			# remove leading stuff of merges to make the interesting part visible
-			if (length($title) > 50) {
-				$title =~ s/^Automatic //;
-				$title =~ s/^merge (of|with) /Merge ... /i;
-				if (length($title) > 50) {
-					$title =~ s/(http|rsync):\/\///;
-				}
-				if (length($title) > 50) {
-					$title =~ s/(master|www|rsync)\.//;
-				}
-				if (length($title) > 50) {
-					$title =~ s/kernel.org:?//;
-				}
-				if (length($title) > 50) {
-					$title =~ s/\/pub\/scm//;
-				}
-			}
 			$co{'title_short'} = chop_str($title, 50, 5);
 			last;
 		}
--
2.37.0
