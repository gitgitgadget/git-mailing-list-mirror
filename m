Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE0B4202A2
	for <e@80x24.org>; Tue, 17 Oct 2017 02:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756262AbdJQCkm (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 22:40:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57223 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752925AbdJQCkm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 22:40:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 639BFB73E8;
        Mon, 16 Oct 2017 22:40:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=af2GlLSJSSALSSBPYc3k4SuvVck=; b=SuIOcq
        To+EFHAlLbt6qziJIaE83lDkgvqXaOlpuw5pJp53MIT0Lppo6Oi+PZogGpXFRfct
        ceN37Z9ywSfUSr/Snvu0YROnaU5a8vTJWAvczulf+smISqOiXpG2sddGa9IhjZcV
        G1tFij53l9eZoiM+WDqoS8OeMIVeSNwg274xc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dGxGU09X0XfnBttT4/03rPl6qjmB3I2W
        m9bSsJCAvELRDbLXCi2eQcSl8i40yjsOXJqgmuhUkEXzvCfYa886OzRrih06iCe9
        +LZQDC9gwVKyTWfA9DWphtB/nZ26jGOfayaQm94PTnhcwUb59ylJq0093uP5rbVE
        NUWZ4vV0ti8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5ACFCB73E6;
        Mon, 16 Oct 2017 22:40:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B1690B73C6;
        Mon, 16 Oct 2017 22:40:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Marko Kungla <marko.kungla@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] check-ref-format: require a repository for --branch
References: <CAKY_R-uk9hpR2hbkPsw2cqoMo6bQKoyp6cWTO20L3fOWfLW2-Q@mail.gmail.com>
        <20170714180313.apsnbnw7no2nvtf5@sigill.intra.peff.net>
        <20170714181831.fvi2coppzhm747mk@sigill.intra.peff.net>
        <20170717172709.GL93855@aiede.mtv.corp.google.com>
        <20170817102217.3yw7uxnkupdy3lh5@sigill.intra.peff.net>
        <xmqqinffsibr.fsf@gitster.mtv.corp.google.com>
        <xmqq1sm3s751.fsf@gitster.mtv.corp.google.com>
        <20171017012718.GC19335@alpha.vpn.ikke.info>
Date:   Tue, 17 Oct 2017 11:40:17 +0900
In-Reply-To: <20171017012718.GC19335@alpha.vpn.ikke.info> (Kevin Daudt's
        message of "Tue, 17 Oct 2017 03:27:18 +0200")
Message-ID: <xmqq376iqyy6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8396B8DE-B2E4-11E7-9F8A-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <me@ikke.info> writes:

>> +	setup_git_directory_gently(&nongit);
>> +
>> +	if (!nongit)
>> +		malformed = (strbuf_check_branch_ref(&sb, arg) ||
>> +			     !skip_prefix(sb.buf, "refs/heads/", &name));
>> +	else
>> +		malformed = check_branch_ref_format(arg);
>> +
>
> Would it make sense to swap the logic and get rid of the double
> negative (!nongit)?

I am trying to follow the pattern "handle the normal case that have
been supported forever first, and then handle new exception next",
so that it is easier to see that there is no behaviour change in the
normal case, so I do not think it makes it easier to see to swap the
if/else cases.
>
>> +	if (malformed)
>>  		die("'%s' is not a valid branch name", arg);
>> -	printf("%s\n", sb.buf + 11);
>> +	printf("%s\n", name);
>> +	strbuf_release(&sb);
>>  	return 0;
>>  }
>>  
