Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0EAC433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 14:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B10B610E9
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 14:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbhDKOV4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 10:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbhDKOVy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 10:21:54 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A4DC061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 07:21:38 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1618150895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7MDzoU6DFiHay2ajVFAdWBOewrgtVMFeUar8YuHp398=;
        b=HC61UPe/AjydlBkA5KFat/JFP+Q7HKme4J/ViJWEFOUOXIrxvHDobUB6cmFYh7TllBJbP+
        c4eX5ojeSpqxYP8UsALYtloJX97CYy4gfe/DRa6UhXHupMJouGJg/BmSkakZPxJ419hK8n
        OxhR72DA6Cv/PDN/tvMVXR/kaiEo4icQL+Q+QZzBgE0r93qmbw5jEFs3bGTNIQ5ZApB+xc
        Dl7NyzMcPu9T5qYPt81RPsAQRqTE7zZgELOfmpbFlR1gyi+hkSzqwn4ws6WzV/i2pmaE36
        gOLsTI1h0+2A1uvflsx37xrubW2DQy3kNuOEP95atFptfkWSRoS/ZoIc6myUWA==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Apr 2021 10:21:34 -0400
Message-Id: <CAKYMAEJQOA3.25YK6UYSYFHXQ@taiga>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] git-send-email: die on invalid smtp_encryption
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Drew DeVault" <sir@cmpwn.com>
To:     =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
References: <20210411125431.28971-1-sir@cmpwn.com>
 <20210411125431.28971-3-sir@cmpwn.com> <87blakgaxr.fsf@evledraar.gmail.com>
In-Reply-To: <87blakgaxr.fsf@evledraar.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun Apr 11, 2021 at 10:20 AM EDT, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 wrote:
> >  # 'default' encryption is none -- this only prevents a warning
> >  $smtp_encryption =3D '' unless (defined $smtp_encryption);
> > +if ($smtp_encryption ne "" && $smtp_encryption ne "ssl" && $smtp_encry=
ption ne "tls") {
> > +	die __("Invalid smtp_encryption configuration: expected 'ssl', 'tls',=
 or nothing.\n");
> > +}
>
> Having not tested this but just eyeballed the code, I'm fairly sure
> you're adding a logic error here, or is $smtp_encryption guaranteed to
> be defined at this point?

I will admit to being ignorant of much of Perl's semantics, but I had
assumed that the line prior to my additions addresses this:

$smtp_encryption =3D '' unless (defined $smtp_encryption);

> $smtp_encryption !~ /^(?:|ssl|tls)$/s

Yeah, that would probably be better.
