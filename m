From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC][PATCH] Print the usage string on stdout instead of stderr.
Date: Mon, 17 May 2010 15:30:48 +0200
Message-ID: <4BF14508.8040307@drmicha.warpmail.net>
References: <878w7ieu4p.fsf@thor.thematica.it>	<4BF12C96.9030802@drmicha.warpmail.net> <87vdamu2es.fsf@thor.thematica.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Scrivano <gscrivano@gnu.org>
X-From: git-owner@vger.kernel.org Mon May 17 15:31:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OE0Po-0007G2-Es
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 15:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353Ab0EQNbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 09:31:20 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43787 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751711Ab0EQNbT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 May 2010 09:31:19 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7986DF7945;
	Mon, 17 May 2010 09:30:43 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 17 May 2010 09:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=5fddJtSNjdG2xZnFh9SJyw4NS4w=; b=m64wqBPqiQmXmp4LAqCOR5XHKObZJcHoGcXQjNn2mqY+g0TclcFJpZFdxPSZSKnmDuh0FTTHKGvcPxeOTrwzPNI64SyQ7t8WPZCGuxFyHHUCyWs25qt5zj6yA8oAR9ipg7mkg8JC9FSTRJ67XTDAkDciPA2g1lFZBjs3vxn4VDg=
X-Sasl-enc: HWNWELdtAluVW+RTWjHkhWtloK+Dynroq6eh1f/Oo+LM 1274103041
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 06B9D55CDD;
	Mon, 17 May 2010 09:30:40 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100503 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <87vdamu2es.fsf@thor.thematica.it>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147235>

Giuseppe Scrivano venit, vidit, dixit 17.05.2010 14:40:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> More importantly, callers expect error messages on stderr, such as usage
>> with wrong arguments. I don't think scripts would call commands with
>> '-h', and if they do they do so on purpose and can parse stderr, knowing
>> there is no stdout in this case.
> 
> It looks like a workaround to me.  Anyway, if -h is left unchanged then,
> I think, --help should be adjusted as well when it doesn't use an
> external pager.
> 
> These two commands behave differently:
> 
> git status --help 2>/dev/null | cat -
> git status -h 2>/dev/null | cat -

They also do two very different things. The first one displays the man
page, the second the usage string.

> IMO, what should be changed is -h to be uniform with --help, as the it
> is the expected output, not an error.

That is not what your patch does.

I'm not opposed to having -h output on stdout. I'm opposed to having
usage error messages on stdout. Currently, both are on stderr, which is
no problem (we're not bound by GNU rules here).

Your patch puts both on stdout, and that is a problem, not only for
several test which could be adjusted, but also for scripters.

A patch which *really* only changes '-h' to use stdout would certainly
not be objected. Actually, most calling sites are probably the "error
case" so that you only need to make sure that the "-h" path get's to use
a different output file descriptor.

Cheers,
Michael
