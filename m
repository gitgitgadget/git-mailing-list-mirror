From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in "git rev-parse --verify"
Date: Thu, 28 Mar 2013 09:52:03 -0700
Message-ID: <7vli97v558.fsf@alter.siamese.dyndns.org>
References: <51543FDB.9010109@alum.mit.edu>
 <CAPc5daUqzz=9TBmj2Q0MHqEc6gMHxXoGr9+JV3hq76zDKJAyCw@mail.gmail.com>
 <515462FB.9040605@alum.mit.edu> <20130328153808.GB3337@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <junio@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 28 17:52:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULG44-0000sF-B5
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 17:52:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756932Ab3C1QwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 12:52:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59844 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756709Ab3C1QwG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 12:52:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7ADEAAE4B;
	Thu, 28 Mar 2013 12:52:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uWQ9x+cYb93p/JkzkpkyI9kxLa4=; b=BoXYqT
	nE5yv4B/dQ/MEoNyF1z25SI+uvEHhRF86yRvqm2aOhwAoEWkxUIBnFF586/9Ly77
	lv3ThdCIKM8J/WwmC3H5E+poPXunlsz6k/sLZ7L9/YwMOQ8PGELQWBnFoCe9kUTD
	XIiI+9iC23+U1twTNwLlRzhGm0byig9Zn6CiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sGPkQ3arYLLyYr8i0sxQK4umKZGAwngv
	aK6/6pkb2ArzkKyES7FtE86Cn3jmFe8I+xSvRROLvQGGjkJzck8tXo4p8z3spXfM
	oS0KYsKBFeGNRxAf/IzI+7iYgO8H4Krc9npjxgZ4h0qJ9JwtWA7k4rBX2yQTsNia
	fguQnXYS1+Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F925AE4A;
	Thu, 28 Mar 2013 12:52:05 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D8BFDAE48; Thu, 28 Mar 2013
 12:52:04 -0400 (EDT)
In-Reply-To: <20130328153808.GB3337@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 28 Mar 2013 11:38:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D1D0F4D4-97C7-11E2-B64F-CBA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219435>

Jeff King <peff@peff.net> writes:

> On Thu, Mar 28, 2013 at 04:34:19PM +0100, Michael Haggerty wrote:
>
>> Is there a simple way to verify an object name more strictly and convert
>> it to an SHA1?  I can only think of solutions that require two commands,
>> like
>> 
>>     git cat-file -e $ARG && git rev-parse --verify $ARG
>
> Is the rev-parse line doing anything there? If $ARG does not resolve to
> a sha1, then wouldn't cat-file have failed?
>
> -Peff

You could force rev-parse to resolve the input to an existing
object, with something like this:

	git rev-parse --verify "$ARG^{}"

It will unwrap a tag, so the output may end up pointing at a object
that is different from $ARG in such a case.

But what is the purpose of turning a random string to a random
40-hex in the first place?
