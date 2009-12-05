From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git reset --hard in .git causes a checkout in that directory
Date: Sat, 05 Dec 2009 11:06:02 -0800
Message-ID: <7vocmdutph.fsf@alter.siamese.dyndns.org>
References: <4B17A166.60306@gmail.com>
 <20091204111158.GE27495@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Maarten Lankhorst <m.b.lankhorst@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 05 20:06:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGzxX-0000L1-EB
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 20:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932890AbZLETGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 14:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932900AbZLETGJ
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 14:06:09 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45587 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932892AbZLETGI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 14:06:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B2585A4D03;
	Sat,  5 Dec 2009 14:06:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B/5DoaXbjF9BnAhKIydDT+aDmFA=; b=FbSw5L
	cG5C/oFHSZHQn9+HNkTKrb4A/q9CiD11VRBhADzHS8o+e/XrkTghVpbLb+Uec2hy
	kwBMs8xCjL5nMiCX887Sruua3+JkuRyUw3/LLNbFi+KHJ6OXp1yw7Iisv992Mmr4
	uJ1PxQMTjjuSJC8DmR0wosRjGZWvh6fGGolVI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ycCXGKhX0/XRpmu9KXC1Avd4j6WzIi4s
	UEi/s0G4s3ED8JfClwtrF9MBv/fHaOzHsB4pYiDBAyZ0qdGudpXmUW6sOR+C2xrx
	Bn0k/akxZc6M5qAlZoQNL4u+1xgmf4+pjrqiUGl1Br5ZiQxcb3moF7PPq1vhfoK6
	1cbK3IMMwT0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 803A4A4D02;
	Sat,  5 Dec 2009 14:06:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 04FF7A4D01; Sat,  5 Dec 2009
 14:06:03 -0500 (EST)
In-Reply-To: <20091204111158.GE27495@coredump.intra.peff.net> (Jeff King's
 message of "Fri\, 4 Dec 2009 06\:11\:58 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3F57B2E6-E1D1-11DE-8F42-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134614>

Jeff King <peff@peff.net> writes:

> On Thu, Dec 03, 2009 at 12:30:46PM +0100, Maarten Lankhorst wrote:
>
>> When I was working on my code and made a mess that I wanted to undo,
>> I accidentally did it in the .git directory, and had a whole clone of
>> my last committed tree there.
>> 
>> It can be triggered easily:
>> 
>> mkdir test; cd test; git init; touch foo; git add foo; git commit -m
>> 'add foo'; cd .git; git reset --hard; [ -f foo ] && echo hello beauty
>> 
>> Other parts of git could be affected, I haven't checked where exactly
>> the bug hides, so I was afraid to send in a patch
>
> Yuck. Thanks for the bug report. This is due to a too-loose check on my
> part in 49b9362 (git-reset: refuse to do hard reset in a bare
> repository, 2007-12-31).
>
> Junio, I think the following should go to maint (I didn't bother
> splitting the --merge and --hard code; --merge is in v1.6.2. I assumed
> we don't care about maint releases that far back).

Although I'll apply your patch to 'maint' and will merge it for 1.6.6, I
am not quite sure if this is the best fix in the longer run.  Shouldn't we
go back to the top of the work tree and running what was asked there?
