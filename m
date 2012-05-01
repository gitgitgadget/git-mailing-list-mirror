From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log-tree: use custom line terminator in line termination
 mode
Date: Tue, 01 May 2012 13:03:21 -0700
Message-ID: <7vmx5r8y9i.fsf@alter.siamese.dyndns.org>
References: <86ty01qez7.fsf@red.stonehenge.com>
 <1335811555-23564-1-git-send-email-jk@jk.gs>
 <7vaa1tf1w8.fsf@alter.siamese.dyndns.org>
 <20120501085649.GD4998@sigill.intra.peff.net>
 <7v1un3c23p.fsf@alter.siamese.dyndns.org>
 <7vobq7al12.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Andreas Schwab <schwab@linux-m68k.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 01 22:03:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPJIH-00028b-NE
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 22:03:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757942Ab2EAUDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 16:03:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44908 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756801Ab2EAUDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 16:03:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39971629D;
	Tue,  1 May 2012 16:03:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b0K6pTOVeONRiQKuNLCL3YcjaPo=; b=cX78xx
	otV0N1On4B+xAJ7xSUKxa+eNAWeZPubtFrRFs6eYoZ6ZnSqxvL4F8uV+ocB8VQpZ
	ryXR3x0EH0q/ubbpE+OX3guGKQS/2t6I5DO24qXDi1qttW89DMcqRufnIb9eKhYg
	+U8yXwHL1TP1d2vK6ibRBACdGNnIJ0+OCiLXc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gPkN/IumvhCY7uq2TbT0OSB9tni7B+fs
	+gKAVw2FvGQ95hpO3idxNiplXYod3CwZ2woWXNqRLueXSRPgaM4XEBUfYEk2YovA
	tEWoeKcOVnL8Xb9NjLp8xEjreUimTJOn7/E4z1d6sIIZSD0vhpSK2PMItI9itr93
	ceKesCUe91Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 308D5629C;
	Tue,  1 May 2012 16:03:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 80F20629B; Tue,  1 May 2012
 16:03:22 -0400 (EDT)
In-Reply-To: <7vobq7al12.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 01 May 2012 10:06:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B44FB5A2-93C8-11E1-A910-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196738>

Junio C Hamano <gitster@pobox.com> writes:

>> The correct output would have NUL after each commit, so "-z --format=%s"
>> would have a single-liner subject with the line-terminating LF replaced
>> with NUL, and "-p/--stat -z --format=%s" would have a single-liner subject
>> with its line-terminating LF, followed by the diff/diffstat in which the
>> terminating LF of the last line is replaced with NUL, but to be consistent
>> with what "-p/--stat -z --pretty=format:%s" does, I think it is OK to
>> append NUL to the diff/diffstat part instead of replacing its last LF with
>> NUL.
>
> In other words, this test on top (the last one only demonstrates the
> breakage).

Just a short hint if anybody wants to take a stab at it while I am deeply
in today's integration cycle.

The code for "separator" semantics was a well tested code when
"terminator" semantics was bolted on, and operated like this:

        for each record
        do
                if we have shown a record already
                then
                        show the termination character
                fi
                show the record
        done

The only difference between the two semantics is if we append the
termination character after all the above is done, so the code should be
structured that way, but that may not be how we currently do it.  So the
proper way to add the "terminator" semantics ought to be:

        if we have shown any record in the loop && opt->use_terminator
        then
                show the termination character
        fi

at the end of the above loop.  If we see opt->use_terminator anywhere else
in the existing code, it is an indication of a bug.

There is one small glitch.  If a record is _not_ terminated with a
newline, e.g. "log --pretty=format:%s" without --stat/-p, "separator"
semantics will end up giving an incomplete line at the end.  Most of the
time we will be piping out output to the pager so it may not be a problem
in the real life, but it would be nicer to also terminate such an output.

So the resulting logic should look something like:

        for each record
        do
                if we have shown a record already
                then
                        show the termination character
                fi
                show the record
                remember if the record ended with a LF
        done
        if we have shown any record in the loop &&
           (opt->use_terminator ||
            (opt->diffopt.line_termination == '\n' &&
             the last record did not end with a LF))
        then
                show the termination character
        fi
        
