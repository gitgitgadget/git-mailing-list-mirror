Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C13D20401
	for <e@80x24.org>; Mon, 26 Jun 2017 07:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751423AbdFZHcr (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 03:32:47 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:35200 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbdFZHcp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 03:32:45 -0400
Received: by mail-vk0-f42.google.com with SMTP id 191so35669040vko.2
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 00:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=cRjIUCFS5QaykqhccMbQ+AmcKZ0sjlOvFBTKp70tEp4=;
        b=Ii6ftB3L8pdCtkIgd18ipsX75hhUVvrCz+Oul5/w9CqVL768vScnUGj2Fi9aqvI25I
         XRI6lcEVzFmnxXPIjW1a50VVGTO0iMyAaht5yguf/A78niUhjWPYQ84/FgxANaFFZQ1C
         LtN0bEehmAq3XL0jw0ayuTfOZSzRIaKIaMgFQXfd2JpU1FRozXb8CoBaCoZIY/Ii1Y6L
         iLIevkf6YOoWDq1Atkm70r2+UIROhauoScWq46tKFtw+Sv6lcGGb34MEdeGdAx6s4TZN
         m4S/HxsNEWPWiytNdW90R1fbajN50QbFBOFeNg30TABuL9AyesS2p3swiX0u3WdLa44D
         1GFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=cRjIUCFS5QaykqhccMbQ+AmcKZ0sjlOvFBTKp70tEp4=;
        b=fLxuqAm/WsIUsHhFPbaweAcwj8t476uX8DlZoCNA08OSVcPM3EuO8UIoUP24CBZOCQ
         DORq5UskX4LcVHh3ABD/ed/JAC31ntEoiiFh4KlbON8FP4oEc+9yjmL1PbxCkiwRv8Gh
         R9soH5S/4zNIZZ4Ud8spdO7Bb2pCKqR9iQEOYKEcjdZUi9PgeC/QerX2nua1cx8G5BaQ
         UF13eMICYj73+AhR0/FVlFyVceH5AgoaoCoNmFagNjrOkIRmU2AMBPrwrTAx4hKzL9MA
         SDL9lc+oj0aDVs2IXA47StLqIkZdAPBMwj9xC1Yer2iPPUZJiIhwKQRNHywTA8mu3edd
         2PfQ==
X-Gm-Message-State: AKS2vOx363VkGlcxnbjZNZgeSiTJmuxP4g7MwO3X8vYddcy5Ktq5/CGj
        8OXD95GZwPcG/ZSbTpsL0v0mK6oD9+OUwr8=
X-Received: by 10.31.65.87 with SMTP id o84mr8195081vka.7.1498462364550; Mon,
 26 Jun 2017 00:32:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.23.13 with HTTP; Mon, 26 Jun 2017 00:32:24 -0700 (PDT)
From:   Michael Kebe <michael.kebe@gmail.com>
Date:   Mon, 26 Jun 2017 09:32:24 +0200
Message-ID: <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com>
Subject: Compile Error v2.13.2 on Solaris SPARC
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When compiling 2.13.2 on Solaris SPARC I get this error:

    CC sha1dc/sha1.o
sha1dc/sha1.c:41:58: error: operator '==' has no right operand
 #if ((defined(_BYTE_ORDER) && (_BYTE_ORDER == _BIG_ENDIAN)) || \
                                                          ^
gmake: *** [sha1dc/sha1.o] Error 1

The define _BIG_ENDIAN is set by Solaris on SPARC systems. So the
check in line 41 gives this error.

The _BIG_ENDIAN define is used few line below for defining
SHA1DC_BIGENDIAN. This is needed for Solaris SPARC systems.
See
https://github.com/cr-marcstevens/sha1collisiondetection/commit/33a694a9ee1b79c24be45f9eab5ac0e1aeeaf271

Greetings
Michael
