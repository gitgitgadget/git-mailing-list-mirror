From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 1/2] config api: Add git_config_magic_int()
Date: Wed, 13 Feb 2008 14:58:51 +0100
Message-ID: <47B2F79B.9090406@op5.se>
References: <47B15701.8040803@op5.se> <7vir0t3l9s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 14:59:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPI9E-0000wG-2o
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 14:59:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753792AbYBMN7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 08:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753703AbYBMN7E
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 08:59:04 -0500
Received: from mail.op5.se ([193.201.96.20]:40741 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751289AbYBMN7D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 08:59:03 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 523DC1F0800F;
	Wed, 13 Feb 2008 14:59:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GOk9UYH1uT1Z; Wed, 13 Feb 2008 14:58:58 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.28])
	by mail.op5.se (Postfix) with ESMTP id D59001F08002;
	Wed, 13 Feb 2008 14:58:57 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <7vir0t3l9s.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73795>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
>> +int git_config_magic_int(const char *name, const char *value,
>> +			 const char *magic_value, int magic_setting)
>> +{
>> +	if (value && !strcasecmp(value, magic_value))
>> +		return magic_setting;
>> +
>> +	return git_config_int(name, value);
>> +}
> 
> I do not think this has much to do with any "magic".
> 
> An instruction "use 0 threads" when taken literally would mean
> "do not use any CPU" which would not make much sense.  In that
> sense, giving a magic meaning of "guess an appropriate value" to
> 0 may be a good idea.  A valid alternative would be to make 0
> mean the same thing as 1, but that is much more boring ;-)
> 
> But if you did so, that means "var = 0" invokes the same magic
> as "var = auto".  The magic lives in "0", and not in "auto".
> 
> I think the direction your patch leads us is good, but I think
> it should allow an array of symbolic ways to spell values to be
> useful, that is:
> 
> 	struct config_symbolic_int {
>         	const char *name;
>                 int value;
> 	};
>         int git_config_symbolic_int(const char *var, const char *value,
> 				    struct config_symbolic_int *);
> 
> That way, you can have
> 
> 	{ { "high", 9 }, { "default", 0 }, { "low", 1 } };
> 
> and say things like "zlevel = high|default|low".

Good idea. I'll look into it right away. I sorely need a break from
coding backends for webapps anyway. I'll send this one separately and
then tack 2/2 onto the builtin-pack-objects patch thing. That one
should probably be a /3 series anyway, when I come to think of it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
