From: "Kevin P. Fleming" <kpfleming@digium.com>
Subject: Re: [PATCH] Corrected return values in post-receive-email.prep_for_email
Date: Tue, 07 Dec 2010 13:44:23 -0600
Organization: Digium, Inc.
Message-ID: <4CFE8E97.4020508@digium.com>
References: <002501cb962c$5fa3aa40$1eeafec0$@me.uk> <7v1v5tqswl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alan Raison <alan@theraisons.me.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 21:18:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ3zK-0006QP-2r
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 21:18:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754224Ab0LGUSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 15:18:08 -0500
Received: from mail.digium.com ([216.207.245.2]:60011 "EHLO mail.digium.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753676Ab0LGUSH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 15:18:07 -0500
X-Greylist: delayed 2017 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Dec 2010 15:18:06 EST
Received: from zimbra.digium.internal ([10.24.55.203] helo=zimbra.hsv.digium.com)
	by mail.digium.com with esmtp (Exim 4.69)
	(envelope-from <kpfleming@digium.com>)
	id 1PQ3Sa-00055B-MM; Tue, 07 Dec 2010 13:44:24 -0600
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.hsv.digium.com (Postfix) with ESMTP id 98E63D8192;
	Tue,  7 Dec 2010 13:44:24 -0600 (CST)
Received: from zimbra.hsv.digium.com ([127.0.0.1])
	by localhost (zimbra.hsv.digium.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uf4XSuEaQIQo; Tue,  7 Dec 2010 13:44:23 -0600 (CST)
Received: from [10.24.250.46] (unknown [10.24.250.46])
	by zimbra.hsv.digium.com (Postfix) with ESMTPSA id B7291D8024;
	Tue,  7 Dec 2010 13:44:23 -0600 (CST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <7v1v5tqswl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163123>

On 12/07/2010 01:34 PM, Junio C Hamano wrote:
> "Alan Raison"<alan@theraisons.me.uk>  writes:
>
>> ---
>>   contrib/hooks/post-receive-email |    6 +++---
>>   1 files changed, 3 insertions(+), 3 deletions(-)
>
> No sign-off, no description.
>
> This is a regression introduced by 53cad69 (post-receive-email: ensure
> sent messages are not empty, 2010-09-10), I think.
>
>> diff --git a/contrib/hooks/post-receive-email
>> b/contrib/hooks/post-receive-email
>> index 85724bf..020536d 100755
>> --- a/contrib/hooks/post-receive-email
>> +++ b/contrib/hooks/post-receive-email
>> @@ -150,7 +150,7 @@ prep_for_email()
>>   			# Anything else (is there anything else?)
>>   			echo>&2 "*** Unknown type of update to $refname
>> ($rev_type)"
>>   			echo>&2 "***  - no email generated"
>> -			return 0
>> +			return 1
>
> This used to "exit 1" before 53cad69 and I agree with the patch that
> signalling error with "return 1" is the right thing to do here.
>
>>   			;;
>>   	esac
>>
>> @@ -166,10 +166,10 @@ prep_for_email()
>>   		esac
>>   		echo>&2 "*** $config_name is not set so no email will be
>> sent"
>>   		echo>&2 "*** for $refname update $oldrev->$newrev"
>> -		return 0
>> +		return 1
>
> This used to "exit 0" before 53cad69 to cause the program stop before
> sending mails.  Again, I agree with the patch that signalling error is the
> right thing to do here.
>
>>   	fi
>>
>> -	return 1
>> +	return 0
>
> And this obviously is correct.
>
> Kevin, care to review and Ack?  Alan, care to add a few lines of patch
> description and sign-off?

Acked-by: Kevin P. Fleming <kpfleming@digium.com>

Yeah, this is clearly my breakage; our internal version of this script 
is so different that it has become hard to backport fixes to the 
upstream version... or I just did a terrible job of it.

Alan, while you are in there fixing this, there is a remaining 'exit 0' 
in prep_for_email (at line 147) that should be 'return 1' instead.

-- 
Kevin P. Fleming
Digium, Inc. | Director of Software Technologies
445 Jan Davis Drive NW - Huntsville, AL 35806 - USA
skype: kpfleming | jabber: kfleming@digium.com
Check us out at www.digium.com & www.asterisk.org
