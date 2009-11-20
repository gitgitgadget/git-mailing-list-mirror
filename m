From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: Use git-difftool for external diffs
Date: Fri, 20 Nov 2009 12:51:36 -0800
Message-ID: <7veinsx6lj.fsf@alter.siamese.dyndns.org>
References: <1258341126-2108-1-git-send-email-davvid@gmail.com>
 <19205.2531.205062.980468@cargo.ozlabs.ibm.com>
 <20091119193913.GA25410@gmail.com>
 <19205.50406.91209.309984@cargo.ozlabs.ibm.com>
 <7vhbsp7htq.fsf@alter.siamese.dyndns.org> <20091120185522.GC56351@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, peff@peff.net, sam@vilain.net,
	git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 21:52:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBaSc-00026Y-GB
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 21:52:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755280AbZKTUvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 15:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755230AbZKTUvs
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 15:51:48 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64347 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755123AbZKTUvo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 15:51:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B342581918;
	Fri, 20 Nov 2009 15:51:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yfLgZBTgcQExnUcPOZc5+3QyKJI=; b=CbZUFA
	QGglWeJv/jY+N7mC8gZ3DdqlKhw4IwnqdR4mxV5QLKRTYSDso3pqo6WmKOiOxoxS
	6M8vyChg/DaJuitejUZ1Q8AFS/j4IFx/Yyy0fV7Uoy2FCsjPSEEBRxJG75tSLsyW
	7yybogAT1h7bPq//NnEjDEN7NGxLcAuLbQ1G0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q9ng+BQpcKq/TZ8Xy1QpMUFNgGgQgZEQ
	EABzfrmKyU0tZZ/cQCRMWl6bRPU0hcVpV6CQsGZ5MAQFiPa5o25LOkvwGN+aY+pc
	n6b/1Y4JHBTfGe/XrzZouDVgz7NSHesmWBYiYzB9DVzDDDVy2vwgMeamS9TaNM8S
	Jq0207Ud4oE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 56CAD81916;
	Fri, 20 Nov 2009 15:51:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A6B1E81914; Fri, 20 Nov
 2009 15:51:37 -0500 (EST)
In-Reply-To: <20091120185522.GC56351@gmail.com> (David Aguilar's message of
 "Fri\, 20 Nov 2009 10\:55\:24 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 82FC7B06-D616-11DE-81DB-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133377>

David Aguilar <davvid@gmail.com> writes:

>> > Also, I don't think we should remove the ability for the user to
>> > choose which external diff tool to use.
>> 
>> This is a larger concern.  Does "difftool" allow use of an arbitrary tool
>> like how gitk does (I have a suspicion that it is not as flexible)?
>
> difftool supports arbitrary tools through configuration.
> For arbitrary tools we set difftool.$name.cmd and
> diff.tool = $name.

So it is not as flexible as just giving a command line template for
one-shot invocation, but that is Ok.

Don't get me wrong.  I think the longer term direction should be to reduce
code from gitk without making lifes harder to existing users, and just
like built-in "diff --cc" stripped the combined-diff implemented in Tcl
from gitk, use of "difftool" would be a good way to unify the "diffing"
experience for a user who uses both command line and gitk at the same
time.

I do not read Tcl very well but I am guessing that in gitk you specify
what tool to run (e.g. "frobanodiff -z"), gitk feeds you two temporary
files on the filesystem to compare (e.g. "frobanodiff -z $tmp1 $tmp2"),
and your command line is responsible for giving satisfying diff experience
to the end user.

I see three possible approaches:

 * Teach "git-difftool" a mode to compare two arbitrary files on the
   filesytem, and set that as "External Diff" command that takes the
   filenames as extra two parameters, just like any other "External Diff"
   programs given to gitk does.  This is the least palatable, as it won't
   solve the read-only repository issue at all (it only allows you the
   logic to choose the configured difftool backend program).

 * Instead of disabling the traditional "External Diff" and taking it over
   like your patch did, add a new codepath for "Difftool" that feeds the
   commit IDs and paths the way git-difftool expects.  The user can use
   both, and the issue of read-only repository is solved when "Difftool"
   is used (but not "External Diff").

 * Take over "External Diff" codepath exactly like your patch did, but
   teach "git-difftool" a new command line option to name an unconfigured
   external program that takes two filenames.  When "External Diff"
   program is *not* configured in gitk, the command line to invoke
   difftool would be exactly as in your patch, i.e. "difftool --no-prompt
   $from $to -- $path".  Otherwise, when gitk is configured to use an
   external program, e.g. "frobanodiff -z", for "External Diff", you pass
   that command line to "git-difftool" via that new option, e.g.

     difftool --no-prompt --extcmd="frobanodiff -z" $from $to -- $path

   Then difftool is responsible for preparing the two necessary temporary
   files out of the given information ($from/$to/$path) and feeding them
   to "frobanodiff -z" command line.

   Maybe such --extcmd support already exists in difftool, in which case
   my earlier suspicion that difftool is not as flexible would be false.

I think the last one would be the way to go in the longer term.
