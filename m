Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82D7C433E1
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 14:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80D2C20825
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 14:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="z3A1gOE/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgGWONK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 10:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgGWONJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 10:13:09 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB42C0619DC
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 07:13:09 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l6so5430778qkc.6
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 07:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3WBYGBMN1uk/EiXtJK0CSifSZL4sqfwKtenxzxJn2PM=;
        b=z3A1gOE/xiuv/jmwuRWJNKj67C+PP7eD0JEglvUQ1mZrDGWKvlkCWL8NWw4DBHjoMj
         Tj4owuPB8TqM09G7UbOL5Xm0KtqCxARAIsOwUAAfhOlh1wSit64fpMBk5sjfdqclo1QT
         iQsAZ6+ytZpgKXIroSd04qy7w20paeRLmsbXNYPnBCuQBkz1dfIO5Iyjxb/8mqzfUcA9
         dYsRYNSPaGWzKFRoShlsB2Kr+KtkHtWY2kYuWNHykoRr/fR+JsS+J7drNfwVQj0O7hi8
         LRr0vp+JTEKIQN2G5vOl6Ph0ZI9BgX4LW4bx+50fc0VjZrO7uHOpCx00Nypbagi373Ao
         jRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3WBYGBMN1uk/EiXtJK0CSifSZL4sqfwKtenxzxJn2PM=;
        b=tul6oLmATTBDfCwKV9eQBdlzlXbMyctSN/fmYZoEAIcGlbL/49CeIRv/yUyJ1rATeh
         0MuRKEj5zJ+3Do6mL619Jlwto9ODPUeCmtFuvsdR6eeWJ6rl3YDlSTSe6B7mjJBHvTcX
         Ba6beW4mwZ0f+kh1toWET36g1yo95h3WDaKXeaPdQfbTNLhxiWmI+m0eDDyMKGfeu8be
         l5JdA9LCeRWGrQu+yuQy8mQY3iRqIzO3v3Bb0j7cSIiFoGH4G2ljFSUmZzQIFdy4J2UW
         +IMqZlIk5eWJo+8tNTe6pvVGHSfGhl/TdB2Y2IU7Lz6pdu02ZKO9C90o94EpsHo+65Qk
         KMlg==
X-Gm-Message-State: AOAM533lknSSpACtvzTEF/Yj3QysZQlnUGdq33Vdi6TpWMJeTYB+kcOS
        QC5k6zSGQyDV4yW+/UyI9dWESA==
X-Google-Smtp-Source: ABdhPJxj8cuc5A+9iLXnDRa3+inh3iPa2DMIQUw83P+1P5c/xDpKVN37WOOkSnfGrdtyF4VMK5NBnA==
X-Received: by 2002:a05:620a:1355:: with SMTP id c21mr5466607qkl.378.1595513588774;
        Thu, 23 Jul 2020 07:13:08 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:351c:83f3:acec:de38])
        by smtp.gmail.com with ESMTPSA id 205sm2588542qkj.19.2020.07.23.07.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 07:13:07 -0700 (PDT)
Date:   Thu, 23 Jul 2020 10:13:06 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        chriscool@tuxfamily.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] upload-pack.c: allow banning certain object filter(s)
Message-ID: <20200723141306.GA86870@syl.lan>
References: <cover.1593720075.git.me@ttaylorr.com>
 <f0982d24e74155f6c0e405e5e3ae8c3e579f798a.1593720075.git.me@ttaylorr.com>
 <20200722092129.GK11341@szeder.dev>
 <20200722201634.GB59352@syl.lan>
 <20200723075144.GL11341@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200723075144.GL11341@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 23, 2020 at 09:51:44AM +0200, SZEDER Gábor wrote:
> On Wed, Jul 22, 2020 at 04:16:34PM -0400, Taylor Blau wrote:
> > On Wed, Jul 22, 2020 at 11:21:29AM +0200, SZEDER Gábor wrote:
> > > On Thu, Jul 02, 2020 at 04:06:32PM -0400, Taylor Blau wrote:
> > > > +static void die_if_using_banned_filter(struct upload_pack_data *data)
> > > > +{
> > > > +	struct list_objects_filter_options *banned = banned_filter(data,
> > > > +								   &data->filter_options);
> > > > +	if (!banned)
> > > > +		return;
> > > > +
> > > > +	packet_writer_error(&data->writer, _("filter '%s' not supported\n"),
> > >
> > > Should we really translate the content of the ERR packet?
> >
> > s/ERR packet/dying message after your other piece of advice, but I think
> > so. This is eventually going to make its way to users, so translating it
> > seems to make sense to me.
> >
> > I guess they would get it in the localization of the server, not the
> > client, but that doesn't sway me away from this, either.
>
> Please note that the contents of other ERR packets are not translated,
> either.
>
> $ git grep -A1 -h packet_writer_error origin/seen:upload-pack.c
> 			packet_writer_error(&data->writer,
> 					    "upload-pack: not our ref %s",
> --
> 			packet_writer_error(&data->writer,
> 					    "upload-pack: not our ref %s",
> --
> 			packet_writer_error(writer,
> 					    "upload-pack: not our ref %s",
> --
> 			packet_writer_error(writer, "unknown ref %s", arg);
> 			die("unknown ref %s", arg);

Fair enough... if there are other changes to make I'll drop the
translation, otherwise this should be easy enough to apply when queuing.

Junio, if you'd rather I reroll the series again, too, that's fine as
well.

>
> > > > +			    list_object_filter_config_name(banned->choice));
> > > > +	die(_("git upload-pack: banned object filter requested"));
> > > > +}
> > > > +
> > > >  static void receive_needs(struct upload_pack_data *data,
> > > >  			  struct packet_reader *reader)
> > > >  {
> >
> > Thanks,
> > Taylor

Thanks,
Taylor
