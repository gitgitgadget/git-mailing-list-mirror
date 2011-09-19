From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-web--browse: invoke kfmclient directly
Date: Mon, 19 Sep 2011 14:22:32 -0700
Message-ID: <7v1uvc9qhz.fsf@alter.siamese.dyndns.org>
References: <20110918032933.GA17977@sigill.intra.peff.net>
 <1316341224-4359-1-git-send-email-judge.packham@gmail.com>
 <20110918183846.GA31176@sigill.intra.peff.net>
 <7vvcso9zzi.fsf@alter.siamese.dyndns.org>
 <20110919182049.GA26115@sigill.intra.peff.net>
 <7v62ko9scw.fsf@alter.siamese.dyndns.org>
 <20110919204448.GA3562@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org,
	chriscool@tuxfamily.org, jepler@unpythonic.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 19 23:22:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5lIW-0004EO-L0
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 23:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213Ab1ISVWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 17:22:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64326 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932103Ab1ISVWf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 17:22:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C6E55227;
	Mon, 19 Sep 2011 17:22:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XyRxJd0lcUMbcnaKJIwLbNjcEog=; b=VIZK4l
	kDBqYt1MyXwSgynYmyYA8KdjCAYPtGpONceX8cJS6M5gsbIHJXI1tTsEgmLB/xv8
	R3v036LKk1+kuyKo84o6tFH+MgR4jbM/kYmyUbMqfQ9gIT6nBBOykhBXwakyNu7x
	CEM320mBvOoWc/Xy4mhZYT6Vboozj6+Brr7b0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k2xQ4QYjWyGt6RXXJXBC16E80DtWGcKP
	TctOZomiHIOQMFRZxiXE1zogXvg+Cwx/KU0ChMMZTMjtiWiakwpXashZk5GUMrhK
	JNEoi5VmrrEJKV0s8ACKQnXvcC8jlJfqFZLw484wOx3XeakVsDvxa8xzL7m3krfY
	S11FHJSiIto=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12AA05226;
	Mon, 19 Sep 2011 17:22:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B0F15221; Mon, 19 Sep 2011
 17:22:33 -0400 (EDT)
In-Reply-To: <20110919204448.GA3562@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 19 Sep 2011 16:44:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7D3ADFF2-E305-11E0-BF25-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181707>

Jeff King <peff@peff.net> writes:

> On Mon, Sep 19, 2011 at 01:42:23PM -0700, Junio C Hamano wrote:
>
>> >> Yeah, I agree, and the dq around $browser_cmd is kind of important, too,
>> >> for that to work and be readable.
>> >
>> > Oops, good catch. Probably the most readable version would be:
>> >
>> >   eval "\"$browser_cmd\"" '"$@"'
>> 
>> Actually I didn't mean that double dq.
>> 
>> In fact, if browser_cmd is meant to be split as a shell snippet, I do not
>> think you want the string seen by eval to have dq around the expanded
>> version of $browser_cmd.  And I tend to prefer feeding a single string to
>> eval, so the version in your message I quoted originally looks good to me.
>> 
>> Unless I am missing something here...?
>
> Oh right. Sorry, I read your comment, thought that's what you meant, and
> that I had overlooked something. Forgetting that it was intentional to
> leave off the quotes inside.
>
> So yeah, my original is right. I just got turned around in all of the
> discussion.

Thinking about it a bit more, I suspect that we should just let the 'eval'
grab value out of the $browser_cmd variable, i.e.

	eval '$browser_cmd "$@"'

no?
