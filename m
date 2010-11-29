From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 04/20] rebase: remove unused rebase state 'prev_head'
Date: Mon, 29 Nov 2010 13:06:21 -0800
Message-ID: <7v7hfv262a.fsf@alter.siamese.dyndns.org>
References: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1290715083-16919-5-git-send-email-martin.von.zweigbergk@gmail.com>
 <4CEF67AB.6050700@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Nov 29 22:06:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNAvy-0004Ig-BQ
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 22:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752397Ab0K2VGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 16:06:40 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36043 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103Ab0K2VGj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 16:06:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AACA13DE5;
	Mon, 29 Nov 2010 16:06:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NXdrNJvcJPmdVUrPZ115vz6d8oA=; b=DdvxpO
	rUAsmEty0az84shGbL4ckf1UCM8F8ihJuCsxWJ5EUVoWwjaOc00+z0koHuXEdUB+
	BTjftGxx+OU5nv7x3p9dWsSvcv2E5Rl5bMmhE+1oOONgRwpNKp1C3imIkrPVmZ1U
	T8+tVjwuSPxbZwVelu63957nKviQD6s0KnQGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YsVE8FTMdnQj5SKf+3egSgflOZkyUGAb
	Ky7CkQXWxB/hO9ZsstEBOVmjCMuZ9ZYiqouVaiuS9OoHWCIClrgJxbAHYmmv3RvA
	fPVEE0gnvNUbt9vYgTU7CYwNoa5xdatNjstfHRv74RpCnRmRBnICwpwv5WdRFSf9
	Mqj+4co/jXE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4BC323DE1;
	Mon, 29 Nov 2010 16:06:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 279E63DDF; Mon, 29 Nov 2010
 16:06:40 -0500 (EST)
In-Reply-To: <4CEF67AB.6050700@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Fri\, 26 Nov 2010 08\:54\:19 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 94E32AD8-FBFC-11DF-91E8-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162430>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Martin von Zweigbergk venit, vidit, dixit 25.11.2010 20:57:
>> The rebase state 'prev_head' is not used. Remove it.
>> 
>> Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
>> ---
>
> The actual value of prev_head was never used. But the check for its
> non-nullness made sure that git-rev-parse HEAD^0 succeeded when
> $merge_dir was created. Have you made sure that we don't need that check?

I think we are Ok.

It was a bit sloppy of 9e4bc7d (rebase: cleanup rebasing with --merge,
2006-06-24) to use the output from `git-rev-parse HEAD^0`, which would
give you "HEAD^0" as string when HEAD does not exist.  Even though the
command itself will exit with non-zero status, the exit status was never
checked.  After 9e4bc7d (rebase: cleanup rebasing with --merge,
2006-06-24), we didn't seem to have any reason to use $prev_head, iow,
this change was probably way overdue.
