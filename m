Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D987E2047F
	for <e@80x24.org>; Thu, 28 Sep 2017 04:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751674AbdI1Erc (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 00:47:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53964 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751042AbdI1Erc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 00:47:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A254B9D32C;
        Thu, 28 Sep 2017 00:47:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uiLxRjI+x4zGayIbR+1bHgKpHuI=; b=qsHmq5
        4Skq5r+KkS1tMCRglxcgHl8KmfG7etdg3HoWXmgtrjxQzYSgUm6mYnvmcVG0SVcN
        5XBdtkBoC8wXlcHvDnf4nRQArn2A4mVfcBXOsQx4+QgbyIhM418tngjceXeo8PGs
        cLvkygtsUyG61DrZjzh4WwwHVW78wcMXqXBgo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Aq3BX4+SqeYGZN1lZu/7Tsre6+HFGdbU
        4lbR1SiTKpJE1hHBRFxE0TmqytD1wASX+yo428+qqlzS/apne7Fl3gapv9sMKH/y
        +KNcGWT9YgsOyI1sY+K5gFZsLogjShtLQlvKYtM5sVl7aijYtT3brHgSweV0KUBo
        URUQjLha9Cw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 99CD99D32B;
        Thu, 28 Sep 2017 00:47:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 066F59D32A;
        Thu, 28 Sep 2017 00:47:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Max Kirillov <max@max630.net>
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] gitk: expand $config_file_tmp before reporting to user
References: <20170928041417.28947-1-max@max630.net>
        <xmqq4lrn30bz.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 28 Sep 2017 13:47:29 +0900
In-Reply-To: <xmqq4lrn30bz.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 28 Sep 2017 13:37:36 +0900")
Message-ID: <xmqqzi9f1lb2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22E7F88A-A408-11E7-B10A-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Max Kirillov <max@max630.net> writes:
>
>> Tilda-based path may confise some users. First, tilda is not known
>> for Window users, second, it may point to unexpected location
>> depending on various environment setup.
>>
>> Expand the path to "nativename", so that ~/.config/git/gitk-tmp
>> would be "C:\Users\user\.config\git\gitk-tmp", for example.
>> It should be less cryptic
>
> It might be less cryptic, but for those of us whose $HOME is a
> looooooong path, ~/.config/git/gitk-tmp is much easier to understand
> than the same path with ~/ expanded, which would push the part of
> the filename that most matters far to the right hand side of the
> dialog.
>
> I somehow find this change just robbing Peter to pay Paul.

Having said that, because a set-up might have HOME or XDG_CONFIG or
other things misconfigured to point at a place where the end user
may not be expecting, I tend to think that catering to Paul by
showing the information closer to the bare metal is much more worthy
thing to do than keeping Peter happy.  Since this is an error path,
accuracy trumps convenience.

So no objection from me (unless somebody else comes up with an
alternative that would make both camps happy, that is).

Thanks.

