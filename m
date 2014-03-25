From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/19] tree-diff: remove special-case diff-emitting code for empty-tree cases
Date: Tue, 25 Mar 2014 15:07:33 -0700
Message-ID: <xmqqzjkej5ju.fsf@gitster.dls.corp.google.com>
References: <cover.1393257006.git.kirr@mns.spb.ru>
	<dad40b2cf785e5951c105cac936d86a7bc6db8a3.1393257006.git.kirr@mns.spb.ru>
	<xmqqior3pa7h.fsf@gitster.dls.corp.google.com>
	<20140325092040.GA3777@mini.zxlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kirr@mns.spb.ru, git@vger.kernel.org
To: Kirill Smelkov <kirr@navytux.spb.ru>
X-From: git-owner@vger.kernel.org Tue Mar 25 23:07:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSZVZ-0006ia-8k
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 23:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbaCYWHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 18:07:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55103 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751380AbaCYWHj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 18:07:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C294377F3A;
	Tue, 25 Mar 2014 18:07:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CvU9pMMWohboMjx0JGSEUWa9iyg=; b=FjL1Ul
	RsXmqwYSezKamJyhR4Clx6/OTLb+/HwXDt82h3EaKaIHQq+bY0PsuM7SQxfE0aCy
	tjNbajWJ5N1oFVOWncvHpBaUOr3Z6TMD/8tsV/Zmt6KOuAh+3yk9Dg0O794JWUKO
	rylAOH84xlm02Rl5wf35ldkUzGDi6c4y1Caag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O2rfJOQXu14CWalhX5+egpLGOtjz4zA6
	e+M8IKP0EGBh7YV4IuMr/L/ikn6/dUBRZ2168Z6LD9f0wCja1B9DxRD6tMoEH9/U
	xKeAaJMjcNoTDRV7gvF54jKtrXVMtuxo8e0NKG6zohrjRJJQ0SUF0WJKAuKkfMCb
	zo13RIdQq9Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABFE877F38;
	Tue, 25 Mar 2014 18:07:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ED60B77F35;
	Tue, 25 Mar 2014 18:07:37 -0400 (EDT)
In-Reply-To: <20140325092040.GA3777@mini.zxlink> (Kirill Smelkov's message of
	"Tue, 25 Mar 2014 13:20:40 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E05A5C10-B469-11E3-A34C-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245155>

Kirill Smelkov <kirr@navytux.spb.ru> writes:

> On Mon, Mar 24, 2014 at 02:18:10PM -0700, Junio C Hamano wrote:
>> Kirill Smelkov <kirr@mns.spb.ru> writes:
>> 
>> > via teaching tree_entry_pathcmp() how to compare empty tree descriptors:
>> 
>> Drop this line, as you explain the "pretend empty compares bigger
>> than anything else" idea later anyway?  This early part of the
>> proposed log message made me hiccup while reading it.
>
> Hmm, I was trying to show the big picture first and only then details...

The subject should be sufficient for the big picture.  "OK, we are
removing the special casing" is what we expect the reader to get.
Then, this

>> > While walking trees, we iterate their entries from lowest to highest in
>> > sort order, so empty tree means all entries were already went over.

sets the background.  "OK, the code walks two trees, both have
sorted elements, in parallel." is what we want the reader to
understand.  Then the next part gives the idea of pretending that
the empty-side always compare later than the non-empty side while
doing that parallel walking (similar to "merge").

So, yes, I think it is a good presentation order to give big picture
punch-line first on the subject, some background and then the
solution.
