From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] push: Alias pushurl from push rewrites
Date: Wed, 27 Mar 2013 14:15:54 -0700
Message-ID: <20130327211554.GH28148@google.com>
References: <20130327122216.5de0c336@hoelz.ro>
 <20130327182345.GD28148@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	josh@joshtriplett.org
To: Rob Hoelz <rob@hoelz.ro>
X-From: git-owner@vger.kernel.org Wed Mar 27 22:16:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKxht-0008Fo-8P
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 22:16:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754160Ab3C0VQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 17:16:00 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:47545 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753377Ab3C0VP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 17:15:59 -0400
Received: by mail-pa0-f42.google.com with SMTP id kq13so1705305pab.29
        for <git@vger.kernel.org>; Wed, 27 Mar 2013 14:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=zB9oebqOsItsfjRXLBI5BwoPWBBM0eP/Kurm//XPrEA=;
        b=0iAAB0VZiBhg+uB5hIld/oRrpkbIZulvq7TR6/xKyuZfdwY+lKggDEA2ZHWGEk7KHy
         IA1546OscQ38u5JMfMkk6znxmA9Wt0YE0EEBIk5401F+TV6pI1hk2PBectIuMQQ3PuLx
         B5ERG4RmMY1usHVRctqDAjyYk+EdmwPi7yJ6AcpChQukrIdKIWjD6gkPDV4NXlpnrSrs
         /vE2j6HROVkEGPfysVQ7DceQDS5GfoWPWyEy+9cEPRKK0D1fmcLVXcgU3nmImxX8h5M+
         0BMx6TxgaweC0QgtDa0M1tyIR4ZTwNZPMucSXuf2/SOy3c16JGkpvktCWwyoKGACGavI
         uyJg==
X-Received: by 10.66.163.132 with SMTP id yi4mr32041810pab.104.1364418959360;
        Wed, 27 Mar 2013 14:15:59 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id mz8sm22743893pbc.9.2013.03.27.14.15.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 Mar 2013 14:15:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130327182345.GD28148@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219333>

Jonathan Nieder wrote:
> Rob Hoelz wrote:

>> --- a/remote.c
>> +++ b/remote.c
>> @@ -465,7 +465,11 @@ static void alias_all_urls(void)
[...]
>> -			remotes[i]->pushurl[j] = alias_url(remotes[i]->pushurl[j], &rewrites);
>> +			char *copy = xstrdup(remotes[i]->pushurl[j]);
>> +			remotes[i]->pushurl[j] = alias_url(remotes[i]->pushurl[j], &rewrites_push);
>> +			if (!strcmp(copy, remotes[i]->pushurl[j]))
>> +				remotes[i]->pushurl[j] = alias_url(remotes[i]->pushurl[j], &rewrites);
>> +			free(copy);
>
> Interesting.
>
> Suppose I configure
> 
> 	[url "git://anongit.myserver.example.com/"]
> 		insteadOf = myserver.example.com:
> 	[url "myserver:"]
> 		pushInsteadOf = myserver.example.com:
>
> The above code would make the insteadOf rule apply instead of
> pushInsteadOf, even when pushing.

Sorry, typo.  The configuration in the example above should have been

	[url "git://anongit.myserver.example.com/"]
		insteadOf = myserver.example.com:
	[url "myserver.example.com:"]
		pushInsteadOf = myserver.example.com:

In other words, suppose I set url.*.insteadof to point to a faster
address for fetching alongside url.*.pushinsteadof requesting that the
original address should still be used for pushing.

Thanks again for tackling this.
Jonathan
