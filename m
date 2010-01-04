From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Sun, 03 Jan 2010 21:52:10 -0800
Message-ID: <7vbphaquwl.fsf@alter.siamese.dyndns.org>
References: <7vzl4zy5z3.fsf@alter.siamese.dyndns.org>
 <20100102115041.GA32381@do> <7vtyv4cpna.fsf@alter.siamese.dyndns.org>
 <fcaeb9bf1001021115j7b23264n42cfba7855c2253e@mail.gmail.com>
 <7v7hs09tpi.fsf@alter.siamese.dyndns.org> <87ljgfgbl0.fsf@catnip.gol.com>
 <fc339e4a1001021847hf1e1a7fq894de7908839ff77@mail.gmail.com>
 <877hrzga16.fsf@catnip.gol.com>
 <alpine.LFD.2.00.1001031124420.3630@localhost.localdomain>
 <7v3a2mzzg4.fsf@alter.siamese.dyndns.org>
 <20100104053125.GA5083@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Miles Bader <miles@gnu.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 04 06:52:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRfrk-00043G-11
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 06:52:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752971Ab0ADFw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 00:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419Ab0ADFw1
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 00:52:27 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35064 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120Ab0ADFw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 00:52:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 361708D5CB;
	Mon,  4 Jan 2010 00:52:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IY13vWVVf4CNxh3X0kT0CrWTGwg=; b=iKVnS4
	PqWRlgZMd80nVE4ql2cZBEvm3s+cMP+nLMNaIrf1yTHGFuqecLuVsgXJGZVW/JDo
	7qFAoncQuY2m9WONvYNcRvrmoM1xE9u1TzwGZQjzndLsSwW8W8pDr+dE/hcuwkQq
	3wgTZ2kG/EYEaN4mcNZ8+XqIhrFH7pt4K35z0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qPD5dYYV7KA4Ic7qnzW3AVGZhqgL4FiH
	Ph9ct6gWiFAJG1S6aF5CIHgzn+ZrWMe/LmTRbyWOG7TmZa0Q1BtnnCPtoj/RFa8C
	p1TYdNrFJL+IAPn02M0YNYcwaL/XsnGafJSZQbACp9uTB9dCOGI7v9ABS94aa+jS
	zOQDN0sP43E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CF4E38D5C7;
	Mon,  4 Jan 2010 00:52:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC19F8D5BE; Mon,  4 Jan
 2010 00:52:11 -0500 (EST)
In-Reply-To: <20100104053125.GA5083@coredump.intra.peff.net> (Jeff King's
 message of "Mon\, 4 Jan 2010 00\:31\:25 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 51A5C34E-F8F5-11DE-85A8-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136093>

Jeff King <peff@peff.net> writes:

> On Sun, Jan 03, 2010 at 12:49:15PM -0800, Junio C Hamano wrote:
>
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>> 
>> > Which means that if you put /usr/xpg4/bin before other paths in your PATH, 
>> > you'll totally break such systems, because now you get the (inferior) 
>> > tools in xpg4 before the preferred tools in /usr/local. Or - this also 
>> > happens - people end up installing their own versions in $HOME/bin, 
>> > because the system admin is uncaring or incompetent.
>> 
>> The build allows you to define SANE_TOOL_PATH ("the tools found in here
>> are saner than the ones in /usr/bin or /bin" is what it means) and we
>> insert it just in front of /usr/bin or /bin in the original PATH (see
>> git_brokne_path_fix in git-sh-setup.sh).
>> 
>> I would call this the right thing (TM) or the best workaround we could do
>> under the constraints, depending on the mood.
>
> I agree that Solaris default tools are insane, but is there any reason
> to munge the PATH for a single feature like external grep? Why not
> EXTERNAL_GREP=/usr/xpg4/bin/grep (or /usr/local/bin/grep) in the
> Makefile? Why not GIT_EXTERNAL_GREP=$HOME/bin/grep in the environment?

That git-sh-setup "fix" is not for running external grep.  It is for our
scripted Porcelains that rely on working basic tools (sed, tr, who knows
what else is broken).

In fact, our Makefile by default punts on external grep on Sun's.  Run
"git grep NO_EXTERNAL_GREP -- Makefile" to see for yourself --- it would
work even on Solaris ;-)

> Obviously we still need SANE_TOOL_PATH for systems where the /usr/bin is
> so crappy as to be unusable for our scripts. But surely we can do better
> for individual tools where the user might have some more specific
> preference about which tool he uses.
>
> -Peff
