Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECB7C77B7D
	for <git@archiver.kernel.org>; Thu, 18 May 2023 16:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjERQ2O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 12:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjERQ2N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 12:28:13 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4A1F4
        for <git@vger.kernel.org>; Thu, 18 May 2023 09:28:12 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-51452556acdso1505350a12.2
        for <git@vger.kernel.org>; Thu, 18 May 2023 09:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684427292; x=1687019292;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUZISBQSYK81qYVjXYfiDg4LlTOtJJRy1ob8qSRBGRY=;
        b=M/F+FGkSUONo9h4ERMwq50echXPIqOBnjSQSt9DYde+4Hjf5W2fOjGGmYwqkw9QjdB
         p0d0j8/3mYyzTl3BpXvPOUPolhf8tNUBGEqF9gzkK4cK0oFIohbCrJqkVmdAMe2j8IuQ
         nui5bP7SBSwUochkppouRs5NURVgomVbyy81FIoaoz9WmIT/56bj2cFJgNuOBq2ut9Du
         ncbP+amHwHyOGcaLT0LpViXZEBEGBxlknbXp5rcTaD0tOIfw3a9Y40g9JFJ+Wz/uB0KW
         6+VpTEikd+dETQV5y1CZa9ijVQlM4BVslXn7xQXB8JCJ77fuQZioRCL9i4jwSRQC4vk/
         V7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684427292; x=1687019292;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oUZISBQSYK81qYVjXYfiDg4LlTOtJJRy1ob8qSRBGRY=;
        b=P6bZ3ZfAL8CvYpS/jEtN37QWrXealTftkaX5tUxF4K70t1aJ8FNpdp+mSfr6GU4pjH
         64bdVSjNm78L/HU4qESKQ4BvTToOHc5ecN8FLveTKFdneI0zqeM/VC9cUt257hoQAF6I
         VYmAjbLVj7lEcs6Cna5pM9yJMlsQGYdnqylWT1DmS7IIZ+0t7HMR68MwdN9C2R3WI0Hc
         0NnGiWkHVTbhMeR4ZS2I1+G11uwCyIeHNoR5XWCf7p+tAIRSNB8UIq5FIqxDsG5XvlCt
         epmbJ+eYibsNfulN/NsukqicttfbEwQIz0/8eSfh0iuFX5YimB/x41m91Y+RbgwLzw9K
         DUQw==
X-Gm-Message-State: AC+VfDzGv3Ox6lIGXMLTvEmeQ5HdJePpZDk2x2jNJNMG1djyzaNhdadp
        hBGGme20eTCjusM9V4OcxZg=
X-Google-Smtp-Source: ACHHUZ763E+N5VDPbqRXOhg4pM6HlxPK6jF5bkagr4PnBrhNytN9tZtDNWqhXraedkFR4xTSYYmtOA==
X-Received: by 2002:a17:902:db07:b0:1a6:b496:4053 with SMTP id m7-20020a170902db0700b001a6b4964053mr3687504plx.59.1684427291610;
        Thu, 18 May 2023 09:28:11 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id iz20-20020a170902ef9400b001ac7f583f72sm1626546plb.209.2023.05.18.09.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 09:28:10 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v2] sequencer: beautify subject of reverts of reverts
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
        <3f5e4116-54e6-9753-f925-ed4a9f6e3518@gmail.com>
        <ZGSlqAPwaLhgWm6v@ugly>
        <2d416834-ef3e-01a2-6be0-9e88bc0de25e@gmail.com>
        <ZGUIqBU0+Vr5LSBF@ugly>
        <10523968-0f02-f483-69c4-24e62e839f70@gmail.com>
Date:   Thu, 18 May 2023 09:28:10 -0700
In-Reply-To: <10523968-0f02-f483-69c4-24e62e839f70@gmail.com> (Phillip Wood's
        message of "Thu, 18 May 2023 10:58:26 +0100")
Message-ID: <xmqqmt21txid.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>>> (i.e. at that point we stop trying to be clever) rather than
>>>
>>>     Revert "Reapply "Revert some subject""
>>>
>> right.
>>
>> how about filing that under GIGO and extending the comment?
>> i mean, when you actually run into this situation, you should be
>> re-thinking your life choices rather than stressing about git
>> producing a somewhat suboptimal commit message template ...
>
> Given that it is simple to handle this case and Junio is expecting a
> re-roll of this topic[1] then I think it would be worth just adding
> those three lines.

Phillip, your first message with these three lines were a bit dense
to understand (in other words, to me, it did not immediately "click"
how these lines contribute to avoiding the revert-reapply-revert
sequence that is awkward).

But after reading the exchange bewteen you two [*], your suggestion
makes quite a lot of sense to me.  It is better for a code to behave
in a dumb but explainable way, than to attempting and failing to act
too clever for its own worth.

Oswald, I do not think GIGO is really an excuse in this case, when
the only value of the topic is to make the behaviour less awkward by
creating something better than a repeated revert-revert sequence,
revert-reapply-revert is worse, as it is markedly harder to guess
what it really means for a reversion of revert-revert-revert than
"revert" repeated four times.  If anything, it is the cleverness of
"lets call revert of revert a reapply" code without Phillip's
suggestion that creates a garbage output, no?

Thanks.


[Footnote]

 * Oswald, please refrain from using Mail-Followup-To; I wanted to
   deliver the contents of this message specifically to you and
   Phillip, but Phillip's MUA followed your Mail-Followup-To and
   lost your address, which made me look it up and add it myself.

   Please refer to these first before saying "I use it because..."
   if you are going to respond:

   https://lore.kernel.org/git/7v4pndfjym.fsf@assigned-by-dhcp.cox.net/
   https://lore.kernel.org/git/7vei7zjr3y.fsf@alter.siamese.dyndns.org/
