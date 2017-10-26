Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC2592055E
	for <e@80x24.org>; Thu, 26 Oct 2017 05:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751166AbdJZFi7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 01:38:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60939 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750884AbdJZFi6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 01:38:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D791D9B4C2;
        Thu, 26 Oct 2017 01:38:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HkdsDt8hg5Rx1a8Yrf3Nl9hDjPQ=; b=B+a/BW
        crcnBpLVjuRh7IVrxMQhXGbNnJZYgllv5c/uGj43LtMQm/+khfI08hofzK5oap7n
        fZd0p+vEOCorVS69831Jor5kpAP2arN8B8MfxgSrevFYWIvzg5p4E0Fi2V2O85Vn
        4rUD788TEOjkz4JgL6pfVx/Xq0AqOUKLljLL8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K8A7LbTrPbws+qrtTeV0NpE2Ggtx31zx
        EOPBHpR0cHqorMn37lzaZeTM1p1lkIDuYB7LklVuf9mnzX/7TwVGs2KoO0tkm+Be
        VzjccFFr3bb/hU9fJ1TRRN9wzpUoS1Ts0spOptMqHi6MDGw8YXOL9oGxoi9c/zGA
        J5EDR0R9Y+Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CDB649B4C0;
        Thu, 26 Oct 2017 01:38:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 36C849B4B6;
        Thu, 26 Oct 2017 01:38:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/6] Create Git/Packet.pm
References: <20171019123030.17338-1-chriscool@tuxfamily.org>
        <alpine.DEB.2.21.1.1710260008270.37495@virtualbox>
Date:   Thu, 26 Oct 2017 14:38:56 +0900
In-Reply-To: <alpine.DEB.2.21.1.1710260008270.37495@virtualbox> (Johannes
        Schindelin's message of "Thu, 26 Oct 2017 01:10:05 +0200 (CEST)")
Message-ID: <xmqq4lqmfoy7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6075F36-BA0F-11E7-89DA-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Note that the correct blib path starts with `C:\BuildAgent\_work` and
> the line
>
> 	use lib (split(/:/, $ENV{GITPERLLIB}));
>
> splits off the drive letter from the rest of the path. Obviously, this
> fails to Do The Right Thing, and simply points to Yet Another Portability
> Problem with Git's reliance on Unix scripting.

In our C code, we have "#define PATH_SEP ';'", and encourage our
code to be careful and use it.  Is there something similar for Perl
scripts, I wonder.

I notice that t/{t0202,t9000,t9700}/test.pl share the same
split(/:/, $ENV{GITPERLLIB}); forcing this specific variable to use
the non-platform convention to accomodate the use of split(/:/)
certainly is a workaround, but it does feel dirty.

It is hard to imagine that we were the first people who wants to
split the value of a variable into a list, where the value is a list
of paths, concatenated into a single string with a delimiter that
may be platform specific.  I wonder if we are going against a best
practice established in the Perl world, simply because we don't know
about it (i.e. basically, it would say "don't split at a colon
because not all world is Unix; use $this_module instead", similar to
"don't split at a slash, use File::Spec instead to extract path
components").

