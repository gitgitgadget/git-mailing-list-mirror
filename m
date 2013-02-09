From: Junio C Hamano <gitster@pobox.com>
Subject: Re: segfault for git log --graph --no-walk --grep a
Date: Fri, 08 Feb 2013 16:22:15 -0800
Message-ID: <7vobfuxrns.fsf@alter.siamese.dyndns.org>
References: <201302090052.22053.thom311@gmail.com>
 <7vsj56xsg5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Thomas Haller <thom311@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 01:22:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3yDJ-0004Rf-3f
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 01:22:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947373Ab3BIAWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 19:22:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38267 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760395Ab3BIAWR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 19:22:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62785C609;
	Fri,  8 Feb 2013 19:22:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/W1TI5cveFJTCWxBPCii16XOiVQ=; b=fJX+ED
	om/ZII6MBgM+m7pog42cwE/nzNcLERcD8QyOmZgA90Ov7raheocZVHHnSKclnLVG
	4Vsc+RrXdCCJOR7zcxYbUPP38Ze+/ZuApKI6GFqnADAR26GQAXYb2hR5ag0jD4sM
	b6tr8owd/isPj9Y3UKwe3H1x9P+8NQTD+MJVA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kF5Vsd705b8yW00BSH/QOjgY3m259g6M
	ONVFvy6w1MMfdM07GY61GekrgAkrK2J75WowMxRAJcEm3uM51X+Y/MWE2+Sjm0H/
	nxmUr3tNUlx4fVmHoY2R0JTwYzGocMloFTDQJX0ig/xgEcJKMpxtsdjZL85igZXJ
	fI29aR6WiMw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55656C608;
	Fri,  8 Feb 2013 19:22:17 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD136C607; Fri,  8 Feb 2013
 19:22:16 -0500 (EST)
In-Reply-To: <7vsj56xsg5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 08 Feb 2013 16:05:14 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C25E10C0-724E-11E2-8FBF-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215830>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Haller <thom311@gmail.com> writes:
>
>> it happens in file revision.c:2306 because "commit->buffer" is zero:
>>
>>                 retval = grep_buffer(&opt->grep_filter,
>>                                      commit->buffer, strlen(commit->buffer));
>
> I think this has been fixed at be5c9fb9049e (logmsg_reencode: lazily
> load missing commit buffers, 2013-01-26); I haven't merged it to any
> of the maintenance releases, but the tip of 'master' should have it
> already.

Ah, no, this shares the same roots as the breakage the said commit
fixed, and the solution should use the same idea, but not fixed.
