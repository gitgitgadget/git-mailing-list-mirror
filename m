From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v11 2/4] parse-options.c: make OPTION_COUNTUP respect "unspecified" values
Date: Thu, 31 Mar 2016 13:06:20 -0700
Message-ID: <xmqqegaqmmyr.fsf@gitster.mtv.corp.google.com>
References: <01020153cd2340f8-4665cd5f-cd5c-41ab-a162-20acc43ca52e-000000@eu-west-1.amazonses.com>
	<01020153cd2341e2-2616ba0b-9271-4a97-87d1-b6dedbf31828-000000@eu-west-1.amazonses.com>
	<xmqq60w2o5g9.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPO4CJ-Q=52Es14CdD0mjG-qgy4=X2kU71npi=8x7FsSQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 22:06:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alirR-0004aj-AK
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 22:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757077AbcCaUGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 16:06:24 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:57946 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752826AbcCaUGX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 16:06:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3C21F52697;
	Thu, 31 Mar 2016 16:06:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HVl2lL4LSuXq/jHxGnj7mLqKW6k=; b=ViSv3s
	VyNhhOQuc+BRAiclLkgSzgzoDtzfGb6djkaiJcGETSJWQpsvmWucSa253zyazqE0
	a8bFpfSkZNl6DZE+xvxwR0DygP6wWn69PZPDzGc9uG6MVUxM7UY7O0zBHNpxW06d
	+gbDGrguHwnIowMEcX/izCdbn8QE+cWFLeg+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K7VKku6kvGOllv8lEK5YOeHfm0cs6uB5
	Q6e2mMtZvQB4kzcfbOzm1uQU/DhANSOQPdJs1GJQY9BLk3iQX0i8hxCnBiPJins5
	cwnh8ltNFe9loUsoFCg23NIXBiVo8MMJZ8az+bvMSqAAbYOaRmd+le84SsL4pAqm
	20n/huAHpL8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 345B952696;
	Thu, 31 Mar 2016 16:06:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A7F1752695;
	Thu, 31 Mar 2016 16:06:21 -0400 (EDT)
In-Reply-To: <CAFZEwPO4CJ-Q=52Es14CdD0mjG-qgy4=X2kU71npi=8x7FsSQw@mail.gmail.com>
	(Pranit Bauva's message of "Fri, 1 Apr 2016 01:04:03 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 09CBD8F6-F77C-11E5-8BE5-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290458>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> On Fri, Apr 1, 2016 at 12:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>         case OPTION_COUNTUP:
>> +               if (*(int *)opt->value < 0)
>> +                       *(int *)opt->value = 0;
>>                 *(int *)opt->value = unset ? 0 : *(int *)opt->value + 1;
>>
>> That is, upon hitting this case arm, we know that an explicit option
>> was given from the command line, so the "unspecified" initial value,
>> if it is still there, gets reset to 0, and after doing that, we just
>> do the usual thing.
>
> This does look cleaner. Nice thinking that there is no need to
> actually specify when it gets 0. It gets 0 no matter what as long as
> OPTION_COUNTUP is speficied in any format (with or without --no) and
> variable is "unspecified".

I do not think there is any planned users of such an enhancement,
but the above points us into a future possibility to be able to do
this:

        case OPTION_COUNTUP:
+               if (*(int *)opt->value < 0)
+                       *(int *)opt->value = -*(int *)opt->value - 1;
                *(int *)opt->value = unset ? 0 : *(int *)opt->value + 1;

That is, by using "-2" as the "unspecified" value, you can start
counting up from 2 (i.e. the presence of the option resets the
variable to 1 and then the option being not "unset" increments it)
if your application wants to.
