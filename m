Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D046C433ED
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 14:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6857610E9
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 14:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbhDKOWe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 10:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbhDKOWd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 10:22:33 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B930C061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 07:22:16 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1618150935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S8xeHzs/V3eBKU8VeKKMikyPJbXeRh76kv0WkLtwL9s=;
        b=SR2lZkhQ8IgmGzU+Z54+IhF3TA3fPNUum4Nef3M0ngvJ2UcZZNLImlbo+VihYlBCyLejHB
        NmG34uTThDhAp0VF297aAttQpdTTvMoEx3lFu+mKnCkGlW31SMowdxiZBeuLeCgyD1zoD6
        ToC3IwuNNJWwhFfMgMfeZjTftlJGzNuVPabK98xUn4Ipm1ORKcu3YO4B9sLUcOb3X+sAQt
        N0zbLfxgIrWZVDOZpO4eqXHeJp6bka0BcddbT1n9vC0Nvpi4DBf+hpNdzREk8N8zPGng/K
        ZpxIjsZCbaor7sHh6WxWZw4acaV7GOFdFwpa3DKavPq7IVWtktBXnmgbL8uFNA==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Apr 2021 10:22:14 -0400
Message-Id: <CAKYMSVQ9ZM9.32H3OS6V9CLK9@taiga>
Subject: Re: [PATCH v2 3/3] git-send-email: rename 'tls' to 'starttls'
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Drew DeVault" <sir@cmpwn.com>
To:     =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Cc:     <git@vger.kernel.org>
References: <20210411125431.28971-1-sir@cmpwn.com>
 <20210411125431.28971-4-sir@cmpwn.com> <87eefggb2q.fsf@evledraar.gmail.com>
In-Reply-To: <87eefggb2q.fsf@evledraar.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun Apr 11, 2021 at 10:17 AM EDT, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 wrote:
> >  # 'default' encryption is none -- this only prevents a warning
> >  $smtp_encryption =3D '' unless (defined $smtp_encryption);
> > -if ($smtp_encryption ne "" && $smtp_encryption ne "ssl" && $smtp_encry=
ption ne "tls") {
> > -	die __("Invalid smtp_encryption configuration: expected 'ssl', 'tls',=
 or nothing.\n");
> > +if ($smtp_encryption eq "tls") {
> > +	# "tls" is an alias for starttls for legacy reasons
> > +	$smtp_encryption =3D "starttls";
> > +};
>
> Needless trailing ";".
>
> This and the preceding patch would be more readable if it was
> re-arranged in some way as to not rewrite the newly introduced lines
> between 2 and 3, maybe:
>
> {
> my $tls_name =3D "tls";
> if (....)
> }

I disagree that this would be an improvement. It would make the patches
a bit more readlable on their own, but the resulting code would
introduce this bizzare variable which doesn't make sense out of context.
