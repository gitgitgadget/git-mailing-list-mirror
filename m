From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] combine-diff: Fast changed-to-all-parents paths scanning
Date: Wed, 05 Feb 2014 14:58:36 -0800
Message-ID: <xmqqfvnx180z.fsf@gitster.dls.corp.google.com>
References: <cover.1391430523.git.kirr@mns.spb.ru>
	<c0ad49d850377aedffa0a593fef8738112019b01.1391430523.git.kirr@mns.spb.ru>
	<xmqqk3dbbwwf.fsf@gitster.dls.corp.google.com>
	<xmqqeh3jbwbt.fsf@gitster.dls.corp.google.com>
	<20140204163400.GA20436@tugrik.mns.mnsspb.ru>
	<xmqq4n4eafmj.fsf@gitster.dls.corp.google.com>
	<20140205165119.GA18558@tugrik.mns.mnsspb.ru>
	<xmqqfvnx5umg.fsf@gitster.dls.corp.google.com>
	<20140205191427.GA3923@mini.zxlink>
	<xmqq61ot4a8e.fsf@gitster.dls.corp.google.com>
	<20140205202248.GB4695@mini.zxlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, kirr@mns.spb.ru
To: Kirill Smelkov <kirr@navytux.spb.ru>
X-From: git-owner@vger.kernel.org Wed Feb 05 23:58:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBBQd-0006R6-HJ
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 23:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261AbaBEW6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 17:58:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45818 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753124AbaBEW6m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 17:58:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ACB0F67E52;
	Wed,  5 Feb 2014 17:58:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DSRdWqZYCh07ywElSW1Q8tz+DC8=; b=ByeWaX
	22f9SSmpWHtco+E1GPo+4l1vkD2i9wGH88SSGs49zFG+Za65LEQyS/zRRchvGKDb
	z+Q044aLENfAWfxw5KpOG7Q+Lm71v4IiUlZtiYBsjghnEGOOU1W6uetriGrxu73u
	p4WNSX/siazZdEg3yc9LeIqbyG9oDLpmUBZDM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mYCxJRc08w257rCLav6ScFkqClYX5mVw
	S8iShU2mn1nOj8r4WxC2bsD9e9eByWlKRbIxe3tSdQRlkqMI6nHkX5LdUYVxb0gA
	jHfKRIWMcyLsPquOLhDWE4Qh0Aeq+upvuUBVUyvPWmwBmoIcXZyJo+6Bsqy6Xg8n
	c+SkFkpxO4U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98A4967E50;
	Wed,  5 Feb 2014 17:58:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA12A67E4D;
	Wed,  5 Feb 2014 17:58:39 -0500 (EST)
In-Reply-To: <20140205202248.GB4695@mini.zxlink> (Kirill Smelkov's message of
	"Thu, 6 Feb 2014 00:22:48 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0D9C0006-8EB9-11E3-B2DD-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241672>

Kirill Smelkov <kirr@navytux.spb.ru> writes:

> On Wed, Feb 05, 2014 at 11:42:41AM -0800, Junio C Hamano wrote:
>> Kirill Smelkov <kirr@navytux.spb.ru> writes:
>> 
>> > I agree object data should be immutable for good. The only thing I'm talking
>> > about here is mode, which is parsed from a tree buffer and is stored in
>> > separate field:
>> 
>> Ah, I do not see any problem in that case, then.
>> 
>> Thanks.
>
> Thanks, that simplifies things for me.

Surely.

Be careful when traversing N-trees in parallel---you may have to
watch out for the entry ordering rules that sorts the following
paths in the order shown:

	a
	a-b
        a/b
        a_b

Inside a single tree, you cannot have 'a' and 'a/b' at the same
time, but one tree may have 'a' (without 'a/b') while another one
may have 'a/b' (without 'a'), and walking them in parallel has
historically been one source of funny bugs.
