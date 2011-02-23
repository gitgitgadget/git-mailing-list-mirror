From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/6] fetch/pull: recurse into submodules when necessary
Date: Wed, 23 Feb 2011 17:58:08 -0600
Message-ID: <20110223235808.GB7286@elie>
References: <4D656F25.5090007@web.de>
 <4D656F4D.6080401@web.de>
 <20110223230713.GB6819@elie>
 <4D659BB2.3020805@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Kevin Ballard <kevin@sb.org>, Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Feb 24 00:58:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsOb7-0003oe-9r
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 00:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982Ab1BWX6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 18:58:16 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:51291 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042Ab1BWX6P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 18:58:15 -0500
Received: by ewy6 with SMTP id 6so1717979ewy.19
        for <git@vger.kernel.org>; Wed, 23 Feb 2011 15:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=XYVAdRLFuZuev6bJBtXgRO020TRy6IytTZQxwIBjjqM=;
        b=jI+Xej/C+PCzPgEBbYqU207/TgcMs5i2d/dpN2T7fy/nLEa1lh79llDLNF9qGf9IMX
         8/nhYnzBi93YzsxlA4UoLFNNtT5iJFLV71oBVhSddS4aPjL+mrBPxl6SdDDZ2656e8pB
         +Mgpo2XbbMkVaecQwGptUyNkGS5GwFpl2EIYU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lDiOozhquETnlObpxptUiGAVmt7nuqgF4hN39VteH0uf2qBFvp43y2EL54Z9ak6GVX
         Zg9M4EDnfFPH9jXNRAOsKlKpGpr2QOJSiwgq5SJFZ9H8fglYGwVIAxl8iWGsr4XN55Sn
         Gv2AdzBBSNFq798JeCBGk7q/X5rsJyP+0RFmg=
Received: by 10.213.27.71 with SMTP id h7mr672373ebc.20.1298505493997;
        Wed, 23 Feb 2011 15:58:13 -0800 (PST)
Received: from elie ([69.209.53.52])
        by mx.google.com with ESMTPS id t50sm7600485eeh.6.2011.02.23.15.58.12
        (version=SSLv3 cipher=OTHER);
        Wed, 23 Feb 2011 15:58:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D659BB2.3020805@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167749>

Jens Lehmann wrote:
> Am 24.02.2011 00:07, schrieb Jonathan Nieder:

>> Could this be combined with the --recurse-submodules, with a "last instance
>> of the option wins" rule?  Something like:
>> 
>>  --recurse-submodules[=(yes | no | changed)]::
>>  --no-recurse-submodules::
>
> Nope, as this only sets the default. "--recurse-submodules" overrides
> anything configured, which is not what we want here. This option should
> only set the default.

Ah.  So --recurse-submodules-default means "like --recurse-submodules,
but with lower precedence than the configuration".  Sensible.  (Maybe
it could be documented in --help-all that way?)

>>> +			/* Submodule is new or was moved here */
>>> +			/* NEEDSWORK: When the .git directories of submodules
>>> +			 * live inside the superprojects .git directory some
>>> +			 * day we should fetch new submodules directly into
>>> +			 * that location too when config or options request
>>> +			 * that so they can be checked out from there. */
>>> +			continue;
>> 
>> Maybe this can be mentioned in a BUGS section on the git-fetch(1)
>> manpage to give readers a warning and clue about the intended
>> meaning of --recurse-submodules?
[...]
> I'm not sure I understand what you mean by this, right now this can
> only work for populated submodules. I hope this will change soon, but
> I'm not quite there yet ;-)

What I mean is the following: to make life easier for people and
scripts using --recurse-submodules today, it might be nice to
document how stable or unstable its meaning is.

In this case, there is a plan to make --recurse-submodules=on-demand
do more in the future than it does now;

 - a note in BUGS could explain that --recurse-submodules's current
   behavior is considered an infelicity and likely to change;

 - unfortunately not all users will necessarily see it that way (c.f.
   aforementioned use case), so it might be better to plan on yet
   another choice in the list of options provided by
   --recurse-submodules.

>> Maybe:
>>
>> 	char *new_rev;
>> 	...
>> 	argv[1] = new_rev = xstrdup(...);
>> 	...
>> 	free(new_rev);
>
> I'm not sure I get what the extra variable gains us ...

A reminder to free that memory in all code paths exiting the function.
But it might not be worth the noise.

>> Maybe a comment so the reader doesn't have to delve deeper?
>
> ?

Sorry for the confusion.  That suggestion refers to the loop after it
rather than what comes before it.

>> 	/*
>> 	 * Collect checked out submodules that have changed upstream
>> 	 * in "changed_submodule_paths".
>> 	 */
>> 
>>> +	while ((commit = get_revision(&rev))) {
[...]
> Thanks!

Thanks for deciphering the gibberish I sent. :)
Jonathan
