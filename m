From: Slavomir Vlcek <svlc@inventati.org>
Subject: Re: [PATCH/RFC] builtin: move builtin retrieval to get_builtin()
Date: Mon, 17 Nov 2014 00:33:40 +0100
Message-ID: <54693454.1040704@inventati.org>
References: <5463DA20.3080703@inventati.org> <xmqq389n2cac.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 00:32:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xq9Iz-00046t-Jg
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 00:32:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbaKPXaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2014 18:30:35 -0500
Received: from latitanza.investici.org ([82.94.249.234]:52384 "EHLO
	latitanza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbaKPXaf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2014 18:30:35 -0500
Received: from [82.94.249.234] (latitanza [82.94.249.234]) (Authenticated sender: svlc@inventati.org) by localhost (Postfix) with ESMTPSA id 1B64C121E0E;
	Sun, 16 Nov 2014 23:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inventati.org;
	s=stigmate; t=1416180633;
	bh=osqNOVEbszsN0ODovscNzs4iykhRArH4hrstzIB0P9s=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=PsIwISqDLa95es4s6EXViELReer0XU72iWt/eKDZ4EzLgKzBdEL7QEdf5YLphNdB8
	 DW61fHkac1lhlpCYaqOXLhKRnD+eJ6hdtyGFJXAdqXVPwBJvURGUZIrxhQ69c087CL
	 fQdC6bWaS4mTM0xKKvk5QN+YtasUg20gXAaOUa2s=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqq389n2cac.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/13/2014 07:19 PM, Junio C Hamano wrote:
>>  git.c | 27 +++++++++++++++------------
>>  1 file changed, 15 insertions(+), 12 deletions(-)
>>
>> diff --git a/git.c b/git.c
>> index 18fbf79..e32c5b8 100644
>> --- a/git.c
>> +++ b/git.c
>> @@ -487,15 +487,20 @@ static struct cmd_struct commands[] = {
>>  	{ "write-tree", cmd_write_tree, RUN_SETUP },
>>  };
>>  
>> -int is_builtin(const char *s)
>> +struct cmd_struct *get_builtin(const char *s)
> 
> I do not think this has to be extern.
> 
> 	static struct cmd_struct *get_builtin(const char *s)
> 
> perhaps.
> 
>> @@ -519,15 +525,12 @@ static void handle_builtin(int argc, const char **argv)
>>  		argv[0] = cmd = "help";
>>  	}
>>  
>> -	for (i = 0; i < ARRAY_SIZE(commands); i++) {
>> -		struct cmd_struct *p = commands+i;
>> -		if (strcmp(p->cmd, cmd))
>> -			continue;
>> -		if (saved_environment && (p->option & NO_SETUP)) {
>> +	builtin = get_builtin(cmd);
> 
> Nice.
> 
>> +	if (builtin) {
>> +		if (saved_environment && (builtin->option & NO_SETUP))
>>  			restore_env();
>> -			break;
>> -		}
>> -		exit(run_builtin(p, argc, argv));
>> +		else
>> +			exit(run_builtin(builtin, argc, argv));
> 
> This change does not seem to have anything to do with the topic of
> the change.  Why is it necessary?

Does the commit message lack some explanation
or the patch would better be divided into several parts?

I noticed that the patch has been modified (suggested 'static'
scope modification, commit message) and added
to the 'next' branch. So does this mean my task is done
or is there still something I should explain?

Thank you for your corrections.
