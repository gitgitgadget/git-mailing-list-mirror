From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Makefile: Fix compilation of windows resource file
Date: Wed, 22 Jan 2014 09:38:18 -0800
Message-ID: <xmqqppnjyl10.fsf@gitster.dls.corp.google.com>
References: <52DD857C.6060005@ramsay1.demon.co.uk>
	<xmqqy529t5bb.fsf@gitster.dls.corp.google.com>
	<xmqqppnlt3u3.fsf@gitster.dls.corp.google.com>
	<52DEF9F2.1000905@ramsay1.demon.co.uk>
	<xmqqk3dssxpb.fsf@gitster.dls.corp.google.com>
	<52DF6B6C.4020708@viscovery.net>
	<xmqq38kgyozt.fsf@gitster.dls.corp.google.com>
	<52DFF4E8.8060605@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jan 22 18:38:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W61ky-0006Gs-LD
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 18:38:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797AbaAVRiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 12:38:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38903 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752564AbaAVRiY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 12:38:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E71B965A7B;
	Wed, 22 Jan 2014 12:38:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R18vP+HetE5fyRx/WzSM4ilPaUI=; b=NDO8aT
	O8M8iWVD0OIzS3v4KF+pLgX9+OwZR7CJNA2GuyzBzsTG2ZhEZsZF/+Tq7Ck3Vu6Q
	GslEAlNUpK5KPqTK3jxGspuUh/xB4tL+fMOWK1CD2rHUIZRkDm67nHMd9hPnXcAU
	1pwf+tAp8997oPLt6vYpO8XBvKAITK1z7nWYs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QiyPEv/KAqRIbZPq2ZphhJ5WDxFPoNpm
	qM2BGF79tFg+4k9Y8F1oy6y32bSjjR1XUdX/NimUq8/twbpxaEz+VeiL9q1BWkPB
	dAZaaY+kUcZnu06HD8qbN/U0Aylu33Fv374YZkWB3YzmN/aHbM9a0qK2WG9H8X85
	Ip8mPF5kIPs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D620565A7A;
	Wed, 22 Jan 2014 12:38:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2834E65A76;
	Wed, 22 Jan 2014 12:38:22 -0500 (EST)
In-Reply-To: <52DFF4E8.8060605@viscovery.net> (Johannes Sixt's message of
	"Wed, 22 Jan 2014 17:42:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FD211CB2-838B-11E3-AFA4-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240841>

Johannes Sixt <j.sixt@viscovery.net> writes:

> The numbers defined in {FILE,PRODUCT}VERSION statements are intended for
> machine consumption and are always 4 positions (if the source contains
> fewer, they are padded with zeros). They can be used by installers to
> decide whether a file that already exists in the system should be
> overwritten by a newer version.

OK, that makes sense.  If you package 1.9 (padded as 1.9.0.0) and
then 1.9.1 (padded as 1.9.1.0), you can update from 1.9 to 1.9.1
just fine.

> Unfortunately, these numbers are visible when the user invokes Properties
> from the context menu of git.exe in the file manager and then switches to
> the "Version" tab. All 4 positions are always listed. Therefore, the user
> will see "1.9.0.0" for the first release of the 1.9 series, which is
> "wrong", because you will call "1.9", not "1.9.0.0", I assume.
>
> With sufficient effort, we could achieve that version 1.9.1 is listed as
> "1.9.1.0". That is still "wrong".

I would not be worried about showing 1.9.1.0 for 1.9.1 and/or
1.9.0.0 for 1.9 at all.

But if the (receiving) system expects these to be monotonically
increasing, I suspect the script I posted would not "work well"
under that expectation.  When you package 1.9.2.g43218765.dirty,
that would become "1.9.2.0", and become indistinguishable from the
package taken from v1.9.2 tag, which is not good at all.  So the
script should strip [0-9]*\.g[0-9a-f]*\(\.dirty\)? from the end
first.

But even without complications from the "N-commit after the tag" it
won't "work well" if you cut packages from anything that is not
tagged anyway.  The only thing we know about any package taken from
the tip of 'master' past v1.9 is that it is newer than the package
taken from v1.9 tag. Sometimes it should be considered newer than a
package taken from v1.9.x tag (i.e. the contents of the maintenance
relase is fully included in 'master'), but not always (i.e. the tip
of 'master' when the package was made may contain up to v1.9.3 but
v1.9.4 may be newer than that).

If you truncate down to only two, like your patch does, anything
past v1.9 and before v1.10 (or v2.0) would have 1.9.0.0 and that is
no worse than giving 1.9.3.0 for v1.9.3 and giving 1.9.0.0 for
anything based on 'master'.  Your user may have installed a package
made from v1.9.1 and would want to update to the one taken from
'master' when it contained everything up to v1.9.3---under my
earlier "take numbers" approach, we would be "updating" from 1.9.1.0
to 1.9.0.0, which does not look like updating at all to the system.
The installers can use this to decide "a file that already exists in
the system" is newer, which is wrong, if I am reading your earlier
explanation corretly.

With your "we just take the first two numbers always", you would be
sidegrading between two 1.9.0.0, which may fare better.

> Since we can't get this display right, I suggest that we just punt (as per
> my patch). That should work out nicely because we can fairly safely assume
> that there are no installers around that look at these particular version
> numbers.
>
> BTW, that same "Version" tab will have another entry, called "Product
> Version" later in the list. This one lists the string that we pass in
> -DGIT_VERSION (see quoted context below). It is the truely correct version
> that *users* should be interested in.
>
>> 
>>> diff --git a/Makefile b/Makefile
>>> index b4af1e2..99b2b89 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -1773,7 +1773,7 @@ $(SCRIPT_LIB) : % : %.sh GIT-SCRIPT-DEFINES
>>>  
>>>  git.res: git.rc GIT-VERSION-FILE
>>>  	$(QUIET_RC)$(RC) \
>>> -	  $(join -DMAJOR= -DMINOR= -DPATCH=, $(wordlist 1,3,$(subst -, ,$(subst ., ,$(GIT_VERSION))))) \
>>> +	  $(join -DMAJOR= -DMINOR=, $(wordlist 1,2,$(subst -, ,$(subst ., ,$(GIT_VERSION))))) \
>>>  	  -DGIT_VERSION="\\\"$(GIT_VERSION)\\\"" $< -o $@
>>>  
>>>  ifndef NO_PERL
>>> diff --git a/git.rc b/git.rc
>>> index bce6db9..33aafb7 100644
>>> --- a/git.rc
>>> +++ b/git.rc
>>> @@ -1,6 +1,6 @@
>>>  1 VERSIONINFO
>>> -FILEVERSION     MAJOR,MINOR,PATCH,0
>>> -PRODUCTVERSION  MAJOR,MINOR,PATCH,0
>>> +FILEVERSION     MAJOR,MINOR,0,0
>>> +PRODUCTVERSION  MAJOR,MINOR,0,0
>>>  BEGIN
>>>    BLOCK "StringFileInfo"
>>>    BEGIN
