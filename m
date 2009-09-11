From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] reset: use "unpack_trees()" directly instead of "git
 read-tree"
Date: Thu, 10 Sep 2009 22:55:52 -0700
Message-ID: <7vskeu10uv.fsf@alter.siamese.dyndns.org>
References: <20090910200334.3722.20140.chriscool@tuxfamily.org>
 <20090910202333.3722.58409.chriscool@tuxfamily.org>
 <7v1vme2h2f.fsf@alter.siamese.dyndns.org>
 <200909110734.13903.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Sep 11 07:56:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mlz7M-0005J8-0r
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 07:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbZIKF4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 01:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752160AbZIKF4L
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 01:56:11 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56630 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbZIKF4K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 01:56:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DE8D14C9C5;
	Fri, 11 Sep 2009 01:56:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gZ/C07h3vP/L6jYHC7z5VUQSZXk=; b=jOHkvC
	LPr2diqOcAQUblZSwExcs711SgP4YhgPBhs7kuDfn807EFrfKfHicUJWUlKJ/HSy
	hmgn7Jm9uCjLUlHeQb22tUUGrxDfLONa6uyc8TMnwoyKrXLF3rtviUO6fTOj/EvE
	RR4JVF85I+/NR2S7lcBZQJkCYqQPugamWtm00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BhXzkNLWWmi/52VkZWp6TU1aYkkVkYU5
	n95grfGZgTHLiyy8nxaUBcj693uFiBBZFES899/wftiQg2qj34ZxeeI4LU4AMFEe
	t9G813w+t03Gq1N/DtHBG+8Xk4tyMhSBjcibT/bhagn5rpWxtJ6/D6noDW6iLif7
	pDFLBXOMTzI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7D4964C9C4;
	Fri, 11 Sep 2009 01:56:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8D9F64C9C2; Fri, 11 Sep 2009
 01:55:54 -0400 (EDT)
In-Reply-To: <200909110734.13903.chriscool@tuxfamily.org> (Christian Couder's
 message of "Fri\, 11 Sep 2009 07\:34\:13 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CB38C91C-9E97-11DE-8138-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128177>

Christian Couder <chriscool@tuxfamily.org> writes:

> On Friday 11 September 2009, Junio C Hamano wrote:
>> Christian Couder <chriscool@tuxfamily.org> writes:
>> > From: Stephan Beyer <s-beyer@gmx.net>
>> >
>> > This patch makes "reset_index_file()" call "unpack_trees()" directly
>> > instead of forking and execing "git read-tree".
>>
>> And the reason why it is a good idea is...?
>
> ...that it should be faster.
>
> Ok, I will add that to the commit message in the next version.

Please don't add "should be".  That is not a justification.
