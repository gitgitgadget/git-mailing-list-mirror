Return-Path: <SRS0=AD9v=6R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A2BC28CBC
	for <git@archiver.kernel.org>; Sun,  3 May 2020 23:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63F8F206E9
	for <git@archiver.kernel.org>; Sun,  3 May 2020 23:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSvkOXtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgECXsh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 May 2020 19:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726181AbgECXsh (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 3 May 2020 19:48:37 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82048C061A0E
        for <git@vger.kernel.org>; Sun,  3 May 2020 16:48:37 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mq3so2977488pjb.1
        for <git@vger.kernel.org>; Sun, 03 May 2020 16:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SbQDSbmAbVERJFmOT7ZwlNove1BIFctW9IUGXb/cOw0=;
        b=BSvkOXtEyesoxi6rShDxZEtBTQEpV6vagH19KyQRIuO0dJMsaOYeI/bZ30OI9jfKdM
         iT1Wupj79UBBCmfwy5AeWrkbz8JwjQgMGkOv/iwzBymuGNtqfoxY/hl8KxvPbR2ugpBQ
         9JZntS4IGqsyLxQnpOqZlxDRoPOd5ZCPJUFE2lsrEZnAhwrZ7DBdvIEkuNyVAa1Lvc3L
         7FSBNkHTIAJs+pKZy7CQfAEJgW2DpOWLpEtwg9GXcSecrplbHQJ16WqjCS9tOpDvWvwh
         3grm+Lxxegp2MNy+RQmhEVw2hlw11pJKkhYB5L2NmlysDF5ZTK7qegVTNjQgl7KyG/OG
         lsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SbQDSbmAbVERJFmOT7ZwlNove1BIFctW9IUGXb/cOw0=;
        b=Oer/8d/uBboqV0YzuBLSuuBHo6E5uCPUKWRUW3Km97UJO9PgzfZ7Mo6H4bJ/6F4eMn
         /Pzl8kWEtequsi3+VzDbAJwzJbvcEcEIEEBpxE3qumeWX9gB5dseCO1JooisWEtgO2Kk
         qPP81MVzbe89TSji5mTsnQaEwACgRD/aYIzppbJdY7MfPQ9a36fmlu+dTvPS5GqiualS
         y03Ub5nye3vfKDDdZiVB+RP2rixbLL7JZNKxARls9MWmc9h6E6vLvJQZVBHNd8I1PLIv
         ZNsuFNuHSyyLNtnAgJYfP6pU4sn3iFMrWQpbk7cZ/9+w1zDwQX/Wq2XMICsuHJ2bNXbf
         6xig==
X-Gm-Message-State: AGi0PuYNxAAwO8qLjbe1aiW4z8c853PoIfl0FY0+dZ6t1EtMRWFBVQvR
        NnwC3hGBmAW0/DPkyEwCJ+0=
X-Google-Smtp-Source: APiQypJTnRghj8j9HJvIuiefZxT7vk5GmGT/KvRE5B+whKKNV7P1gokFk1uyUK+3qrlAad8vKcpPNQ==
X-Received: by 2002:a17:90a:d153:: with SMTP id t19mr14072201pjw.42.1588549716745;
        Sun, 03 May 2020 16:48:36 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id z7sm7118750pff.47.2020.05.03.16.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 16:48:36 -0700 (PDT)
Date:   Sun, 3 May 2020 16:48:34 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Leonardo Bras <leobras.c@gmail.com>, git@vger.kernel.org,
        Jan Viktorin <viktorin@rehivetech.com>,
        Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCH] send-email: Defines smtpPassCmd config option
Message-ID: <20200503234834.GA86805@Carlos-MBP>
References: <20200501105131.297457-1-leobras.c@gmail.com>
 <20200501125308.GE33264@Carlos-MBP>
 <xmqqees3odrb.fsf@gitster.c.googlers.com>
 <20200501222723.GF41612@syl.local>
 <20200501235948.GD6530@camp.crustytoothpaste.net>
 <20200503094348.GE170902@coredump.intra.peff.net>
 <20200503162757.GE6530@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200503162757.GE6530@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 03, 2020 at 04:27:57PM +0000, brian m. carlson wrote:
> On 2020-05-03 at 09:43:48, Jeff King wrote:
> > On Fri, May 01, 2020 at 11:59:48PM +0000, brian m. carlson wrote:
> > 
> > > I think perhaps many folks aren't aware that you can invoke Git with an
> > > arbitrary shell command as "credential.helper", which of course makes
> > > life a lot easier.  So if you want to invoke a separate command, it's
> > > really as easy as this:
> > > 
> > >   git config credential.smtp://smtp.crustytoothpaste.net.helper \
> > >     '!f() { echo username=my-username; echo "password=$(my-password-command)"; }; f'
> > > 
> > > So I think that documenting the use of the credential helper is step 1,
> > > because probably most people _do_ want to use that for their passwords,
> > > and then documenting that credential helpers can be arbitrary shell
> > > commands that speak the protocol is step 2, so that people who don't can
> > > figure out a way to do what they want.
> > > 
> > > I'll send some patches later which document the latter feature, since I
> > > don't think we mention it anywhere outside of the FAQ.  I actually
> > > didn't know about it until Peff mentioned it to me one time.
> > 
> > This is documented, but only recently did it make it out of
> > Documentation/technical/ and into gitcredentials(7). I don't mind adding
> > more pointers, though.
> 
> Ah, yes, I remembered that series, but forgot that it introduced
> documentation for that.

if we are going to mention an example or a credential helper specially
tailored to smtp, then the recently reintroduced syntax by Dscho in
9a121b0d22 (credential: handle `credential.<partial-URL>.<key>` again,
2020-04-24), might come up handy IMHO.

Carlo
