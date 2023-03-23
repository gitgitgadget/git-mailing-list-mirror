Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1448DC74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 19:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjCWTmz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 15:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjCWTmx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 15:42:53 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA8D234DE
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:42:53 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id j3-20020a17090adc8300b0023d09aea4a6so2971000pjv.5
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679600572;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27EgVwwLcTxZpdh+0EelAqOQ1oe3WjpKzqnxxmbegZo=;
        b=O7qj3hNqZMZqZVnb8g7m/s3OGQuT+3oEn5NTXCAg7pb/UTHJdF07ckznRkAjLsSEnn
         e62VKSKLvv8MeEdAYB7YrIgbQIUprK1IZ5wk/carXchdzRjX5L5FzdmaPHW5pQk2kTm6
         KJNwVTUVRduiaKCZJVo4Tru3gHdVG3K3aJZyn5TBZL+5QwOVLaZja5b57Np1QE+K1CR+
         HrVJpADPvXelUO+3VyiRZKW6ROCV4nm9gVSclrBoYlKN9gRegCn5u9DquP6N0LjSeyZS
         9+Zb1B4ZqHFIP3pI3BlZQKbzJbO1moYPMxFLTmWEXbk9Fk9UybMqk+7ioerliYhtHAIR
         ttwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679600572;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=27EgVwwLcTxZpdh+0EelAqOQ1oe3WjpKzqnxxmbegZo=;
        b=dx413sSckfJ84jJlomTuZroIji7cQxOB129YX6bCmyiIAPJfktBBiktHznhB7z6O8/
         cYRz8BvwodLI7+2dxidN7kynM0HDTVYWaS2fgCN7/2sFkgGjNNvPvbTwfpfcJoii2Fa4
         ZSCgs2VEl0SekNBWCOkOQs9ejQKomiZIoqd2PsdZ43qHcBeuAbQ0XL8SktMMLdzkFfAC
         jBKf6xsdmiM3avEtSPpz8EqJsusb5acOGq/LOmomDTF7Qi+xI0Z08XPCrZqZQ5SPy7sl
         zT7C0GZ4REkDbIiYcgsjPgWCNIVh+c6X19B4gjTXe7JMWSaxi8sqiDcxI1fx80LLkIaJ
         GH6w==
X-Gm-Message-State: AAQBX9dNzpoSzjmG5+a0wQ1B+Nfblrhure3WGOFmXWHw/gfYPi3PMmXv
        CPuxto3yddxeNCjaQ/4Vgvk=
X-Google-Smtp-Source: AKy350bfkaluJzK3fxSLEjBawqfWijQFk2YftMLsK+bjcBQFZWyNY/XfzHfaArZKtOBcQyNEjWmxZg==
X-Received: by 2002:a17:902:fb85:b0:19e:b088:5900 with SMTP id lg5-20020a170902fb8500b0019eb0885900mr29224plb.38.1679600572574;
        Thu, 23 Mar 2023 12:42:52 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id iy10-20020a170903130a00b0019309be03e7sm12725841plb.66.2023.03.23.12.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 12:42:52 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: limiting git branch --contains
References: <ZBygZbz5E6jVNp3y@ugly>
Date:   Thu, 23 Mar 2023 12:42:52 -0700
In-Reply-To: <ZBygZbz5E6jVNp3y@ugly> (Oswald Buddenhagen's message of "Thu, 23
        Mar 2023 19:54:29 +0100")
Message-ID: <xmqqpm8z8dab.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> git branch --contains can be a rather expensive operation in big
> repositories. as my use case is actually a rather limited search for
> commits in my local wip branches,...

I can do

    $ git branch --list --contains master \??/\*

to show only the topic branches that forked from/after 'master', and
replacing 'master' with v2.40.0 or any older point and the output
starts showing more branches, but the search excludes integration
branches like 'next' and 'seen'.  Is that what you are after?
