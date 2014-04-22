From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [SECURITY PATCH] git-prompt.sh: don't put unsanitized branch names in $PS1
Date: Tue, 22 Apr 2014 12:47:57 -0700
Message-ID: <xmqqr44p4042.fsf@gitster.dls.corp.google.com>
References: <1398107248-32140-1-git-send-email-rhansen@bbn.com>
	<20140421202454.GA6062@sigill.intra.peff.net>
	<53562A96.6000002@alum.mit.edu>
	<xmqqy4yx5knw.fsf@gitster.dls.corp.google.com>
	<5356B71A.6070500@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, sitaramc@gmail.com
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 21:48:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcgfq-0005vu-LY
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 21:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285AbaDVTsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 15:48:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48788 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751275AbaDVTsC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 15:48:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01FDC7F07C;
	Tue, 22 Apr 2014 15:48:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kUZN0gRXaT8+Mou5AeGoPu2uNdY=; b=o/8tGe
	zpwOHZfM4NuwERANtPjFCy/WlugkUQ1j85tCJjM2t4glRMiF77kKSN12KV8NinWu
	Q5oBJFUTIi2lyzRAMkNHKg21CjcnPADdzUsaPRiNMbY7td6YRR4sY6dqpPJzF6sj
	DlhiVyfhQboYr/q1Y8AH7g7EuIWcVa162tMvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G9iOd5qokcsrl7fJnCjN7LFO9eA026MT
	StECpN5FKSMJhnkG8C9n4VnMQPt+Aa2iSHdwXmFweI1IYP5hTUrrm9yvjJB8SveU
	flENW7raXgsxNWeTt5/eGGgUUCxglNZXlLEA0DpwsdiAC7sK+BbmYD4+g3xicr36
	6D634XrwMhQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE1FC7F07B;
	Tue, 22 Apr 2014 15:48:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D6967F074;
	Tue, 22 Apr 2014 15:47:59 -0400 (EDT)
In-Reply-To: <5356B71A.6070500@bbn.com> (Richard Hansen's message of "Tue, 22
	Apr 2014 14:38:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 01E77DB0-CA57-11E3-98EA-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246777>

Richard Hansen <rhansen@bbn.com> writes:

>> and plan for transition to forbid them
>> everywhere in a next big version bump (it is too late for 2.0).
>
> Would it be acceptable to have a config option to forbid these in a
> non-major version bump?  

Of course ;-) Because we try very hard to avoid a "flag day" change,
any "plan for transition" inevitably has to include what we need to
do _before_ the big version bump.

> If it's OK to have a config option, then here's one possible transition
> path (probably flawed, but my intent is to bootstrap discussion):
>
>   1. Add an option to forbid dangerous characters.  The option defaults
>      to disabled for compatibility.  If the option is unset, print a
>      warning upon encountering a ref name that would be forbidden.
>   2. Later, flip the default to enabled.
>   3. Later, in the weeks/months leading up to the next major version
>      release, print the warning even if the config option is set to
>      disabled.

Sounds fairly conservative and nice.  We may want to treat creating
a new such ref and using an existing such ref differently, though,
and that might give us a better/smoother transition (as you are, I
am just thinking aloud).

For example, it might be sufficient to do these two things:

 (1) upon an attempt to use an existing such ref, warn and encourage
     renaming of the ref.

 (2) upon an attempt to create a new one, error it out.

in the first step, and in either case, tell the user about the
loosening variable.

Going that route may shorten the time until the initial safety.
