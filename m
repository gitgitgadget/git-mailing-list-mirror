From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2010, #02; Sun, 07)
Date: Tue, 09 Mar 2010 16:58:04 -0800
Message-ID: <7vvdd5t2lf.fsf@alter.siamese.dyndns.org>
References: <7vk4tnd9wu.fsf@alter.siamese.dyndns.org>
 <7vk4tnw4nz.fsf@alter.siamese.dyndns.org>
 <20100309231306.GD25265@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steven Drake <sdrake@xnet.co.nz>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 10 01:58:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpAFi-0003An-Gi
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 01:58:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756128Ab0CJA6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 19:58:16 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54396 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756064Ab0CJA6O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 19:58:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9424EA02C9;
	Tue,  9 Mar 2010 19:58:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UMv/KkE7AyuL/QUiIUjbatpi0k0=; b=m3gBVG
	Y/0z7qiIXCcddgI+7ONIgOorF3jX5jFb9GpNCJmflU+WlvrsiDjVN0M/j6JIErQZ
	sUj4GumXH7D8/k2s0InWP4+GojbD4mMB6iWLrsLLgwolPEelMsx+g3Xv1wa0UiQ7
	kwOmhl29PIVTv/eI04hxC6A2Lue/In/r/HcYU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bc2BbWEb0oDOap+fhsJ1TT+WOSvEZ7UO
	o6ZQFleTPbbR1RnUY608l7TZM8NnzHPpW+oqNakePpFCrHfu+d6mFwxZmcAcyyRh
	YptOz04FzLWRIKNTYaqF9qcMIoUmYxIRx1+2ssXxt3b8QkWeLWdxrUQcMVfakIXd
	xnn5q+8JqKw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FA45A02C5;
	Tue,  9 Mar 2010 19:58:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D460A02C4; Tue,  9 Mar
 2010 19:58:05 -0500 (EST)
In-Reply-To: <20100309231306.GD25265@sigill.intra.peff.net> (Jeff King's
 message of "Tue\, 9 Mar 2010 18\:13\:07 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FE9A1196-2BDF-11DF-AB44-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Mar 08, 2010 at 01:20:32AM -0800, Junio C Hamano wrote:
>
>> After thinking about this a bit more, I do not think it is a good idea to
>> disable configured decoration when an explicit --pretty is given.  A patch
>> to do so would be a trivial two-liner:
>> [...]
>> but there is one big difference between notes and decoration.  Decorations
>> are designed to be a small, one-per-ref tokens that would sit well on a
>> line that already has other essential informations, while notes are a lot
>> louder "in your face" annotations that occupy line(s) on their own.
>
> True, but turning off configured decorations also helps scripts. I think
> we can all agree that normal "git log" is not supposed to be consumed by
> scripts, but should "git log --pretty=raw" turn off configured
> decorations?
>
> With the current code, gitk (which calls "log --pretty=raw") barfs on a
> repository with log.decorate turned on.

Yuck.  Do you mean we would need _at least_ something like this?  I am
undecided if we should limit to FMT_RAW if that is the case, though.
Reading from "git log --pretty=raw" is just as unkosher as reading from
"git log --pretty=oneline", but a bigger question is do we still have
enough plumbing support to replace them, or Porcelain "log" has advanced
too much too quickly, leaving plumbing "rev-list" behind.

I can obviously rip the configuration variable support out.

Steven, what do you want to do?

 builtin-log.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 0afba31..29a59b0 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -77,6 +77,8 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 
 	if (!rev->show_notes_given && !rev->pretty_given)
 		rev->show_notes = 1;
+	if (rev->pretty_given && rev->commit_format == CMIT_FMT_RAW)
+		decoration_style = 0;
 
 	if (rev->diffopt.pickaxe || rev->diffopt.filter)
 		rev->always_show_header = 0;
