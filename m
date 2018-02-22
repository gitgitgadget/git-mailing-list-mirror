Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 707791F404
	for <e@80x24.org>; Thu, 22 Feb 2018 20:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbeBVUJL (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 15:09:11 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:40378 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751432AbeBVUJI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 15:09:08 -0500
Received: by mail-wm0-f41.google.com with SMTP id t82so640457wmt.5
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 12:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YkB2kXME9MlbQ+aLuuanhKNPMGBAxEzc4Q62/zGfA+o=;
        b=KXkwOu0eYw7pXx1TKp0aZmZrDffHt2vGlK3pwiuOH1UTj74/VBVr8T1woFXA1NHekR
         juKB71Hf+vm/PNl47vtrzN3YiOapFr7599pTe+NHAyn5AMHZLkSghwADWnQfpWGVk7zr
         mEzn23L3twlDyKX7/1CS+c5ff/rOy/jnUiwA166JKsflBfp/jSL3EmRKPc6GCTCZf6uN
         8SrzpTIN4zWUpih3MN7k7dqQdk16EPtUSvV4CtGLy+zIJz0QVIzx11Box0yhBMPsyEKc
         jlnLA20TL64dq9E8TWUI6N5vZ2/tQKUEf7Qr3su7CT0DfpBqwERcINWkfewRVtZQt146
         HM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YkB2kXME9MlbQ+aLuuanhKNPMGBAxEzc4Q62/zGfA+o=;
        b=PHJS47TpP74ayI4Q5n2YTy/IEa2cPBIg9LKGqAnn3chALCJN5fbZxujn23Xlg4Ne7j
         KWNvaimKnQcAiG/gttDuzWoGYGxRnmpigc/QNESUv9VvD8F9YE0s3oY7vl1yhr4ZM2s0
         UChR0IAF6JYnQU/IbOi3vlTJNv1xiFY3YmYzzNsAC1UkU6xSSmEnpjjwV81Q8EH0OyLc
         gDNLapa65WyYtREGQKxpYi1MPH399k/Gm80fgpy9YrF109tO5B7q7PGSOpCXeZGqJEp0
         5bVgVWVoI+nvav6c7mDHb8d4vHwg5kvdDGQw60d1ouMXO0I5NYk/aw/ADE8S5q7c27At
         ugrg==
X-Gm-Message-State: APf1xPBHQzi+wKvWR4kEY4+t6sItZfwsfYhIbTM1xLuubhcaBGLaDcmb
        gJLfH+jLIDrrTeT3z9SQA+JVqV7C2pYKFv/k+4ddng==
X-Google-Smtp-Source: AH8x224H3c6YD+c266BIJX8U3PXoSNpZbiwY5lHy85x0n4fxty3TEjMFUNr2NT0YVF5wmDO1R96eBDIdp47JoBiUAyk=
X-Received: by 10.28.54.26 with SMTP id d26mr305890wma.39.1519330146721; Thu,
 22 Feb 2018 12:09:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.179.2 with HTTP; Thu, 22 Feb 2018 12:09:05 -0800 (PST)
In-Reply-To: <20180207011312.189834-8-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-8-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 22 Feb 2018 12:09:05 -0800
Message-ID: <CAGZ79kbnioP+12xa2qfaYLyzdeCH8hh2Ri0xHD7rNciJiTYxmg@mail.gmail.com>
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

> +static enum protocol_version discover_version(struct packet_reader *reader)
> +{
...
> +
> +       /* Maybe process capabilities here, at least for v2 */
> +       switch (version) {
> +       case protocol_v1:
> +               /* Read the peeked version line */
> +               packet_reader_read(reader);
> +               break;
> +       case protocol_v0:
> +               break;
> +       case protocol_unknown_version:
> +               die("unknown protocol version: '%s'\n", reader->line);

The following patches introduce more of the switch(version) cases.
And there it actually is a
    BUG("protocol version unknown? should have been set in discover_version")
but here it is a mere
  die (_("The server uses a different protocol version than we can
speak: %s\n"),
      reader->line);
so I would think here it is reasonable to add _(translation).
