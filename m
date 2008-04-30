From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 0/7] limit the usage of the default remote "origin" to
 the minimum
Date: Wed, 30 Apr 2008 07:24:00 +0200
Message-ID: <48180270.9080708@gnu.org>
References: <4812DA50.3000702@gnu.org> <cover.1209391614.git.bonzini@gnu.org> <20080429193536.GA19340@sigill.intra.peff.net> <7vwsmg5nqv.fsf@gitster.siamese.dyndns.org> <20080429231201.GA22646@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	spearce@spearce.org, johannes.schindelin@gmx.de, srb@cuci.nl,
	Alex Riesen <raa.lkml@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 30 07:24:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr4oN-00089S-6v
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 07:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630AbYD3FYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 01:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbYD3FYM
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 01:24:12 -0400
Received: from hu-out-0506.google.com ([72.14.214.224]:38128 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbYD3FYL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 01:24:11 -0400
Received: by hu-out-0506.google.com with SMTP id 19so349797hue.21
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 22:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=qMaqcP4GCw3tdN2x1hrKc/jvw2WIdmrj2tI3AJtYHCM=;
        b=sB01E+GwpaIjeH1wZVVXL4DYhLUoMXezOdNm78x3jI7PAv6zuuuS36dQ9UfyZqqxNcznefB/ymzJOK+H4jzUBVo2f/Eo8pvT1Ezwl8QqXE2VZ+5gSkrJO4tAyTHLsuOOI7/gEKlyX6yuDA1RXlEA/Pvc+y8Ke983qR3N/4LIBOY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=KFt051v2473zUqbVtxuxI5nesnaCpbez7K+QAl3APIrhUg0nTjpsYTI4V0eMvznV6vIpSbIc/dmlTrwvY6rR1ub68QEnqDuvlQpcQH2xTvMc6y7hsUHcm40nGvbyXW36I0qNqHZKt/Z9l8+wGn97aesci+fSbkRqiuaAiFo6O78=
Received: by 10.86.25.17 with SMTP id 17mr278571fgy.65.1209533039263;
        Tue, 29 Apr 2008 22:23:59 -0700 (PDT)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id d4sm113584fga.4.2008.04.29.22.23.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Apr 2008 22:23:58 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <20080429231201.GA22646@sigill.intra.peff.net>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80792>


>>> ... The principle of "remove defaults from code, and
>>> put them into the automatically generated config file" makes sense to
>>> me. It gives users an easy place to look to understand and change such
>>> behavior. So even without the rest of the patches, I think this is an
>>> improvement.
>> If the removal of defaults do not break expectations of users of an
>> existing repository, I'd agree.  Is it the case, or the lack of default
>> that is supposed to be there now suddenly makes the tool do unexpected
>> things?
> 
> I think in the case of patches 1 and 2 (but without the later patches)
> it becomes redundant. And of course, Paolo's idea is that it opens us up
> to changing the default later, in which case it will cease to be
> redundant. But I think even in the meantime that it gives the user
> a clue when looking in the config file about what can be tweaked.

Agreed.  Patches 1 and 2 can definitely go in earlier and can help in 
the transition (see later).

> Didn't we already have this discussion and don't we already have a way to
> define a remote that you can use to push to more than one places?

No, because you may want to push to some places, and mirror to others. 
Unfortunately, mirroring is not handled entirely within match_refs but 
is also special-cased in builtin-send-pack.c.  So you cannot handle it 
with a magic refspec (like --force), and you are forced to use a 
separate remote, independent of remote.*.mirror.

>>> ... I
>>> assume people still with ancient .git/remotes files? Are those actually
>>> deprecated?
>>
>> Neither .git/branches.  When you interact with hundreds of remote
>> repositories, one interesting branch per each, like akpm does, the format
>> of one-file-per-remote is far easier and simpler to work with.
> 
> Then in that case, I think the warning is definitely bogus.

When you use .git/remotes and .git/branches, do you actually use them 
with the zero-argument versions of "git pull" (and "git fetch")?  I'm 
not sure about that, actually I very much doubt so.

So here is my plan.

1) Merge patches 1 and 2 now.

2) Add a warning to "git push" if it pushes to something without a push 
refspec.  Merge patch 3, the doc can say that --push suppresses this 
warning.  Make sure the warning suggests how to silence it.

3) Merge patch 5 as it is just a cleanup.

4) Merge patch 6.

5) Add a similar warning to "git fetch".

6) Add a warning when "git push" is used with zero-arguments and there 
is more than one remote with a push refspec.  Something like, "git push 
will only push to ***.  This may not be what you want, and it may change 
in future versions of git".

7) If there is a revolt against the warning in (5), revert it and add a 
warning whenever the "magic origin" behavior is triggered by "git push".


For 1.6.0, the remaining changes would be harder to warn about 
preventively, so this part can be refined:

8) In "git pull", turn the warning into an error.

9) Ditto for "git fetch".

10) Ditto for "git push" if we had to go for (7).  If we didn't, merge 
patch 4 for 1.6.0.  Put a prominent note in the release notes that "git 
push" will push to all remotes with a push refspec.  By now, users will 
have added push refspecs appropriately thanks to the warning in step 2 
above; so at least "git push" will not stop pushing to origin.


In the meanwhile, decide what is the best thing to do for patch 7.  If 
we decide it is to go in, steps 5 and 9 will have to be replaced with 
something else (I don't know what).

Paolo
