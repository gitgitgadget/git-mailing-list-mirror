From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] make commit --interactive lock index
Date: Thu, 29 May 2008 16:40:57 +0200
Message-ID: <483EC079.1050008@gnu.org>
References: <E1K1eXH-00063c-Bt@fencepost.gnu.org> <alpine.DEB.1.00.0805291343120.13507@racer.site.net> <483EABD8.3050600@gnu.org> <alpine.DEB.1.00.0805291454270.13507@racer.site.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 29 16:47:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1jKB-0004Ze-LC
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 16:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbYE2Ok7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 10:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752493AbYE2Ok7
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 10:40:59 -0400
Received: from mu-out-0910.google.com ([209.85.134.188]:24994 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbYE2Ok7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 10:40:59 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2653848mue.1
        for <git@vger.kernel.org>; Thu, 29 May 2008 07:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=MtSZc3H9dFCMEfWEK659NmxTaIn+ItjVr4YfQRbfryw=;
        b=TThF3ijlYhMIf1g9abwsjUw3nwyaJIV+LvgdPniCi3u7sfjtjsxXOAYavZJCp57RvdR4KiwJjsi+GbTaz5agxfQaj+JuQ8iIIrRwNX7EFJadqCzUD8HyA1F+Hrzt+Ke5kFJecz0wABDfECe/DBMpg0X6hfX1AxiGkTWCJ2vKCtE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=UydAeNcmkL4RNKz11lAKA+wqSLJ6HDfVnRTbJ8K5Ln84MEAGBiV/UhO0XxXYps+9dWsXJmkZp/D37qADxtOQFFkSkA9vieOq9R5v6JyyUIcHusJXGT0ysLccIykJDpzTURWKzYm/+DizezPH0um86N7y1q+Y9W50Z9JNZJDxbvs=
Received: by 10.103.11.7 with SMTP id o7mr2782182mui.103.1212072056620;
        Thu, 29 May 2008 07:40:56 -0700 (PDT)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id u9sm4557152muf.12.2008.05.29.07.40.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 May 2008 07:40:55 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <alpine.DEB.1.00.0805291454270.13507@racer.site.net>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83204>


>>>> +	assert (!(interactive && pathspec && *pathspec));
>>> As pathspec is specified indirectly by the user, I think an assert() 
>>> here is actively wrong.
>> But the program may still guarantee a condition by checking it 
>> elsewhere.  I don't need to teach you about that, do I?  In particular, 
>> the assert checks that this:
>>
>> if (interactive && argc > 0)
>>         die("Paths with --interactive does not make sense.");
>>
>> ... is equivalent to !pathspec || !*pathspec.
> 
> Okay, I have to spell it out:
> 
> I think that the assert() here is not helpful at all, and that you should 
> rather do the "if () die()" thingie.

The "if() die ()" thingie is already in builtin-commit.c, so we won't 
ever get a pathspec in the "add --interactive" case.  If we do, 
something else has already been done incorrectly before -- not by the 
user but by the programmer.

Paolo
