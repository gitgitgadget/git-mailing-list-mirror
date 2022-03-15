Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFB7C433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 18:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348777AbiCOSDQ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 15 Mar 2022 14:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350984AbiCOSDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 14:03:09 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659B85938C
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 11:01:53 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 22FI1pAW062237
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 15 Mar 2022 14:01:51 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Phillip Wood'" <phillip.wood123@gmail.com>
Cc:     "'Git Mailing List'" <git@vger.kernel.org>,
        "'Phillip Wood'" <phillip.wood@dunelm.org.uk>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, "'Carlo Arenas'" <carenas@gmail.com>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Ramsay Jones'" <ramsay@ramsayjones.plus.com>
References: <20220304131126.8293-1-phillip.wood123@gmail.com>        <20220315105723.19398-1-phillip.wood123@gmail.com>        <20220315105723.19398-3-phillip.wood123@gmail.com> <xmqqzglrdsd8.fsf@gitster.g>
In-Reply-To: <xmqqzglrdsd8.fsf@gitster.g>
Subject: RE: [PATCH v3 2/4] terminal: don't assume stdin is /dev/tty
Date:   Tue, 15 Mar 2022 14:01:46 -0400
Organization: Nexbridge Inc.
Message-ID: <02fd01d83896$c0261240$407236c0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGKt2ggdcH8T8D+I2vfsOMG9Pml6gGNcxSxAhyA+dkC9+EoRq0mr39A
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On March 15, 2022 1:43 PM, Junio C Hamano wrote:
>Phillip Wood <phillip.wood123@gmail.com> writes:
>
>> diff --git a/compat/terminal.c b/compat/terminal.c index
>> da2f788137..bfbde3c1af 100644
>> --- a/compat/terminal.c
>> +++ b/compat/terminal.c
>> @@ -23,21 +23,28 @@ static void restore_term_on_signal(int sig)
>> static int term_fd = -1;
>
>The variable can be -1 to signal "no valid file descriptor".
>
>>  static struct termios old_term;
>>
>> +static void close_term_fd(void)
>> +{
>> +	if (term_fd)
>> +		close(term_fd);
>> +	term_fd = -1;
>> +}
>> +
>
>And we use that negative value after closing it.
>
>The check before closing it is wrong.  It should be
>
>	if (0 <= term_fd)

Should this expression succeed if term_fd == stdin? I might be missing the point here.
--Randall

