Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E01021F406
	for <e@80x24.org>; Tue, 12 Dec 2017 19:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbdLLTg2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 14:36:28 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64546 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752279AbdLLTgY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 14:36:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA65BC7E75;
        Tue, 12 Dec 2017 14:36:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LVOp5pLruZXaVaEpBAO7sQ6W+0U=; b=EUtDr0
        0O8THF1NtO6GktegqpeDoS/ReOmrUCxCO5+LEmJO+FszGyfBI3ZbpYrmOiBC3eDg
        PaKK7hkFbP1/0OZnfevO5YvQ0j9GkPijXMNfFkZUOnk3RDj5OjS0GcpcGrv/DOx2
        rBhWrbz3HWokFyOpjJw7hOvGpQRMxL4oHkjV0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cu384our+uQpH686XaOyWm2Xk40Da1y5
        liH8Ia3IDZTEchssuDCkKLqSpQTjGvgzEjQVzlDetoGPs610E26Jb+L0/MEVua2N
        kb2ijRoYnbGF0vofTFjoLz84K5Yzv/mz4cceN5Z82e8CgxDItGNsMH94CK2cBIzp
        tf8ulgbZBBU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D82B2C7E74;
        Tue, 12 Dec 2017 14:36:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 465E7C7E71;
        Tue, 12 Dec 2017 14:36:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Yaroslav Halchenko <yoh@onerussian.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>, kyle@kyleam.com,
        Jeff King <peff@peff.net>
Subject: Re: Q: rational for $XDG_CONFIG_HOME/git/config to be "non global" or just a bug?
References: <20171211211102.rrxqd6yscnd33efd@hopa.kiewit.dartmouth.edu>
        <20171211225615.GC214273@aiede.mtv.corp.google.com>
        <xmqqtvww3gea.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xpH6M-FqRJcvsbv=mjj1T04GR6pxz-4NkTmGZUgUKU6wQ@mail.gmail.com>
Date:   Tue, 12 Dec 2017 11:36:22 -0800
In-Reply-To: <CA+P7+xpH6M-FqRJcvsbv=mjj1T04GR6pxz-4NkTmGZUgUKU6wQ@mail.gmail.com>
        (Jacob Keller's message of "Tue, 12 Dec 2017 01:36:17 -0800")
Message-ID: <xmqqshcf20y1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC6F185C-DF73-11E7-A4BD-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

>> I actually thought that the plan was "you either have this, or the
>> other one, never both at the same time" (and I think those who
>> pushed the XDG thing in to the system made us favor it over the
>> traditional one).  So as long as --global updates the one that
>> exists, and updates XDG one when both or neither do, I think we
>> should be OK.  And from that viewpoint, we definitely do not want
>> two kinds of --global to pretend as if we support use of both at the
>> same time.
>
> It appears that we actually prefer ~/.gitconfig rather than XDG_CONFIG_HOME..
>
> And at least based on current cursory testing on the command line, we
> do both read and write to the proper location, assuming that
> ~/.gitconfig is preferred over $XDG_CONFIG_HOME.

OK, so I misremembered the details but it seems that the behaviour
is consistent and there is no ambiguity?  

Am I reading you correctly?
