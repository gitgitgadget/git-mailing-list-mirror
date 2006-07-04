From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] Additional merge-base tests
Date: Mon, 03 Jul 2006 23:41:50 -0700
Message-ID: <44AA0DAE.1060308@gmail.com>
References: <44A9E6AE.10508@gmail.com> <7v3bdhoraa.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: torvalds@osdl.org
X-From: git-owner@vger.kernel.org Tue Jul 04 08:42:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxebk-0003hE-9a
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 08:42:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWGDGlz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 02:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWGDGlz
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 02:41:55 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:39866 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750822AbWGDGly (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 02:41:54 -0400
Received: by wr-out-0506.google.com with SMTP id 71so80529wri
        for <git@vger.kernel.org>; Mon, 03 Jul 2006 23:41:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Ysfe2VOwQQI8huT8a5TQEv+X+8FLgcuKgSWfga755jacIIx/hT+Nac+Yb9A2eZFYRm08w1NetcsidmCDQqV9r9GJpstrKJtbgIqqP6Testwcyfm6E9L/HkK/bi9dBUa6aTiRSUlx3GrK5tZN28JxszbMOHtiECrd4xKHJjEYFZM=
Received: by 10.54.91.18 with SMTP id o18mr1442598wrb;
        Mon, 03 Jul 2006 23:41:53 -0700 (PDT)
Received: from ?10.0.0.6? ( [69.160.147.208])
        by mx.gmail.com with ESMTP id 38sm3575068wrl.2006.07.03.23.41.52;
        Mon, 03 Jul 2006 23:41:53 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060411)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
In-Reply-To: <7v3bdhoraa.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23259>

Junio C Hamano wrote:
> A Large Angry SCM <gitzilla@gmail.com> writes:
> 
>> This demonstrates a problem with git-merge-base.
>>  
>> +# Setup for second test set
>> +#
>> +#   PL  PR
>> +#  /  \/  \
>> +# L2  C2  R2
>> +# |   |   |
>> +# L1  C1  R1
>> +# |   |   |
>> +# L0  C0  R0
>> +#   \ |  /
>> +#     S
> 
> Cute.
> 
> This is a good demonstration that merge-base may not give you
> minimal set for pathological cases.  If you want to be through
> you could traverse everything to make sure we do not say 'S' is
> relevant, but that is quite expensive, so I think there will
> always be artifacts of horizon effect like this no matter how
> you try to catch it (didn't I keep saying that already?).

Not _that_ pathological in practice, given that you can't really depend 
on the timestamps in a distributed SCM.

The problem is in mark_reachable_commits(); it is either superfluous or 
it needs to parse_commit() those commits that haven't been parsed yet 
that it needs to traverse.

> However, I do not think it is really a "problem".  At least what
> "merge-base --all" did not miss any, that should be OK.

The degree of the problem is, admittedly, situational.

> I think the practical way to proceed is to say that the test
> condition should really check that we do not _omit_ C2 in the
> merge-base --all output.

I do not believe that the (current) code will miss any bases but it can 
certainly return bases that are reachable from other bases.
