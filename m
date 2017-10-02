Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ACA020A10
	for <e@80x24.org>; Mon,  2 Oct 2017 00:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751075AbdJBAjs (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 20:39:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52423 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750947AbdJBAjr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 20:39:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 07032B6439;
        Sun,  1 Oct 2017 20:39:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eE6yau1knUlJ3kQeS/yxS/jhXnM=; b=qILWTM
        TK8wFXn025WBfL2Ar8FOKM64pQtT3bdP5K0D7cvljaeGDqaBaVHnbtf4qY0dJZwD
        lQHrBMfS+BtHG5qY/ieFzBkILXZKhIyuEKTkBotxy9bOYPaR9m7oD3B6yA5zreBS
        wfbW2nQuBaM2Psj69tCCNQzuYjoQPZ9ETNE/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lVg9An1QPChDbFmA+jiVA+uIIlieN6wb
        D2PTCXSwvhUudoIv61C1UdAsuFn0JxOqFD32l9NUVcM7PZvKu37eT9VX4RBl7BiE
        XIkAfxUqAbq8LtJ+fJTz00CzFEEKE4rTInKOL3QhBAOSgYu2a9i9AesWqpCjiGSO
        Mn2L/lWeM6s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F1306B6438;
        Sun,  1 Oct 2017 20:39:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5F286B6435;
        Sun,  1 Oct 2017 20:39:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org, hanwen@google.com,
        sbeller@google.com
Subject: Re: [PATCH v6 0/3] Incremental rewrite of git-submodules
References: <xmqq4lrrfjt9.fsf@gitster.mtv.corp.google.com>
        <20170929094453.4499-1-pc44800@gmail.com>
Date:   Mon, 02 Oct 2017 09:39:45 +0900
In-Reply-To: <20170929094453.4499-1-pc44800@gmail.com> (Prathamesh Chavan's
        message of "Fri, 29 Sep 2017 15:14:50 +0530")
Message-ID: <xmqqo9pqs7qm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3095798A-A70A-11E7-868D-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prathamesh Chavan <pc44800@gmail.com> writes:

> * The function get_submodule_displaypath() was modified for the case
>   when get_super_prefix() returns a non-null value. The condition to check
>   if the super-prefix ends with a '/' is removed. To accomodate this change
>   appropriate value of super_prefix is passed instead in the recursive calls
>   of init_submodule() and status_submodule().

OK.

> * To accomodate the possiblity of a direct call to the function
>   init_submodule(), a callback function init_submodule_cb() is introduced
>   which takes cache_entry and init_cb structures as input params, and
>   calls init_submodule() with parameters which are more appropriate
>   for a direct call of this function.

OK.

> * Similar changes were even done for status_submodule(). But as it was
>   observed that the number of params increased a lot due to flags
>   like quiet, recursive, cached, etc, and keeping in mind the future
>   subcommand's ported functions as well, a single unsigned int called
>   cb_flags was introduced to store all of these flags, instead of having
>   parameter for each one.

Use of a flag word instead of many bit parameter is a very good
idea.  I do not think it is brilliant to call a field in a structure
that is used as an interface to the callback interface cb_flags,
though, especially when it is already clear that it is about the
callback from the name the structure.  Just name them "flags".

I may or may not leave more detailed comments on individual patches.

Thanks.
