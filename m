From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: current git kernel has strange problems during bisect
Date: Mon, 12 Jan 2009 01:17:31 +0300
Message-ID: <f19298770901111417t6762e1e3x79b2f488ee6f1243@mail.gmail.com>
References: <200901111602.53082.borntraeger@de.ibm.com>
	 <200901111607.59054.borntraeger@de.ibm.com>
	 <alpine.DEB.1.00.0901111613250.3586@pacific.mpi-cbg.de>
	 <200901111620.03345.borntraeger@de.ibm.com>
	 <alpine.LFD.2.00.0901111113150.6528@localhost.localdomain>
	 <20090111194258.GA4840@uranus.ravnborg.org>
	 <alpine.LFD.2.00.0901111200330.6528@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Sam Ravnborg" <sam@ravnborg.org>,
	"Christian Borntraeger" <borntraeger@de.ibm.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	"Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 11 23:19:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM8e0-0002Yz-2u
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 23:18:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbZAKWRf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 17:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751966AbZAKWRf
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 17:17:35 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:51223 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbZAKWRe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 17:17:34 -0500
Received: by bwz14 with SMTP id 14so31371961bwz.13
        for <multiple recipients>; Sun, 11 Jan 2009 14:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=NgHEdx4zSsWwNOEa9/qftmOE14lA4oyJNJUeM8jFlMk=;
        b=SycFlnSUTkgagFlGC89U83jSqDsYqiRvQkFGLuICKW0g+JQF+Wd/hnfSuuG2VPGc38
         WsBKO5U1wB9XM0tj7lCCYR5AM8fQSgi1yedr4GQRyeyhRfzQ1iQy1y5NB5OBnW1pjf5E
         qKjijqmRlW1lerIIvsj751JIlJhVOdhQtGmC0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=OAi1IXSIGfuiZ5gnTZsjyPOku1Qtf70LNVpKOw0dYp7/PHd7V2lCPEjPNdaE72cqvn
         99mA5TgEYy6CjZRFPRFpQS8Qmtlrd1/BYfTTNZBEdBOxPxTINQmt1MADfFwSQkBh5LqT
         5Gjz8Ex9J5EYrKOe+MX9RVLGvk4otDUV3KxD8=
Received: by 10.223.124.209 with SMTP id v17mr20535248far.6.1231712251379;
        Sun, 11 Jan 2009 14:17:31 -0800 (PST)
Received: by 10.223.121.211 with HTTP; Sun, 11 Jan 2009 14:17:31 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0901111200330.6528@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105234>

On Sun, Jan 11, 2009 at 23:04, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> On Sun, 11 Jan 2009, Sam Ravnborg wrote:
>>
>> The cost of moving this piece of history from one git tree to another
>> git tree is that we make it harder to debug the kernel for the advanced user
>> that knows how to do bisect.
>>
>> It is not like this history would be lost - one just had to look
>> somewhere else to find it.
>>
>> That may be a bad pain/benefit ratio - time will tell.
>
> Umm. No.
>
> Time is exactly what makes it useful. It will make all the downsides
> shrink, and the advantages stay.
>
>> There should be a way to avoid such pain when bisecting without
>> having to mark a semi-random (for the average person) commit as good.
>
> Well, you don't actually have to mark that semi-random one as good either.
> What you can do is to just mark anything that _only_ contains fs/btrfs as
> good. IOW, you don't have to know the magic number - you just have to be
> told that "oh, if you only have btrfs files, and you're not actively
> bisecting a btrfs bug, just do 'git bisect good' and continue".
>
> Yeah, you'll hit it a few times, but you don't even have to compile things
> or boot anything, so it's not actually going to be all that much slower
> than just knowing about the magic point either.

But would not such bug avoid being bisected if you blindly
mark btrfs commits as good?

v2.6.29 <-- bad
...
...
...
btrfs stuff <-- mark as good
...
the-real-bug
...
v2.6.28 <-- good

So you hit the btrfs commit, mark it as good, leaving the real bug below,
and the bisection continues, with both sides being actually bad.

Am I missing something?
