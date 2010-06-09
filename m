From: =?iso-8859-1?Q?Henrik_Grubbstr=F6m?= <grubba@roxen.com>
Subject: Re: [PATCH v4 0/5] Patches to avoid reporting conversion changes.
Date: Wed, 9 Jun 2010 20:04:34 +0200 (CEST)
Organization: Roxen Internet Software AB
Message-ID: <Pine.GSO.4.63.1006091943100.22466@shipon.roxen.com>
References: <7vfx16oxmz.fsf@alter.siamese.dyndns.org>
 <Pine.GSO.4.63.1006031543340.22466@shipon.roxen.com> <20100604005603.GA25806@progeny.tock>
 <Pine.GSO.4.63.1006041212200.27465@shipon.roxen.com> <20100604194201.GB21492@progeny.tock>
 <Pine.GSO.4.63.1006061143000.27465@shipon.roxen.com> <20100607085947.GA3924@pvv.org>
 <Pine.GSO.4.63.1006071726170.22466@shipon.roxen.com> <20100607195013.GA27362@pvv.org>
 <Pine.GSO.4.63.1006081731550.22466@shipon.roxen.com> <20100609140327.GA19828@pvv.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1423418003-1276106674=:22466"
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Wed Jun 09 20:05:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMPe7-0004ZC-Fk
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 20:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755768Ab0FISEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 14:04:39 -0400
Received: from mail.roxen.com ([212.247.29.220]:44918 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755392Ab0FISEi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 14:04:38 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 133E462819A;
	Wed,  9 Jun 2010 20:04:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZgtQamG3FxA5; Wed,  9 Jun 2010 20:04:35 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 073AF628197;
	Wed,  9 Jun 2010 20:04:35 +0200 (CEST)
In-Reply-To: <20100609140327.GA19828@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148802>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-1423418003-1276106674=:22466
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 9 Jun 2010, Finn Arne Gangstad wrote:

> On Tue, Jun 08, 2010 at 05:52:37PM +0200, Henrik Grubbström wrote:
>
>> [...]
>> True, there's no problem before the attribute change, but there is for
>> commits between the attribute change and when the repository got
>> normalized (which can be a while with the current git).
>
> As you say, the current git makes it easy to commit something where
> the attributes and the contents do not match. I think this needs to be
> fixed, and that your proposed patch in relaxed mode makes the problem
> _worse_, since it will then take even longer before these commits are
> fixed. But see below.
>
>>
>> Re: configuration option naming:
>>
>>   I've settled for core.normalizationPolicy, with the values
>>   'strict' (default) for the behaviour requested by you and Jonathan,
>>   and 'relaxed' for my initial behaviour.
>
> The name might be a bit vague, maybe there are other things that could
> be normalized? Maybe adding the word "index" is an improvement -
> e.g. core.indexNormalizationPolicy or just core.indexNormalization.

Hmm... Maybe.

>> Teaser:
[...]
>
> THIS behaviour is what I find scary. In this case, "ident" is clearly
> a newly added attribute, and git should not hide this from you. If you
> add a mode where git will hide this permanently, chances are the
> repositories will never be fixed.

True.

> The ident attribute may be a bit special since in your case it is only
> supposed to change if some other contents in the file change as well,
> but please also think how this will work with the text/eol
> attributes. Setting the text attribute and then having to CHANGE a
> file before getting it normalized is not good.
>
> Still, I think your original problem description of cloning something
> and ending up with a dirty tree is indeed an annoying problem.  So
> what about having the relaxed mode behave as follows:
>
> If both of these are true:
> - the current attributes for a file are the same as it is registered as
>   in the index with your new patch
> - a checkout of the file would result in identical contents to what is
>   currently in the working directory
> Then behave as if the file is not modified.
>
> Or, in other words: If attributes are unchanged, a file is unmodified
> not only if it would result in the same contents after being added,
> but also if it would result in the current working directory
> contents after being checked out again.

Ok, so the expanded-keywords file in the example should show up as 
modified in relaxed mode as well, but be cleaned if the modified 
attributes file is added to the index? Or only after being committed?

> This should work for both text and ident on clone at least.

I'll see what I can do...

Currently, I'm trying to understand the semantic difference between 
ce_modified() and ce_match_stat().

--
Henrik Grubbström					grubba@grubba.org
Roxen Internet Software AB				grubba@roxen.com
---559023410-1423418003-1276106674=:22466--
