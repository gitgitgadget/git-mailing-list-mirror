From: Moritz Neeb <lists@moritzneeb.de>
Subject: Re: [PATCH v3 3/7] clean: read user input with strbuf_getline()
Date: Sun, 28 Feb 2016 08:36:48 +0100
Message-ID: <56D2A390.9010804@moritzneeb.de>
References: <56D28092.9090209@moritzneeb.de> <56D28203.7040502@moritzneeb.de>
 <CAPig+cSkV0KMG7gONabPxgQkzWgPU+1YGTMb4SDmpg1QrHxhSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 28 08:36:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZvuQ-0005jy-Q0
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 08:36:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbcB1Hgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 02:36:51 -0500
Received: from moritzneeb.de ([78.47.1.106]:37640 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750748AbcB1Hgu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 02:36:50 -0500
Received: from [192.168.1.3] (x4db4d017.dyn.telefonica.de [77.180.208.23])
	by moritzneeb.de (Postfix) with ESMTPSA id 036FA1C02F;
	Sun, 28 Feb 2016 08:36:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456645009;
	bh=DKGG8mZ2QO21zs6GmeHIm8uKQhZlTppvvBwDwdmjx5Q=;
	h=Subject:References:Cc:To:From:Date:In-Reply-To:From;
	b=Mauc0GnFLRMEq4Ch4J4EiuODjN3nADRIbMRSnrvOdEsp4qDgXsk4R5axhB0FCakcA
	 LxCb5mR0Ck9HjQXMT9NxnFNLGgJYuC0i79QgcsvSJFHvCjzOxtC0wfxoRbpnYXjR+I
	 oodf1fFrVsRog1mmUL3qge8iEMaj7lJ+SCu9MmzI=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <CAPig+cSkV0KMG7gONabPxgQkzWgPU+1YGTMb4SDmpg1QrHxhSA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287757>

On 02/28/2016 07:36 AM, Eric Sunshine wrote:
> On Sun, Feb 28, 2016 at 12:13 AM, Moritz Neeb <lists@moritzneeb.de> wrote:
>> The inputs that are read are all answers that are given by the user
>> when interacting with git on the commandline. As these answers are
>> not supposed to contain a meaningful CR it is safe to
>> replace strbuf_getline_lf() can be replaced by strbuf_getline().
> 
> Grammo: "it is safe to replace ... can be replaced by ..."
> 

I dropped the second duplication.

>> In the subsequent codepath, the input is trimmed. This leads to
> 
> How about?
> 
>     After being read, the input is trimmed.

Yep, sounds better.

Thanks.

> 
>> accepting user input with spaces, e.g. "  y ", as a valid answer in
>> the interactive cleaning process.
>>
>> Although trimming would not be required anymore to remove a potential CR,
>> we don't want to change the existing behavior with this patch.
>> Thus, the trimming is kept in place.
>>
>> Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
>> ---
>> diff --git a/builtin/clean.c b/builtin/clean.c
>> @@ -570,7 +570,7 @@ static int *list_and_choose(struct menu_opts *opts, struct menu_stuff *stuff)
>>                                clean_get_color(CLEAN_COLOR_RESET));
>>                 }
>>
>> -               if (strbuf_getline_lf(&choice, stdin) != EOF) {
>> +               if (strbuf_getline(&choice, stdin) != EOF) {
>>                         strbuf_trim(&choice);
>>                 } else {
>>                         eof = 1;
>> @@ -652,7 +652,7 @@ static int filter_by_patterns_cmd(void)
>>                 clean_print_color(CLEAN_COLOR_PROMPT);
>>                 printf(_("Input ignore patterns>> "));
>>                 clean_print_color(CLEAN_COLOR_RESET);
>> -               if (strbuf_getline_lf(&confirm, stdin) != EOF)
>> +               if (strbuf_getline(&confirm, stdin) != EOF)
>>                         strbuf_trim(&confirm);
>>                 else
>>                         putchar('\n');
>> @@ -750,7 +750,7 @@ static int ask_each_cmd(void)
>>                         qname = quote_path_relative(item->string, NULL, &buf);
>>                         /* TRANSLATORS: Make sure to keep [y/N] as is */
>>                         printf(_("Remove %s [y/N]? "), qname);
>> -                       if (strbuf_getline_lf(&confirm, stdin) != EOF) {
>> +                       if (strbuf_getline(&confirm, stdin) != EOF) {
>>                                 strbuf_trim(&confirm);
>>                         } else {
>>                                 putchar('\n');
>> --
>> 2.4.3
