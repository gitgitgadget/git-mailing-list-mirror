Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D45F9211B3
	for <e@80x24.org>; Fri, 30 Nov 2018 06:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbeK3Ryy (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 12:54:54 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64449 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeK3Ryy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 12:54:54 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0566D112D25;
        Fri, 30 Nov 2018 01:46:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iAOnK187qBR1P/64oX4MqJIMLAI=; b=Cc4NPI
        ZXgue+wSE2k8/A4D+o7jWBDA9NUZaM8X3kvLIG2QqHojYKIg3vafN+ebgAgXlbzt
        JQmuSwO2QPJtHKm4gDuxMGGx6cB+JUrEedg3okf9GGvHu2rdYJt+2XVXnvvysYyc
        4oDG3/4zma4I1HV7weOp8d3n4p2Vt8U4r78dY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vsDq8DibzPAPAjecUmt06nt/SLsg7Do8
        Bxu/Tq9u/aYQuCmvZpUL5fEIUN6I9mUVccVAqD1j586C/pNJWMMprIV2OVzNAjkg
        2iFxiefmx0Xbi7DPgG+C83VXEs43lOrWpnCL5yAbyc1I04LTvpZYMHax7CkehOlm
        iffXf1SSMTE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F2069112D24;
        Fri, 30 Nov 2018 01:46:34 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 65219112D23;
        Fri, 30 Nov 2018 01:46:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Stefan Xenos <sxenos@google.com>
Subject: Re: [PATCH/RFC v3 00/14] Introduce new commands switch-branch and restore-files
References: <20181127165211.24763-1-pclouds@gmail.com>
        <20181129215850.7278-1-pclouds@gmail.com>
        <xmqqefb3mhrs.fsf@gitster-ct.c.googlers.com>
        <CACsJy8BZ7s2TbqiO+hensOF0quz+N3h5+GwKqiNTakGaGJ2yeA@mail.gmail.com>
Date:   Fri, 30 Nov 2018 15:46:33 +0900
In-Reply-To: <CACsJy8BZ7s2TbqiO+hensOF0quz+N3h5+GwKqiNTakGaGJ2yeA@mail.gmail.com>
        (Duy Nguyen's message of "Fri, 30 Nov 2018 06:41:45 +0100")
Message-ID: <xmqqr2f3kqpi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD7FB410-F46B-11E8-AA84-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>>
>> OK.  Is "auto-vivify the named branch based on a remote-tracking"
>> also rejected, as it is a confusing behaviour that is a too subtle
>> and implicit, just like the detaching head is, and require --guess
>> or sticking to 'git checkout'?  I think it should.
>
> This touches the "remote" concept which I think is another confusing
> thing for new people (your "master" is not the same as the server's
> "master", aka origin/master) and perhaps this dwim thing helps.
> Frankly I don't do dwim much so I don't know if it's that often used.

I actually think a user who sees a DWIM without understanding what
the user wants to do would perceive magic that sometimes works and
sometimes does not, and some other times it does a random thing that
the user does not even understand what is going on.  And such a
random magic that sometimes works, even if the "sometimes" is "most
of the time", say 85% of the time, would not help user form the
right mental model.

"git checkout master~2" that DWIMs to "git checkout --deatch
master~2", but does totally different thing when "git checkout
master" is given, leaving the user confused "what is so different
between these two?".  Until the user realizes 'master' can serve
both as a branch name and a name for a commit object, while master~2
can only be a name for a commit object and is not a branch name, the
behaviour of the command will stay to be mysterious and DWIMmage
would not help user form the right mental model.  I earlier said
that I agree with your decision to leave the implied form out of
switch-branch for exactly that reason.  

The behaviour falls into the same category as "git checkout frotz"
that DWIMS to "git checkout -b frotz -t remotes/origin/frotz", which
also is mysterious until the user understands your 'master' is unique
and is different from 'master' to everybody else, I would think.
