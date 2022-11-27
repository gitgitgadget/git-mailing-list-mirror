Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF561C4321E
	for <git@archiver.kernel.org>; Sun, 27 Nov 2022 01:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiK0BZF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Nov 2022 20:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiK0BZD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2022 20:25:03 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF3C1582E
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 17:25:03 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id w129so7298652pfb.5
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 17:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7nrp4TETjF91ZI+xbhjoXfgIvsiQp81irTpknXd9og=;
        b=Vyx6S4hvILhtQr/K9iJ+IW5H7Kk6hU/zkc4bJ5Yafs4I1dC4X3Fudkxe00IPj8+PNp
         LGMB9Rj8xAkat/27kX3aWxLiPny08cISJe+a/M/lfDdr+yGG5Xmd4KMeF0K8xBuoXbkt
         +i48C6WxsoG0aikhNFImoPJ/Zn1yyBx1LgVpE4gDqzZn8fc3QAZBLu7bYDzoVJGzm4hF
         cLsvlvtLAlV5/bwghn9e20U5+jJv779jzt9wr99ATo/xNmrllnzcdzMZqhFeQnCu2YB4
         ULeBHrso6h1YdnUvVwtyUdgIjN8dfg6qhjrB00Ib3w4EsllCNOfOGTXOZ3yw7Uu/QNQ8
         BtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g7nrp4TETjF91ZI+xbhjoXfgIvsiQp81irTpknXd9og=;
        b=W6HFPdPQ9n9e1T1LXLMLVb4IEiXTkuqyQSKnIAj9ei0nhoEaSHotzlLZWPFf5T3PMW
         booBb+yVckNHxTYy2p+/Xv94z8o0qkR9Jg87WGKSGNuh2HwJNr/baZ28J8P2EVmU0/Y0
         0RUprf04BSzyESI0EeahSYD58iuE1gPwi4tJw9KhWX3+OAAJygAOF1mti9+rVZlbJjTd
         KBx9ed7fOQNO4kGXBwBtBR6XBtGmFIrhJXEaZVdFZWUVMMsO4ajDVyi4mchsGzEjsXPC
         WdOUNZDW+GdF9u0btASkhs1XohxQ2CWpkmuyCdEBq3m3VfqTudJr/EFImXZMX008511G
         z6lw==
X-Gm-Message-State: ANoB5pne2QNksKb7r3Aqo+loPA5WU3gflJgQXxNLijUZyvRuGEMGmw/x
        qabhawwgoNVKGiGnifHq6RZgo9VeESUpng==
X-Google-Smtp-Source: AA0mqf7qpLxTXjltXF7S+uJS8TnzjWCVIMyjfsZNqb/RuCW0UAI8CBYTIloFYoVGUGZJU2dsCoVToA==
X-Received: by 2002:a63:195:0:b0:442:c653:677d with SMTP id 143-20020a630195000000b00442c653677dmr40344578pgb.43.1669512302398;
        Sat, 26 Nov 2022 17:25:02 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902650500b0018869119e37sm5918485plk.142.2022.11.26.17.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 17:25:02 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] send-email: relay '-v N' to format-patch
References: <87edtp5uws.fsf@kyleam.com>
Date:   Sun, 27 Nov 2022 10:25:01 +0900
In-Reply-To: <87edtp5uws.fsf@kyleam.com> (Kyle Meyer's message of "Sat, 26 Nov
        2022 15:21:23 -0500")
Message-ID: <xmqqzgcd9ok2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Meyer <kyle@kyleam.com> writes:

> Here's a patch handling the -v case.  I don't plan on working on a more
> complete fix for the other cases (as I mentioned before, I don't use
> send-email to drive format-patch), but in my opinion the -v fix by
> itself is still valuable.

Yup, I think it is a good place to stop for the first patch.  Other
people can add more when they discover the need, and anything more
complex [*] is probably not worth the effort, I would think.

    Side note: [*] we could imagine running "git format-patch -h"
    (or a new variant of it), parse its output and populate the
    %options dynamically, for example.

Will queue.  Thanks.
