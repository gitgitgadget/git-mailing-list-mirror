From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t6200: avoid path mangling issue on Windows
Date: Fri, 19 Apr 2013 09:33:46 -0700
Message-ID: <7vr4i632fp.fsf@alter.siamese.dyndns.org>
References: <1365348344-1648-1-git-send-email-ralf.thielow@gmail.com>
	<1365348344-1648-2-git-send-email-ralf.thielow@gmail.com>
	<516F95D1.5070209@viscovery.net>
	<7v38un93br.fsf@alter.siamese.dyndns.org>
	<5170DA96.9000300@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Apr 19 18:33:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTEG3-0006tl-3L
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 18:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967876Ab3DSQdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 12:33:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62276 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758506Ab3DSQdt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 12:33:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D85DE156E1;
	Fri, 19 Apr 2013 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vfJuqS2HuaqBpkcvX3oBXwXE3YY=; b=CcWzbG
	yOQxazaVAJjkvOH7fb0pv0Dy8HQbBJAa1FVkyQB74AgDsbnviFfjS+5jdR6AYxeZ
	rNj28nCQ6M0+b0yHej1QroEM7CMGJeQnRFJCtSS2HsXyXfftlTYP5lXxpId3hShC
	OUwsOBqXEGyR2aRSIqT1+0PSWGnf1L0GwiScQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TlkBr/6BeTreRfm6Qj6U65DCvH3r1T9E
	Anb5VPaZcx1WU1h8MTl/YnbN3Qg1cevf51R13JeTnH2vwosP3d6Avwv8lR/EVtrG
	oR/e+aiRsp/R/wwlpAxD5SWARZ3YX9tTrwv53Q3QLD1EzMmo8BecebdHv/PHThif
	3RUmaHANVVk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D00A8156E0;
	Fri, 19 Apr 2013 16:33:48 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F75F156DD;
	Fri, 19 Apr 2013 16:33:48 +0000 (UTC)
In-Reply-To: <5170DA96.9000300@viscovery.net> (Johannes Sixt's message of
	"Fri, 19 Apr 2013 07:48:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E94D477C-A90E-11E2-8ECD-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221769>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 4/18/2013 19:05, schrieb Junio C Hamano:
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>> 
>>> From: Johannes Sixt <j6t@kdbg.org>
>>>
>>> MSYS bash interprets the slash in the argument core.commentchar="/"
>>> as root directory and mangles it into a Windows style path. Use a
>>> different core.commentchar to dodge the issue.
>>>
>>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>>> ...
>>> -	git -c core.commentchar="/" fmt-merge-msg --log=5 <.git/FETCH_HEAD >actual &&
>>> +	git -c core.commentchar="x" fmt-merge-msg --log=5 <.git/FETCH_HEAD >actual &&
>> 
>> Sigh... Again?
>> 
>> Are folks working on Msys bash aware that sometimes the users may
>> want to say key=value on their command line without the value
>> getting molested in any way and giving them some escape hatch would
>> help them?  Perhaps they have already decided that it is not
>> feasible after thinking about the issue, in which case I do not have
>> new ideas to offer.
>
> What is "the issue"? And in which way would an escape hatch help us here?

When the user passes key=value and value begins with a slash, value
may be a path in the filesystem very often, and adjusting it to the
local filesystem convention helps Windows users a lot.

But there are cases outside that very often when the user wants the
value passed literally.  There seems to be no way to do so.

That is the issue I was wondering. If there is a clean solution to
disable path mangling per token, we could cleanly solve it.

For example, while making sure that a value that begins with slash
in normal cases is still adjusted, i.e. mangling all of the
following,

	xyzzy key=/a/b/c
        xyzzy key="/a/b/c"
        value=/a/b/c; xyzzy key="$value"
        value=/a/b/c; xyzzy "key=$value"


if bash could be told with a very unnatural and not so hard to type
way that the particular value is not to be mangled, e.g.

	xyzzy key="""/a/b/c"""
        value=/a/b/c; xyzzy """key=$value"""

which a normal bash would interpret as the concatenation of an empty
string inside dq, /a/b/c/ (or key=$value) inside dq, and an empty
string inside dq, which is the same as /a/b/c (or key=$value) inside
dq, it would help the less common case.  Nobody would type a string
surrounded by two empty strings to be concatenated on purpose
(i.e. very unnatural) and typing the same dq four more times than
you would normally do is not too much of a hassle (not so hard to
type).  The problematic case can then be fixed to

	git -c core.commentchar="""/""" fmt-merge-msg ...

and it will work the same way on and off Windows.
