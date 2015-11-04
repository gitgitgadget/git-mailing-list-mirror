From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 00/11]  Expose the submodule parallelism to the user
Date: Wed, 04 Nov 2015 09:54:46 -0800
Message-ID: <xmqqk2pxbqft.fsf@gitster.mtv.corp.google.com>
References: <1446597434-1740-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, peff@peff.net, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 18:54:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu2Gt-0003em-Cz
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 18:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756191AbbKDRyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 12:54:50 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56844 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756173AbbKDRyt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 12:54:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2AB7D28AE3;
	Wed,  4 Nov 2015 12:54:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CZvYuTdlUetqkjayI6AVgh46AE0=; b=GNF2Nc
	sNnGr60W+q7rTHbz2svH5A0zYiQEDL/lHmoMVu3jj72cRzLCoq1G8kkbmUhP134V
	+XtCR3qfMmVQL4PKQNV8qayLkSqsB7bKJWLFjVFXF4wUbVE8s++LCtuzQ/C7PChp
	oxQYiUSrHHv0sFnVQOg2wenJ+RmsiZxGhVv7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=br+I28sc+9w6bO9v71zTdEktxwnxK0Ef
	3VAMyc8aBn08xlWTY+AvOfsACLO4cePfRF8GjQUOp0F7zHwr09Eiwr8qYPMasz2U
	NXriZTLnqfoYrhxxWiNTfOCBHVwwp+PH06StM4Re2tl/ykfK3U5npunZfGSw9uzr
	wXCmaAuK1rI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 22E1A28AE2;
	Wed,  4 Nov 2015 12:54:48 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9C5CB28AE1;
	Wed,  4 Nov 2015 12:54:47 -0500 (EST)
In-Reply-To: <1446597434-1740-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 3 Nov 2015 16:37:03 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 237ACA1A-831D-11E5-9B7D-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280861>

Stefan Beller <sbeller@google.com> writes:

> Where does it apply?
> ---
> This series applies on top of d075d2604c0f92045caa8d5bb6ab86cf4921a4ae (Merge
> branch 'rs/daemon-plug-child-leak' into sb/submodule-parallel-update) and replaces
> the previous patches in sb/submodule-parallel-update
>
> What does it do?
> ---
> This series should finish the on going efforts of parallelizing
> submodule network traffic. The patches contain tests for clone,
> fetch and submodule update to use the actual parallelism both via
> command line as well as a configured option. I decided to go with
> "submodule.jobs" for all three for now.

The order of patches and where the series builds makes me suspect
that I have been expecting too much from the "parallel-fetch" topic.

I've been hoping that it would be useful for the project as a whole
to polish the other topic and make it available to wider audience
sooner by itself (both from "end users get improved Git early"
aspect and from "the core machinery to be reused in follow-up
improvements are made closer to perfection sooner" perspective).  So
I've been expecting that "Let's fix it on Windows" change directly
on top of sb/submodule-parallel-fetch to make that topic usable
before everything else.  Other patches in this series may require
the child_process_cleanup() change, so they may be applied on top of
the merge between sb/submodule-parallel-fetch (updated for Windows)
and rs/daemon-plug-child-leak topic.

That does not seem to be what's happening here (note: I am not
complaining; I am just trying to make sure expectation matches
reality).  Am I reading you correctly?

I think sb/submodule-parallel-fetch + sb/submodule-parallel-update
as a single topic would need more time to mature to be in a tagged
release than we have in the remainder of this cycle.  It is likely
that the former topic has a chance to get rebased after 2.7 happens.
And that would allow us to (1) use the child_process_cleanup() from
get-go instead of _deinit and to (2) get the machinery right both
for UNIX and Windows from get-go.  Which would make the result
easier to understand.  As this is one of the more important areas,
it matters to keep the resulting code and the rationale behind it
understandable by reading "log --reverse -p".

Thanks.
