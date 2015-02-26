From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: feature request: excluding files/paths from "git grep"
Date: Thu, 26 Feb 2015 12:16:25 +0100
Message-ID: <54EF0089.6070605@drmicha.warpmail.net>
References: <54EDBEC2.8090107@peralex.com> <CACsJy8AM=W4f6u_7YpvmfiBwrJjqfJMJoq6CQYfKOh+qD6rF3Q@mail.gmail.com> <20150225143116.GA13567@peff.net> <xmqqk2z5on72.fsf@gitster.dls.corp.google.com> <20150225185128.GA16569@peff.net> <xmqqbnkholx9.fsf@gitster.dls.corp.google.com> <20150225191108.GA17467@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>, Noel Grandin <noel@peralex.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 12:16:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQwQp-00078n-5G
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 12:16:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500AbbBZLQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 06:16:29 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39207 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752792AbbBZLQ2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Feb 2015 06:16:28 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 5642D20A6B
	for <git@vger.kernel.org>; Thu, 26 Feb 2015 06:16:27 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Thu, 26 Feb 2015 06:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=A3JPy3sbskGAyNFaqfA+sh
	1i8zo=; b=QbTM2ZeWGkaKDatIIBUMsF9FZTE0KiCUxOFmNS16QJjycd+0PWdREv
	kUXLyijcbZsN+4/g3Tjaw4xHCgf3X9wmX5+mnhvyCGVZex4y2Pi+geqGz4R/fO8/
	aXV4fIWm25a9N9gdtJo7ECKm6vPWa5TPZ4rlnrboZ1/iA6SlEaDFc=
X-Sasl-enc: cH8F4biAEsuPRoUNmuTC705L9XH/N2lqxjBN5s88rioq 1424949387
Received: from localhost.localdomain (unknown [188.96.114.76])
	by mail.messagingengine.com (Postfix) with ESMTPA id B67A3680122;
	Thu, 26 Feb 2015 06:16:26 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <20150225191108.GA17467@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264433>

Jeff King venit, vidit, dixit 25.02.2015 20:11:
> On Wed, Feb 25, 2015 at 11:01:22AM -0800, Junio C Hamano wrote:
> 
>> Jeff King <peff@peff.net> writes:
>>
>>> So I think _if_ using "diff" attributes is enough for this purpose, then
>>> there is no code to be written.  But if somebody wants to draw a
>>> distinction between the uses (I want to diff "foo" files, but never see
>>> them in grep) then we could introduce a "grep" attribute (with the
>>> fallback being the value of the "diff" attribute for that path).
>>
>> That is all true.
>>
>> If we were to have a new 'grep' attribute that can be used to
>> express 'It is OK to diff two versions of this path, but hits by
>> grep in this path is useless' (and verse versa), the built-in macro
>> attribute 'binary' should also be updated with it.  A path being
>> 'binary' currently means '-diff -merge -text' but it should also
>> mean '-grep' in the new world, if we were to go in that direction.
> 
> I think it would do so automatically. There is no "grep" attribute
> given, so we fall back to the "-diff" attribute. But I do not mind
> modifying the macro to be more explicit.
> 
> Note also that I am not volunteering to work on this, nor am I convinced
> it's actually worth pursuing. I've yet to see a useful case where you
> would want text diffs but not greps (or vice versa), and if we can avoid
> cluttering the attribute space, we should. I was mostly pointing it out
> that it is not logically inconsistent to want such a thing. :)
> 
> If somebody does look into it, I suspect the place to start is modifying
> userdiff_find_by_path to optionally prefer "grep" to "diff".
> 
> -Peff
> 

So, as a summary of the discussion, it seems it's time to switch the
default to --textconv for git grep?

Michael
