From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v3 01/13] Move index v2 specific functions to their
 own file
Date: Fri, 10 Aug 2012 07:58:54 -0700
Message-ID: <7vobmilro1.fsf@alter.siamese.dyndns.org>
References: <1344424681-31469-1-git-send-email-t.gummerer@gmail.com>
 <1344424681-31469-2-git-send-email-t.gummerer@gmail.com>
 <7vtxwbn2qe.fsf@alter.siamese.dyndns.org> <87hasan7ty.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gummerer <t.gummerer@gmail.com>, <git@vger.kernel.org>,
	<mhagger@alum.mit.edu>, <pclouds@gmail.com>,
	<robin.rosenberg@dewire.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 10 16:59:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szqg8-0002uc-0Y
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 16:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759279Ab2HJO67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 10:58:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34201 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758948Ab2HJO65 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 10:58:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6B6B9BA5;
	Fri, 10 Aug 2012 10:58:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JyITFigXusvvxCYgAPXlwHcGj8o=; b=TYFBnr
	nHqKfPyeGQyo6yKeuZDBvIKuuo6eGUsEnHWYizGgNo2YLcl4prj5hkrUOIwQO+8f
	AEbb7MQ8oCL2J9bh+1kUl8hiYOKL8Pf7xbzsRTIrnoYA1pmrBgahp8MG2SsiO7eJ
	EYdtKpqietMJu1myfjTkMi+s2b3SvTqcDp6Lw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wW7UKD01VlKFIeO2nnUNsYyGPqySWE5w
	dRCBHT0JyLchvDLBzDtHmBfP+161o7exh9tVAGyuSSOI7virSn9LyWP9/aQZnKv4
	2HxFWbQaJvGiIODDKn6n3dbAdTFlqKZ6zVt/8mql+d8oaa+131LQKrb0/AEyPvN2
	nu1O22QZnL8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B317F9BA4;
	Fri, 10 Aug 2012 10:58:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D8399BA2; Fri, 10 Aug 2012
 10:58:56 -0400 (EDT)
In-Reply-To: <87hasan7ty.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Fri, 10 Aug 2012 16:24:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8717262-E2FB-11E1-B2F7-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203221>

Thomas Rast <trast@student.ethz.ch> writes:

> But I think the idea always was that any write that changes the basic
> layout of the file (so that you would read something wrong) will need a
> full rewrite.  Otherwise we're too far in DB land.
>
> Most updates will be
> of the "update the stat and/or sha1 of a file" kind, anyway.

Yes, I agree the v5 format documented in the series does not let you
do anything other than the kind of updates without rewriting [*1*]

But that does not fundamentally change the story that a new format
and a new way to access the index to cope with larger projects would
want to come up with a solution to address the competing read/write
issue, or at least help to make it easier to solve the issue in the
future.

"That problem is not new" is not an answer when the question is "We
still have the problem".


[Footnote]

*1* While my gut feeling matches your guess that the kind of updates
would be the majority, I do not think anybody did numbers to
substanticate it, which we may want to see happen.
