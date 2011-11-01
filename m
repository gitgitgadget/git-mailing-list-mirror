From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Display change history as a diff between two dirs
Date: Tue, 01 Nov 2011 10:15:55 -0700
Message-ID: <7vr51rn4qc.fsf@alter.siamese.dyndns.org>
References: <4EAC6765.4030003@gmail.com>
 <7vty6rrow8.fsf@alter.siamese.dyndns.org> <4EAE688C.8010502@gmail.com>
 <7v39e8o61s.fsf@alter.siamese.dyndns.org>
 <CANEMaQRoXRygmrYsu0xF6mWq50r9Qhh-YuXXNAhyQewd+fDtsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Roland Kaufmann <rlndkfmn+git@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 01 18:16:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLHwj-000897-7S
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 18:16:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211Ab1KARQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Nov 2011 13:16:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45382 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755395Ab1KARP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2011 13:15:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1E77532C;
	Tue,  1 Nov 2011 13:15:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sECvQwNpJ8GxbTMrH+I+bAX+Z2s=; b=YS0dAn
	fl7SejKte/J1M+bb+IAGxEf3cmeDNzVlLsNlF8muxRabLnt13CNQ3eBBqGPzL0Vr
	qIzRiwJIsxkywYEb9Q/+brk+Y+V/C3x/b8/rSiJ9ysiwnpWU9Ach/ksNHCvCIMr2
	oTqUGt8QnW36awt28N6lzCcjM0bz14aqHcUr8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nSuJwKrAuTg9XH07cz/ybZ1yoJRu3jbz
	fSAwDIUu0/lUwgvahDBM1lduLNz2QvFmcya2HRrTdJBdfXk1xcR5C+FskX5Z7p8x
	S2bHN/fsJ3kbpENgqAP2i2vrswZ2wwp9N39HmAmhngOXmj443BKVuMIbkYirENid
	/ca4WzXj41o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8FB55329;
	Tue,  1 Nov 2011 13:15:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4EE815327; Tue,  1 Nov 2011
 13:15:57 -0400 (EDT)
In-Reply-To: <CANEMaQRoXRygmrYsu0xF6mWq50r9Qhh-YuXXNAhyQewd+fDtsQ@mail.gmail.com> (Roland
 Kaufmann's message of "Tue, 1 Nov 2011 10:01:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 29B3E3DC-04AD-11E1-BF2B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184576>

Roland Kaufmann <rlndkfmn+git@gmail.com> writes:

> On Tue, Nov 1, 2011 at 04:49, Junio C Hamano <gitster@pobox.com> wrote:
>> Roland Kaufmann <rlndkfmn+git@gmail.com> writes:
>>> Would it be better to have yet another configuration available for
>>> this option instead of reusing the existing infrastructure for `git
>>> difftool`?
>
>> It probably is OK for "git diff --dirdiff" to use GIT_EXTERNAL_TREEDIFF if
>> and only if GIT_EXTERNAL_DIFF is not defined, and use GIT_EXTERNAL_DIFF
>> otherwise. People who have GIT_EXTERNAL_DIFF set to a tool capable of
>> handing directory pair can just add "--dirdiff" to the command line, and
>
> Did you perhaps mean the other way around: GIT_EXTERNAL_TREEDIFF
> if set, and GIT_EXTERNAL_DIFF otherwise?

I think I misstated the precedence order.  What I had in mind was roughly
like this:

 1. "git diff" (and others like "git log") without "--dirdiff" option:
    GIT_EXTERNAL_DIFF is used just as before and no GIT_EXTERNAL_TREEDIFF
    is consulted;

 2. "git diff --dirdiff": GIT_EXTERNAL_TREEDIFF is used if set, otherwise
    GIT_EXTERNAL_DIFF is used.

That way, people who have been using GIT_EXTERNAL_DIFF that is capable of
comparing two directories do not have to change anything and can just give
"--dirdiff" when they want to operate the command with this new mode of
comparison. People whose GIT_EXTERNAL_DIFF is not capable of comparing two
directories have two choices, but in either case they first would need to
find an external tool they want to use with the "--dirdiff" mode. If they
want to use the same new external tool for non "--dirdiff" mode, then they
can set GIT_EXTERNAL_DIFF to it. If they want to keep using the command
they have been using with GIT_EXTERNAL_DIFF when not in "--dirdiff" mode,
however, they can keep their GIT_EXTERNAL_DIFF to the old "two files
comparison" tool, and set GIT_EXTERNAL_TREEDIFF to the new one.

But that is all about envisioning how a proper integration of the feature
in the main "diff/log -p" command codepath would work. I do not know if it
is worth to add that to your script, which would be a stop-gap experiment
until we find out if the "populate two temporary directories and have a
tool compare them as a whole" mode is useful.
