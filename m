From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2010, #01; Mon, 04)
Date: Mon, 04 Jan 2010 17:35:07 -0800
Message-ID: <7vhbr1bagk.fsf@alter.siamese.dyndns.org>
References: <7vljgei7rs.fsf@alter.siamese.dyndns.org>
 <4B421766.4040506@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jan 05 02:35:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRyKZ-0006Xd-JJ
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 02:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753754Ab0AEBfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 20:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753563Ab0AEBfR
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 20:35:17 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59064 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526Ab0AEBfP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 20:35:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 36C21AC69B;
	Mon,  4 Jan 2010 20:35:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EiSwRxZn2rF/S2i38qzxx4r02ms=; b=rPf+KT
	3+KPTBTj+EJpkinL85XVxD96RtB8FVaCJVwkXEsPn/3zqUwaxRbkZsJqO40ef2xJ
	Rld9ojRiMdgR9Ijn3iredGcJYufFlblXF2rMUTxwKPn4hRDx5bSO9dmoNbNBh0rw
	7SiQ8NTfgdRphdoibhQBu6Z9dUtAF/9xADJTc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jvQ+aNdksBSrpWCuX/v+5aFIsMmP8WTw
	N2GmMoLjfeuO9CmMQRaQcjxE3Rf4z2eIj7lvlOD1FLiP7W0tTJ4lEHLkKMZVn+Fm
	gOYzgCKzmoMJhjw2YOF1KoUq7ta712q3ACSPGsen/PF6nxxP/H9mnu6Bzlk7w1eT
	ZVHlHUgGT1U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 18238AC69A;
	Mon,  4 Jan 2010 20:35:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F0D6DAC696; Mon,  4 Jan 2010
 20:35:08 -0500 (EST)
In-Reply-To: <4B421766.4040506@kdbg.org> (Johannes Sixt's message of "Mon\,
 04 Jan 2010 17\:29\:26 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 90FD7578-F99A-11DE-98CA-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136149>

Johannes Sixt <j6t@kdbg.org> writes:

> Junio C Hamano schrieb:
>> * jk/run-command-use-shell (2010-01-01) 8 commits
>>  - t4030, t4031: work around bogus MSYS bash path conversion
>>  - t0021: use $SHELL_PATH for the filter script
>>  - diff: run external diff helper with shell
>>  - textconv: use shell to run helper
>>  - editor: use run_command's shell feature
>>  - run-command: optimize out useless shell calls
>>  - run-command: convert simple callsites to use_shell
>>  - run-command: add "use shell" option
>
> Two notes about this:
>
> 1. My patch "t0021:..." contains an unrelated change to t4030 (it
> changes a /bin/sh to $SHELL_PATH) that is not necessary. I included it
> in my first version of the patch, but later noticed that we already
> have many similar uses of /bin/sh instead of $SHELL_PATH in test
> scriptlets and decided to remove the change, but I only changed the
> commit message and forgot to unstage t4030.

While you are technically correct that the change you made in t4030 is not
justified by the commit log message in the sense that the "hexdump" script
will go through run_command() interface and is not subject to the special
rules filter writers need to keep in mind, the patch text itself is a good
change, isn't it?  Do you want me to split the commit into two (one with
the current message with a patch only to t0021, and another to t4030 with
a justification like "SHELL_PATH is what the user told us to use")?

> 2. If you intend to merge the early part of the topic to master early
> and hold "diff:..." and "textconv:..." in next a bit longer (as
> proposed by Jeff), then you should move "t0021:..." after
> "run-command: optimize out useless shell calls".

As "run-command: convert simple callsites to use_shell" is the one that
changes the filter_buffer(), do you want to have t0021 patch before that
one, to prepare the test for the coming change?
