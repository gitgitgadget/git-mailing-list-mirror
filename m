From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git pull" doesn't know "--edit"
Date: Sun, 12 Feb 2012 01:59:00 -0800
Message-ID: <7vlio8l6e3.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.02.1202111016340.28503@i5.linux-foundation.org>
 <CA+55aFwLqvVyMipun4DM4CnbO97Dota3LCM2VPFfLq1LS5a4aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 12 10:59:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwWDZ-0005Vj-JH
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 10:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244Ab2BLJ7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Feb 2012 04:59:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52035 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168Ab2BLJ7D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2012 04:59:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A89F22351;
	Sun, 12 Feb 2012 04:59:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bZ9SVC9mesJxWJRCyPmRJzvVDog=; b=MxdUL7
	5fqfU9RwmGcYSI5tX1UGXZZpl3HptYeJiNR1GK/vAhWBKYiUnDm+FBjDcVXpT+8w
	tixp/1RETOWsrJxvYWGAqOANGfRnz4jOIkmDdYnHMBOMgd1j/E62JSKClkvTN8eH
	+XiOiB97tkOEO2vDeJ5QRvF0XgWmHldlu++lE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nTsk9qtbf7lpa0eN0JDKWYZZ4uud/glK
	1xwieJru0O8vqEFErcwO30cfJOH96az8sfKsXlDrJTFCXDMlNA2R9kkFckPO1lju
	KVu1RdMyX3/URQ2WuUKIhndzATVV84SMrlWNcqmTe4IJ3iWKF1T5oEzydyY0oJYg
	VOyK27hFe00=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A02972350;
	Sun, 12 Feb 2012 04:59:02 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3628D234D; Sun, 12 Feb 2012
 04:59:02 -0500 (EST)
In-Reply-To: <CA+55aFwLqvVyMipun4DM4CnbO97Dota3LCM2VPFfLq1LS5a4aQ@mail.gmail.com> (Linus
 Torvalds's message of "Sat, 11 Feb 2012 12:07:40 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 30D52C62-5560-11E1-BFF0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190564>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> In the docs, the "GIT_MERGE_AUTOEDIT=no" thing is mentioned as the way
> to get the legacy behavior, which (at least to me) implies that
> setting it to "yes" gets the modern behavior.

Honestly, I didn't actually intend to accept any value other than "no" to
be set in that variable.

Also the variable's name was way suboptimal.

I didn't intend "Auto" to describe "Edit" (as in "is the editor spawned
AUTO-matically? yes/no"), but meant it to describe "Merge" (as in "When a
merge results in AUTO-committing, do we edit it? yes/no?").

> Maybe this is intentional, and not a bug? But it does seem a bit odd -
> the name is "AUTOEDIT", not "FORCEDEDIT".

A clean merge that tries to start an editor even when not interactive is
honoring the "yes" setting is understandable/explainable if you read the
misnamed variable as "When a merge results in AUTO-committing, do we edit
it? yes/no?"

But it of course does not mean that such a behaviour is useful.  It is not
just "a bit odd", it is outright useless in a text terminal, especially
when you are redirecting the input from /dev/null ;-).

> Or maybe the thing could extend the notion of the current boolean to
> be a tri-state instead: in addition to the traditional true/yes/on and
> false/no/off have a "force" mode that is that "always force it on
> regardless".

Yeah, if we support any value other than "no", I think the trivalue
always/auto/never (aka yes/auto/no) would make the most sense.

> And maybe this is just a "nobody cares" situation - "Don't do that then".

I would have agreed with you 3 years ago, but these days I find the end
users are being much pickier than they used to be ;-).
