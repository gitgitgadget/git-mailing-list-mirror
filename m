From: Junio C Hamano <gitster@pobox.com>
Subject: Re: squashing patches
Date: Mon, 09 Jun 2008 14:02:40 -0700
Message-ID: <7vskvmfhjj.fsf@gitster.siamese.dyndns.org>
References: <20080607220101.GM31040@leksak.fem-net>
 <20080609114550.GA8079@leksak.fem-net>
 <7vprqqh06j.fsf@gitster.siamese.dyndns.org>
 <20080609204327.GD8079@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Joerg Sommer <joerg@alea.gnuu.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Mon Jun 09 23:04:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5oWy-0004AF-Oj
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 23:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599AbYFIVDD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 17:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752472AbYFIVDC
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 17:03:02 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56042 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbYFIVDA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 17:03:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 17995216A;
	Mon,  9 Jun 2008 17:02:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DAE922165; Mon,  9 Jun 2008 17:02:45 -0400 (EDT)
In-Reply-To: <20080609204327.GD8079@leksak.fem-net> (Stephan Beyer's message
 of "Mon, 9 Jun 2008 22:43:27 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 70135A3C-3667-11DD-8961-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84429>

Stephan Beyer <s-beyer@gmx.net> writes:

>> > Comments? Opinions? Ideas?
>> 
>> I actually expected that the primitive command sequence the backward
>> compatible "edit" would expand to would be a pair, "pick" followed by
>> "pause".
>
> Something "like" this was my veeeery first approach: "edit" with commit
> was the backwards-compatible "edit" and without arguments was your
> "pause".
> Example:
> 	pick ea7beef
> 	edit		# or "pause" as you suggested
> After a little discussion this became:
> 	pick --edit ea7beef
>
> And I can't objectively say what's better

Me neither.  My "expectation" came primarily from what I understood,
namely you seemt to prefer atomism, and not from "I want things to be this
way".

If we think any proposed and future instruction would be reasonable to
have --edit option, then all insn implementation would need to support
"edit" option anyway, and the users do not have to remember which insn
does and does not support --edit so both forms would work equally well
(and "--edit option" would make the insn stream shorter, which may be
good).  But probably "mark --edit" and "reset --edit" would not make
sense, so a separate "edit" insn may be more generic and useful.

> The open question is, if we should do this by a natural number <n> or
> by a commit.
> The natural number approach seems easier, but imagine someone pauses
> and does some commits (not --amend)... Here the behavior of these
> approaches differs. ;-)

I see.  Not using count but setting an explicit mark and using that commit
sounds more robust, considering that use case.

>> About the other parts in your original message:
>> 
>>  - The "tag" command looked a little out of place;
>
> Eh, why?

Why not?

I just wondered why there was a support only for lightweight tag there.
You do not have "branch" command, and your "tag" command does not seem to
support things like -a, -s, -m<msg>, etc.  Not that I think you should
support full "tag" and "branch" command set, but it seemed a bit odd.
