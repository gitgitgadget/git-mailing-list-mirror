Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF2D21F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 20:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbeKMGKj (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 01:10:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55911 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeKMGKj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 01:10:39 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2288F1103AA;
        Mon, 12 Nov 2018 15:15:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ngh+g+eewsNeKyTm/SwtEtV40v0=; b=aF9Tk7
        kG7PakhT8blgkqngwIYfYhPyBYC/lo1f0SQ7eIeg0JYVLKwieRS0H6S/RvwlVXn3
        RES2NkE21ZjuvRKVrYowXralQrSe1uJsmeQDPAJPWR0FulYzwf4AF9A4uByDW4QQ
        kG1pzRl5PS8On4Ga+rcjXDUyc0FEnp4s86nFg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WJ/CULCeXwzdNV7MDFCKSfAM6m/saXZK
        YJ95uDsofQjjVD9ggLqVzvf6H4fo42UwC3UhMYSzKXvH1FDFwzGX90ksmZgkuLTw
        AscPYZuCqmdAUhnw1P24IB446uzwFNtuhV4998ibGgYzII6Yg8I8swI6jLOruYpl
        JDkfvt6isi4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 18A161103A9;
        Mon, 12 Nov 2018 15:15:50 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 709101103A7;
        Mon, 12 Nov 2018 15:15:49 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] checkout: print something when checking out paths
References: <20181110133525.17538-1-pclouds@gmail.com>
        <xmqq8t1y3jex.fsf@gitster-ct.c.googlers.com>
        <CACsJy8BGgf0J=iKNc3qmz_rTMNdaPmR_1v+9i3nhGKcuOH4AFA@mail.gmail.com>
Date:   Tue, 13 Nov 2018 05:15:48 +0900
In-Reply-To: <CACsJy8BGgf0J=iKNc3qmz_rTMNdaPmR_1v+9i3nhGKcuOH4AFA@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 12 Nov 2018 17:27:31 +0100")
Message-ID: <xmqqy39yyruz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF246826-E6B7-11E8-87B6-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Another thing I'm going to change (if this v1 is in the right
> direction): print different messages for "git checkout -- foo" and
> "git checkout foo -- bar". The first one is "%d paths have been
> reverted" but the second one does different things and probably should
> say "%d paths have been updated from branch foo" or something like
> that.

I actually think that it is a bad idea to deliberately use such
misleading words like "revert", that will discourage users from
weaning themselves off of SVN.  "checked out N paths out of the
index", "checked out N paths out of the commit X" and "checked out N
paths out of branch B" would be clear enough and won't have such a
problem---otherwise you are encouraging them to make a mistake

	echo garbage >path
	... say oops ...
	git revert path

