Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED1B31FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 19:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbcGSTD2 (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 15:03:28 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38907 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbcGSTD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 15:03:26 -0400
Received: by mail-wm0-f42.google.com with SMTP id o80so38055891wme.1
        for <git@vger.kernel.org>; Tue, 19 Jul 2016 12:03:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=opRUxoqRkguvyR8svhi9XDfEOLMSVn9NGPXxPO4NKYY=;
        b=N+IN+I7/EJBsOrL9C7pyvV/a70q0GE+R5VEbFxUzAXxUI3snuZTtkLQFUC2nNKH9Cu
         5qyNtk5aEZbzjPkgj8CUIsUmzy/dVKYA6TkCLXjfuNFQTpMwZurZ0ev/8T9f1MU3Cv24
         ZC266UJIu9pM45GIiW4Ohu/W+7HXU8KadzUvfMGhVuWvOKsohkHuKzruvxIqq3Gnr9TY
         K+jAz3/ISANPnWju7xl93Gnru49QdXRoyE6t5Lkn96BxFObtaZDCKzkCZ2xUz/6mNiBT
         PqT58lrh+k5bwe1gF/VcBbQE0gb3c04gvWBsupTKPzLb/YR5Ilq2Em3Y5OQ+xktVkw1l
         2Pfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=opRUxoqRkguvyR8svhi9XDfEOLMSVn9NGPXxPO4NKYY=;
        b=T+GP4az0T5aCBITGoKtoM14LUSAvPMRXeiqt3HJ0UxJVhDtk7CuYmEdB9lRwvItgnb
         cjm/w3LsnWZznE3Nvj2xbX0cF15vxnUAa6E3XVNmKMIO9Gk8SQZvlV9wICr8BNwhVwZ+
         iT+GYMjHwIvFJi4XvUr33gV8iUlBO+5zraq0Y3PHdubzvkdqs9tgF6y0dak8COiSkKOA
         46whG6jNW2BDCph+4Y46nFD51tp3S2tlTSc07okK3PBa2oCjh8aXdlKAS5nXnaR2jAyc
         06a0lLLuK0bko/luBoE71jqKaG4m4MGQFoT2FZBcdAtYWCVFOE/W5mdMzf9+WL9QCFwV
         f1Vw==
X-Gm-Message-State: ALyK8tIJXnVBFEBsxx+qFbX3Ajg38MWOold6Fl1Dvd27r+9Z3B0PAZVDhlG+W+K6aOeW4sQyghcxtuEuLxz3BBnv
X-Received: by 10.28.129.197 with SMTP id c188mr6565762wmd.46.1468955004859;
 Tue, 19 Jul 2016 12:03:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.167.87 with HTTP; Tue, 19 Jul 2016 12:03:24 -0700 (PDT)
In-Reply-To: <CAGZ79kY+2PYx9oz9tvi0zG-oE6qS-Za7D3ocY1XtqcSsDchz0Q@mail.gmail.com>
References: <xmqq37n6iq7d.fsf@gitster.mtv.corp.google.com> <1468880498-30235-1-git-send-email-jonathantanmy@google.com>
 <CAGZ79kY+2PYx9oz9tvi0zG-oE6qS-Za7D3ocY1XtqcSsDchz0Q@mail.gmail.com>
From:	Jonathan Tan <jonathantanmy@google.com>
Date:	Tue, 19 Jul 2016 12:03:24 -0700
Message-ID: <CAGf8dgL3t7uX7yAux0xc2QMJJdmnM0262Quj4o6gDehwA+4JqQ@mail.gmail.com>
Subject: Re: [PATCH v2] fetch-pack: grow stateless RPC windows exponentially
To:	Stefan Beller <sbeller@google.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 19, 2016 at 9:46 AM, Stefan Beller <sbeller@google.com> wrote:
> Care to elaborate on why you choose 11/10 as growth factor?
>
> (As someone who has a tick in micro optimizing:
> 9/8 is roughly the same exponent, but the division
> by 8 is easier as it is just a shift by 3. Similar 17/16)

I don't have a specific reason for 11/10 as opposed to, say, 9/8 - I
think that the time taken to execute this line is negligible compared
to what's done in the calling code, but I'll change it to 9/8 if there
is another reason for me to send another patch.

> I guess one design criterion was 10 being a round number?
> Does it make sense to experiment with the factor at all?
> Digging into that, LARGE_FLUSH originates from 6afca450c3f,
> (2011-03-20, fetch-pack: progressively use larger handshake windows),
> and before we only had a linear growth.
>
> So I guess what I do not understand is why we need to slow down the
> exponential growth at all?

The current code has an exponential (a' = a * 2) then a linear (a' = a
+ 1024) growth. I'm not slowing down the exponential growth - that
part is retained. I'm replacing the linear growth with another
conservative exponential growth (a' = a * 11 / 10).
