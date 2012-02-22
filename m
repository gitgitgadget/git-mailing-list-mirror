From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib: added git-diffall
Date: Tue, 21 Feb 2012 18:41:17 -0800
Message-ID: <7vbooregj6.fsf@alter.siamese.dyndns.org>
References: <1329785969-828-1-git-send-email-tim.henigan@gmail.com>
 <7vd397g8ic.fsf@alter.siamese.dyndns.org>
 <CAFouetiLmK3dXLRkBh+cTNA_OMPS77xo8z95WK5y4tk-o-UUog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 03:41:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S029R-0000Va-Cb
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 03:41:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335Ab2BVCl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 21:41:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39990 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752065Ab2BVClX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 21:41:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2F677BA8;
	Tue, 21 Feb 2012 21:41:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0ETroTSK3cYgBKyHrkiQ6e4bApA=; b=TMxWJR
	rwfJb8zbv8gyTVoSsCc1DOXrkOJC41Kt9hgNg1bP/Z9R0qNegouZDyAJo9cD0kZJ
	+YhFifWIgH1nJ7VNCiGVvK5D3a6u2hLGjDfVu+Dd3m71wagQrs/GHk5lCBK/lWu3
	M//FW38VIILZ0orU6hw3SgohbrpvXjiyuydXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tQIib/+CIPMD8GE2gUBljHrXg42vbPtA
	Ct0Gh8Eq7dd7vKsNzBbUsl5/fC8hhBZsfoDIyWhZtx/kW9D2B8kZQa3GDRVVRMaL
	7RWZ8AfYSIVySNk36KUrdWKUWkcSdTn3xGc3M49IgNiWAzxyf0pJOrsv8fAj5VRB
	VnkUE2rkYdE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D966B7BA7;
	Tue, 21 Feb 2012 21:41:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3DF367BA6; Tue, 21 Feb 2012
 21:41:19 -0500 (EST)
In-Reply-To: <CAFouetiLmK3dXLRkBh+cTNA_OMPS77xo8z95WK5y4tk-o-UUog@mail.gmail.com> (Tim
 Henigan's message of "Tue, 21 Feb 2012 21:02:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B303EDD6-5CFE-11E1-BDD7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191225>

Tim Henigan <tim.henigan@gmail.com> writes:

> There is no specific reason it must be bash.  I changed from
> "#!/bin/sh" to "#!/bin/bash -e" due to a bug report from a user on
> Ubuntu [1].  The user reported that:
>
>     "If you use /bin/sh on ubuntu you get the dash shell instead of bash shell.
>     This causes git_merge_tool_path to fail. The error isn't trapped,
> so it exits
>     without displaying anything and without cleaning up."
>
> Given that all the other scripts distributed with git use /bin/sh, I
> will change this script to match.

You need to dig back to that bug report deeper and find out what exactly
is causing the "failure", before blindly allowing /bin/dash to be used.

I think the above function name is a typo of get_merge_tool_path that is
borrowed from git-mergetool--lib.sh, but nothing in the function jumps as
a blatant bash-ism at me from a quick reading.

David, any idea on this?

>> The following is only after a cursory scanning, so there may be other
>> things that needs fixing, but anyway:
>>
>>  - Don't use "which" in scripts.  Its output is not machine parseable, and
>>   exit code is not reliable, across platforms.  It is only meant for
>>   consumption by human who can read English (or natural language in the
>>   current locale).
>
> I used "which" in two places.  Both were added to support problems
> with missing standard tools on certain platforms (missing mktemp on
> msysgit and missing option from tar on Mac [2]).  Is there some other
> standard way to detect the platform or if certain utils are present?

There are examples in the script you are borrowing functions from, even in
the function that allegedly fail for the dash user ;-).

> The cleanup triggers on all the platforms I have tested (Ubuntu,
> msysgit, Mac).  I could change it, but for me it has "just worked".

You set "trap cleanup" for exit event, and then the control reaches the
end of the script, which is an exit event, and the cleanup function is
called.  So it is natural that if you manage to get to that "trap cleanup"
line, of course cleanup will run.  But if you dropped "trap" and "EXIT"
from that line, it amounts to the same thing.

A more important thing to know is that until the control reaches that
"trap cleanup EXIT" line, you do not have that trap set.  So if you caused
the program to exit in an earlier part of the program (say, in the big
"while read name" loop) before the control reaches this line, you won't
see any cleanup.

Perhaps that is what you wanted, but then again writing "trap" and "EXIT"
there is pointless.

Usually people set up a clean-up task with trap before going into complex
stuff, so that no matter where in the complex code the trapped condition
(typically a signal, but an exit event is also possible) happens, they can
be sure the clean-up task is run.  That is the reason behind the following
ordering.

>> If you are to set up temporary files or directories that you want to clean
>> up, a good discipline is to follow this order:
>>
>>  - define variable(s) to hold the temporary locations, e.g.
>>    tmpdir=$(mktemp ...)
>>
>>  - set the trap before starting to use these temporary locations, e.g.
>>    trap 'rm -rf "$tmpdir' 0 1 2 3 15
>>
>>  - and then start populating tmpdir and do whatever you want to do.
