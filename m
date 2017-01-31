Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D8F11F6BD
	for <e@80x24.org>; Tue, 31 Jan 2017 21:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750828AbdAaVjd (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 16:39:33 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34714 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750792AbdAaVjc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 16:39:32 -0500
Received: by mail-pf0-f195.google.com with SMTP id y143so29874399pfb.1
        for <git@vger.kernel.org>; Tue, 31 Jan 2017 13:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/38Q7+brboR24EQenVHCzMJgAtSC30ndmdIBs5gdsgU=;
        b=L0BmHXL5KVEwvh5j80nJacxblSzcO9TfaUzCBSNa+gjLaaCUW9SOusO0nD1NfvV6Cm
         z96eYDRKuqUmT2dmpjP5d5ceqTUfGQ8EvFWmUp8ZhtlRM5gm6LkHbJS1/DAVAxVVVYcX
         0AzoPmkoaEbcQub7uoL52vwdY5PwomtF9caWrrOxBNHhAVLQKuEB5339Cz8SFYohT9Yo
         DnfRVgyJpBFkt9L9CmErUWkimW/giqAEu/X7liAaxS7FU2eypqVQrM19HAvD4EtQNOZe
         v0dwRcvUWyKY9xUc0TZrWohYGjZ3K1tNKleiMPCA41Tidlf8wMDHDYjy6EeN9AV9wgby
         wxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/38Q7+brboR24EQenVHCzMJgAtSC30ndmdIBs5gdsgU=;
        b=eQSV4UcrpwGONe7O3nig4nnr3baFx1hzKJ3Xy9L1WQC6A6OLhrOUYoFyY8LaFlS/Hz
         5qEAMl6TvwmrhzJVmKadFCVXDqfwlDjf7vZzxrIop24MexwB3pO4us6WkbsSanFWMHrF
         qQVn5cTZvfG2Zsw5bj/l94cPGZYszpspr78HIUc5n4t93iCSokjn1eK61ldL6JJ9lD+F
         2rcEUt9SEkFOuDAvwtQ65TD79uxP84GfcWLxkNbiECiAoI4ZWqoe8NYKNIR+x9flb9AS
         1P0J3DO9MulG9ms+wcwjuIlDOgZv+y+9jHcRPyFPKIqxhfgSppbSEvxg5bbGhDBgRYdk
         R9Sg==
X-Gm-Message-State: AIkVDXJVpB7dSI51mxy9RHiGq66HgmyUhfU6mRSm4jKrz4G6KkmvAZBQBaKP3Vn2aWYkCw==
X-Received: by 10.99.135.195 with SMTP id i186mr32457595pge.105.1485896953869;
        Tue, 31 Jan 2017 13:09:13 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:a052:8a35:4bb5:b253])
        by smtp.gmail.com with ESMTPSA id f65sm43473581pfk.5.2017.01.31.13.09.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 31 Jan 2017 13:09:13 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 14/21] read-cache: touch shared index files when used
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
        <20161226102222.17150-15-chriscool@tuxfamily.org>
        <xmqqa8bhb32x.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD1EgOxcPi=tpiosKkYMcCZe+b6gwW0CKt2sE1NZ7gQv=A@mail.gmail.com>
        <xmqqo9zi35n6.fsf@gitster.mtv.corp.google.com>
        <CACsJy8AR6yNr0y+_JZDkW-HO_yHPkUx_6zbLGoviKQBOVcSg5A@mail.gmail.com>
        <xmqqvatouwsh.fsf@gitster.mtv.corp.google.com>
        <CACsJy8B_xe6RtszPrncvDdSYosNUQxvhcEQ3DO_WO0sepXqvvQ@mail.gmail.com>
        <xmqqlgu627uj.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD2LWGtNtdhtQTZXqsACBvK=jD25vt8M4HzBRBVS1sJ+=Q@mail.gmail.com>
        <xmqqefztsj4c.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD3KXOgVOhuMtws36XPiek56U4mQKdUs07hzKc-dC=ppmA@mail.gmail.com>
        <xmqqsho6amm7.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD3iWg5g-h209VDyg1U03Jmma8nTONyCYB-kN7GwspkL8Q@mail.gmail.com>
        <xmqqy3xrqbkr.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 31 Jan 2017 13:09:11 -0800
In-Reply-To: <xmqqy3xrqbkr.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 31 Jan 2017 11:22:12 -0800")
Message-ID: <xmqqbmunq6mg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Yes, but you need to realize that "it is better not to bother users
> with a report of failure to touch in read-only repository" and "we
> ignore all failures".

Sorry about an unfinished sentence here.  "need to realize that
... and ... are different things."

> ... It is very similar
> to a situation where you ... run "status".
> The command first runs the equivalent of "update-index --refresh"
> only in-core, and it attempts to write the updated index because
> (1) it paid the cost of doing the refreshing already, and (2) if it
> can write into the index, it will help future operations in the
> repository.  But it does not report a failure to write the index
> exactly because it is merely doing an opportunistic write.
>
> And in the "we read from the split index, and we attempt to touch
> the underlying shared one to update its timestamp" case, it is OK
> not to report if we failed to touch.
> ...
> ... On the
> other hand, if you added new information, i.e. wrote the split index
> based on it, it is a good indication that the <split,shared> index
> pair has information that is more valuable.  We must warn in that
> case.

This reminds us of a third case.  What should happen if we are doing
the "opportunistic writing of the index" in "git status", managed to
write the split index, but failed to touch the shared one?

In the ideal world, I think we should do the following sequence:

 - "status" tries to write cache to the file.

 - we try to write and on any error, we return error to the caller,
   who is already prepared to ignore it and stay silent.

    - as the first step of writing the index, we first try to touch
      the shared one.  If it fails, we return an error here without
      writing the split one out.

    - then we try to write the split one out.  If this fails, we
      also return an error.

    - otherwise, both touching of the shared one and writing of the
      split one are successful.  

 - "status" finishes the opportunistic refreshing of the index, by
   either ignoring an error silently (if either touching of shared
   one or writing of split one fails) or writing the refreshed index
   out successfully.

It is OK to swap the order of touching the shared one and writing of
the split one in the above sequence, as long as an error in either
step signals a failure to the opportunistic caller.

I do not offhand know if the split-index code is structured in such
a way to allow the above sequence easily, or it needs refactoring.

If such a restructuring is required, it might not be within the
scope of the series and I am OK if you just left the NEEDSWORK
comment that describes the above (i.e. what we should be doing) as
an in-code comment so that we can pick it up later.  The whole point
of the step 14/21 on the other hand is to make sure that a shared
index that is still in active use will not go stale, and from that
point of view, such a "punting" may not be a good idea---it
deliberately finishes the series knowing that it does not adequately
do what it promises to do.  

So, ... I dunno.

