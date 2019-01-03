Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 874B41F803
	for <e@80x24.org>; Thu,  3 Jan 2019 19:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfACTbj (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 14:31:39 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38021 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727342AbfACTbi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 14:31:38 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so31421835wml.3
        for <git@vger.kernel.org>; Thu, 03 Jan 2019 11:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6CYOsxbjV5NiM+zvasXZiY25MoWGYnN9NKnlDiclPdc=;
        b=UgIBPYzmecbs+2UCfPQPBX080re/jI++pcBLarzTxvhrdJv5lVxKyZE8/uL0mWP04W
         RZw4DibLSusATc75h4AQ7dIL0sILyafu2tNCAsi80ZAgdMy9yEDefuOxMivmdrbfnUGl
         A2nmYW1TxFLQFbdebLBPNts4EZv92YiKOOhk2yAIsVrJp+fUGPXxM+GbQdCqtO8PE0QE
         V0ABL6DK2XApBpseDtpCmGl0Pl0pTX/0Agz9xsRAtSMKppNgLHX6IXUsor4YpsO1pc9h
         wEJVe+PgGkAWbM7T7KTeTgSWkfaABD5KDA4k4puh4J6Fglhm92yaSIGn1CROGi1OV4mA
         mfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6CYOsxbjV5NiM+zvasXZiY25MoWGYnN9NKnlDiclPdc=;
        b=pAhl2H9FvSARjm1I3nzOmANUqlYEt+keaN3OG1CpmoXhLHEta7yfqwFgGuD3NLvOig
         XsbuKQ7nN2SCBjFAxYQQVpRVo7Kb1t24AYMObqALJSJt1JB2+SDiEGKc5gGB+mJ1d8q5
         FOGV1TnMOihTr/QmZRBtkRRwLkMlZ54SPRIrB9q2Iyf/IF6+CsptcxU6QS/ldDah5Hnv
         bLmvRSBKy9XXFe+WR+pk0f9keu9CSNXuy5dunooiCJRWkLGJWMHRY2dikjfaBiZErcDR
         Jrh6KIS74e+JNqTC1qvrka5HnWUT6Wx+772JcDYPyNDjycS1o1qqEiGC/vouIPZwPMyF
         NKMg==
X-Gm-Message-State: AA+aEWZYeu8KXrqOfOFAko+E22X28c238lBclnD3cBNsOGfNImUwXaDN
        TZWcpAteea7feA1ciNkk9ss=
X-Google-Smtp-Source: AFSGD/VrKuWxOrSOuO1uebo9mWs53YyYTZTmUi/zHEsvi/9TCBadVFciaevrooh6zRxb73G9Z4IhxA==
X-Received: by 2002:a1c:5f8a:: with SMTP id t132mr40562217wmb.40.1546543895360;
        Thu, 03 Jan 2019 11:31:35 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l19sm43400590wme.21.2019.01.03.11.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 11:31:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     randall.s.becker@rogers.com, git@vger.kernel.org,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v4 1/4] transport-helper: use xread instead of read
References: <20181228233556.5704-1-randall.s.becker@rogers.com>
        <xmqqbm4ykcdk.fsf@gitster-ct.c.googlers.com>
        <20190103071632.GB24149@sigill.intra.peff.net>
Date:   Thu, 03 Jan 2019 11:31:34 -0800
In-Reply-To: <20190103071632.GB24149@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 3 Jan 2019 02:16:33 -0500")
Message-ID: <xmqqpntdh71l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Jan 02, 2019 at 12:55:51PM -0800, Junio C Hamano wrote:
>
>> > Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
>> > ---
>> >  transport-helper.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/transport-helper.c b/transport-helper.c
>> > index bf225c698f..a290695a12 100644
>> > --- a/transport-helper.c
>> > +++ b/transport-helper.c
>> > @@ -1225,7 +1225,7 @@ static int udt_do_read(struct unidirectional_transfer *t)
>> >  		return 0;	/* No space for more. */
>> >  
>> >  	transfer_debug("%s is readable", t->src_name);
>> > -	bytes = read(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
>> > +	bytes = xread(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
>> > - 	if (bytes < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
>> > - 		errno != EINTR) {
>> > + 	if (bytes < 0 && errno != EINTR) {
>> >  		error_errno(_("read(%s) failed"), t->src_name);
>> 
>> Can't we also lose EINTR check, though?  When read() returns
>> negative, we check errno and if it is EINTR, continue the loop.
>
> Yes.
>
> I also wondered if this caller might actually be relying on the current
> non-looping behavior, but it looks like I already traced through and
> determined this was OK:
>
>   https://public-inbox.org/git/20180111063110.GB31213@sigill.intra.peff.net/
>
> (the cleanup is correct either way, but that is what makes the
> conversion to xread() OK).
>
> We may want to just take the xread() conversion and then do the patch
> that I linked above on top, since it also cleans up the xwrite() spot,
> too.

OK.  That does sound cleaner.
