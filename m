Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233B2C433DF
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 09:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F26EE2075E
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 09:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jL0qekJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgHZJqL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbgHZJqK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 05:46:10 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EA6C061574
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 02:46:10 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 17so690483pfw.9
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 02:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=JKM5/lhkEgevGRLiIxot/BsDa3JfHN5VbHm7nAN/Fcs=;
        b=jL0qekJvJ0pVx5x2R15t5zqQP+P+7sQasPZuzsR+G7SaNxBDHpdFkNOxNrX5BtA1ac
         NZ6+FaTyZhRYdhPHL2QmAWEGFgoOUdiIbuFAXgbk97RPdLDF2+MeRCVkaR0M0bqwfIVt
         r0D6JURs0Rk2FbctOHbD7131o4YG9lF9AJG26afsEI2Kf+hSOGI40hPCrXKYjfIC53+S
         N+52+rH/XZ+lxPT5QV5u5IuWXEqHPHugcQqHyYb0cHYr3I7gxM4o3g2RTcH9DUOsqaDk
         8Dw8Sqf1jb5kalXRhSOv34SnN5AKiGrjZ2we5xR6zD8WuIN/uUc6evb6EzlolK9/5+G8
         lOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=JKM5/lhkEgevGRLiIxot/BsDa3JfHN5VbHm7nAN/Fcs=;
        b=LSnwg9+LkUn8QSdsq78cw+poU13bMpYsK6Z5MpmRCKdQaJF93Hr2w1OrcmTjTBsdPL
         bAarTkkidi8f68RQOfBQLhoU7va5uT61lbarU69OiDGu6x0y0YYFWl8nTTtofXKrEvT6
         ygleHgHfQhSxSilPMep1OFQDgi+3fBVCrMnIdmSrQdmhkjTo1bLAlgzUamM9+AeecQiY
         zDgI8/ORcSPIXsfWED19vFiF6WvsKWG2B1wLwDsL3YsU3+y/9hO0qrWEcdHK2tmdd7Kn
         xVeeXB+SRJ3/e5wNHgxnu7INZ2IiWOYVYDktX0yDDNAbrDhMAo4sIhoFyVs/u2DsT2vi
         MWTw==
X-Gm-Message-State: AOAM530RnpBDKtonNUM7Om1t0DfJBMK9wS5gOo30hwJ0N6N6dbqT32Q2
        yEOGeadkJg72+KFUZvYspKI=
X-Google-Smtp-Source: ABdhPJwZxvHQlWNpdi0jvtM0Df/LnKtPgggQ+SgFa2x2x/bTDtijWQ5iFpI2t1ekmGVYFd95DugtrQ==
X-Received: by 2002:a63:fa44:: with SMTP id g4mr10255822pgk.406.1598435168836;
        Wed, 26 Aug 2020 02:46:08 -0700 (PDT)
Received: from konoha ([106.210.38.198])
        by smtp.gmail.com with ESMTPSA id p9sm1778605pjm.1.2020.08.26.02.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 02:46:07 -0700 (PDT)
Date:   Wed, 26 Aug 2020 15:15:27 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     gitster@pobox.com
Cc:     Johannes.Schindelin@gmx.de, chriscool@tuxfamily.org,
        christian.couder@gmail.com, git@vger.kernel.org,
        kaartic.sivaraam@gmail.com, liu.denton@gmail.com, peff@peff.net,
        shouryashukla.oo@gmail.com
Subject: Re: [PATCH 2/3] submodule: fix style in function definition
Message-ID: <20200826094506.GA311769@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwo1mzc6y.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> The definitions of 'verify_submodule_committish()' and
>> 'print_submodule_summary()' had wrong styling in terms of the asterisk
>> placement. Amend them.

> I pointed out only these two, but that does not necessarily mean
> they are the only ones.  Have you checked all the new code added by
> the series?

There is one more. It is not related to my patch series though. Here it
is:
----
static char *compute_rev_name(const char *sub_path, const char* object_id)
----
Would you like me to correct this one too?

>> Also, the warning printed in case of an unexpected file mode printed the
>> mode in decimal. Print it in octal for enhanced readability.

>I actually did check this side ;-) and am reasonably sure that there
>aren't any other irrational choice of format specifiers.

Sure! No worries!

