From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH 5/7] enforce `xfuncname` precedence over `funcname`
Date: Fri, 25 Jul 2014 00:59:56 +0530
Message-ID: <53D15EB4.1050303@gmail.com>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>	<1406140978-9472-6-git-send-email-tanayabh@gmail.com>	<xmqqtx67bt78.fsf@gitster.dls.corp.google.com>	<vpqlhrjqmyw.fsf@anie.imag.fr>	<xmqqiommadl0.fsf@gitster.dls.corp.google.com>	<53D15188.2010209@gmail.com> <vpqegxa386m.fsf@anie.imag.fr> <xmqqppgu8sxz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 24 21:30:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAOiQ-0007PW-6e
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 21:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934484AbaGXTaD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 15:30:03 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:51374 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933705AbaGXTaC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 15:30:02 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so4171745pdj.26
        for <git@vger.kernel.org>; Thu, 24 Jul 2014 12:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=9SzcIOrgugiKFB1hAlTq/0a6ZSmeUnnatCcJ2OM+w4I=;
        b=HflcEkYSL2ymntxTA2tf5w8lZL1f/30MQRqGJlKEtml8d6FmxAZi3iU6r5qiUGEtK4
         w+xzNijIGsY6eZvMAe07pxY7e409xQqsdKzNmSPK0Y/qqagVf2BWVhUquL64BnNF49gM
         E1ZYQ9ihccyCvwfim9LhZLBC2a/2TPjFjx1cXOD+Rg7JEbkI3hW9HfBKjrpHIB6brOc4
         po0vyZGQxyHIouB2DvEGd2XJpHC8coPH19y4JrS5EYiYKq5bAzKLPFUnmSgqcffjGB4V
         Y6lAi75SU2+CGfN/s1E/flvFD43xT6JgKA5yBHLs+Z2OiuXp0PUzByjowQccON70xKNP
         tpgQ==
X-Received: by 10.68.125.226 with SMTP id mt2mr13540339pbb.6.1406230201580;
        Thu, 24 Jul 2014 12:30:01 -0700 (PDT)
Received: from [127.0.0.1] ([117.96.50.136])
        by mx.google.com with ESMTPSA id t3sm1625593pdf.54.2014.07.24.12.29.58
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 24 Jul 2014 12:30:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqppgu8sxz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254182>



On 7/25/2014 12:50 AM, Junio C Hamano wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
>> Tanay Abhra <tanayabh@gmail.com> writes:
>>
>>> For core the only test failing was xfuncname vs funcname,
>>
>> Being a little pessimistic: there may be other cases where the hashtable
>> magically gives the right order for existing tests, but that would fail
>> for untested use-cases.
>>
>> But I can't think of any such case.
>>
>>> so the situation is not as bad as you think. One course of action
>>> would be leave git_config() as it is, so that third party apps
>>> may not be broken. Provide a function like git_config_cache(),
>>> then rename all the git_config() calls in core to git_config_cache(),
>>> fallback to git_config() where it is not applicable (for example,
>>> git config -l).
>>
>> I think Junio's point about "git config -l" is correct: we should just
>> keep git_config_raw there.
> 
> I have a slight preference of making git_config() do the right thing
> and take advantage of caching behaviour, to be honest.  How much
> extra effort is necessary in your code to carry a piece of
> information, in addition to what lets you say "here are the values
> associated with that key in the order we read from the files", in
> order to be able to say "by the way, here is the order of key-value
> pairs, if you want to show everything we read in the same order"?
> If it would be excessive, using _raw() could be an easy way to punt,
> but because we know it is easy to decide to punt, I'd like to see us
> see if a real solution is feasible first before punting.
>

I am thinking over it, lets see if there is a way before we take the
easy route.

>>> Also can you name any third party apps that use the git_config()
>>> system on which I can test the patches.
>>
>> There are probably tons of. I can think of git-multimail.
> 
> This question does not really matter.
> 
> Among the various points, I actually think the last one you omitted
> from your quote, closing door to one useful way to fix UI mistakes
> in the future, is the most serious one.
>

If we take the easy way out, fixing UI mistakes would be easier,
just replace git_config_cache() with git_config_raw() for such cases.
