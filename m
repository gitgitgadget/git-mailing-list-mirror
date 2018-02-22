Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA94E1F404
	for <e@80x24.org>; Thu, 22 Feb 2018 19:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750826AbeBVTNi (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 14:13:38 -0500
Received: from mail-wr0-f176.google.com ([209.85.128.176]:34328 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbeBVTNh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 14:13:37 -0500
Received: by mail-wr0-f176.google.com with SMTP id m5so11699423wrg.1
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 11:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PIK9Gd40I66tmPd6lK8iARvQ0rlMOKLqdEf5tJJ9bBY=;
        b=uFO/CgXG9SEs+T6KBccT0rBF2aLEk/j5dA3o3fCQD8k4eO4rtmtGpoPVaGKcL16rJH
         17fcJKrKFqLXwVSVAtogDL/Ks7tQF5cbRGzMfXEEZigXwhBMcGCK/nirFAsVxdZaueWC
         y1i4tnEh/5V750bI+yb3tXj68mv6ko9QCCvdpFZwMNUrlQ+EzvleiWsDTMAXZnBTiw+t
         IShn74CDO8nl8/cpGRYPXDzuNxU26Pdv6jmG13j2zGQOxlTviC6UrVuh03a3aK7LYC8d
         TlA5dBJFGKqRWeLaeKUF7vQx0SgdQCRgSSLdm4/BUW263d3EVZTellUaPPY5+OE9x/3c
         UCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PIK9Gd40I66tmPd6lK8iARvQ0rlMOKLqdEf5tJJ9bBY=;
        b=qwhVuqF5k9kbM3NUsuaOA3FHyyUcBsKZNyDzltx4FnaqWusFixW8TpgjSJ9OzVfRnh
         NN87c7/exgUOK6XE93KZCICKNs22JbadTzh/F1KFvj9RbcIMYmteUG5S4A4f+sJJPtmG
         FNkvnddrsCmJljZRbNRsOGpLURUejRCQwiSbGjJ/BrC+veSb+o/mR1a+SNfW8Q13BTgE
         zvUvxVjq7v61L2ebNoH4082TW5eNTe92KabDGOga8SczcX8HhMiy59nMuR87BWKcJxtW
         LJvUDJJv5W+6r3vU3zVrSml41f86y9BbKLHz6wgUFX0szaJBLz4NPRPNOBrBco3J0tG4
         Ui8A==
X-Gm-Message-State: APf1xPDm0xInp76veiNH0K9dNFlExUXlvC8QqoD3k0Qug4Z65DjSc3v5
        QBMIkyeHo5EbXZ4FlURmz6Sqmw+W3pTBB8YGcphpvQ==
X-Google-Smtp-Source: AH8x226yFRFmYMCJ7UkRHc8Op+M4E/IxvAamgtyqrt5rIYAFkbjicIzwEx1PHKUOzpssbHpc8ghhHWGbWleG60Ok9Wc=
X-Received: by 10.223.160.125 with SMTP id l58mr6960068wrl.264.1519326816031;
 Thu, 22 Feb 2018 11:13:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.179.2 with HTTP; Thu, 22 Feb 2018 11:13:34 -0800 (PST)
In-Reply-To: <20180207011312.189834-4-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-4-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 22 Feb 2018 11:13:34 -0800
Message-ID: <CAGZ79kauYniFpo+Y_hFauVKMWNgxjQ_OOoX0mgePcr3Z6hSLWg@mail.gmail.com>
Subject: Re: [PATCH v3 03/35] pkt-line: add delim packet support
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
> One of the design goals of protocol-v2 is to improve the semantics of
> flush packets.  Currently in protocol-v1, flush packets are used both to
> indicate a break in a list of packet lines as well as an indication that
> one side has finished speaking.  This makes it particularly difficult
> to implement proxies as a proxy would need to completely understand git
> protocol instead of simply looking for a flush packet.
>
> To do this, introduce the special deliminator packet '0001'.  A delim
> packet can then be used as a deliminator between lists of packet lines
> while flush packets can be reserved to indicate the end of a response.

Please mention where this can be found in the documentation.
(Defer to later patch?)
As the commit message states, this is only to be used for v2,
in v0 it is still an illegal pkt.

>
> Signed-off-by: Brandon Williams <bmwill@google.com>

The code is
Reviewed-by: Stefan Beller <sbeller@google.com>
