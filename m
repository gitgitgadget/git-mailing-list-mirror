Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1BE5207EC
	for <e@80x24.org>; Fri, 23 Sep 2016 17:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761246AbcIWRNr (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 13:13:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58812 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1760368AbcIWRNq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 13:13:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB5063E6F4;
        Fri, 23 Sep 2016 13:13:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PmChhU4p8Fma2Hpjje6Mr8cYEhQ=; b=NlSicW
        rIERewQxUelW7fvUDvxsneU+BmYOTU9Wqu5WAO2wqVbzK4kA7qWDYEJw5xWQghVo
        p62m78FlwDmikJb6GoP29Z7MpTJ9wtHtJ+YcwTxecpdi6blEYzCxrAz+uBepZl7L
        c+cHzF8HY9taSf8fe6wt1uvFy4MUylBvHSy38=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=taCDDKb2jL/T5YEdTBggTYe9nPjoklCj
        DWLpZj9MF7o9ywI08fBqwFdnzpchyiMclZIDfhwoFVONG0OOu+NLXZNA3NwSm7eI
        QRoU6FdEy8X6DfOwlxtYkQwDz2KzwaXS6pGMS0bFlZ99rm1thF2F1EmhpWjNwjy5
        NZWENO2pcoc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C36D63E6F3;
        Fri, 23 Sep 2016 13:13:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 466BB3E6F2;
        Fri, 23 Sep 2016 13:13:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] run-command: async_exit no longer needs to be public
References: <78f2bdd0-f6ad-db5c-f9f2-f90528bc4f77@ramsayjones.plus.com>
        <58164A5E-AC93-48A9-9139-B69CFB854CA8@gmail.com>
Date:   Fri, 23 Sep 2016 10:13:42 -0700
In-Reply-To: <58164A5E-AC93-48A9-9139-B69CFB854CA8@gmail.com> (Lars
        Schneider's message of "Fri, 23 Sep 2016 10:26:02 +0200")
Message-ID: <xmqqmviy1qux.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1502A0E6-81B1-11E6-9509-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> If you need to re-roll your 'ls/filter-process' branch, could you please
>> squash this into the relevant commit c42a4cbc ("run-command: move check_pipe()
>> from write_or_die to run_command", 20-09-2016).
>> 
>> [Note that commit 9658846c ("write_or_die: handle EPIPE in async threads",
>> 24-02-2016) introduced async_exit() specifically for use in the implementation
>> of check_pipe(). Now that you have moved check_pipe() into run-command.c,
>> it no longer needs to be public.]
>
> Hi Ramsay,
>
> thanks for noticing this. I actually hope that I don't need another re-roll :-)
> If I don't re-roll. Should I make a patch with this cleanup or do you
> take care of it?

I can just squash the the patch you are responding to into c42a4cbc,
with an additional paragraph "While at it, retire async_exit() as a
public function as it no longer is called outside run-command API
implementation", or something like that.

I do not offhand know if the topic is otherwise ready as-is, or
needs further work.  When you need to reroll, you'd also need to
fetch from the result of the above from me first and then start your
work from it, though, if we go that route.


