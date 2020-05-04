Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04CBC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 23:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBA9920663
	for <git@archiver.kernel.org>; Mon,  4 May 2020 23:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="fi51e2T6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgEDXOM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 19:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgEDXOM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 19:14:12 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB83BC061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 16:14:10 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id t16so21295plo.7
        for <git@vger.kernel.org>; Mon, 04 May 2020 16:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nICruQ0SwEVO1M90gumQmeBAwurwbjeta5bLrlfmBBo=;
        b=fi51e2T6YUTwvcaFaDM2nhjnRLG+OdqpMhEQ/Jwor/IH76HxBjD9NMLFWTgiu5Ii6d
         6qZNWFc8AEbUVfZ8No2+HEvoHAf3O6vJgYSJ3Yz8xoRnpp/4l8v+3HcRsmj+SYq3Bk5v
         buo+f59C+gywh8U47RfOXXAUrfkBf9EKOILapgpFTm7L8RCr8VHJahH/MYl9Wb1fxceB
         LaL/n3wYfdGbcHJCqIAWadOvabdQxW8CZOZVEwNmUJgIfXMS8W2mlPa+yRjciTZkTvkQ
         TA1P0fGcLCRUjR23MhsjDRyhmDL0Yf6/7Q48ktcbCkE4/GSap8umMl8L+8NqfrNiTxjG
         ++jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nICruQ0SwEVO1M90gumQmeBAwurwbjeta5bLrlfmBBo=;
        b=LlQ/WON/4CBjrH+TntUHxpf02JfKM6qToYOHNKZCrDNEGxVhAHda4KWXmNVpYJlfdG
         oBLlSxYMFaLWhwFYJv9+UrsMQLRR+UBsp1cH8yB0YvIQCS+iX4MxVDa5tpKwjp798+C4
         iHKUiBMpnScQF8KOiByMVRoZc7Ton4I6a9lwirRREKhMjAqYDCgEDLsx+UhbRrls9ogu
         IS3TNmenupSwK5J7kjnTYqtO0LOtxAiwCY8I/0cTVMbF7dMh1ui85rDy5o2LWv30m2g1
         6v0Wi2WIR9XHoT8W7YRmWbDYsMP1zPy2ohCITdbaNKgeymcIAHCxbbsNpgJu8X16z/1E
         a/MA==
X-Gm-Message-State: AGi0PuZ3AasXFLiUqn6Ac+/llMEHMSdeESoIy1iJ6VKIrTyaWFrSHbFw
        YrLlwVZewKQxf2Eri5Rb46AGmvr0C7GUPQ==
X-Google-Smtp-Source: APiQypLuKcRoP5QkmQcUjn8JuvOfte210upMFlxKMkq++31oyC7oVBx7vkEvn78Dj981lZvYObOisA==
X-Received: by 2002:a17:90a:1b4c:: with SMTP id q70mr187946pjq.55.1588634050219;
        Mon, 04 May 2020 16:14:10 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id f136sm158528pfa.59.2020.05.04.16.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 16:14:09 -0700 (PDT)
Date:   Mon, 4 May 2020 17:14:08 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Wolfram Sang <wsa@the-dreams.de>,
        Kevin Daudt <me@ikke.info>, Wolfram Sang <wsa@kernel.org>,
        git@vger.kernel.org, Thomas Koutcher <thomas.koutcher@online.fr>,
        Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: tig: bug when binding to 'generic'?
Message-ID: <20200504231408.GI45250@syl.local>
References: <20200502190433.GB25220@ninjato>
 <20200502190729.GC1838755@alpha>
 <20200502193102.GA1160@kunai>
 <20200504220517.GE45250@syl.local>
 <xmqqsggfe23v.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsggfe23v.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 04:01:40PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Thanks for clarifying. I was a little confused when I read your patch
> > series, since on first blush I thought that you were submitting it to be
> > applied in Git's integration branches, and not Tig's.
> >
> > In either case, the heads-up is appreciated, but I do not think
> > necessary in general. I am not sure about the feelings of others, but I
> > do not think Tig-specific bugs need to be reported on Git's mailing
> > list.
> >
> > Of course, if there are Git bugs that affect Tig (or any other project),
> > we would be interested in hearing about them.
> >
> > That's all to say that I think the README there should be updated.
>
> FWIW, I do not mind seeing tig related improvements discussed here
> (I am assuming tig does not have its own development list).  That is
> how we've been operating with other "projects around Git", like
> "imerge" and "tbdiff" (no need to look for the latter these days,
> though).

Ah, fair enough: I do remember seeing an imerge query on the list a
couple of days (weeks?) ago.

> Unless Jonas and others who are involved find the list traffic here
> is too heavy and messages about tig will be drowned in here, I do
> not see a reason to kick them out.

OK, that sounds good (it wasn't really up to me anyway, but I'm glad
that I know how you feel about the matter ;)).

Thanks,
Taylor
