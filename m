From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git stash deletes/drops changes of
Date: Thu, 23 May 2013 15:49:08 -0700
Message-ID: <7vd2shcnx7.fsf@alter.siamese.dyndns.org>
References: <AANLkTin-BIxgQE5CO2cLhCYJAGHFxiXPquyozKc308DS@mail.gmail.com>
	<loom.20130523T185301-635@post.gmane.org>
	<87sj1d5ous.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Greenleaf <james.a.greenleaf@gmail.com>, <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri May 24 00:49:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfeJv-0000tz-QD
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 00:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759890Ab3EWWtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 18:49:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39672 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759833Ab3EWWtL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 18:49:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED138229C8;
	Thu, 23 May 2013 22:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FJtN044F5SEy00Q5pZoiLKQ01u8=; b=f3MJcx
	jLSh+kR8QMi3YQBJIR+JMTJ3zbVkBxG98V7yEPf1oow+rUnxXiV+g5C0h22JxF8h
	5PqvqV6Kiu3/5i1Q7ErA0GCKlTkhXkj2h4lXR/M2aiXSWKEM4qM4B4uiR4K46sep
	vY8g88+HTuvIWhv8gF6YNzyDw/KK4SR+mA2W0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z7K996jhz+NpPdSYWADU4gDQDqMD5y/K
	pbzkUb3hQdDt72vvrAS8wUAPOdgQXYFMPO9x55slAGMqhahOnS9BubK0Mu56RDRI
	wcUY9gJz+B68khu/zdQagr8X31ih2nNGPRfDsbtHqKKbkkGsPvrR1Qe+W06JBORQ
	N+XRmAqOAnE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E520E229C7;
	Thu, 23 May 2013 22:49:10 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F37D229C6;
	Thu, 23 May 2013 22:49:10 +0000 (UTC)
In-Reply-To: <87sj1d5ous.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Fri, 24 May 2013 00:10:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FB8C5840-C3FA-11E2-92F9-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225312>

Thomas Rast <trast@inf.ethz.ch> writes:

> So maybe it would be time to first make up our minds as to what
> --assume-unchanged should actually mean:
>
> * Ignore changes to a tracked file, but treat them as valuable.  In
>   this case we'd have to make sure that failures like git-stash's are
>   handled properly.
>
> * Ignore changes to a tracked file, as in "who cares if it was changed".
>
> * A very specific optimization for users who know what they are doing.

It has always been a promise the user makes to Git that the working
tree files that are marked as such will be kept identical to what is
in the index (hence there is no need for Git to check if they were
modified). And by extension, Git is now free to choose reading from
the working tree file when asked to read from blob object recorded
in the index for that path, or vice versa, because of that promise.

It is not --ignore-changes bit, and has never been.  What are the
workflows that are helped if we had such a bit?  If we need to
support them, I think you need a real --ignore-changes bit, not
an abuse of --assume-unchanged.
