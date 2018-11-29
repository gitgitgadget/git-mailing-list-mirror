Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4214E211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 06:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbeK2Rqr (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 12:46:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60231 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbeK2Rqr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 12:46:47 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 90BDB1065C7;
        Thu, 29 Nov 2018 01:42:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=iB5bOuw+fh0Z
        PMJmvpVqny9A4+Y=; b=IoVLmrXjj/xf5X/REqBlu3hPH/3DXLSLEufz6FWvzQ30
        7dn/MxtXozo+qKe+ZnD1oldOre0mufnkaH0wvCFdiHD6R85uEgJ4/94i37gi9n07
        c9SiLD9cL2cPkmfh4vQY3AeuD//r31oJHL3cm6sGQn9dw+GnU5A7/mOhT7ZFflM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=h0IrZj
        f7WUH3vxwxaIgrkL1IR39pELl9BcMt5SFP9cZ7GZWZh4M7XvhgXIrsDP/3YQ1jir
        FElNEkmGWFVyl4JAizwFQ33XwdPmqAlOZRHxzeUsI0AEXa7K0ryXXAhCbm6vGgYx
        23kVwbrNkRGTGgKAf9RV3YwtaVT+BtBSsIVe4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8774C1065C6;
        Thu, 29 Nov 2018 01:42:27 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E8F9B1065C5;
        Thu, 29 Nov 2018 01:42:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/5] test-lib: add support for GIT_TODO_TESTS
References: <20181127225445.30045-1-avarab@gmail.com>
        <20181127225445.30045-5-avarab@gmail.com>
Date:   Thu, 29 Nov 2018 15:42:25 +0900
In-Reply-To: <20181127225445.30045-5-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 27 Nov 2018 23:54:45 +0100")
Message-ID: <xmqqk1kwo04u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EF96002C-F3A1-11E8-AEB6-063AD72159A7-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> -To skip tests, set the GIT_SKIP_TESTS variable. Individual tests can
> -be skipped:
> +To skip tests, set either the GIT_SKIP_TESTS or GIT_TODO_TESTS
> +variables. The difference is that with SKIP the tests won't be run at
> +all, whereas they will be run with TODO, but in success or failure
> +annotated as a TODO test.

It is entirely unclear what "They will be run with TODO" means.

I know what you want to achieve from the code change; instead of
just skipping, you want to cause as much side effect the skipped
test piece wants to make until it fails and dies, without taking
the remainder of the test down.  And I kind of agree that sometimes
such a mode would be very useful (i.e. when you do not want to
bother separating such a failing test properly into the setup part
that would affect later tests and the one-thing-it-wants-to-test
part that can now be safely skipped).  From the cursory look, the
code change in this patch is sensible realization of that idea.

Having said all that, I won't picking this up until next month ;-) I
really want to see that everybody is concentrating on making sure
that 2.20 is solid before playing with shiny new toys.

Thanks.

