From: Michael G Schwern <schwern@pobox.com>
Subject: Re: [PATCH 1/4] Extract some utilities from git-svn to allow
 extracting Git::SVN.
Date: Wed, 25 Jul 2012 17:01:48 -0700
Message-ID: <501088EC.50405@pobox.com>
References: <1343196066-81319-1-git-send-email-schwern@pobox.com>
 <1343196066-81319-2-git-send-email-schwern@pobox.com>
 <20120725212418.GA17494@dcvr.yhbt.net> <501075B2.8090205@pobox.com>
 <20120725230833.GA23993@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, Jonathan Nieder <jrnieder@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jul 26 02:02:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuBX0-0005Ui-3B
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 02:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233Ab2GZABw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 20:01:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53544 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751126Ab2GZABv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 20:01:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1B619848;
	Wed, 25 Jul 2012 20:01:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=Gu3rDjxoHHhH
	1j+QNfV6bZf4N7Y=; b=BSVSwVvWBKGn+hOCjdtD++uSrzacKfBizR9VMYg7irWu
	dOoj2LU9KMLZBHEoz02R8MO4YnHScac9Hzlol7frZwtrJCPVq5QQilz7a1ALcsi/
	Eskg1RniXN3DXVvW4GKd+bN7VKLwiny/CDl9cbulxlJJNdoLZDM7RhyuOohju0c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Oygb2T
	TaGOKz1zLVlVj8cuOPs61XU5dijUCOpnP4fLgEz0Rw+ANnt1WR5gHjA3O/nleVTf
	UgobXKtyM3gTUNENvRBr1X8E59ZufY/t5VuOwP5dxlfAsBfQnebEf8LookN/TlPO
	ky3urpUNYXWvvS5Ytd/bTstF4tlGRVr/kqoVs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E9469847;
	Wed, 25 Jul 2012 20:01:50 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8BB179843; Wed, 25 Jul
 2012 20:01:49 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <20120725230833.GA23993@dcvr.yhbt.net>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: 19692FD4-D6B5-11E1-9660-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202218>

This is rapidly getting into the weeds.  Regardless of the debate below, what
would you like me to do?  Switch indentation to tabs and resubmit?  AFAIK only
the new tests are affected.


On 2012.7.25 4:08 PM, Eric Wong wrote:
>>>> +BEGIN {
>>>> +    # Override exit at BEGIN time before Git::SVN::Utils is loaded
>>>> +    # so it will see our local exit later.
>>>> +    *CORE::GLOBAL::exit = sub(;$) {
>>>> +        return @_ ? CORE::exit($_[0]) : CORE::exit();
>>>> +    };
>>>> +}
>>>
>>> For new code related to git-svn, please match the existing indentation
>>> style (tabs) prevalent in git-svn.  Most of the Perl found in git also
>>> uses tabs for indentation.
>>
>> About that.  I followed kernel style in existing code, but felt that new code
>> would do better to follow Perl style.  The existing Perl code mixes tabs and
>> spaces, so I felt it wasn't a strongly held style.  You'll get more Perl
>> programmers to work on the Perl code by following Perl style in the Perl code
>> rather than kernel style.
> 
> git-svn should be all tabs (though some spaces accidentally slipped in
> over the years).  git maintainers are mostly C programmers used to tabs,
> so non-C code should favor their expectations.

Perhaps this is self fulfilling.  Would you like to attract more Perl programmers?


> I also favor tabs since they're more space-efficient and leads to faster
> "git grep" on large source trees (more important for bigger projects).
> I remember many years ago "git grep" was shown to be ~20% faster on
> a source tree with tabs.

Storage costs a dime a gig.  One extra music file negates your space savings.
 I have more CPU power on my phone than I had on my desktop "many years ago".
 It doesn't matter if tabs make git-grep 20% faster because it's going to be
200ms vs 240ms.

Regardless, you don't choose your coding style because it's easier for the
computer.  You choose it because it makes the code easier for humans to work with.


> (I'm neither a kernel hacker nor a regular Perl hacker)
> 
>> Alternatively, how about allowing emacs/vim configuration comments?  The
>> Kernel coding style doesn't allow them, how do you folks feel?  Then people
>> don't have to guess the style and reconfigure their editor, their editor will
>> do it for them.
> 
> I don't like them, and I think others here frowns upon them, too.  They
> take too much space and shows favor/preference towards certain editors.
> It'll be a bigger problem if more editors become popular and we start
> "supporting" them.

What you say above is correct, but the extra space is not wasted.  It would be
like complaining about all the space that Documentation takes up, and that it
shows preference towards English.  Its *useful* to somebody not already using
your style.  It's useful for new-to-your-project folks.  It's also useful for
somebody switching between the C and Perl code (though a good editor should
already be set up to do C and Perl differently).

Are the editor wars still going on here?  Is somebody going to be *offended*
if their editor isn't represented?  If so, shouldn't they grow up?


>> The important thing is to have one less special thing a new-to-your-project
>> Perl programmer has to do.
> 
> Historically git development has catered to C programmers used to tabs.
> I think the mixing of indentation styles in current Perl files is the
> most confusing.

I agree that mixing the style within the Perl code isn't good.  Perl code can
very quickly be reformatted.  A basic perltidy config can help keep it that way.


-- 
Alligator sandwich, and make it snappy!
