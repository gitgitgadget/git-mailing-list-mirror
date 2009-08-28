From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Round-down years in "years+months" relative date view
Date: Fri, 28 Aug 2009 20:21:46 +0200
Message-ID: <81b0412b0908281121s1d37a0cdj1cdd0595014124e7@mail.gmail.com>
References: <4A97193A.8090502@facebook.com>
	 <20090828060538.GA22416@coredump.intra.peff.net>
	 <81b0412b0908280058i364bfb83nb04354d982abc053@mail.gmail.com>
	 <20090828150212.GA6013@coredump.intra.peff.net>
	 <81b0412b0908281000l41c862f9ye52da7251014c4f7@mail.gmail.com>
	 <20090828171552.GA6821@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Reiss <dreiss@facebook.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 28 20:21:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh65D-0004te-8n
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 20:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbZH1SVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 14:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbZH1SVq
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 14:21:46 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:39812 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045AbZH1SVp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 14:21:45 -0400
Received: by bwz19 with SMTP id 19so1758230bwz.37
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 11:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=xzJfUTU/J1S3sOfOikL/UtT57CE2CdcPRcwitD4IrN4=;
        b=bPSr9/TZTlTnwcSKAr8GAJgIATM6t9VNJ5xAioYGzCQro7QKpYKv/7rYludw4ehetc
         cwS6d7nKcrkajKHRCyFuXRzN31gJPaEZO0wcWkD5w5+3QWMM72fdImhV9HQhXMp+MGPN
         mQJlidvIH+j9RIHLd5/PjyXx6dfkyHRdCBEfo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=hnCYoa7FfffJJp9AHEo0t7bGnRAwYqzWIk5+k1UX9CUtsweF1mG7aLLyG8fz7COMJf
         BUe0YwWEK1cQ4dP+qzTCmJR1a6j0lHbZmpG1lGiC6bGFsJ803KavO6ADT7rzBTFHkBfE
         AuUlErBMoEhfSRR7S5Ik3WwLxzQUOobou973s=
Received: by 10.204.154.76 with SMTP id n12mr1161927bkw.162.1251483706337; 
	Fri, 28 Aug 2009 11:21:46 -0700 (PDT)
In-Reply-To: <20090828171552.GA6821@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127322>

On Fri, Aug 28, 2009 at 19:15, Jeff King<peff@peff.net> wrote:
> On Fri, Aug 28, 2009 at 07:00:59PM +0200, Alex Riesen wrote:
>
>> On Fri, Aug 28, 2009 at 17:02, Jeff King<peff@peff.net> wrote:
>> > But that's the point: you can't do that without a race condition. Your
>> > test gets a sense of the current time, then runs git, which checks the
>> > current time again. How many seconds elapsed between the two checks?
>>
>> How _many_ do you need?
>
> I don't understand what you're trying to say. My point is that if you
> are checking results to a one-second precision, you need to know whether
> zero seconds elapsed, or one second, or two seconds, or whatever to get
> a consistent result.

Taking this particular case as an example, can't we just set the time
of the _commit_ back in time? We can.
And we don't need to know the difference precisely, it can be
something like /[0-9]+ ago/, can't it?
Ok, it is possible, that something goes terribly wrong and the test suite
freezes for an extended period of time, so the pattern above does
not apply anymore. In this case, wont you prefer the test suite to
break? Ok, maybe not, if the freeze was an Ctrl-Z pressed at
unlucky moment. Which involves an operator online and looking,
and action and reaction will be both visible.

So, yes, it is not absolutely safe, but this approach has no side effects
on the working code. And very low probability of something go wrong.
