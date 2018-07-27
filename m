Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FB2B1F597
	for <e@80x24.org>; Fri, 27 Jul 2018 10:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389099AbeG0L0s (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 07:26:48 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:4661 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388964AbeG0L0S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 07:26:18 -0400
Received: from [192.168.2.201] ([92.22.29.59])
        by smtp.talktalk.net with SMTP
        id izcOfahmqVlGZizcPfo0V9; Fri, 27 Jul 2018 11:05:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1532685906;
        bh=M95C1kTJTFYAHyzcx1IKljigO+xsz0tKFEZeyQ09JQI=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OriFYEq3Q3dUJbFVhsAAbNv0wfWtrslKVuKC5ynm7ncpDAw79W6eMvH7PEfxJ9Ici
         3YRRbCa3Uy8XfLzRlnlZE+AfD2MnC7HZ4I+Dwype+MvxtCRO9E9D/wagLghPjoDPT5
         Cv7IDojTHnWl9oruDKCt+PSsC7N+JF2KQ3HamZLk=
X-Originating-IP: [92.22.29.59]
X-Spam: 0
X-OAuthority: v=2.3 cv=JcuSU3CV c=1 sm=1 tr=0 a=OmzqbFWWvC/aSYX+a7e/kQ==:117
 a=OmzqbFWWvC/aSYX+a7e/kQ==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=3CcSZ-WtEhYkJEVimD8A:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 1/4] add -p: select individual hunk lines
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
 <20180726155854.20832-1-phillip.wood@talktalk.net>
 <20180726155854.20832-2-phillip.wood@talktalk.net>
 <xmqqin51pz5u.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <b28e1f88-bc87-2f57-ba41-cc4a67c9a5b0@talktalk.net>
Date:   Fri, 27 Jul 2018 11:05:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqin51pz5u.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFFXgbnwzQktpwduAJTHqxr+fAy5N544GV4rEOgZ2nIzuquLcCl+mqn7e6P3Xe63KaLccFYBCVK7dtvrZecYo2VQrkm1PNvWpEbiF0Kb4ItJ4AttObu8
 50NuqQlF79qeDxUxH5MVXTph7iBIIIOjWlnSSVZiEnk9s6cPtcSYb8RPZdHwXHJapGJXtQOu32uZ2xemWtsxjhxn2XetqEFW0LCUcNJQD9BofrpsUN7XAIbZ
 MiVKdeVAqe2DMi9vIYMQjsUQRLMvARjQgv+ae3Uvk7LcToc5nusvXEr/Nmx1X84NZeWR40urnb2BdKMcoEdubw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/07/18 20:36, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> +sub label_hunk_lines {
>> +	my $hunk = shift;
>> +	my $text = $hunk->{TEXT};
>> +	my (@line_flags, @lines);
>> +	my ($block, $label, $last_mode) = (0, 0, '');
>> +	for my $line (1..$#{$text}) {
> 
> $text is a ref to an array so @$text is the whole thing, $#{$text}
> is the index of the last item in that array, and $text->[0] is the
> first element of that array.  This for loop runs with $line == 1
> thru $line == $#{$text}, so we are somehow excluding the very first
> element?

Yes that's right, $text->[0] contains the hunk header

>> +		$line_flags[$line] = 0;
>> +		my $mode = substr($text->[$line], 0, 1);
>> +		if ($mode eq '\\') {
>> +			$line_flags[$line - 1] |= NO_NEWLINE;
>> +		}
>> +		if ($mode eq '-' or $mode eq '+') {
>> +			$lines[++$label] = $line;
>> +		}
>> +	}
>> +	if ($label > 1) {

