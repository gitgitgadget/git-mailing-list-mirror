From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] strtoul_ui: reject negative values
Date: Thu, 17 Sep 2015 12:12:11 -0400
Message-ID: <55FAE65B.1060204@xiplink.com>
References: <1442500646-15293-1-git-send-email-Matthieu.Moy@imag.fr>
 <55FAD981.5080808@xiplink.com> <vpqr3lxoy9t.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, max@max630.net
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 17 18:11:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zcbmt-0003PL-9N
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 18:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529AbbIQQLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 12:11:50 -0400
Received: from smtp114.ord1c.emailsrvr.com ([108.166.43.114]:38848 "EHLO
	smtp114.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751904AbbIQQLu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Sep 2015 12:11:50 -0400
Received: from smtp15.relay.ord1c.emailsrvr.com (localhost.localdomain [127.0.0.1])
	by smtp15.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 6F7903800CB;
	Thu, 17 Sep 2015 12:11:49 -0400 (EDT)
Received: by smtp15.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 30DE0380226;
	Thu, 17 Sep 2015 12:11:49 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.4.2);
	Thu, 17 Sep 2015 16:11:49 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <vpqr3lxoy9t.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278127>

On 15-09-17 11:34 AM, Matthieu Moy wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>>> --- a/git-compat-util.h
>>> +++ b/git-compat-util.h
>>> @@ -814,6 +814,9 @@ static inline int strtoul_ui(char const *s, int base, unsigned int *result)
>>>  	char *p;
>>>  
>>>  	errno = 0;
>>> +	/* negative values would be accepted by strtoul */
>>> +	if (strchr(s, '-'))
>>> +		return -1;
>>
>> I think this is broken, in that it doesn't match strtoul's normal behaviour,
>> for strings like "1234-5678", no?
> 
> The goal here is just to read a positive integer value. Rejecting
> "1234-5678" is indeed a good thing. We already rejected it before my
> patch by checking for p (AKA endptr for strtoul), as you noted below.
> 
>> The test also doesn't work if the string has leading whitespace ("
>> -5").
> 
> Why? It rejects any string that contain the character '-', regardless of
> trailing spaces.

Right, sorry.

>>>  	ul = strtoul(s, &p, base);
>>>  	if (errno || *p || p == s || (unsigned int) ul != ul)
>>>  		return -1;
>>
>> Hmm, but we check *p here, so IIUC it's an error if the string has any
>> trailing non-digits.  Weird.
> 
> strtoul_ui is more defensive than strtoul, by design.

Fair enough, just not what I expected from a function with that name.

		M.
