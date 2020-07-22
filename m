Return-Path: <SRS0=ybwr=BB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B24C433E0
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 20:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51DFA20771
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 20:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="PlC2at2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732698AbgGVUQi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 16:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgGVUQh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jul 2020 16:16:37 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A65C0619DC
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 13:16:37 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e12so2809782qtr.9
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 13:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ATG4BUyT5eb4h5Mkd+m9YJHwNKbuHHzVojB4Ygf02v8=;
        b=PlC2at2p8t3YVnmAyuYIGw636yIBz3ZynA3qavf3ZaXCdxyu0uH9Zv0HvDD6eBzSN1
         IQYekFsD2d87oTJhW3XquZtCTbSkJoEv6XH+XTfnA598CZfP58KvyRGx8Q/wkyCX5ARM
         aBT/XPbpjwPAZtSN5Oo4Crk6YGuN+KQZp+LN6iZRhUwDa63noLPkVPTKQnPD4ePiUmpR
         MaCPxeuVTnbPwNwkrqqtOgLOl6M0yikNjSHpBGtIadbmnrxLiyN2pTBnafQEBoEqNF3n
         KnlDt6a7NOXZbcjrQEIOI85v8jucuBgh6785a9JGHo83BThUWXNuMcPneFkGEENXA9ji
         aABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ATG4BUyT5eb4h5Mkd+m9YJHwNKbuHHzVojB4Ygf02v8=;
        b=OpVgrMblI0L8BM4T7mBdxmfuU189n5Lv7AAzeOFjIMr80d78ZIZLDl1+fkY/xmBxuw
         HQEbODt8DSWxmcpxwUzhMewCZjfJcEMfn+zaKq3TQwuO5yy/pAPhGOiQOHj1VtH2vQ4t
         zkgbcPJVGFDmw6Z2QOP2elDRW1gDNVnNE469W+0+zXzmUAK+A64gblCPRbOmaJJmNmf+
         0d7fKyEM/12Af0HKiSsUScAH508Cm9xlEgwOMGEDovM+95gKB+F1Z4lEUNvFBhr8AnQN
         eh6uIDpbbluKRE3Nr7Kmxg3VbJjxaN37QPXbyjSGq7ZNVCvz2W6Lz/8n/MCMepquFscy
         mZ1A==
X-Gm-Message-State: AOAM532u93v9k3A34EpoqFHN+1KxTD9h0aFi08uU3eJ7/pzXDE/JULf3
        RAD9rlhH3moannRYYqy6kutyGA==
X-Google-Smtp-Source: ABdhPJxjrW/GR2MxW4zqLOIxcTTrBdk7mSUrA+Yg4VgA3n7/3c/4WmFfXb4f1BJFajiFJSJpB5ubig==
X-Received: by 2002:aed:208c:: with SMTP id 12mr1128384qtb.286.1595448996703;
        Wed, 22 Jul 2020 13:16:36 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:351c:83f3:acec:de38])
        by smtp.gmail.com with ESMTPSA id h81sm816707qke.76.2020.07.22.13.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 13:16:36 -0700 (PDT)
Date:   Wed, 22 Jul 2020 16:16:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        chriscool@tuxfamily.org
Subject: Re: [PATCH 2/4] upload-pack.c: allow banning certain object filter(s)
Message-ID: <20200722201634.GB59352@syl.lan>
References: <cover.1593720075.git.me@ttaylorr.com>
 <f0982d24e74155f6c0e405e5e3ae8c3e579f798a.1593720075.git.me@ttaylorr.com>
 <20200722092129.GK11341@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200722092129.GK11341@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 22, 2020 at 11:21:29AM +0200, SZEDER Gábor wrote:
> On Thu, Jul 02, 2020 at 04:06:32PM -0400, Taylor Blau wrote:
> > +static void die_if_using_banned_filter(struct upload_pack_data *data)
> > +{
> > +	struct list_objects_filter_options *banned = banned_filter(data,
> > +								   &data->filter_options);
> > +	if (!banned)
> > +		return;
> > +
> > +	packet_writer_error(&data->writer, _("filter '%s' not supported\n"),
>
> Should we really translate the content of the ERR packet?

s/ERR packet/dying message after your other piece of advice, but I think
so. This is eventually going to make its way to users, so translating it
seems to make sense to me.

I guess they would get it in the localization of the server, not the
client, but that doesn't sway me away from this, either.

> > +			    list_object_filter_config_name(banned->choice));
> > +	die(_("git upload-pack: banned object filter requested"));
> > +}
> > +
> >  static void receive_needs(struct upload_pack_data *data,
> >  			  struct packet_reader *reader)
> >  {

Thanks,
Taylor
