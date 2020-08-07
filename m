Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE71AC433DF
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 16:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A682020748
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 16:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwTqymLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgHGQbq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 12:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgHGQbn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 12:31:43 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79ABC061756
        for <git@vger.kernel.org>; Fri,  7 Aug 2020 09:31:43 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id l60so1134316pjb.3
        for <git@vger.kernel.org>; Fri, 07 Aug 2020 09:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mKnXtYBnyVNPBzE9oOh0XhM3oJ+J8nK+2ZHcOsqA0dg=;
        b=BwTqymLSHQVDkl1ZyN0XLHg5Fivmlf58rWL0S/2taIrlTmHoPaGiuqp8hB70vkal9c
         LtDmENA0IHIZ2dNLRB7OEX3ek5iK67XO+AX4NBnVseKR9a+dBEfXvuOTfQ+5vEabSsnH
         HcrlMMZlRDPgChMlx0+e8D86nSChxAdGcf1EY+5GyB/1d3a2PwoBjT9tfOowRi5LPq+V
         XqFO/cF6k76fxYx9gq8GsnHGauJ2f8/sryBZA28fI0lThE0ihmQ2q9Zzjisiv7Fpt6oH
         xScfy6o0g2a7eR93+NzfEXDLRfgepfxYUNxCwc8gzUO/Qy91qRbDelwWKYcnV3Rbi0Ow
         16xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mKnXtYBnyVNPBzE9oOh0XhM3oJ+J8nK+2ZHcOsqA0dg=;
        b=DsEv42dVWX+CnOvE12WFcvLnNukBQfuwQ6sbRO1qB4QdAOaxiZh/8ymwssM6Y6yUYo
         kwa5yPeb37jnsCwXHzsx9gyLjX9i3I5duUZksoeWsCtCxpjSEi86XyWNMGdfVjTNmIuf
         AJhvarmi9ySUvRF1Rhv5YhiMJ55bpoXEDFV4b7iSwiyT/M2qnd1PmRZlL8Lx4ELOM0sT
         iO07Xv34X9q4iBsdZj+NlmS409ph7IRRWwoN8TKuAjNh7c9ishQjt3qaPplNMVA18lT8
         a/IkOZzVTVAcaMeU1+IBNblPUt4hMnF+t/Cs9Yf+ptVgW7cES8dQH7D71nXt6S5cDNiU
         MYmQ==
X-Gm-Message-State: AOAM533Tmwd0LGjF2Ur2OADAxASwDBRRdMzje6Eqb+M9WA4qTlLElGqN
        pJQqmTsEHgPNBPNfwORoXRrF6WrrZ5A=
X-Google-Smtp-Source: ABdhPJz4v6RXiAzawPlPuNzsfMrqwhszQHHNO2sJXpu6MYyeSiRG/u/UBU+m+icwBm4oPR9zrEQhig==
X-Received: by 2002:a17:902:d902:: with SMTP id c2mr12887783plz.71.1596817903173;
        Fri, 07 Aug 2020 09:31:43 -0700 (PDT)
Received: from konoha ([45.127.46.143])
        by smtp.gmail.com with ESMTPSA id c27sm11092480pgn.86.2020.08.07.09.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 09:31:42 -0700 (PDT)
Date:   Fri, 7 Aug 2020 22:01:35 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, johannes.schindelin@gmx.de,
        liu.denton@gmail.com, pc44800@gmail.com, chriscool@tuxfamily.org,
        stefanbeller@gmail.com
Subject: Re: [PATCH v2 5/5] submodule: port submodule subcommand 'summary'
 from shell to C
Message-ID: <20200807163135.GA12568@konoha>
References: <20200806164102.6707-1-shouryashukla.oo@gmail.com>
 <20200806164102.6707-6-shouryashukla.oo@gmail.com>
 <xmqq5z9vjsvz.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5z9vjsvz.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/08 03:45, Junio C Hamano wrote:
> Shourya Shukla <shouryashukla.oo@gmail.com> writes:
> 
> > ...
> 
> > +			argv_array_pushl(&cp_log.args, "--pretty=  %m %s",
> > +					 "--first-parent", NULL);
> > +			argv_array_pushf(&cp_log.args, "%s...%s",
> > +					 src_abbrev,
> > +					 dst_abbrev);
> 
> > ...
> 
> > +	diff_args.argc = setup_revisions(diff_args.argc, diff_args.argv,
> > +					 &rev, NULL);
> 
> Peff's jk/strvec topic will soon be in 'master', and basing the
> series on top of 'master' after that happens would make these lines
> to read like
> 
> 			strvec_pushl(&cp_log.args, "--pretty=  %m %s",
> 				     "--first-parent", NULL);
> 			strvec_pushf(&cp_log.args, "%s...%s",
> 				     src_abbrev,
> 				     dst_abbrev);
> 
> 	diff_args.nr = setup_revisions(diff_args.nr, diff_args.v,
> 				       &rev, NULL);
> 
> We may even be able to reduce line wrapping thanks to shortening a
> few common words:
> 
>     argv_array => strvec
>     argc       => nc
>     argv       => v
> 
> For today's integration, I dealt with these as conflict resolution,
> so let's keep review discussion going, and hope jk/strvec is in
> 'master' by the time this topic becomes ready.

Understood. I will base this patch on the above series. Seems like a
great series of  great change! BTW, I asked a couple of things in the
cover-letter which I think you might have missed. Quoting them here:
-----8<-----
Also, I want to ask a couple of things:

	1.Whether we can suppress the error message that we get when
	  trying to find the summary of non-existent submodules?
	  For example:

	  fatal: exec 'rev-parse': cd to 'my-subm' failed: No such file or directory
	   * my-subm 35b40f1...0000000:

	 Will it be OK to suppress the above error message?

	2.Is it fine to document and expose the 'for-status' option in
	  'git-submodule.txt'?
----->8-----

Regards,
Shourya Shukla
