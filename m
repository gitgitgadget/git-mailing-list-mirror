Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 168821F404
	for <e@80x24.org>; Thu, 22 Feb 2018 19:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbeBVTw6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 14:52:58 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:51198 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750967AbeBVTw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 14:52:57 -0500
Received: by mail-wm0-f44.google.com with SMTP id k87so604130wmi.0
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 11:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ptB5JgW8q+un05GP6Y+i+jQ5PFphYsTWHKnqfs947jY=;
        b=TNfmz84oW229fTlZsKJGWw8AECK5+IUIHTC+KDY64K8G4JgN2I3zr0owrLRo33j4R9
         irVtItkOWmmNcYK4XEwf17XFpDvZA1DcIzEHxfNYPZKYbHn0vPMulFqIw9/UA83fNdsI
         4jWY5iGNf9QA9ESlZh5pNfa5gXODD4yn4EEO6KwHJpaphK7Y1UD8P7e2MM3lqwsYewwD
         tsMQQuPEioSXQw9pL62zw9RoLABH1w2fkkN7vjDxRJKsMtmpcoIyXi1cRqLnbKh+IGDo
         ktTSR29cA0bjabkuMoS71Bz2o2eyV817W9kF2ffKMY2Px4nBRQLthduZPscd//NUB/1V
         X9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ptB5JgW8q+un05GP6Y+i+jQ5PFphYsTWHKnqfs947jY=;
        b=mKdgkjg0qURwIkip8kug9jiXDB2snm2PLkezocsqLdzM0Gw2JITgFlxheWFvmtPlV7
         J1lqMZIOAOFECvb9ViAdFILITUMPO8zeZXCTyQ72SsVd7LroZvzAgBwzwA6JbnN2Tnmv
         1CmnfAazrRzOoxlEBw/lvNrG4hxSL+KL4PAYgDsRPh5F7azUnc389N3R72lQfancJ6so
         bZM0IBtumK8fu/182XTZd69Pj/Yvyl1DJAu8fwZT76YmT/iMbeFHpUC81PSjsDVZSDXN
         5CryMvBNwlxCbW1niv75w6f12HC0J2z2TwoZ4T2igzEbnESchfVsRBqLzOgk8Vvo8wNP
         6ELA==
X-Gm-Message-State: APf1xPATFPQN5aM4N4JWw9FPLMf2E/UIbM+N9hCbluqcohw+AMGKOQes
        XI6i0ns7Prd6lI9uheGPoONOmuO14ofb0I/+n9M9VA==
X-Google-Smtp-Source: AG47ELuU78/V6qBcv1Ebz9bBdjxJBn/PM28xETLwL+7nNxeJkmxEgTC3/K4sXLa7ypjJopCNMSNxJmoR0rfIGgu/PzQ=
X-Received: by 10.28.69.87 with SMTP id s84mr248236wma.107.1519329175790; Thu,
 22 Feb 2018 11:52:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.179.2 with HTTP; Thu, 22 Feb 2018 11:52:54 -0800 (PST)
In-Reply-To: <20180207011312.189834-8-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-8-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 22 Feb 2018 11:52:54 -0800
Message-ID: <CAGZ79ka_tYYhFE5OPfSgpuvssuivCTj7x3aXzLYLO22WGugTRA@mail.gmail.com>
Subject: Re: [PATCH v3 07/35] connect: convert get_remote_heads to use struct packet_reader
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 6, 2018 at 5:12 PM, Brandon Williams <bmwill@google.com> wrote:

> @@ -56,6 +62,41 @@ static void die_initial_contact(int unexpected)
>                       "and the repository exists."));
>  }
>
> +static enum protocol_version discover_version(struct packet_reader *reader)
> +{
> +       enum protocol_version version = protocol_unknown_version;
> +
> +       /*
> +        * Peek the first line of the server's response to
> +        * determine the protocol version the server is speaking.
> +        */
> +       switch (packet_reader_peek(reader)) {
> +       case PACKET_READ_EOF:
> +               die_initial_contact(0);
> +       case PACKET_READ_FLUSH:
> +       case PACKET_READ_DELIM:
> +               version = protocol_v0;
> +               break;
> +       case PACKET_READ_NORMAL:
> +               version = determine_protocol_version_client(reader->line);
> +               break;
> +       }
> +
> +       /* Maybe process capabilities here, at least for v2 */

We do not (yet) react to v2, so this comment only makes
sense after a later patch? If so please include it later,
as this is confusing for now.


> +       switch (version) {
> +       case protocol_v1:
> +               /* Read the peeked version line */
> +               packet_reader_read(reader);

I wonder if we want to assign version to v0 here,
as now all v1 is done and we could treat the remaining
communication as a v0. Not sure if that helps with some
switch/cases, but as we'd give all cases to have the compiler
not yell at us, this would be no big deal. So I guess we can keep
it v1.

With or without the comment nit, this patch is
Reviewed-by: Stefan Beller <sbeller@google.com>
