Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D8AA1F404
	for <e@80x24.org>; Fri, 30 Mar 2018 18:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752210AbeC3ScN (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 14:32:13 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:39634 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbeC3ScM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 14:32:12 -0400
Received: by mail-wm0-f53.google.com with SMTP id f125so17899595wme.4
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 11:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3VUqp9lV6cmOEdfgXUHG8p4Ylt0rSq6GtY3X3gV2AiQ=;
        b=b7sBBX/65uQNn1JnN3GfB5JmQjqpTQZNR0BQsi6+UiVbZ228KnoxKkF+LC8MhK1i99
         YAv8j8dovKqlKKltrdknA7n681w/qlkmN39Tue2GFBg92w5wvWsn1OdoN0tn+VY5QpwA
         b+Gk0J0UyHyGjn9TmS1oBydIngBiDdeGf2ySwS9j+y+yYcv9nGtZ7Ulqt1+sOFS/fw69
         fzGlNOfB7OhWC2n8giRfObet0POHWsRuuv30Nh7JfrF2ts/vBU1eabO6Q0sXRWLzFGAX
         t5TMf94LhBLWKqCWvSreVbeo8SM9TxpG/vZgHnK4T5S4SDfCPd/lC26wRETtV0Dv67D1
         7REg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3VUqp9lV6cmOEdfgXUHG8p4Ylt0rSq6GtY3X3gV2AiQ=;
        b=QuVmNI5XxV2QY46yCBWltYCxy5AFm5lfvh98xmWn980cn9fTQWdvqV7l0iKhWse6jK
         T8ILS51CB+qeZDTxdL+CFXCH3aS3X0VaSH0dzN3/gsPzZaN2wAUuC4RUS1xi+Ng9ve4N
         9jj3y97T5ykzjMSIZbO6XzcRj6tklvLAbPh6hD41Oea9g0uad5YWhjMe+77fY30/8Eow
         EJHjgLiClUeTMEmsrZb/lxhHA6Aqa9mZW3M6y3HujNwn/Ki/DRUpRGaDBRXw/kEkDU8B
         kwhgLZum9ahQbirVKuGW6ARkV3TKuQWZzbjn7Xw+QzGKU+0yGZgmMVkxH9tHp1puWPFk
         2F8Q==
X-Gm-Message-State: ALQs6tCG9BkNArj5CTc1hdgCqnferLSkLTkuMsqzFs53oQ++6mMm+zYg
        g8EMefNmDchBu4AwGpPisoI=
X-Google-Smtp-Source: AIpwx48U/ByeBQyUBW5O732RDIqiHuNP9cL7A/h69X0XPiip28nVCO7+MSez25ksCWUYejykl2LebQ==
X-Received: by 10.28.54.6 with SMTP id d6mr2005047wma.32.1522434730538;
        Fri, 30 Mar 2018 11:32:10 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d9sm10752338wmh.38.2018.03.30.11.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Mar 2018 11:32:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] setup.c: reset candidate->work_tree after freeing it
References: <20180330070744.22466-1-pclouds@gmail.com>
        <xmqq7ept4hhj.fsf@gitster-ct.c.googlers.com>
        <CACsJy8DS2pRaDhXgKqFQaqjFft_EW5G=8t9PhNcAgMsSDsS0jA@mail.gmail.com>
Date:   Fri, 30 Mar 2018 11:32:09 -0700
In-Reply-To: <CACsJy8DS2pRaDhXgKqFQaqjFft_EW5G=8t9PhNcAgMsSDsS0jA@mail.gmail.com>
        (Duy Nguyen's message of "Fri, 30 Mar 2018 19:41:02 +0200")
Message-ID: <xmqqo9j52z4m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Mar 30, 2018 at 7:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Which fields in candidate are safe to peek by the caller?  How can a
>> caller tell?
>
> To me, all fields should be valid after
> check_repository_format_gently().

If so, free() is wrong in the first place, and FREE_AND_NULL() is
making it even worse, no?  We learned there is work_tree set to
somewhere, the original code by Peff before abade65b ("setup: expose
enumerated repo info", 2017-11-12) freed it because the code no
longer needed that piece of information.  If we are passing all we
learned back to the caller, we should not free the field in the
function at all.  But it seems (below) the codepath is messier than
that.

> We still need to free and set NULL here though in addition to a
> cleanup interface. The reason is, when checking repo config from a
> worktree, we deliberately ignore core.worktree (which belongs to the
> main repo only). The implicit line near this
> free(candidate->work_tree) is "leave git_work_tree_cfg alone, we don't
> recognize core.worktree". Once we move setting git_work_tree_cfg out
> of this function, this becomes clear.

So in other words, there is a code that looks at the field and it
_wants_ to see NULL there---otherwise that brittle code misbehaves
and FREE_AND_NULL() is a bad-aid to work it around?

Then proposed log message "leaving it dangling is unsanitary" is
*not* what is going on here, and the real reason why the code should
be like so deserve to be described both in the log message and in a
large in-code comment, no?
