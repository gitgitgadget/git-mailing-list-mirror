From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] argv-array: Add argv_array_pop function [v2]
Date: Thu, 05 Apr 2012 18:20:53 -0700
Message-ID: <7vobr53bbe.fsf@alter.siamese.dyndns.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-2-git-send-email-nhorman@tuxdriver.com>
 <7vd37m5458.fsf@alter.siamese.dyndns.org>
 <20120405232429.GA8654@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 03:21:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFxrL-0008Rm-CM
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 03:21:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757037Ab2DFBU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 21:20:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64437 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757011Ab2DFBU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 21:20:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EE37688D;
	Thu,  5 Apr 2012 21:20:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=bZ9QPi3d7jQH4lZVI8UCgjfho1k=; b=ElRnZmPfrGFDvQupXPtO
	UmCKj/mndQZBA6LqYjyjr29bnVqI44r9I0RweWfBuM7VIInE1WAujEhnFmZo61Go
	KqbyuqYYC1sl4C35ECZ6NguNkjoFTJUbXq1Zgj+YtZnehkcN/KaN5kl5dAhlERLb
	+tXfrmFal0XOe4rUplhiLwM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=exM87wbIu3IKTAkVl+9hcp1rG7ecNcVgfpDwN8NGvNvHEe
	MSdwbSQ7PdhhcLpNiKsw2eTelq26hZ2xdYJi48XiK+K42PGTYOUczVlS9Tse+nNE
	cyq1oNlJ7IhQmY1fYRT/fABbpQtGxL18w1Jep7N4t7ahyZGGFZcoBTcBK389c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86BAD688C;
	Thu,  5 Apr 2012 21:20:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DD5C6889; Thu,  5 Apr 2012
 21:20:54 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C1BECA26-7F86-11E1-AD92-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194833>

Neil Horman <nhorman@tuxdriver.com> writes:

> On Thu, Apr 05, 2012 at 01:12:51PM -0700, Junio C Hamano wrote:
>> Neil Horman <nhorman@tuxdriver.com> writes:
>> 
>> > As a convienience, it would be nice if we could pop entries off the argv_array
>> > structs so that if they had multiple uses in a function, we wouldn't have to
>> > clear them and repopulate common entries.  This patch adds the argv_array_pop
>> > function to do just that.  Common entries can be added to an argv_array first,
>> > then useage specific ones can be added on the end and removed later on.
>> >
>> > Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
>> 
>> 
>> > CC: Jeff King <peff@peff.net>
>> > CC: Phil Hord <phil.hord@gmail.com>
>> > CC: Junio C Hamano <gitster@pobox.com>
>> > ---
>> 
>> Please don't do "Cc:" here; they belong to your e-mail header.
>> 
> You mean place them below the snip line?  I can do that.

No.  When you review and fix typo in format-patch output, you can add
these to the e-mail header part and git-send-email will pick them up just
fine.

>> If your use case is "After using an argv_array for the first invocation,
>> truncate it while keeping the common ones that appear early, so that ones
>> that are specific to the second invocation can be pushed", it strikes me
>> somewhat odd why you would want to specify "how many to pop".
>> 
> Why?

You know you have N common ones.  You push some more, perhaps with a
sequence of "if (condition) argv_push();" and use it.  Now it is time to
reprepare it for the second usage.  Wouldn't it be more natural to say

	argv_array_setlen(N);
        /* start pushing the specific ones for next invocation */
        argv_array_push();
        if (condition)
        	argv_array_push();

>> > +	for(num--; num>0; num--) {
>> 
>> Gaah.
>> 
> Eeek :).  If you want something else equally....equal here, please ask for it.
> I prefer for loops, but if you would rather have a while loop here, I'm fine
> with that.

Please look at the existing "for ()" loop in the same file, and then go
read the CodingGuidelines.
