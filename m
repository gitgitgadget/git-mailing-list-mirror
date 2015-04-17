From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] reachable: only mark local objects as recent
Date: Fri, 17 Apr 2015 10:18:56 -0700
Message-ID: <xmqq618ur7un.fsf@gitster.dls.corp.google.com>
References: <20150327113240.GA7781@peff.net>
	<xmqqa8yyw9je.fsf@gitster.dls.corp.google.com>
	<20150417132824.GA13192@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 17 20:09:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjAhU-0004J9-FC
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 20:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932735AbbDQSJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 14:09:08 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53960 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932247AbbDQSJH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 14:09:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 59F2144B2F;
	Fri, 17 Apr 2015 14:09:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Cj7+OujXBY3/aN6m/bH38nwVs4k=; b=oG72px
	RKtkbFyD15HpniMNmj9K+7FUFaCZ+FmPiTJ+6qZIQcv+e6dx44T0zf6nMQHRJcGY
	gMr76ylN0EvDfCUEtSOgGc/yWdMduukX5ZGkl3nli+ovb5eL5EDPqWTo4m4aOgjI
	hPNSuTWnLspgoAOrHODOQNrbTRx1q4dcsM5S8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q2mcUBxJS7kM64rLKv4bm644B6wUG0Zi
	wecCqXuOJ5aMww5ZNEnec4eM1/ddwIaw6ekDaNhq/Qqn6TCL16+0qhQddr6P9BG1
	zKlWGyCWfephv1udeaJ4SY5WoJhCgOCdDz3zK+JMUbc8//Ipej2WCHz2Ux1Q1tuc
	LQd771vpLlI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 526BE44B2E;
	Fri, 17 Apr 2015 14:09:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B228448751;
	Fri, 17 Apr 2015 13:18:57 -0400 (EDT)
In-Reply-To: <20150417132824.GA13192@peff.net> (Jeff King's message of "Fri,
	17 Apr 2015 09:28:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D4F65B1A-E525-11E4-9035-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267372>

Jeff King <peff@peff.net> writes:

> On Fri, Mar 27, 2015 at 12:00:05PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > It is possible that we may drop an object that is depended
>> > upon by another object in the alternate. For example,
>> > imagine two repositories, A and B, with A pointing to B as
>> > an alternate. Now imagine a commit that is in B which
>> > references a tree that is only in A. Traversing from recent
>> > objects in B might prevent A from dropping that tree. But
>> > this case isn't worth covering. Repo B should take
>> > responsibility for its own objects. It would never have had
>> > the commit in the first place if it did not also have the
>> > tree, and assuming it is using the same "keep recent chunks
>> > of history" scheme, then it would itself keep the tree, as
>> > well.
>> 
>> In other words, if you have a loop in dependency chain among
>> alternate repositories, your set-up is broken by definition.
>> 
>> Which makes sense to me.
>> 
>> Thanks.
>
> I don't see this patch in "pu" or "What's Cooking" at all. Did it get
> dropped?

It appears that way (rather, "never picked up").  Thanks for
reminding.




>
> It does fix a performance regression, but the problem is in v2.2, so I
> don't think it's urgent for v2.4-rc.
