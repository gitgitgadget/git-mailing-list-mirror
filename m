From: Junio C Hamano <gitster@pobox.com>
Subject: Re: diffstat witdth with one changed file
Date: Mon, 21 May 2012 15:20:48 -0700
Message-ID: <7vehqd6urj.fsf@alter.siamese.dyndns.org>
References: <CACsJy8BrqaLbtVp5uF3q2Jo63DPwtFACYw3_rPy8eyNK7VSWMw@mail.gmail.com>
 <m2obphcubh.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue May 22 00:21:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWayG-00009G-IM
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 00:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757852Ab2EUWUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 18:20:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54218 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751753Ab2EUWUv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 18:20:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31E1A8F0E;
	Mon, 21 May 2012 18:20:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fBYhzkAUZc/GIoCMYoCxy7AKkVo=; b=opKKzp
	hCuDmsz2P5gxrSUgEJgonNQci1P3Op1mdFFFI7i95xk1JXUfZg3w5Qcl3YOy+jxu
	gPDcWUDLxMIgr5x5c/gJ75QLgxIkAEtQxSiiS3bP+K+qnOjMqLOUDt/OMno1kirc
	MX64v6zaVHOaLHqLLGSd364xlUU7z6rf8LAU4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=alLB4oJFCZXObOHtB97LPol4tRX1FAs2
	y6yy1P4b/cO/CvhEY/j6MxGGv4j77PZIzb9qfhq2AqhQvyaBaoGUcT2M277x+VHN
	kbl2wiQNnGyjDYr4e891C9OIhO6y6ZwIScavdW+z3lpMPqyEPfiRZfWazstK+sny
	6DqwPr0RDNs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 295108F0D;
	Mon, 21 May 2012 18:20:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A78198F0C; Mon, 21 May 2012
 18:20:49 -0400 (EDT)
In-Reply-To: <m2obphcubh.fsf@igel.home> (Andreas Schwab's message of "Mon, 21
 May 2012 19:33:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 383E8378-A393-11E1-8118-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198141>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> With recent git, "git log --stat 90e6ef5", the first commit's diffstat
>> uses full terminal width while the next one uses less than 80 chars.
>> Both changes one file. Is it intentional?
>
> In commit 0e641b1 the file has only 41 lines of changes, so it looks
> intentional.

Correct.  We do not try to make width of bars from two different commits
comparable [*1*], but we do try to make them comparable within a single
commit; for a commit that changes only a single path, you still have adds
and removals to compare.  The overall length is ideally one + or - per
line if the graph fits the output width, but if that makes the graph too
wide, we scale to fit in the output width.  So a change with 41 lines gets
only 41 +/- and does not consume full 80-column terminal.

[Footnote]

*1* This is very much on purpose; otherwise it will hurt the perceived
latency of the command.
