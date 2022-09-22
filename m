Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9918ECAAD8
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 04:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiIVEAf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 00:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiIVEAe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 00:00:34 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD7DAB074
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 21:00:32 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id g8so6810997iob.0
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 21:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=5hX1BqxFsb6I/bnd/S6IsK5O30YyW65VhwRAnDgn6M0=;
        b=fw5ZgPvOQD0OXiGGm8l5C+D5J0PgVnscUS/oQeGy6zf5ALoUWZXQ9HTQpa3Azjpmjr
         RR7qCnlnqWT4LyOMxvSw0Iu8D0XFpVQTM5XkdqodtZ0PgqRixyAS0Zhk3w9QtO6s1YBD
         6GGEWI1Nq9UdTJu+xdRf6/BbAChun84pJ0LPOMicR7q3A8b8a+B/rDDmBgzZfQlvIEUd
         e0DOvEH6PqxChFvV21rZixV1uaYpMpz+yPEJ+p1lhnGlxqLrElsNuq18pghBHlvmtSyE
         Zdihqt5LILAffyG/oS8KZZL84ZlH95LWTHZ5EwymS5lpVb/u4mciNIZhrdIEFFXKzpOJ
         XVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=5hX1BqxFsb6I/bnd/S6IsK5O30YyW65VhwRAnDgn6M0=;
        b=PEfYYPa09XM3AOfmiTGlB6aKQEhuGfGV68BDLTgjnUVtLekFo9tVDY1yb36GEZiuNG
         BTwvOBv4WnHXp107JBqQ7lnaIFh03d7KprTC+FXYF/OdDObrqDHMs9Ya75jHHad1cr14
         sU8lYRkk0N/yscTSkgrZGgQaX6Hg1c1CwsgE/f5omjDbSlXo8UREU5M2L2veRFOAvAu8
         3Y5wx52QtFCxO3jGVbPelYUfP4DKLsXbQaD+PFo3Y0AXUkvUrF6yoniPG9/TLOQXMrgG
         GXaTXzppiK7DyEk8p6yPXLeW3BiYHQM0Rqm03U8TfDHfbFVmgElYGFkgbfg0vlSiJYVi
         tqJw==
X-Gm-Message-State: ACrzQf0cvrVHtFdoBHpN3/slYmZo3RNCDNzlnbB22PzvvzP6SkVx3UC3
        XWa0Pnh4l7/TT1GA0xEXm3AmTYiVH1k=
X-Google-Smtp-Source: AMsMyM4VIQlypSrMnx0HNONJAWnBjWK8f/RQORaahpMXDFzEiFfEaMb+idlAvuoxC5ByyWgAYqthfg==
X-Received: by 2002:a05:6638:430c:b0:35a:1c37:a343 with SMTP id bt12-20020a056638430c00b0035a1c37a343mr814958jab.183.1663819231524;
        Wed, 21 Sep 2022 21:00:31 -0700 (PDT)
Received: from gmail.com (207-237-203-247.s3058.c3-0.arm-cbr1.chi-arm.il.cable.rcncustomer.com. [207.237.203.247])
        by smtp.gmail.com with ESMTPSA id f31-20020a0284a2000000b0035a78b02838sm1694931jai.132.2022.09.21.21.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 21:00:31 -0700 (PDT)
Date:   Wed, 21 Sep 2022 23:00:01 -0500
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Erik Cervin Edin <erik@cervined.in>, git@vger.kernel.org
Subject: Re: [PATCH v2] sequencer: avoid dropping fixup commit that targets
 self via commit-ish
Message-ID: <YyvdwbE6oCeNn035@gmail.com>
References: <xmqqleqfcoz3.fsf@gitster.g>
 <20220920031140.1220220-1-aclopte@gmail.com>
 <xmqqa66s36pt.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa66s36pt.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 21, 2022 at 11:47:26AM -0700, Junio C Hamano wrote:
> Johannes Altmanninger <aclopte@gmail.com> writes:
> 
> > +test_expect_success 'auto squash that matches regex' '
> > +	git reset --hard base &&
> > +	git commit --allow-empty -m "hay needle hay" &&
> > +	git commit --allow-empty -m "fixup! :/needle" &&
> > +	GIT_SEQUENCE_EDITOR="cat >tmp" git rebase --autosquash -i HEAD^^ &&
> > +	sed -ne "/^[^#]/{s/[0-9a-f]\{7,\}/HASH/g;p;}" tmp >actual &&
> > +	cat <<-EOF >expect &&
> > +	pick HASH hay needle hay # empty
> > +	fixup HASH fixup! :/needle # empty
> > +	EOF
> > +	test_cmp expect actual
> > +'
> 
> hint: Waiting for your editor to close the file...
> Successfully rebased and updated refs/heads/main.
> --- expect      2022-09-21 18:45:27.617530848 +0000
> +++ actual      2022-09-21 18:45:27.613530478 +0000
> @@ -1,2 +1,2 @@
>  pick HASH hay needle hay # empty
> -fixup HASH fixup! :/needle # empty
> +pick HASH fixup! :/needle # empty
> not ok 11 - auto squash that matches regex
> 
> That does not look very good X-<.

Sorry the v2 of this test case is very misleading, should probably drop this
test entirely.  It's been a long a day so I'll send v3 another day (if needed).
