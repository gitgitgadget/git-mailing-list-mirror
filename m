Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3067CC7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 15:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239452AbjDZPmV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 11:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjDZPmT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 11:42:19 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B608E5BBE
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 08:42:18 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1a66911f5faso58307055ad.0
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 08:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682523738; x=1685115738;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kNEn5tndTBTRj6Zy0OYpAELoT8EjYPfzsvZLEbJAqSQ=;
        b=ZZUdrvPLAZw5uwCIY/YblPQUDNR2JgpiyPmUSH1b8BrPlxj77SHcpiEPrnCdW9ooW3
         mI49NN0YqC0VWGar4DPTm3jihXTUxYM5Fa/gdHxQ9t5qL4awxer8OPU8D2ug95n/IR+y
         ZbidgGonaZjwWfpmOJVaUvt9703J83J4UstLjNsdbXHPJipADrAncRXfbEBu2pRSrfRk
         mLlUVf/+YQeGtP51y3MEBI9h+nvSfINKv/uNKdjeo62lEVQE5ms3x9TUHCHISg58Y/Z3
         VYZNTXc1jFfsJk4IDbT164izT4+pQyW9I58Z8Dlb+4V9N3i6kqK23J/V+YL5OQMVi+NO
         OVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682523738; x=1685115738;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kNEn5tndTBTRj6Zy0OYpAELoT8EjYPfzsvZLEbJAqSQ=;
        b=RnFSxz3mJmzbg0RssjZOsw0Ugy2s5hYZX/m1DSg4g5cRDwY7HqqR49KxB1alvHns2G
         Rp0aSKTLooOU6++KgKDHgIKLITvAsX7Pr5dhG1lymQ5vZA+dFSidmVh3j1POJViRRIkX
         dYsd411YAZnhfFo9o4Hu1wAhnoO324NOp5Gt3SeVat8Ac8Bw5XOinC5c4Pf7J2Wkj0yt
         Vw479MKhRL2Quras3zolh8KtN1hljYxtHw8JAtMn/s5NYOpArO9PG80rYy+4fyuZUK//
         uGxo8Ic6U1PbzirOuVhtzyT9MHgW/i8dMRdCPS8Gsiva0xDhl1JKAOGSH6nQ9ub4k3Fs
         Ij/w==
X-Gm-Message-State: AAQBX9c9PuxBuvYuUXV4tM3HrKc3khVJxJphtPfb/sZXE6l3DWj0Ncsg
        ozDhwzg+oexivwiVk8zeSiQ=
X-Google-Smtp-Source: AKy350a9ZfYLOjioQRt9KuV7xJoRPjcgokZ5U5uQ2UdGCqVXvP1Nt0oCxD8EnW1uZSbjJygnhAT9xA==
X-Received: by 2002:a17:902:dac7:b0:1a6:9762:6eee with SMTP id q7-20020a170902dac700b001a697626eeemr28207730plx.40.1682523738053;
        Wed, 26 Apr 2023 08:42:18 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id jh21-20020a170903329500b001a52abb3be3sm10146440plb.201.2023.04.26.08.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 08:42:17 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Adam Majer <adamm@zombino.com>, git@vger.kernel.org
Subject: Re: git clone of empty repositories doesn't preserve hash
References: <e7a8957e-6251-39f1-5109-87d4dd382e81@zombino.com>
        <xmqqr0syw3pe.fsf@gitster.g>
        <d04c430e-b609-b0a1-fd0f-0f3734d5c3b1@zombino.com>
        <20230405200153.GA525125@coredump.intra.peff.net>
        <xmqqa5zmukp5.fsf@gitster.g> <xmqq355euj2i.fsf@gitster.g>
        <ZEhHsJh20gtiDBd9@tapette.crustytoothpaste.net>
        <xmqqcz3ry2sw.fsf@gitster.g>
        <20230426105134.GA130148@coredump.intra.peff.net>
Date:   Wed, 26 Apr 2023 08:42:17 -0700
In-Reply-To: <20230426105134.GA130148@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 26 Apr 2023 06:51:34 -0400")
Message-ID: <xmqq8reeveee.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We could send a capabilities^{} line, which Git has supported on the
> client side since eb398797cd (connect: advertized capability is not a
> ref, 2016-09-09). So sending it should not break even old clients
> (though we would have to check what alternate implementations like
> libgit2 or dulwich do; we know JGit supports it).

Ah, I forgot all about that JGit workaround.  Yes, we can exploit
it, and any implementation that does not understand it correctly
(including git before 13e67aa3 (v0 protocol: fix sha1/sha256
confusion for capabilities^{}, 2023-04-14)) does not work with JGit
when cloning an empty repository anyway, so it is not all that bad.

But I tend to agree with your conclusion that it may be an update
for the sake of completeness to retrofit v0/v1 on the serving side.
It would not help any real-world use cases all that much.

Thanks.
