From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH/RFC 5/5] add tests for checking the behaviour of "unset.variable"
Date: Fri, 03 Oct 2014 02:05:29 +0530
Message-ID: <542DB711.9040503@gmail.com>
References: <1412256292-4286-1-git-send-email-tanayabh@gmail.com>	<1412256292-4286-6-git-send-email-tanayabh@gmail.com>	<xmqqr3yqmdxa.fsf@gitster.dls.corp.google.com>	<542DB2FE.609@gmail.com> <xmqqmw9emdax.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 22:35:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZn6A-0006kC-C3
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 22:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbaJBUfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2014 16:35:34 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36261 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655AbaJBUfd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2014 16:35:33 -0400
Received: by mail-pa0-f48.google.com with SMTP id eu11so3398644pac.35
        for <git@vger.kernel.org>; Thu, 02 Oct 2014 13:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=SlH0q3wzmQBlXp1ZjCxWY8iNZS0RsFNVmJ3995uqLWg=;
        b=XtwGD5/aFJqBTY294CK0c2mhZDd5L6nexbV9F7IbfrImm19OXOADAJAzuUYwglGz2k
         w/NfRfD5IpB03vTKQ1EJQ3kghyWBseiMhPhgyfHdsDIzLw71pt8VEzebcjazWECDcamI
         /vyDZRcEAPnxJOBQotM5d6HvvrmFStVJBon/TX0lVuiMrft/csbhAYvQw6fsQW67zrJ3
         z6OMS9/Vy1Vh9yJBh/ha0lgxbd9r/E5ahYMwehPHpIkRrilIEz+wzrk9SNrunlbt7GAu
         ypafK4Li5fBN89BIBWvhgyKxJvKYKeAYEaj/iVSagEmFtMIx4Oh+aaPOgOyBnA0zpLPo
         aJ5Q==
X-Received: by 10.66.139.36 with SMTP id qv4mr1653066pab.53.1412282133173;
        Thu, 02 Oct 2014 13:35:33 -0700 (PDT)
Received: from [127.0.0.1] ([223.176.236.129])
        by mx.google.com with ESMTPSA id xr10sm4699279pab.35.2014.10.02.13.35.31
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 Oct 2014 13:35:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqmw9emdax.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257824>



On 10/3/2014 1:53 AM, Junio C Hamano wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> On 10/3/2014 1:39 AM, Junio C Hamano wrote:
>>> Tanay Abhra <tanayabh@gmail.com> writes:
>>>
>>>> +test_expect_success 'document how unset.variable will behave in shell scripts' '
>>>> +	rm -f .git/config &&
>>>> +	cat >expect <<-\EOF &&
>>>> +	EOF
>>>> +	git config foo.bar boz1 &&
>>>> +	git config --add foo.bar boz2 &&
>>>> +	git config unset.variable foo.bar &&
>>>> +	git config --add foo.bar boz3 &&
>>>> +	test_must_fail git config --get-all foo.bar >actual &&
>>>
>>> You make foo.bar a multi-valued one, then you unset it, so I would
>>> imagine that the value given after that, 'boz3', would be the only
>>> value foo.bar has.  Why should --get-all fail?
>>>
>>> I am having a hard time imagining how this behaviour can make any
>>> sense.
>>>
>>
>> git config -add appends the value to a existing header, after these
>> two commands have executed the config file would look like,
>> ...
> 
> I *know* how it is implemented before the changes of this series.
> And if the original implementation of "add" is left as-is, I can
> imagine how such a behaviour that is unintuitive to end-users can
> arise.
> 
> I was and am having a hard time how this behaviour can make any
> sense from an end-user's point of view.
>

That's what I was trying to document. I think that it makes no sense
to use the feature as I had shown above. I had envisioned "unset.variable" to
be explicitly typed in on the appropriate place as can be seen in the first
two tests but Matthieu had suggested to add tests using git config too. This
is when I had discovered these inconsistencies.

I can think of two solutions, one leave it as it is and advertise it to be
explicitly typed in the config files at the appropriate position or to change
the behavior of unset.variable to unset all matching variables in that file,
before and after. We could also change git config --add to append at the end
of the file regardless the variable exists or not. Which course of action
do you think would be best?
