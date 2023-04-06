Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D2BC76196
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 18:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239418AbjDFSUI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 14:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjDFSUH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 14:20:07 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D6A19B
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 11:20:04 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so43702852pjb.4
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 11:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680805204; x=1683397204;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJK9kIkwE8hWfw9TbSlTYsijsHWYuXPtD9HHKeoLJQg=;
        b=ZW+/rhzkxOwl5lz28u36IPl/vFNG0h7aiLzcqUjW4PyXkB48SmfcqPItvAJZqGorNh
         faDPPl5UhDjCBEjAJu/zDrey1WksgWssLh4mzASvtNjSdCqeuP/JLX2qI5CRvQOrlEmX
         0PWVK7lLT6S8dzlUDKwukyO8EIOBU4e1AR/9qf+6cppotl/J6bGmB6kPrzQlkbnJZ6uY
         E5jdxcpSwtFbcodPdE9UwTlszpRlKJzICIbB6c1kCyu2XMCrp17UoAopE7nCcC2GAqKB
         1ZWwZg7QfqWzpB/bnIZ9/VlUf9dmnke6oe4mfRbZdW+SrDw1AVP2WR8lUXxgqA6oYbOc
         ERPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680805204; x=1683397204;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GJK9kIkwE8hWfw9TbSlTYsijsHWYuXPtD9HHKeoLJQg=;
        b=Hf0T/D+uVuSM9TO+PLA7PqCkS5OwwjUbuVxTAjMEVF2EZjMoKaMw/AkS+lamMRxgp0
         2DFFU1yd7qqfEL+1R/PK+gdZLA2xu0SdaqxnmiGJk24ws19/pblJo0kPayKmAGDI32wW
         nswEB4XrLSyjwbLWcYD21PpV0BKGmCm8d2Y/LK37R9dA2X9R8vz+0ARQQIwWEmGO46AZ
         YvVvarvcgK58+4D2tU1uxZsd7nGWzuWD48lMJWIw0W1N7eiDHC1uyAXQ+lR/lZkUYc5E
         QdCFOPndEXUXADh6+1gPCDfIle/TwlRQ+gKVni3xOnXIVPUVKL1p7jWKcFCQPHrE3RnC
         U9vQ==
X-Gm-Message-State: AAQBX9do+2qAaIv0AoYqjF0G9dJvWSxHlDuXpvCHZ22f+JLJseyW/7+u
        +Tcj6eYB3pDB1TzY+xECebe7gAAbU5U=
X-Google-Smtp-Source: AKy350Zs3rtX5Kgy/gX8dL35cvNnaW8/IcehLGNfoAGZS0cBIxHouFuEcrIxeY3a6maGFSixbualiA==
X-Received: by 2002:a17:90b:1a8e:b0:233:feb4:895f with SMTP id ng14-20020a17090b1a8e00b00233feb4895fmr11995555pjb.44.1680805204180;
        Thu, 06 Apr 2023 11:20:04 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id r14-20020a17090a4dce00b00233db0db3dfsm3406625pjl.7.2023.04.06.11.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 11:20:03 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] branch, for-each-ref: add option to omit empty lines
References: <20230330112133.4437-1-oystwa@gmail.com>
        <20230330112133.4437-3-oystwa@gmail.com>
        <44e7ac0f-2fd9-fd01-89da-a8d036d2e400@dunelm.org.uk>
        <xmqqjzywg7sg.fsf@gitster.g>
        <CAFaJEqtxNa+fuuKzkKPLkF3qdYwZUj+tMKXB3u2ok6H008vjHA@mail.gmail.com>
        <20230406171203.GB2709660@coredump.intra.peff.net>
Date:   Thu, 06 Apr 2023 11:20:03 -0700
In-Reply-To: <20230406171203.GB2709660@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 6 Apr 2023 13:12:03 -0400")
Message-ID: <xmqqo7o0q3e4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It might be enough to flip the default unconditionally (no config), but
> I think we may still want "--no-omit-empty-lines" as an escape hatch. I
> dunno. Maybe that is somehow choosing the worst of both worlds.

It is very tempting, indeed.  We can add the escape hatch and flip
the default, and only when somebody complains, come back and say
"oh, sorry, we didn't know anybody used it" and flip the default
back, perhaps?

This is a totally unrelated tangent, but it is a bit unfortunate
that with our parse-options API, it is not trivial to

 - mark that "--keep-empty-lines" and "--omit-empty-lines" toggle
   the same underlying Boolean variable,

 - accept "--no-keep" and "--no-omit" as obvious synonyms for
   "--omit" and "--keep", 

 - have "git foo -h" listing to show "--keep" and "--omit" together,

 - omit these "--no-foo" variants from "git foo -h" listing.

by the way.

