Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 827D920193
	for <e@80x24.org>; Fri, 28 Oct 2016 02:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034437AbcJ1Chl (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 22:37:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59626 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1034365AbcJ1Chk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 22:37:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F25444B0B1;
        Thu, 27 Oct 2016 22:37:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iU1or0ixGS7N8wQSPePoNNJ0elM=; b=pjhM+2
        LGt448ci3gnJXT3NSTnVyiB/TYB/rlJAioDCBy8u70ObULxyMkVm5tmC8GDLXj00
        BXt/GVB8gDtCWH7ZGz4P2JuPVzbEQU9/ztj2v1R4rT4yHn0FgXWPRKuuWHu5kdVn
        Gi5dUbT86k9yo0FEpQnKH8DsNpjLjx5DozURY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RDFvodkZDbu3xHz0nx7YzCt8XHi7rR+A
        Dm0WY8+Ar+vPnrEWXZJB9mqupZjudmZ9LTYAlFIMcbYtrfz/pqLRnX1Bcj7oOweO
        1I7jaOLI6DndCdtpUM/5rhOmiMvPqIq13T4j3KUcQhZHXOb9NbNku1HGILksHR3k
        D4LsaCvVC7E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E87D84B0B0;
        Thu, 27 Oct 2016 22:37:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5767F4B0AF;
        Thu, 27 Oct 2016 22:37:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/3] sha1_file: open window into packfiles with O_CLOEXEC
References: <alpine.DEB.2.20.1610251327050.3264@virtualbox>
        <20161025181621.4201-1-gitster@pobox.com>
        <20161025181621.4201-3-gitster@pobox.com>
        <20161026042555.neaxvnmggtcku5cc@sigill.intra.peff.net>
        <xmqqa8drcc5i.fsf@gitster.mtv.corp.google.com>
        <20161026164746.2fu57f4pji5qdtnh@sigill.intra.peff.net>
        <xmqqpomnatg6.fsf@gitster.mtv.corp.google.com>
        <20161026201721.2pw4slsuyhxhcwxj@sigill.intra.peff.net>
        <xmqqd1imbymi.fsf@gitster.mtv.corp.google.com>
        <20161027102419.dbzigj7wtr355ofh@sigill.intra.peff.net>
        <CA+55aFwfhFqV74s_O=GucycY9U19ysiACDqX=mK4Gf=eQ0coxQ@mail.gmail.com>
        <xmqqoa254czs.fsf@gitster.mtv.corp.google.com>
        <CA+55aFxTHF4BRfcrCiV1D26-be+_rPhwAV+Vq8Roz-NMpPBadg@mail.gmail.com>
        <CA+55aFxdy4maom8byH0FoBBMWx+sQB8J7uWvHOxswjiaAhSjVg@mail.gmail.com>
        <xmqqfunh4b63.fsf@gitster.mtv.corp.google.com>
        <CA+55aFw83E+zOd+z5h-CA-3NhrLjVr-anL6pubrSWttYx3zu8g@mail.gmail.com>
        <xmqqa8dp46wx.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 27 Oct 2016 19:37:35 -0700
In-Reply-To: <xmqqa8dp46wx.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 27 Oct 2016 18:08:14 -0700")
Message-ID: <xmqq60od42s0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7DBB5C42-9CB7-11E6-91C1-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> On Thu, Oct 27, 2016 at 4:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> Would the best endgame shape for this function be to open with
>>> O_NOATIME (and retry without), and then add CLOEXEC with fcntl(2)
>>> but ignoring an error from it, I guess?  That would be the closest
>>> to what we historically had, I would think.
>>
>> I think that's the best model.
>
> OK, so perhaps like this.

Hmph.  This may not fly well in practice, though.  

To Unix folks, CLOEXEC is not a huge correctness issue.  A child
process may hold onto an open file descriptor a bit longer than the
lifetime of the parent but as long as the child eventually exits,
nothing is affected.  Over there, things are different.  The parent
cannot even rename(2) or unlink(2) a file it created and closed
while the child is still holding the file descriptor open and the
lack of CLOEXEC will make the parent fail.  I do not know how well
fcntl(2) emulation works on Windows, but I would not be surprised
if J6t or Dscho comes back and says that FD_CLOEXEC given to F_SETFD
would not work while O_CLOEXEC given to open(2) does.
