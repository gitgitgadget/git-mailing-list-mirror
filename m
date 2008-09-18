From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 2/4] diff.c: associate a flag with each pattern and use
 it for compiling regex
Date: Thu, 18 Sep 2008 10:06:28 +0200
Message-ID: <48D20C04.1020703@op5.se>
References: <7v3ak06jzj.fsf@gitster.siamese.dyndns.org> <GZAEBf1BcP9-dznrIesxaE4Rb8bim6DpwDWCb9yWl99UVoQC9Dog0A@cipher.nrlssc.navy.mil> <7vod2m1464.fsf@gitster.siamese.dyndns.org> <48D1F80C.5030502@op5.se> <7vod2myljk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Arjen Laarhoven <arjen@yaph.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	Boyd Lynn Gerber <gerberb@zenez.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 10:07:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgEYA-0003fx-Ki
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 10:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755944AbYIRIGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 04:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755937AbYIRIGg
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 04:06:36 -0400
Received: from mail.op5.se ([193.201.96.20]:38446 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449AbYIRIGe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 04:06:34 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id BBE281B80077;
	Thu, 18 Sep 2008 09:56:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.829
X-Spam-Level: 
X-Spam-Status: No, score=-3.829 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.570, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oBEzgx1y56iv; Thu, 18 Sep 2008 09:56:29 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.171])
	by mail.op5.se (Postfix) with ESMTP id A0E581B80081;
	Thu, 18 Sep 2008 09:56:27 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <7vod2myljk.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96180>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
>> Junio C Hamano wrote:
>> ...
>>>>  static struct funcname_pattern {
>>>>  	char *name;
>>>>  	char *pattern;
>>>> +	int cflags;
>>> What does "C" stand for?
>> "compile". It's the same name as regcomp(3) uses for the flags being
>> used to compile the regular expression. The full mnemonic name would
>> be regex_compile_flag, which is a bit unwieldy. Perhaps regcomp_flags
>> would be a good compromise?
> 
> Ah, I see.
> 
> When I saw that new field for the first time, I didn't think it will be
> used to store the bare flag values regcomp/regexec library would accept
> directly (I expected we would see #define or enum to tweak our own set of
> features, not limiting ourselves EXTENDED/ICASE etc. that regcomp/regexec
> library supports)
> 
> IOW, it just did not click for me to look at "man 3 regcomp" which says:
> 
>     int regcomp(regex_t *preg, const char *regex, int cflags);
> 
> So unless others feel that we might get a better layering separation by
> not storing REG_EXTENDED and stuff directly in that field (which was my
> initial reaction without looking at 4/4 which does store REG_EXTENDED
> there without our own enums), cflag is perfectly a good name here.
> 

I think it makes perfect sense to use whatever we pass when compiling
the regex. I wouldn't dare try to hack up something that pre-mangles
a regular expression and assume it gets it right everywhere anyway, so
I'm quite happy with leaving it all to regcomp(3) and friends.


> Thanks --- I am bit under the weather and not thinking quite straight.
> 

Mix 2cc's of 7yo Havana Club into a large cup of tea. Drink one such
cup every hour and eat a fresh fruit with it. I haven't been ill a day
in my life since I came up with that most excellent cure for absolutely
everything. If nothing else, it makes it a bit less boring to be ill.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
