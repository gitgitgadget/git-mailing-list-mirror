From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Fix ranges with git-show
Date: Wed, 20 Jun 2012 10:47:23 -0700
Message-ID: <7vmx3xx4d0.fsf@alter.siamese.dyndns.org>
References: <d3e839101b031a7208e74a0b6e22d343d5a093e9.1340136145.git.trast@student.ethz.ch> <a598bb8c20221679e295caa743197c86219eda68.1340136145.git.trast@student.ethz.ch> <7vhau7ypk6.fsf@alter.siamese.dyndns.org> <87bokexwiq.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jun 20 19:47:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShP06-0003o8-Bb
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 19:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754406Ab2FTRr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 13:47:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41445 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754165Ab2FTRrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 13:47:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2496B9E72;
	Wed, 20 Jun 2012 13:47:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LAwT38IEWjkB/9LJ77SJRt2xiS8=; b=kCQVMG
	vTEQbOy/9PuiYvwfhLPfjWrtG16cxM2M0zL8URqS8RYbhikiJhPtpuoZkHLfxXY1
	dSlV4T3jLjPdRSw98C/rRRzlGqzPGIHCaoMR7jvPRP76ugKy1Ml1kO2IMPlvL1SQ
	M3ZnSUH7TiPayZJXlS+nm0BpzGqCVzkYnsO28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ILu483Ap1xCeBIONBjZgZEDkM1fdfRsJ
	p7dWCQOxjTo2PQL1TPEQOIjCrniWPzokBgnYC2GZ5q8GsrQaT4sKgX21wjSDu8UV
	V7ni0Wjn9Sgd7VlyAusaGh36KPnNfLPyFTPOrpDkNrY7eyUx2LR3+Ekf5E5xIXub
	IhYbRAkyMMo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A99D9E71;
	Wed, 20 Jun 2012 13:47:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8EF4E9E6E; Wed, 20 Jun 2012
 13:47:24 -0400 (EDT)
In-Reply-To: <87bokexwiq.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Wed, 20 Jun 2012 09:39:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FE6F673C-BAFF-11E1-8DDF-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200305>

Thomas Rast <trast@inf.ethz.ch> writes:

> Clever.  But it eliminates all possibility of *simultaneously* showing a
> range and some other objects, of which
>
>> Among your new tests:
>>
>> 	git show ^side3 annotated
>>
>> must change, as it is not asking to show individual objects (in
>> other words, I think the test expects a wrong thing), but everything
>> else should work as expected (I didn't check).
>
> is just a symptom of.  Do you want to change it?  

I do not understand the question.  Do I think your patch is broken
that "git show ^side3 annotated" shows the annotated tag?  Yes, I
think it is broken, and it is the symptom of the same breakage as
the "If we have a range, let's walk it outselves without doing
exactly the same thing as the normal 'log' walk".  In other words,
"git show" is to show individual objects unless you feed ranges.  If
you feed ranges, it will act as "git log".

> So far, showing "anything plus ranges"
> is broken only as far as the ranges are concerned.

Yes, I think the command works correctly only when you do not give
any range, and once you give any range, its output is utterly
broken.

> If you do make this change, can we merge the log and show code?
> Granted, show defaults to -p --cc --no-walk, and log does not, but can
> we then unify the main logic?

What "main logic" remains?  

I offhand do not think of a need to do anything more than the above
patch, but I may not be getting the benefit you are seeing.  

The remainder of cmd_show() are about showing individual objects
(including commits), which has very different semantics from what
"log" does, no?

"log" asks get_revision() to grab each commit while digging the
history deeper with add_parents_to_list() and feed the returned
commit to the internal diff-tree , but "show" does not have to use
get_revision() because it already has list of objects it wants to
show, and calling into get_revision() is not even necessary as it
does not want it to do add_parents_to_list() to find more commits to
show.
