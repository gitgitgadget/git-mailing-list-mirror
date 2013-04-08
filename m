From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] transport-helper: check if remote helper is alive
Date: Mon, 08 Apr 2013 14:08:03 -0700
Message-ID: <7vy5csvih8.fsf@alter.siamese.dyndns.org>
References: <1365320706-13539-1-git-send-email-felipe.contreras@gmail.com>
 <1365320706-13539-3-git-send-email-felipe.contreras@gmail.com>
 <20130408005155.GA24030@sigill.intra.peff.net>
 <CAMP44s0PYARrCQxyBOiGzCAKTXqGp5yrKyfVwLjE1CyuxVSU2A@mail.gmail.com>
 <20130408023351.GA32558@sigill.intra.peff.net>
 <CAMP44s1cphJ5wojt2OeZjWJVOi5AMQJR2jN_BCkQw0B0BxpUfA@mail.gmail.com>
 <7vtxngyl30.fsf@alter.siamese.dyndns.org>
 <CAMP44s2PJGJQBM86CGsA5BOn1RLi4mqNsq+d0oyY0jA=XHQGDA@mail.gmail.com>
 <7vwqscx3l5.fsf@alter.siamese.dyndns.org>
 <CAMP44s0DjJL44uavM44sxgSyrgbTLpUarEPB6=-imvw1rewOOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 23:08:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPJIT-00044L-42
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 23:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944Ab3DHVII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 17:08:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39402 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964875Ab3DHVIH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 17:08:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7C86154A6;
	Mon,  8 Apr 2013 21:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VeoUVsQe1Av+45C8f6Gt+vNGbBI=; b=HN4fqn
	cDIpNG2y/E4i0/GBBkCeuYZ6x3uGiRRWWtxqxIDoiRPFvnYDPtRE3mrRoUs16zyT
	Hnr9oBidEkYYITgyST0sws/+ADQawYnvuDUB14vWBqtwp1V7cTq9vlUdDO6JDcLM
	S6FotLeqR/5cgi0GFly5RxcSlmg4/P5K1pmx0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=drCrkpLJbglsO47vtnrdlsmL2a0QlCcf
	ogDDCG+vpPGw9WKcJiSCSq3QIoZswG4H3fQRr+r1DnIre+eYZnzhfhBRK6hDCVzV
	tGkyXdUTvJSw7jyGC+tV3bcI7ObVyygMzcwBBGXSBlWZI35lPX1NhrJ2wo9ek+U4
	7av9mjxprA4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE554154A5;
	Mon,  8 Apr 2013 21:08:05 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14973154A1; Mon,  8 Apr
 2013 21:08:05 +0000 (UTC)
In-Reply-To: <CAMP44s0DjJL44uavM44sxgSyrgbTLpUarEPB6=-imvw1rewOOA@mail.gmail.com> (Felipe
 Contreras's message of "Mon, 8 Apr 2013 14:08:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 67CDCB26-A090-11E2-AC19-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220516>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Mon, Apr 8, 2013 at 1:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>>>> ...  But if we keep
>>>> helper running, who will be communicating with it via these open
>>>> pipes?  The process that is calling finish_command() on fast-import
>>>> and disconnecting from the helper won't be, as read/write to the
>>>> pipe, even if we do not disconnect from here, will result in errors
>>>> if the helper has already exited at this point.
>>>
>>> Nobody will send any further input, but in theory we could redirect
>>> the pipe and send more commands. That's how it was designed.
>>
>> Who does the redirection to whom?
>
> The one that is doing all the redirections, transport-helper.
>
>> How would the process tree and
>> piping constructed around the current system?
>
> I cannot parse that correctly,

Sorry, s/the current system/& look like/;

> but transport-helper is already
> receiving the output from the remote-helper.

OK, so you are envisioning that transport-helper would read from the
helper after importer is done?  If so, perhaps it is a prudent
solution to disconnect in this version (to fix), and then in a
separate patch that adds such an extension (I imagine it would
involve that the helper advertising a capability or being invoked
with an option to let transport-helper somehow know that it should
continue the conversation once fast-import is done) to disable the
disconnect here when that extension is in use?
