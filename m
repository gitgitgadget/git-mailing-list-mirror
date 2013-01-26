From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 1/2] git-p4.py: support Python 2.5
Date: Sat, 26 Jan 2013 10:19:37 -0800
Message-ID: <CA+sFfMfxQUqe-Nqp-2CjZ0ShLuwOYqPUCOQMrGASUmhEhxNMNg@mail.gmail.com>
References: <1359146641-27810-1-git-send-email-drafnel@gmail.com>
	<1359146641-27810-2-git-send-email-drafnel@gmail.com>
	<20130126124510.GA31052@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, esr@thyrsus.com, john@keeping.me.uk,
	Brandon Casey <bcasey@nvidia.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 19:20:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzAMH-0001Lb-2a
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 19:20:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379Ab3AZSTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 13:19:39 -0500
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33145 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343Ab3AZSTi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 13:19:38 -0500
Received: by mail-wi0-f177.google.com with SMTP id hm2so430827wib.4
        for <git@vger.kernel.org>; Sat, 26 Jan 2013 10:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=6wlbGnacqpcCXsrxVZjfEym3YPnsWohNvqWXXLaEfak=;
        b=o0DPX1AnKxBqnPkIVDmIFHEr1c7dSTveLWBNhawGVPOtWKvAoRClmdxiJvoTtgmnxQ
         mbgXq/oW49W3iAd9NhZBOqcBP2pqboS8mjK9DuZci3B15xglB7vyd5WfZY+d262GsOtu
         g6yeYd8ttWysxRYP5Epv9skh53la9OI9/bHUXMd+d87ozCaXnSKmkYLHQ38+lvQvxrTq
         ns9TXdUgiiZtINJV3VPN63umc+UVkMrkPFIv8kIcjxI3hrof6rGkQmN+IhL2FbqX0rHW
         dOZyLYHcVlGw8WtdIFNdZarsgR57xJrKPZ0SIAWFneRNik0m2EPM6Q6bvgrE+eXUq/wK
         t5Ug==
X-Received: by 10.194.242.69 with SMTP id wo5mr14227112wjc.10.1359224377180;
 Sat, 26 Jan 2013 10:19:37 -0800 (PST)
Received: by 10.194.143.18 with HTTP; Sat, 26 Jan 2013 10:19:37 -0800 (PST)
In-Reply-To: <20130126124510.GA31052@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214630>

On Sat, Jan 26, 2013 at 4:45 AM, Pete Wyckoff <pw@padd.com> wrote:
> drafnel@gmail.com wrote on Fri, 25 Jan 2013 12:44 -0800:
>> Python 2.5 and older do not accept None as the first argument to
>> translate() and complain with:
>>
>>    TypeError: expected a character buffer object
>>
>> Satisfy this older python by calling maketrans() to generate an empty
>> translation table and supplying that to translate().
>>
>> This allows git-p4 to be used with Python 2.5.
>
> This was a lot easier than I imagined!
>
>>  def wildcard_present(path):
>> -    return path.translate(None, "*#@%") != path
>> +    from string import maketrans
>> +    return path.translate(maketrans("",""), "*#@%") != path
>
> translate() was a bit too subtle already.  Could you try
> something like this instead?
>
>     m = re.search("[*#@%]", path)
>     return m is not None
>
> I think that'll work everywhere and not force people to look
> up how translate and maketrans work.

Yes that's simpler and works fine.

-Brandon
