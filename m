Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E866C433E0
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 07:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 753BC206C1
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 07:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ct/xXch/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgGWHvt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 03:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgGWHvs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 03:51:48 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44C9C0619DC
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 00:51:48 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j18so4066038wmi.3
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 00:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/978xhjl7ItTbjRzuqAy/2dR7HokmCQIlQchAszLJG8=;
        b=ct/xXch/SaSu7INpTUYeYKa4/eAZy1yrcrHnqTWlfEfZk3qVDi4A9zpk1xDI6s1Ztc
         mGFE9cHx3CPbVE6+NtG5oR9/Ul9WmmIlVy2KDsfr7qc0EDngSWqmVOh9P2wr1q0Fuk6e
         w3VaN8NNsKyL/YtukPbP8/TJvoRgmvJBOPFdB1zzTUH28Z1pisAnxPbPhL7MLdMG65a0
         EieoEsjNIqfaVM9k+3C/ui9srPdeTw2pRmeDMyiVEVDPtggys1htdR/byfzu4CyHngtX
         P+EE1jVUhv7hXR1QavWhe+BxX1GeJ/TIUfa5FH+NlSkE/Y1ZRkBu9XwOGbDl67V9OuyU
         o4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/978xhjl7ItTbjRzuqAy/2dR7HokmCQIlQchAszLJG8=;
        b=PHnwf/POrqFYNm30+S9DS0VLDgVcsOrbjdkwdAe+Bsn/vQEz0EodZY8pdVrivKyV+C
         BRM0sbYnPjfvvXFK4r7Qqgd6wh8ljDzED1FUG1ARFlzkgPTtCYQpgHrvjEJhBWs9T4Vv
         8jJN295WOR43KeAH8n6dfZ7XGyfzNv8XeO9XC7TwuDE3MGcPFW2K9E60ydmRGfmiAZqS
         cCmw7/QGrif4yHLssdY5THrvoLhJ+98TX6v4LBcroj9zr2DmFt0OqpbYa3PcKvsYraws
         WWZTZdww3zQCVxVK93497QX1XRvsxqg4F9sJeoQImWAmgxdJ+30vlR5excs0JgUYmoaA
         XgSA==
X-Gm-Message-State: AOAM530mnRjiWMrNWPeh8iWWGsGfPwPpDzWxRiLbSegrh6q4W+V/aoeg
        FB3fXXdFX4lLkV5mYjngqenW6XG3
X-Google-Smtp-Source: ABdhPJzk/VhzoAaz1jMpLErYTiWa1mMy/p7BO8ynE280fYqdhQjD4HUnVH9mQRiOPQ09x0PsrYxBNw==
X-Received: by 2002:a05:600c:410f:: with SMTP id j15mr2962104wmi.128.1595490707409;
        Thu, 23 Jul 2020 00:51:47 -0700 (PDT)
Received: from szeder.dev (62-165-238-20.pool.digikabel.hu. [62.165.238.20])
        by smtp.gmail.com with ESMTPSA id b10sm2304373wmj.30.2020.07.23.00.51.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2020 00:51:46 -0700 (PDT)
Date:   Thu, 23 Jul 2020 09:51:44 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, chriscool@tuxfamily.org
Subject: Re: [PATCH 2/4] upload-pack.c: allow banning certain object filter(s)
Message-ID: <20200723075144.GL11341@szeder.dev>
References: <cover.1593720075.git.me@ttaylorr.com>
 <f0982d24e74155f6c0e405e5e3ae8c3e579f798a.1593720075.git.me@ttaylorr.com>
 <20200722092129.GK11341@szeder.dev>
 <20200722201634.GB59352@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200722201634.GB59352@syl.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 22, 2020 at 04:16:34PM -0400, Taylor Blau wrote:
> On Wed, Jul 22, 2020 at 11:21:29AM +0200, SZEDER Gábor wrote:
> > On Thu, Jul 02, 2020 at 04:06:32PM -0400, Taylor Blau wrote:
> > > +static void die_if_using_banned_filter(struct upload_pack_data *data)
> > > +{
> > > +	struct list_objects_filter_options *banned = banned_filter(data,
> > > +								   &data->filter_options);
> > > +	if (!banned)
> > > +		return;
> > > +
> > > +	packet_writer_error(&data->writer, _("filter '%s' not supported\n"),
> >
> > Should we really translate the content of the ERR packet?
> 
> s/ERR packet/dying message after your other piece of advice, but I think
> so. This is eventually going to make its way to users, so translating it
> seems to make sense to me.
> 
> I guess they would get it in the localization of the server, not the
> client, but that doesn't sway me away from this, either.

Please note that the contents of other ERR packets are not translated,
either.

$ git grep -A1 -h packet_writer_error origin/seen:upload-pack.c
			packet_writer_error(&data->writer,
					    "upload-pack: not our ref %s",
--
			packet_writer_error(&data->writer,
					    "upload-pack: not our ref %s",
--
			packet_writer_error(writer,
					    "upload-pack: not our ref %s",
--
			packet_writer_error(writer, "unknown ref %s", arg);
			die("unknown ref %s", arg);


> > > +			    list_object_filter_config_name(banned->choice));
> > > +	die(_("git upload-pack: banned object filter requested"));
> > > +}
> > > +
> > >  static void receive_needs(struct upload_pack_data *data,
> > >  			  struct packet_reader *reader)
> > >  {
> 
> Thanks,
> Taylor
