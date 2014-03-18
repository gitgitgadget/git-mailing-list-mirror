From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Using "-" for "previous branch" failing with rebase
Date: Tue, 18 Mar 2014 11:59:42 -0700
Message-ID: <xmqqr45z8h9d.fsf@gitster.dls.corp.google.com>
References: <20140315152924.26c3294e@bigbox.christie.dr>
	<7vppll2uvp.fsf@alter.siamese.dyndns.org>
	<20140317204744.6ac795a0@bigbox.christie.dr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Tim Chase <git@tim.thechases.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 19:59:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPzF0-00082B-4j
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 19:59:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757610AbaCRS7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 14:59:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53470 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757410AbaCRS7w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 14:59:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC7A47323D;
	Tue, 18 Mar 2014 14:59:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iPfkFA1okpLbVJg+osun4X2xjXg=; b=ftz3wd
	TyNbqWZI9g/XmQzi/1PBT0DPBEbxA+qtyRmYW1L99AJlfmjh52ouzPbzrACJOXc/
	wF4FrT+J3gSCLz9XiRcJqbcGG4W1kKKngQ0vqSak2AsNZMzT62uPuZTEgnP/v1jT
	r9EAfVlvQjTUhSANqnCJZEHU9IL/JbNcruq5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H+DxLprsPoLiHFzfuAQTdKru4sK6xmrS
	Ir8zX07F6mxNF/D/19RAYCnGDeL4oHJcf7kReh4e2ZSGdxHIqMsDNz1FrJ6fJmIx
	JyYY1oUa1XJBXYyLAyNIRjkMEzODBC+jqvwgpI2QMkQHiYfvUYQ0aOvQ+HFtX+bK
	PZIKTB7TQF0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C87D47323C;
	Tue, 18 Mar 2014 14:59:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1EDF07323B;
	Tue, 18 Mar 2014 14:59:46 -0400 (EDT)
In-Reply-To: <20140317204744.6ac795a0@bigbox.christie.dr> (Tim Chase's message
	of "Mon, 17 Mar 2014 20:47:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 78EA868A-AECF-11E3-9D10-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244368>

Tim Chase <git@tim.thechases.com> writes:

> On 2014-03-16 23:37, Junio C Hamano wrote:
>> Tim Chase <git@tim.thechases.com> writes:
>> 
>> > Is this just an interface inconsistency or is there a some
>> > technical reason this doesn't work (or, has it been
>> > addressed/fixed, and just not pulled into Debian Stable's
>> > 1.7.10.4 version of git)?
>> 
>> It is merely that nobody thought "rebase" would benefit from such a
>> short-hand, I think.
>> 
>>     Teach more commands that operate on branch names about "-"
>>     shorthand for "the branch we were previously on", like we did
>>     for "git merge -" sometime after we introduced "git checkout -"
>> 
>> has been sitting in my "leftover bits" list at
>> 
>>     http://git-blame.blogspot.com/p/leftover-bits.html
>> 
>> for quite some time.  Hint, hint...
>
> Not sure if the "Hint, hint" was intended for me,...

No.  It is primarily a search-engine bait ;-) and is secondarily a
hint to any aspiring Git hackers on the list.

In general, I am not very enthused to see the single letter "-" used
where you name any commit object (like "diff").  It is a short-hand
for the @{-1} notation that names the branch name, and it is OK in
general to add support for it to the places where we expect a branch
name and not just any commit object name (e.g. "checkout -"), but
maybe it is just me who was heavily involved in the original design.
