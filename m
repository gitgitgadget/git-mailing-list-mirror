Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E79C20A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 01:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbeLIBaq (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 20:30:46 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58212 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbeLIBaq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 20:30:46 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 17471112F32;
        Sat,  8 Dec 2018 20:30:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Cokd3jl14ExCaU518azqFNiMyXw=; b=QDAQE1
        YMfeLoxWqhcjFV53lqkBZl00NigkG+2UB5ZqvyXHwKxVN6K5dfSi6uxjdtPcTQHW
        /eWwvNPS9oBDO5fqFIE1nhD9RfPG+nTudexQreHKm3G4AbtIzXh/Hgy6XLAXVDg2
        oLZokxxeu1cCEqEqBMHgT0zUf3zxrK04Mki/E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pn7CGUkBAUap72nTV3TFLvdhLzVheXpR
        D/K86kZ8SY6qxeVZ1QMQrKPjsd4zM9+rZ6yhOBANyCOuqmqCxmgmiMlnO3zFw5b0
        tqbdE+QG3EgdU8STWxbzDpXRrh8fRaSSxMRsuNMfSIgWq/imURz/PAchWcv4FFbV
        NhWgI5SvtsA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 11481112F31;
        Sat,  8 Dec 2018 20:30:44 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 86044112F30;
        Sat,  8 Dec 2018 20:30:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Weiske <cweiske@cweiske.de>
Cc:     git@vger.kernel.org
Subject: Re: Bug: git add --patch does not honor "diff.noprefix"
References: <c165fc5f-c452-fb2e-8ac3-d2afb12948bc@cweiske.de>
Date:   Sun, 09 Dec 2018 10:30:42 +0900
In-Reply-To: <c165fc5f-c452-fb2e-8ac3-d2afb12948bc@cweiske.de> (Christian
        Weiske's message of "Thu, 6 Dec 2018 11:34:43 +0100")
Message-ID: <xmqqsgz75vwd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B9E58D4-FB52-11E8-9F96-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Weiske <cweiske@cweiske.de> writes:

> When running "git add -p" on git version 2.19.2 and "diff.noprefix" set
> to true, it still shows the "a/" and "b/" prefixes.
>
> This issue has been reported in 2016 already[1], but is still there in
> 2.19.2.

It is very likely because it is a non-issue.  

The reason why prefixes are customizable is to match the convention
used to show your patch to others, but the patch to be immediately
consumed within an "add -i/-p" session is viewed only by the user,
so it is much much lower priority to change the code.  I guess the
reason why no such change was made is because nobody felt it worth
the trouble to change the code to use a non-standard prefix when
producing the patch to be shown, and then also change the code to
accept a non-standard prefix when using the chosen patch to be
applied.
