From: Jim Meyering <jim@meyering.net>
Subject: Re: sscanf/strtoul: parse integers robustly
Date: Wed, 11 Apr 2007 15:52:01 +0200
Message-ID: <87fy77t3we.fsf@rho.meyering.net>
References: <871witxicn.fsf@rho.meyering.net>
	<7v4pnnqr9q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 11 16:12:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbdF2-00066C-12
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 15:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbXDKNwE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 09:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752715AbXDKNwE
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 09:52:04 -0400
Received: from mx.meyering.net ([82.230.74.64]:58537 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752770AbXDKNwD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 09:52:03 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 4B9BA6BFD; Wed, 11 Apr 2007 15:52:01 +0200 (CEST)
In-Reply-To: <7v4pnnqr9q.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Wed\, 11 Apr 2007 00\:55\:29 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44238>

Junio C Hamano <junkio@cox.net> wrote:

> Jim Meyering <jim@meyering.net> writes:
>
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index 139fc19..5f6a281 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -301,4 +301,17 @@ static inline int prefixcmp(const char *str, const char *prefix)
>>  	return strncmp(str, prefix, strlen(prefix));
>>  }
>>
>> +static inline int strtoul_ui(char const *s, int base, unsigned int *result)
>> +{
>> +	unsigned long ul;
>> +	char *p;
>> +
>> +	errno = 0;
>> +	ul = strtoul(s, &p, base);
>> +	if (errno || *p || p == s || (unsigned int) ul != ul)
>> +		return -1;
>> +	*result = ul;
>> +	return 0;
>> +}
>> +
>>  #endif
>
> War on sscanf is fine, but I wonder if this is small enough to
> be a good candidate for inlining.

I don't care if it is actually inlined.
I used "inline" because this function seems small enough that
duplicating its code won't hurt, and because then I didn't need
to bother with a separate prototype.  On the size front, it looks
no larger than most of the other inline functions in that file.
