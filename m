From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git-am silently applying patches incorrectly
Date: Fri, 04 Mar 2011 11:31:29 -0800
Message-ID: <7vy64u65ta.fsf@alter.siamese.dyndns.org>
References: <4D70EBC3.3010400@colin.guthr.ie>
 <7vr5am7p30.fsf@alter.siamese.dyndns.org>
 <7vei6m7muw.fsf@alter.siamese.dyndns.org>
 <7v39n27llq.fsf@alter.siamese.dyndns.org>
 <AANLkTim=jpJmBZmtAVX2V8Ui44AwpTbevJtSR2Xk=wLX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Colin Guthrie <gmane@colin.guthr.ie>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 04 20:31:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pvaj5-0003XZ-Ty
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 20:31:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759934Ab1CDTbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 14:31:42 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62430 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759792Ab1CDTbm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2011 14:31:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 91A603369;
	Fri,  4 Mar 2011 14:33:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q2QdfiJdFmutvQtUrmoJU3GHd+A=; b=mPeBm+
	8jotirzwMWKSfNO2eQslU0RXDYk5lTyT7GRwwNFL8qKuviCatpEEs7c7iEDdlVf6
	qJ3N6mvqV+DUEcArq+hNRCuby9pm/q4Wa0d4MvFK299AamR+bhpYbkcQQ9P6D8ZG
	8UkAzDBr4GQC+/AwyGbECc1U/rim7G5G594aE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YXnb3GwLv+oK574BaQCkb8q92Utz1VJx
	Y+HvR8qbH6ijlDwkIkXNQuuXF6Z5CEA5lovmM2nBNmGy7DzvuaG++Oo/SLlxxi78
	HTNQA2Y8Q69koY33/d/u95gkZMxjfBv99hAFUArCTPMS2QFGpz6rSTDTUFjJ3DE9
	bYEse1Mi1UY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 584D83368;
	Fri,  4 Mar 2011 14:32:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3FD8C3367; Fri,  4 Mar 2011
 14:32:53 -0500 (EST)
In-Reply-To: <AANLkTim=jpJmBZmtAVX2V8Ui44AwpTbevJtSR2Xk=wLX@mail.gmail.com>
 (Linus Torvalds's message of "Fri\, 4 Mar 2011 11\:18\:01 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 35D32B3A-4696-11E0-A99E-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168462>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> IOW, maybe something like "img->last_match = applied_pos +
> postimage.nr;" or whatever.
>
> I dunno.

I was lazy and didn't want to worry about the consequences of excluding
the end of the context lines in the previous hunk, especially when the
patch was generated with small number of context lines.

But it would probably be a good idea to cut the search at the tail end of
the previous hunk.
