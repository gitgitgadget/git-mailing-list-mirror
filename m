Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE6511F453
	for <e@80x24.org>; Tue, 22 Jan 2019 08:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfAVItx (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 03:49:53 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33658 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfAVItx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 03:49:53 -0500
Received: by mail-io1-f65.google.com with SMTP id t24so18543846ioi.0
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 00:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heckman.io; s=googleapps;
        h=mime-version:from:date:message-id:subject:to;
        bh=u+wVfvsN6/F+l/sqFxW8wbXE34i5cAyJQbc/a3lPK/I=;
        b=RHrCrO7JcuhGTnvNVMvzx4ZHiRoB0/KFnxYmaWWDIvmjS2JmCth2E0N6N8Mh0XwaMc
         ueIx9RuWetAjaWABXK7smgsswycXmlhZ1u/JZ+1NPIW6VtmROMUCPBEKzEXPktJNbhiM
         hsSUB9dWQTjIc4jTZdiUNIKRz8fxKC7DZu2pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=u+wVfvsN6/F+l/sqFxW8wbXE34i5cAyJQbc/a3lPK/I=;
        b=ECmpPNZeKgPZHKD1GL9pkt9dV2C6sTjdO6voYFlOKXQVTsTDh5llubdewvn0fJ80FT
         Ycd+Ym71tm7Niswhx1RVZRoFDnSp+oiTo//ididVpI8d/PkmwYb8G0yFTJ7lb0DTY79Y
         b31E7RdkbiW+2IHFpba9RdPcmb1LX/Hjoq0H/sjX+PueO1BJreUzvxgv/jnORQvjNH6Z
         qeyirOhzjMV0yZz6bLZmrt0Nbo6rXp0KbZKKXmSmbeL2lrRExmpN50lhcGfuMFK0glI2
         C3nvoVy6bmSkOL6bJb+eydVsxVsa50ZJjeh6uW5Pxef++6u074RUDP3NPhqGgs4YYo/0
         rPYQ==
X-Gm-Message-State: AJcUukeX8z/yU/Q9CQOUTCiBoJThTnEqH7aWu0o86lKoKudnzbJOVgNA
        HVtcIBxej/hHmxLXoJXfi7H3uZFUL8bN9PrS6zOaDGRRBOwnTq0M
X-Google-Smtp-Source: ALg8bN6F6agnXvDUjXwl7cyDn52frWK/2SHY+gzI3mhOawNv7d4SV7Trv73Z4Qih40S8FvERBgUeb70RZNcO7SzjhBk=
X-Received: by 2002:a5d:9b16:: with SMTP id y22mr14612904ion.52.1548146992054;
 Tue, 22 Jan 2019 00:49:52 -0800 (PST)
MIME-Version: 1.0
From:   Tim Heckman <t@heckman.io>
Date:   Tue, 22 Jan 2019 17:49:16 +0900
Message-ID: <CAB=D40guDg_bhFYGCYgpfKkqtMa49u1+=hqBHDWuoNwsQ4sxjw@mail.gmail.com>
Subject: git ls-remote: specifying connect timeout / retry limit
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I've hit a particular situation where I've ran a `git ls-remote`
command against a remote Bitbucket repository that resulted in the
command hanging for a pretty long amount of time. Running strace shows
that the TCP connect call eventually times out, and `git ls-remote`
uses a default timeout period meaning it takes awhile to notice. If it
retries different IPs, and they all fail, it can take many minutes for
"git ls-remote" to return.

Is there a mechanism by which I can configure the connection timeout
and retry count to have the `git ls-remote` command fail much faster?
For my case I'd like a 15 second timeout and limiting retries to 2. Of
course I plan on wrapping the command in a deadline itself, but I'd
rather give it a bit more time to pull data if I'm on a slow/latent
connection yet it was able to make the initial connection.

Digging through the manpage there's nothing jumping out at me at how
to solve this so I thought I'd reach out here.

Cheers!
-Tim
