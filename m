From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t0005: skip signal death exit code test on Windows
Date: Thu, 06 Jun 2013 10:21:47 -0700
Message-ID: <7vy5anyx1w.fsf@alter.siamese.dyndns.org>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<51AEE1C3.9020507@viscovery.net>
	<20130605071206.GC14427@sigill.intra.peff.net>
	<51B02D81.3000700@viscovery.net>
	<20130606063754.GA20050@sigill.intra.peff.net>
	<CAMP44s2L4EOG7aEOR8gqXeaHm7SeuPg=GQAWX3PByKKbtTHnwQ@mail.gmail.com>
	<20130606064409.GA20334@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 06 19:22:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukdsq-0005gD-2C
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 19:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160Ab3FFRVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 13:21:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51004 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751686Ab3FFRVv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 13:21:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57AF023584;
	Thu,  6 Jun 2013 17:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CSEN+GEbsYMgZGJ8gPJTlvBYuKc=; b=u/Z8tq
	216y2m1AOP1Xj+Aqb5vxcB7G7QfYMUt1bm+FD3OILWt6jBALdXR1p5U8wF7FGmiD
	Yp+AlxHPpB3TwQYbjwB/8dgyRWT3YVycB+hMPVd0kkwdHG5YP+BXdX5E/OVAcRMW
	AbaVJa7G/UbreSj9DUh5SjyK33mTRiRLsgluE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l46DVtlg11Lo1YRuREQgvHQQzeC+UCAE
	TryXocm76dM40eZu+4IqLRl0QKI3XRlfUmJK6AlOsh3yM190mU0HXm9+Xt+chC2O
	VB8Or0QINaiiIt+JikOhpnMdOFR5ksjdAkgcOSntXmC3Hotf9V0EVnGdbESfvXIB
	tDhrvF+yrw4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B5CB23582;
	Thu,  6 Jun 2013 17:21:50 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9DBFE23580;
	Thu,  6 Jun 2013 17:21:49 +0000 (UTC)
In-Reply-To: <20130606064409.GA20334@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 6 Jun 2013 02:44:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 92887F9E-CECD-11E2-BD3C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226515>

Jeff King <peff@peff.net> writes:

> On Thu, Jun 06, 2013 at 01:41:05AM -0500, Felipe Contreras wrote:
>
>> > Thanks. I wasn't quite clear on how the signal handling worked on
>> > Windows, but from your description, I agree there is not any point in
>> > running the test at all.
>> 
>> Shouldn't we clarify that Git exit codes only work on UNIX-like
>> operating systems?
>
> Clarify where? My impression is that this issue is well-known in the
> msys world, and it is a platform issue, not a git issue.

I actually was scratching my head while reading "the implementation
of raise() just calls exit(3)." part, in this:

> The particular deficiency is that when a signal is raise()d whose SIG_DFL
> action will cause process death (SIGTERM in this case), the
> implementation of raise() just calls exit(3).

After a bit of web searching, it seems to me that this behaviour of
raise() is in msvcrt, and compat/mingw.c::mingw_raise() just calls
that.  In other words, "the implementation of raise()" is at an even
lower level than mingw/msys, and I would agree that it is a platform
issue.

> If somebody wants to write a note somewhere in the git
> documentation, that's fine with me, but I'm not clear on exactly
> what it would even say.

I agree with both points.  I can suggest to clarify the log message
a bit with "the implementation of raise() in msvcrt (Microsoft C
Runtime library) just calls exit(3)", but that does not address the
end-user documentation issue.

I tried to summarize the issue for end-user documentation and came
up with this:

    The Git implementation on MinGW exits with status code 3 upon
    receiving an uncaught process-terminating signal, just like any
    program that link with msvcrt (Microsoft C Runtime library)
    whose raise() implementation just calls exit(3).  This is
    different from Git on POSIX, which reports a death by receiving
    a signal with the exit status code (128 + signal number).

But when stated this way, it feels that it belongs to Msysgit
documentation, not ours, at least to me.
