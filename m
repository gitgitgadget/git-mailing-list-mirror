From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git attributes ignored for root directory
Date: Wed, 12 Oct 2011 16:12:13 -0700
Message-ID: <7vfwix7qk2.fsf@alter.siamese.dyndns.org>
References: <4E8B55FB.1050203@svario.it> <4E8C481A.1070808@alum.mit.edu>
 <7vd3eb8hkb.fsf@alter.siamese.dyndns.org> <4E961626.4030201@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gioele Barabucci <gioele@svario.it>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Oct 13 01:12:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE7yK-0004iG-Io
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 01:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391Ab1JLXMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 19:12:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50269 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751899Ab1JLXMS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 19:12:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ACB686FB2;
	Wed, 12 Oct 2011 19:12:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0kyoAqr8pa51yBTBzYKCC30BKjc=; b=YacSDm
	P41GVa+EJq+bqVkpD6WhEqUzqAerDX+f5OfQ+2Ce8GFHGHEJ8Lboc5NY6B+u2O5P
	s7jqN4hQhzWt8ABrP7i9ZTVayZeKt+n6d42AEneVYHqWOaru9vVFTxny43q5GooQ
	C9g230KtRToSv1acugQ7uHawTAJKWPjQTi50U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dbeeQ/tstkU5vz1L5Lj7KQQYZQzsfwkR
	HeGl0sykODf4EQYf9x/UuiAX6LqudGIsXwWNTLcnx8aI5c7BYvx9pHmE0khh3DCB
	JR+zioY4n6hiU3l/RQtEg/CvKnu1Urn/Lg4ipu96+lA6kEZDYjHYy8Aky74+zAbm
	5mVLqF12aVQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1EC46FB1;
	Wed, 12 Oct 2011 19:12:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0FFB46FB0; Wed, 12 Oct 2011
 19:12:14 -0400 (EDT)
In-Reply-To: <4E961626.4030201@alum.mit.edu> (Michael Haggerty's message of
 "Thu, 13 Oct 2011 00:35:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9F91B6DC-F527-11E0-BF1E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183429>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 10/05/2011 07:38 PM, Junio C Hamano wrote:
>>  - If the pattern is a single dot and nothing else, it matches everything
>>    in the current directory.
>
> This disagrees with shell usage, where "." represents a directory
> itself, not the files within a directory.

Either you misread me, or what I wrote was fuzzy, or perhaps both.

The suggested update to the list of rules very much wants a '.' to mean
the directory itself.  The problem I was solving, which turned out to be
something different from the original issue in the thread was this.

Suppose you have a directory "foo" and want to say "I want to ignore
everything in that directory". You would say "foo/" in .gitignore in the
higher level and you are happy.

How would you say the same thing if the directory to be ignored weren't
"foo" but at the top-level of the working tree? There is no such level
higher than the top-level where you can say "<the name of your project>/"
in its .gitignore file.

The best you could do is to say "./" in the .gitignore file at the
top-level directory, and the update rule you quoted is specifically
designed to address it.

Of course, you could list both ".*" and "*" in the .gitignore file at the
top-level directory for the same effect, but that works only because you
do not have to give values to the entry in .gitignore mechanism. It would
be cumbersome to duplicate two entries in .gitattributes file like that as
a workaround.
