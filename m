From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git-am silently applying patches incorrectly
Date: Fri, 04 Mar 2011 13:33:17 -0800
Message-ID: <7vtyfi606a.fsf@alter.siamese.dyndns.org>
References: <4D70EBC3.3010400@colin.guthr.ie>
 <7vr5am7p30.fsf@alter.siamese.dyndns.org>
 <7vei6m7muw.fsf@alter.siamese.dyndns.org>
 <7v39n27llq.fsf@alter.siamese.dyndns.org>
 <AANLkTim=jpJmBZmtAVX2V8Ui44AwpTbevJtSR2Xk=wLX@mail.gmail.com>
 <7vy64u65ta.fsf@alter.siamese.dyndns.org>
 <loom.20110304T210337-216@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexander Miseler <alexander@miseler.de>
X-From: git-owner@vger.kernel.org Fri Mar 04 22:33:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pvccw-00011u-1g
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 22:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760214Ab1CDVd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 16:33:28 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55867 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760167Ab1CDVd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2011 16:33:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CF99F40CF;
	Fri,  4 Mar 2011 16:34:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0C+pnSZvI/cGwcK7LL0kF40fHqQ=; b=cImUkH
	4RQQ46tckkg63NZZIoSDFlBHt2+7nplWjdCW6DZ8yAD8h1Cn4zSNf9Gj3KpVIqDY
	3Ymsz0p5jYha3yr+p95g8NrSBlqWMl2VrW+FlaiPHde+PguH/x+GuzUM35RFUFS5
	PqoeG0NYme5gqr+U1usWSlLhVZFm5clU1BHSk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JVMD55sKMCeygUjLi+02D/SWeTVnBLqQ
	yv8w+j+iI8D8UMchg/fDoZli8j9mN3LndRZh/9FGrkXCsAGhuoVrmOldcwf4bGN6
	yqGe5NtB9EqcxnyLh2bCY30kQk5QwqIbwHKUOeHWiSV+0tbVBE3P+iIpU4+tOA35
	vE6ykHhvwJE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ABD7940CB;
	Fri,  4 Mar 2011 16:34:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5EBF640CA; Fri,  4 Mar 2011
 16:34:41 -0500 (EST)
In-Reply-To: <loom.20110304T210337-216@post.gmane.org> (Alexander Miseler's
 message of "Fri\, 4 Mar 2011 20\:14\:01 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 39F06564-46A7-11E0-B91F-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168467>

Alexander Miseler <alexander@miseler.de> writes:

> It's a bit intimidating for a newbie to chime in on a discussion between the 
> creator and the maintainer, but:
> IMHO the biggest problem here isn't the incorrectly, but rather the silently. 
> Reducing the chance of guessing incorrectly is good, but git-am still has to 
> guess sometimes and it should warn/inform the user when it does that.

(Please don't cull Cc line).

No need to feel intimidated.  

The patch under discussion was merely "first things first--let's fix the
obviously wrong case that can be fixed without regression".

Try implementing that warning logic, and using it in real-life projects.
You don't actually have to _code_ it, but merely imagining how it would
work and perform would be sufficient for you to realize that it would be
quite expensive (you need to find all the possible mismatches, essentially
scanning the whole file), and worse yet, it would be annoyingly noisy with
many false positives, because in many real-life projects, end of function
tends to match the problematic pattern that triggered this discussion
quite often even without patches that introduce more of the pattern.

Unless you can reduce the false hits to manageable levels, such a warning
is not very useful (it would be useful as a lame excuse "we warned, but
you took the suspicious result", but that does not help the users).

In short, Linus and I both know what you are talking about, and we may
revisit that issue later, but the thing is that it would not be very
pleasant, and not something that can be done in one sitting during a
single discussion thread on the list.
