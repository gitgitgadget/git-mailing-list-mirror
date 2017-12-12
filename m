Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5A9D1F404
	for <e@80x24.org>; Tue, 12 Dec 2017 01:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751274AbdLLBFG (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 20:05:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61697 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750759AbdLLBFF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 20:05:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 35ED1B3CAA;
        Mon, 11 Dec 2017 20:05:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yo09ElNII0t15W3twgq/STmboWo=; b=rOHNHk
        Td96v1AsZD45qnECXTEMxFO04NQwXLqEo5/UPg2vD5disexvmOY+DFJwLGzxvmkE
        KtCuHrb3/ssn7/EEyeySX/dTLgYh43rubF20iqzC+pUZ6sJuHqOmRFdiEyeb9WEx
        6i4KRBDwnCi9FVp++K+s0YHQHUzLNgRwDWjWk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uHMqGygwwZhlM9gPKgXnimPg+HV/7PRe
        ECTblMaPbkn1bufGdudbrBs7lFKpppXS40SoxjNj9ilM8TUUPG27/hLA9oNj8euN
        bFsylZYztAtv1h2NfcPClMfWIyBHzvp35hMUMeRzY4dUlZWzMtjmaeHPp8nA1/cS
        NFOEhapfPZM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D460B3CA9;
        Mon, 11 Dec 2017 20:05:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0753EB3C9E;
        Mon, 11 Dec 2017 20:05:03 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Yaroslav Halchenko <yoh@onerussian.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>, kyle@kyleam.com,
        Jeff King <peff@peff.net>
Subject: Re: Q: rational for $XDG_CONFIG_HOME/git/config to be "non global" or just a bug?
References: <20171211211102.rrxqd6yscnd33efd@hopa.kiewit.dartmouth.edu>
        <20171211225615.GC214273@aiede.mtv.corp.google.com>
Date:   Mon, 11 Dec 2017 17:05:01 -0800
In-Reply-To: <20171211225615.GC214273@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Mon, 11 Dec 2017 14:56:15 -0800")
Message-ID: <xmqqtvww3gea.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C75C9EE-DED8-11E7-9FDC-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> I think the documentation
>
> 	~/.gitconfig
> 		User-specific configuration file. Also called "global"
> 		configuration file.
>
> should be clarified --- e.g. it could say
>
> 	$XDG_CONFIG_HOME/git/config
> 	~/.gitconfig
> 		User-specific configuration files. Because options in
> 		these files are not specific to any repository, thes
> 		are sometimes called global configuration files.

Yeah, I think that makes sense.

> As for "git config --global", I think the best thing would be to split
> it into two options: something like "git config --user" and "git
> config --xdg-user".  That way, it is unambiguous which configuration
> file the user intends to inspect or modify.  When a user calls "git
> config --global" and both files exist, it could warn that the command
> is ambiguous.
>
> Thoughts?

I actually thought that the plan was "you either have this, or the
other one, never both at the same time" (and I think those who
pushed the XDG thing in to the system made us favor it over the
traditional one).  So as long as --global updates the one that
exists, and updates XDG one when both or neither do, I think we
should be OK.  And from that viewpoint, we definitely do not want
two kinds of --global to pretend as if we support use of both at the
same time.

