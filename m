Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 323F21FF76
	for <e@80x24.org>; Fri, 23 Dec 2016 12:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941499AbcLWMw0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Dec 2016 07:52:26 -0500
Received: from mx1.2b3w.ch ([92.42.186.250]:60665 "EHLO mx1.2b3w.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753288AbcLWMwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Dec 2016 07:52:25 -0500
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
        by mx1.2b3w.ch (Postfix) with ESMTP id 13008C35B2;
        Fri, 23 Dec 2016 13:51:48 +0100 (CET)
Received: from mx1.2b3w.ch (dilbert.2b3w.ch [92.42.186.250])
        by mx1.2b3w.ch (Postfix) with ESMTPA id E3886C354E;
        Fri, 23 Dec 2016 13:51:47 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 23 Dec 2016 13:51:47 +0100
From:   Beat Bolli <dev+git@drbeat.li>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 1/3] mingw: adjust =?UTF-8?Q?is=5Fconsole=28=29=20t?=
 =?UTF-8?Q?o=20work=20with=20stdin?=
In-Reply-To: <alpine.DEB.2.20.1612231024400.155951@virtualbox>
References: <cover.1482342791.git.johannes.schindelin@gmx.de>
 <cover.1482426497.git.johannes.schindelin@gmx.de>
 <ca4c61c603247c8ad0b876b068f6cd41fbe01667.1482426497.git.johannes.schindelin@gmx.de>
 <fc3e0d9c-86ea-4a62-6b70-b9cdd67f581a@drbeat.li>
 <alpine.DEB.2.20.1612231024400.155951@virtualbox>
Message-ID: <f6964a29e4bdc5a68fff56900cf67c36@drbeat.li>
X-Sender: dev+git@drbeat.li
User-Agent: Roundcube Webmail/0.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 2016-12-23 10:30, Johannes Schindelin wrote:
> Hi Beat,
> 
> On Fri, 23 Dec 2016, Beat Bolli wrote:
> 
>> On 22.12.16 18:08, Johannes Schindelin wrote:
>> > diff --git a/compat/winansi.c b/compat/winansi.c
>> > index cb725fb02f..590d61cb1b 100644
>> > --- a/compat/winansi.c
>> > +++ b/compat/winansi.c
>> > @@ -84,6 +84,7 @@ static void warn_if_raster_font(void)
>> >  static int is_console(int fd)
>> >  {
>> >  	CONSOLE_SCREEN_BUFFER_INFO sbi;
>> > +	DWORD mode;
>> 
>> Nit: can we move this definition into the block below where it's used?
>> 
>> >  	HANDLE hcon;
>> >
>> >  	static int initialized = 0;
>> > @@ -98,7 +99,10 @@ static int is_console(int fd)
>> >  		return 0;
>> >
>> >  	/* check if its a handle to a console output screen buffer */
>> > -	if (!GetConsoleScreenBufferInfo(hcon, &sbi))
>> > +	if (!fd) {
>> 
>> Right here:
>> +               DWORD mode;
> 
> By that reasoning, the CONSOLE_SCREEN_BUFFER_INFO declaration that has
> function-wide scope should also move below:
> 
>> > +		if (!GetConsoleMode(hcon, &mode))
>> > +			return 0;
> 
> Right here.
> 
>> > +	} else if (!GetConsoleScreenBufferInfo(hcon, &sbi))
>> >  		return 0;
>> >
>> >  	/* initialize attributes */
> 
> As the existing code followed a different convention, so does my patch.
> 
> If you choose to submit a change that moved the `mode` declaration to
> narrow its scope, please also move the `sbi` declaration for 
> consistency.

It's probably not worth it. It just jumped at me when reading the patch, 
and, writing much C++ recently, it looked weird to have a definition so 
far away from the single use of the variable.

Cheers,
Beat
