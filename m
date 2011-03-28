From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Add two grep config options
Date: Mon, 28 Mar 2011 09:24:26 +0200
Message-ID: <4D9037AA.9090601@drmicha.warpmail.net>
References: <1301088071-918-1-git-send-email-jratt0@gmail.com> <7vlj024wal.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Joe Ratterman <jratt0@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 09:28:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q46s0-0001cz-DR
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 09:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832Ab1C1H2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 03:28:06 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:44846 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751086Ab1C1H2F (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Mar 2011 03:28:05 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1BE4C2058D;
	Mon, 28 Mar 2011 03:28:04 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 28 Mar 2011 03:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=2XOsiI2JwuPaz/aVfOFwAnwcSR8=; b=Mhw59Njd0q77qJg1EpcUUOwDniNZJwUToeHQwe5oszoRABaqArORX9d5DhOee5d1hqRMWorVGiKJrTipD+j/drZDKgXQQ8hqTf5cxCDYoekGBxJmdAXKx0h3W7JMJQePBHy4lKHJOK2HSdXUKVSg8oCVkguS7EBEe9UdLDg+ueo=
X-Sasl-enc: rkwXURoro/paeZb7rS+GU5m84XKdkoLy8C2ufe1yJIJ8 1301297283
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5751F40E0CB;
	Mon, 28 Mar 2011 03:28:02 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <7vlj024wal.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170104>

Junio C Hamano venit, vidit, dixit 26.03.2011 00:25:
> Joe Ratterman <jratt0@gmail.com> writes:
> 
>> grep.extended-regexp: Enabling this boolean option has the same effect
>> as adding "-E" to all "git grep " instantiations.  This can be
>> disabled by specifying "--no-extended-regexp" on a particular call.
>>
>> grep.line-numbers: Enabling this boolean option has the same effect as
>> adding "-n" to all "git grep " instantiations.
>>
>> Signed-off-by: Joe Ratterman <jratt0@gmail.com>
> 
> Thanks.
> 
> Things to consider:
> 
>  - Apply this patch on top of "master",run "git shortlog v1.7.4..HEAD",
>    store the output somewhere, and imagine reading that 2 months from now.
>    Does a single line in the output about this patch sufficiently tell you
>    what it was about?
> 
>  - Configuration variables are spelled without hyphens between words (you
>    can see "gui.commitmsgwidth" in the context of the patch you sent and
>    notice that it is not "gui.commit-msg-width").
> 
>  - This will break scripts people have written, knowing that they can rely
>    on "grep" they wrote without giving "-E" from their command line will
>    use BRE, and force them to update the script with --no-extended-regexp
>    for no good reason.  Worse yet, there isn't even --no-line-numbers
>    supported to defeat grep.linenumbers configuration to protect such
>    scripts.
> 
>    I understand that some people would feel that the convenience would
>    outweigh the risk of script breakage in this particular case, and I am
>    sympathetic to the cause, but I still have to point it out.  Is there
>    anything we can do to mitigate the risk somehow?

This comes up again and again, and I feel that rather than adding config
options one by one, we should either allow aliases for standard commands
and/or setting default options depending on the mode (ui use vs.
scripting use), so to say a companion to "git -c n=v" which allows

git config ui.grep "-E -n"

I.e. just like "git -c n=v <cmd>" sets up pseudo config before running
cmd, our wrapper could augment argv from "ui.<cmd>".

We could safeguard scripts from this by

- checking istty and
- checking env for GIT_PLUMBING

and setting the latter in git-sh-setup.sh. After a long migration phase,
we could skip the first (fragile) check.

Michael
