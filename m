From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: [PATCH] contrib/hooks/post-receive-email: Make revision display
 configurable
Date: Mon, 03 Nov 2008 16:45:44 -0800
Message-ID: <490F9B38.1060703@pcharlan.com>
References: <1225668059-12670-1-git-send-email-pgit@pcharlan.com> <7vy700tmdx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 04 01:47:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxA4V-0001Ao-18
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 01:47:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754904AbYKDAps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 19:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754886AbYKDAps
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 19:45:48 -0500
Received: from lax-green-bigip-5.dreamhost.com ([208.113.200.5]:39844 "EHLO
	swarthymail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754501AbYKDAps (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Nov 2008 19:45:48 -0500
Received: from [192.168.0.2] (031.132-78-65.ftth.swbr.surewest.net [65.78.132.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by swarthymail-a3.g.dreamhost.com (Postfix) with ESMTP id 82FFB7F040;
	Mon,  3 Nov 2008 16:45:45 -0800 (PST)
User-Agent: Mozilla-Thunderbird 2.0.0.17 (X11/20081018)
In-Reply-To: <7vy700tmdx.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100018>

Junio C Hamano wrote:
> Pete Harlan <pgit@pcharlan.com> writes:
> 
>> Add configuration option hooks.showrev, letting the user override how
>> revisions will be shown in the commit email.
>>
>> Signed-off-by: Pete Harlan <pgit@pcharlan.com>
>> Acked-By: Andy Parkins <andyparkins@gmail.com>
>> @@ -390,8 +396,13 @@ generate_update_branch_email()
>>  
>>  		echo ""
>>  		echo $LOGBEGIN
>> -		git rev-parse --not --branches | grep -v $(git rev-parse $refname) |
>> -		git rev-list --pretty --stdin $oldrev..$newrev
>> +		git rev-parse --not --branches |
>> +			grep -v $(git rev-parse $refname) |
>> +			git rev-list --stdin $oldrev..$newrev |
>> +		while read onerev
>> +		do
>> +			eval $(printf "$showrev" $onerev)
>> +		done
> 
> This would make the default "non-custom" case much less efficient.  If we
> really cared, perhaps we could do something like this...
> 
> 	git rev-parse --not --branches |
>         grep -v "^$(git-rev-parse --not $refname)\$" |
>         case "$using_custom_showrev" in
>         yes)
> 		git rev-list --stdin $oldrev..$newrev |
>         	while read onerev
>                 do
>                 done
>                 ;;
> 	*)
>         	git rev-list --pretty --stdin $oldrev..newrev
>                 ;;
> 	esac
> 
> But I suspect we do not care too much about it.

I agree about the efficiency; that bothered me when I wrote the patch,
but figured the lack of efficiency wouldn't be noticeable.

OTOH, it still bothers me; I'll write up a v2 patch that does something
much more like what you suggest.

Is it easier at this point for you to have a new patch that applies on
top of my previous patch, or a wholesale replacement for it?  Or is
what's done done and that's the end of it for something this minor?

Thanks to you both for your time and work,

--Pete

> 
> Will apply as submitted.  Thanks
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
