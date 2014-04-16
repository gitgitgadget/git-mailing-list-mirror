From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] rebase: avoid non-function use of "return" on FreeBSD
Date: Wed, 16 Apr 2014 09:47:23 -0700
Message-ID: <xmqqsipdi5lw.fsf@gitster.dls.corp.google.com>
References: <438458da797bcab97449bfa931a9d1d@74d39fa044aa309eaea14b9f57fe79c>
	<0779303f7d2257a618b5bed00260a8a@74d39fa044aa309eaea14b9f57fe79c>
	<xmqqob03le3v.fsf@gitster.dls.corp.google.com>
	<FAD02895-24B2-46C3-ABEF-E9CE17926FF9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 18:47:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaSzl-0000qm-OB
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 18:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045AbaDPQr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 12:47:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43399 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751331AbaDPQr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 12:47:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE04A7BE55;
	Wed, 16 Apr 2014 12:47:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vUGV7fChx3kjxN9mG0jL94AH/xM=; b=qmHidG
	I94vrWj4EnfROpef3x4FCcrk6HvJ66CtiIhIMytYPAWvq5M6oqDX3fInoPm/Bwk+
	n3Zjz3Ecc2P8HwQcnN3kFst3AiYQP0H0JPDW/zcVxGBQ67gfx10Kfo/mOs4oVQNx
	xnDwt+w34JlMoG1LgeJk94Dxw6cyWOLPX9+Gk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VL73mRxSvtte8j9Gi81Xnsg4DqSkg3D5
	Jxxbt66UcFJmWBxeL9D3xFWcsDEgu2r3S1SYEm4hvaoeyd4cSvY78WHullkNsI/U
	qLYNh6bHFd0PvYvLGJTt7SbqWKMfAFkMrSPgqU3ml8Hr8j6WF01fmXe7igfUPpbi
	RHM4Bi3mIYA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C63597BE52;
	Wed, 16 Apr 2014 12:47:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EADC17BE51;
	Wed, 16 Apr 2014 12:47:24 -0400 (EDT)
In-Reply-To: <FAD02895-24B2-46C3-ABEF-E9CE17926FF9@gmail.com> (Kyle J. McKay's
	message of "Tue, 15 Apr 2014 21:32:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C99CE0E6-C586-11E3-BCFC-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246341>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> On Apr 14, 2014, at 15:51, Junio C Hamano wrote:
>> I think we would want to see the actual change formatted this way
>> (without needing to pass "-w" to "git show"), as it will make it
>> clear that this artificial extra level of "define the whole thing
>> inside a function and then make a single call to it" is a workaround
>> of specific shell's glitch that we would not have to have in an
>> ideal world ;-)
>>
>> Besides that would make it less likely to cause conflicts with the
>> real changes in flight.
>
> Sounds good to me.
>
>> Please double check what I queued on 'pu' when I push out today's
>> integration result.
>
>> diff --git a/git-rebase--am.sh b/git-rebase--am.sh
>> index a4f683a5..2ab514ea 100644
>> --- a/git-rebase--am.sh
>> +++ b/git-rebase--am.sh
>> @@ -4,6 +4,13 @@
>>  # Copyright (c) 2010 Junio C Hamano.
>>  #
>>
>> +# The whole contents of the file is run by dot-sourcing this file
>> from
>> +# inside a shell function, and "return"s we see below are expected to
>> +# return from that function that dot-sources us.  However, FreeBSD
>> +# /bin/sh misbehaves on such a construct, so we will work it around
>> by
>> +# enclosing the whole thing inside an extra layer of a function.
>> +git_rebase__am () {
>
> I think the wording may be just a bit off:
>
>> and "return"s we see below are expected to return from that function
>> that dot-sources us.
>
> I thought that was one of the buggy behaviors we are working around?

Yeah, it is written as if every reader has the knowledge that the
extra

	extra__func () {
        ...
        }
        extra__func

around did not originally exist.  The description does not read well
with the work-around already there.

> Maybe I'm just reading it wrong...
>
> Does this wording seem any clearer?
>
> 	and "return"s we see below are expected not to return
> 	from the function that dot-sources us, but rather to
> 	the next command after the one in the function that
> 	dot-sources us.

Not really.  The comment was not about explaining "return"s.  When a
reader reads the text with the work-around, it is clear that these
"return"s are inside this extra function and there is no possible
interpretation other than that they are to return from the extra
function.

The comment was meant to explain why a seemingly strange "define a
function and then immediately call it just once" pattern is used,
and "Earlier, these returns were not inside any function when this
file is viewed standalone.  Because this file is to be dot-sourced
within a function, they were to return from that dot-sourcing
function --- but some shells do not behave that way, hence this
strange construct." was meant to be that explanation, but apparently
it failed to convey what I meant to say.

> If I'm the only one getting a wrong meaning from the comments, then no
> reason to change them.

I agree that the description does not read well with the work-around
already there.  I am not sure what would be a better way to phrase
it, though.
