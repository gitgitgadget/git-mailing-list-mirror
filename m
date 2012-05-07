From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v4 5/6] completion: calculate argument position
 properly
Date: Mon, 07 May 2012 14:52:27 -0700
Message-ID: <7v8vh34q1w.fsf@alter.siamese.dyndns.org>
References: <1336353800-17323-1-git-send-email-felipe.contreras@gmail.com>
 <1336353800-17323-6-git-send-email-felipe.contreras@gmail.com>
 <CAMP44s3Bscm0T_=-g-wRc9kkZYZjGHGaP6hPi8598=Oh=skjxw@mail.gmail.com>
 <7v7gwn6cmv.fsf@alter.siamese.dyndns.org>
 <CAMP44s3rC6bT3rjrBFdnywwsp5NrXt54L5L-7oKZ=bNFKccq+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Scott Bronson <bronson@rinspin.com>,
	Nathan Broadbent <nathan.f77@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 23:52:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRVr8-0006Ah-T6
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 23:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756868Ab2EGVwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 17:52:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43813 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755548Ab2EGVw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 17:52:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03E046811;
	Mon,  7 May 2012 17:52:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TcdTYRHCYFGWZ07D3lkpZA4Yj4A=; b=KQ7eM1
	f22pa63VuYiezBRIP8i6PXo6YdER7C+wz//35PqlIiw1qKRIkV8CIHWZQJ6Up7D0
	l9LxwIGAwb9lGvKtawLVDmyNECTyPt6C1uy8pQl3TosF+aa2Vr4creSevJWtcxLj
	VYYfP+FwTIdJlB2cehTTy/4jizSTN/OUYUT4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fKnfQDs847CkUyILXSO8dUyICvPtrjXe
	XZ3w7T3UYdWHvEDEI5jgSZIUBHX5ujRGdO0XqUbz1EO7sVgfYDHmQwrUVm4jjsLX
	c9PFEe+lm52AoMn/QIhZ71bsy/jSNoo7ugzjXHBdRjjeYmAIchKBhEXlZzCNcqM+
	r6LgP9RSdIU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EEA7C6810;
	Mon,  7 May 2012 17:52:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 841DB680F; Mon,  7 May 2012
 17:52:28 -0400 (EDT)
In-Reply-To: <CAMP44s3rC6bT3rjrBFdnywwsp5NrXt54L5L-7oKZ=bNFKccq+w@mail.gmail.com> (Felipe
 Contreras's message of "Mon, 7 May 2012 23:01:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0802CDA-988E-11E1-AB71-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197318>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> Together with 4/6, I am guessing that you are using $cmd and $cmd_pos
>> as a global variable to pass state to/from helper functions. Are they
>> properly documented in code (if not, please do so)?
>
> Like cur, prev, words, and cwords? Wait a second... they are not
> documented anywhere. I'm also not going to work on this... not my
> itch.

The usual thing to do is to clean up after other people's mess while you
are mucking with the vicinity of them anyway, especially if you are making
things worse by adding another.

And I am fully aware that it may not be your itch---otherwise I wouldn't
have asked.  I would have said "This needs to be fixed (or else)".

Why is it that everybody on the list, who is working together well in the
community, seems to have trouble only when interacting with you?  Please
remember that it is not my itch to live with an unnecessarily abrasive
behaviour from you, either.
