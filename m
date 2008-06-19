From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2] gitweb: standarize HTTP status codes
Date: Fri, 20 Jun 2008 00:22:38 +0200
Message-ID: <200806200022.39685.jnareb@gmail.com>
References: <1213564515-14356-1-git-send-email-LeWiemann@gmail.com> <m3y752melj.fsf_-_@localhost.localdomain> <485AAEB9.2080100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 00:24:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9SY2-0000M9-U1
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 00:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105AbYFSWWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 18:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752402AbYFSWWw
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 18:22:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:9453 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbYFSWWv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 18:22:51 -0400
Received: by ug-out-1314.google.com with SMTP id h2so1055277ugf.16
        for <git@vger.kernel.org>; Thu, 19 Jun 2008 15:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=WKh1zHByt0rMPMly1sO/B66kD0Mg0zAYaH24cFYhfyM=;
        b=FmDDKQmOAGrMqgxrPOEbIH4qcGIoMex0edzmhR874wlpEDrMQur/AOZGMYZK2A0dM+
         HnJSdov9uK7paEHKb6QJKHIiyL5FnfA9pr3eXIqv06J6lNVp1AHR+BygIfuPdRNnvQbG
         i0dGR/lH2wI2PdciN+vQrbQreSW1YIJKMMQlU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=OU+5eefoho3lYRXlR65iPmEVz8fAcc+C/1qsxznt8d8Q0XqxrkmKn89CrNmOnR0ZZZ
         r5lESQFv3Uf+5TI82an4EtxDVJcWi9HZXK1rggRMr7D6n9ap/PntQbZHDkJFl0Tx7dW9
         l9A7BRjRbDU753LZys/H3IOvpORlkqMujBNno=
Received: by 10.210.120.7 with SMTP id s7mr2386515ebc.76.1213914169586;
        Thu, 19 Jun 2008 15:22:49 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.242.161])
        by mx.google.com with ESMTPS id c22sm1673435ika.1.2008.06.19.15.22.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Jun 2008 15:22:47 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <485AAEB9.2080100@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85549>

Lea Wiemann wrote:
> Jakub Narebski wrote:
>> Lea Wiemann <lewiemann@gmail.com> writes:
>>>
>>> For convenience the die_error function now only takes the status code
>>> without reason as first parameter (e.g. 404 instead of "404 Not Found")
>> 
>> _Whose_ convenience?
> 
> The developer's convenience of course.  It's plain redundant.

Redundancy isn't always bad.

Moreover I think that "convenience of developer" here is a bit matter
of taste, and the fact if one is web developer, or "accidental" gitweb
developer.
 
>>  * I don't think that RFC 2616 allows blanket replacing reason phrase
>>    by generic "Error",
>>  * Test::WWW::Mechanize displays both HTTP error status code and
>>    reason phrase when get_ok(...) fails:
>>  * From the point of view of someone examinimg gitweb.perl code, 400,
>>    403, 404, 500 are _magic numbers_;
> 
> I think we're really arguing about the color of the bikeshed here.  IMO 
> we're not stretching RFC 2616 too much by putting "Error" there (since 
> reason codes don't matter on a technical level), and the status codes 
> make enough sense to me (and I'm not even a web developer) that I'm not 
> concerned about readability.

Well, I didn't know what 400 code meant, and I had to check RFC 2616
for that.  '400 Bad Request' is more readable.

But it is a bit bikeshedding.  This patch consist of two things: using
better HTTP error status codes (for example getting rid of 
403 Forbidden as default catch-all code and using 500 Internal Server
Error for cases where an error _is_ serious server error), and
changing die_error(...) signature / calling convention (meant for
convenience).  I agree wholeheartly with first part (modulo using
404 Not Found for errors which usually happens because of user error).
Second part might wait when code stabilizes and there is lull in the
gitweb development (changes shouldn't conflict anyway, but applying
patches might fail because of changed context)...

...but as I can see you have send PATCH v3, in the form I can agree
with.
 
> I don't think your constants a la HTTP_INVALID are a good idea (I 
> remember the status codes in a year, but maybe not the constants); 

I can agree with that.

> die_error could figure out the right reason code using a hash. (...)

Good idea.  I see it is done this way in PATCH v3.
 
>>> -		die_error(undef, "At least two characters are required for search parameter");
>>> +		die_error(403, "At least two characters are required for search parameter");
>> 
>> Should gitweb use there '403 Forbidden', or '400 Bad Request'?
>> This is failing static validation of CGI parameters, not a matter of
>> some permissions...
> 
> I used 403 in the sense of "sorry, we don't have shorter search strings 
> activated for performance reasons".  The '2' could even become 
> configurable.  400 is fine too, though, I don't care.

I had in mind using '403 Forbidden' for "permission denied" errors,
i.e. for cases where different _configuration_ could result in access.
 
>>> -	close $fd or die_error(undef, "Reading tree failed");
>>> +	close $fd or die_error(500, "Reading tree failed");
>> 
>> Not O.K.  Barring errors in gitweb code this might happen when
>> [X Y Z].  All those are clearly 4xx _client_ errors,
> 
> I haven't verified that, so until we have better error handling I prefer 
> 500, but I really won't bother objecting to 404.

I'd rather have '404 Not Found' here; in most cases this is client
error, and one should examine URL not mail webmaster.

> FWIW I'm  
> assuming that once gitweb uses the new API, that error handling code 
> will go away anyway.

I hope that performance impact for non-caching case would be negligible,
and cleaner code would overweigth this concern.
 
>>>  	if (!defined $ftype) {
>>> -		die_error(undef, "Unknown type of object");
>>> +		die_error(500, "Unknown type of object");
>> 
>> Errr... shouldn't be '400 Bad Request' here, per convention?
> 
> Nope, we didn't get *anything* back, so something weird happened.  500.

Ohhh... right.  I didn't get that from seeing only this part.

-- 
Jakub Narebski
Poland
