From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC] Designing a faster index format - Progress report
Date: Tue, 29 May 2012 11:33:59 -0700
Message-ID: <7vzk8q4z1k.fsf@alter.siamese.dyndns.org>
References: <20120523122135.GA58204@tgummerer.unibz.it>
 <CACsJy8As2SQwEi2vHAQA+OeH+TjoCzzcknFbQ2tGXaWX7zsHVA@mail.gmail.com>
 <20120525201547.GB86874@tgummerer>
 <CACsJy8BRWmqz+2_A5_=1S9_sxOQa9GXnPQ7J1Y6id0_vh2-=+Q@mail.gmail.com>
 <20120527090407.GD86874@tgummerer> <7vbolaotwj.fsf@alter.siamese.dyndns.org>
 <CACsJy8D+WgEr4i2H-1oiBLY5oLurM0aNxGovbVEZDvr7OGgknw@mail.gmail.com>
 <87vcjfi09m.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gummerer <t.gummerer@gmail.com>, <git@vger.kernel.org>,
	<mhagger@alum.mit.edu>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue May 29 20:34:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZRFM-0006nk-6D
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 20:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754986Ab2E2SeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 May 2012 14:34:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43202 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754681Ab2E2SeD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2012 14:34:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A3F68EA0;
	Tue, 29 May 2012 14:34:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8tJTkzUn2or3KzGRYLr1KfkU4Jo=; b=wkJ4XW
	vBMhoIbDJ0jSKAeEyCgEDbRxKTzsbSjnmNumCo1US4BtNkWNjsWC6yU4v75ypTzM
	cTBMpP4MTsMyATr9uWwZM+RCRfjYOw6ME6/hqKjlePItk01L4F3X8ugBVJmB6R+V
	ngdaf+FDUjOdMl+1y4Uu934zyrlwsMwyL/zTU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dSQSa5ymtizYc92oesR71468BiOKOC2z
	Ya0vGFjD8+LbtbvoI3phM35GtGdeDmFvR7Ij3/0SVS8bxcYHAfDDCImEtpft+EhL
	ONC+y76x4zUnp+o78gqPYqE+VFIIgeoSlXbUEdA1Tp6wsNUKTVg+iIPxdzcRo84y
	rM6yp5tz7V0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A25FA8E9E;
	Tue, 29 May 2012 14:34:01 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2FC0E8E9B; Tue, 29 May 2012
 14:34:01 -0400 (EDT)
In-Reply-To: <87vcjfi09m.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Tue, 29 May 2012 15:29:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DC41D842-A9BC-11E1-9DF8-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198747>

Thomas Rast <trast@student.ethz.ch> writes:

> Then I will twist Duy's words to mean that you should make git-ls-files
> the poster child of this new API for development and profiling purposes
> :-)

Exactly.

> Actually converting the rest of the git code base to such an API is too
> big an undertaking for the summer, so please don't stray on that path.

Didn't I say that this topic is too big for a GSoC task _way_ before
GSoC organization application started?  Without meaningful portion
of the codebase using the newly proposed data stracture and giving
demonstratably better performance figure, it is very hard to justify
that the project completed successfully at the end of the summer.
