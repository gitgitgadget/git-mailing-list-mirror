Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4026BC433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 13:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiJMNNn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 09:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiJMNNk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 09:13:40 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BBC47B9C
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 06:13:39 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id fy4so3820722ejc.5
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 06:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zCnm2K+hECMIMAAg+2RLwsQC1wcn+N8NoNkGZzpPZMo=;
        b=jT1Mycc3KToNaTwqK2/MVcGqaiWCfAXhKvgqft8Bvp6wa3RiNU6KHQmYll8sTSidej
         0AnaPNP3ZVheKTI2cq89cOBl3szx1At3TKTHq2Kuq89tVR5e1ZOhVhCk+yOte1gb9+hb
         TvQ9o/IS7OZNhrU8x2Zmqp//BtGslbqFuU6KHXyo1kni8tzDZogFpEnCzs4KrZoNiy4n
         pqxVscKbxWF6s8ZLfYcClV9G6GhX+Zvex6JZP2H9yZi0wFj5cI7nv/+TzAha/CwNKC/4
         6KexxeHMEo0PYfbQv+ec+vlzSe4pCDraztv3NBzr9xo/jRUGTZfBz1DUylsDP0Xmtm20
         JvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCnm2K+hECMIMAAg+2RLwsQC1wcn+N8NoNkGZzpPZMo=;
        b=HSEno0L9J7BSSvDTRoPASAr/nwtsgq6OSKJF62HBZ1IZbMyCpKRuocpV8YOXS6m8eb
         U110Ho+yLxfGxqGo99gn/DLN/2hRZ5N+ofFcq+h9FAh/GWV0eNGtgcj3YVqZKO8f6Fi8
         94Ojkpsw+f9uwfHZ2P5HMxkJv5CTXutslDZI5jQvsDy22HMLilViwiMG7nlnVk28+wF/
         RQ0ecCrHbwzrqMHFXiY0wGt2aK8x9mAKQbVwuHn8lsNmCzRLJvDsPl2toNR8ZQEbDQdr
         4JxYks7fE+IV8exi9RCI1Ojk+pArnj/cavEOPOD7HaMRnVqDmTh2NL3p6rPNmHZNG8u5
         ZrWw==
X-Gm-Message-State: ACrzQf359Q8cWcuDAdWbrKGdVbI3wXx5ouSOyY2r3v1d4tNPgfDsinnW
        2UDlLgXsh4vSnPUIzXySp7s+GIvsETuz2Q==
X-Google-Smtp-Source: AMsMyM6WcR1yUYzt6i7jnlsZlqBcBxMplt2tPfP/M3yKE2vw1Wgm/NwcWXrZ0+LL+YDYONQTKXGFaw==
X-Received: by 2002:a17:906:2a93:b0:78d:b87e:6aab with SMTP id l19-20020a1709062a9300b0078db87e6aabmr15213186eje.157.1665666818104;
        Thu, 13 Oct 2022 06:13:38 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id t6-20020a170906268600b0073d81b0882asm3031564ejc.7.2022.10.13.06.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 06:13:37 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oiy1o-004mmQ-2a;
        Thu, 13 Oct 2022 15:13:36 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ignacio Taranto <ignacio.taranto@eclypsium.com>,
        git@vger.kernel.org
Subject: Re: About git reporting missing newline for symlinks
Date:   Thu, 13 Oct 2022 15:11:49 +0200
References: <CAAHd=zcrU3VJro1R3xDj3hmqGXZHUA6rHuDFxwhF5aewNvA8xQ@mail.gmail.com>
 <xmqq7d14k9uh.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqq7d14k9uh.fsf@gitster.g>
Message-ID: <221013.86o7uflvcv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 12 2022, Junio C Hamano wrote:

> Ignacio Taranto <ignacio.taranto@eclypsium.com> writes:
>
>> So, both git diff and git show display "\ No newline at end of file"
>> for symlinks.
>>
>> I think this is related to how Git renders diffs, IMO it shouldn't
>> display a warning about newlines for symlinks.
>>
>> Am I making any sense here?
>
> Yes, but not really.
>
> It is not "warning" at all.  The users want to know when compared
> contents do or do not end with an incomplete line at the end, and
> the "\ No newline" is the diff's way to give that single bit of
> information to us.
>
> And the contents of a symbolic link typically is a single incomplete
> line, so it is expected to see "\ No newline" when comparing them.
>
> This is important as "git diff | git -C ../some/where/else apply"
> should be able to recreate the change in the current repository
> (which may have change to or addition of a symbolic link) in the
> other repository, and "git apply" on the receiving end must be able
> to tell that the symbolic link it needs to create in the other
> repository must not have an extra LF at the end.

In apply.c's parse_fragment() we seem to only care that we find a
"\"-line that's at least the length of "\ No newline...".

I wonder what (if any) compatibility issues we'd have if we emitted
e.g.:

	\ The filename pointed to by the symlink does not end in a newline
