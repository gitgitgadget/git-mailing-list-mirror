From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: check-ref-format and rev-parse can not handle branches with an @ in their name combined with @{u}
Date: Tue, 14 Jan 2014 15:45:27 -0800
Message-ID: <xmqqvbxm2kmg.fsf@gitster.dls.corp.google.com>
References: <52D5C296.7050906@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Keith Derrick <keith.derrick@lge.com>
X-From: git-owner@vger.kernel.org Wed Jan 15 00:45:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3Dft-0001oD-7b
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 00:45:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752345AbaANXpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jan 2014 18:45:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48258 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752328AbaANXpc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jan 2014 18:45:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A74664301;
	Tue, 14 Jan 2014 18:45:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=udQhYoXkhymIxVQUAGyTODKUYrQ=; b=tkncNE
	2jQCfKX3UqNTF52IhN2uiZCvJgN415eATxQ0FOEK6AWCWEfXR70kYFvMzdzp5zSe
	b7/4F5VHzT/WdhwlGLQEIlL+6XH5Fu0RGr6dvsG5i4JQmOZC3oG588Os68tKvZDJ
	9pPhr5K4HZoKYbJFR/GGxv0kY78kQlVXLkzcg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=StYF+t6QFQ5rXgBDwHnhetkOU+6IJhf3
	gKvNC15uvmiyHUEUvV4sYmVml6IEYyYNrGe/0bOa/wdJrClw3gfYZmLN/wp15Bd2
	hKyigNlRQP1Yk6x+3x7IryawVspmaCMP5vwJguvdD9HhYS+UVfy1I0KoOxIUsSWM
	YGqmRy5GZZw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68BFC642FF;
	Tue, 14 Jan 2014 18:45:31 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 75523642FA;
	Tue, 14 Jan 2014 18:45:30 -0500 (EST)
In-Reply-To: <52D5C296.7050906@lge.com> (Keith Derrick's message of "Tue, 14
	Jan 2014 18:04:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F3B96D9E-7D75-11E3-B200-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240424>

Keith Derrick <keith.derrick@lge.com> writes:

> I couldn't find a duplicate in the JIRA instance.

Don't worry, we do not use any JIRA instance ;-)

> According to the documentation of check-ref-format, a branch name such 
> as @mybranch is valid.

Correct.

> Yet 'git check-ref-format --branch @mybranch@{u}' 
> claims @mybranch is an invalid branch name.

I do not think it claims any such thing.

    $ git check-ref-format --branch @foo@{u}; echo $?
    fatal: '@foo@{u}' is not a valid branch name
    128
    $ git check-ref-format --branch @foo; echo $?
    @foo
    0

The former asks "Is the string '@foo@{u}' a suitable name to give a
branch?" and the answer is no.  The latter asks the same question
about the string '@foo', and the answer is yes.

So I do not see any bug here.
