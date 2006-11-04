X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problem with git-apply?
Date: Sat, 04 Nov 2006 02:00:04 -0800
Message-ID: <7v4ptf4jmj.fsf@assigned-by-dhcp.cox.net>
References: <20061104072349.GA19667@cubit>
	<7v8xir4k3w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 4 Nov 2006 10:00:16 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7v8xir4k3w.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 04 Nov 2006 01:49:39 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30913>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgIJy-00028q-1o for gcvg-git@gmane.org; Sat, 04 Nov
 2006 11:00:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965161AbWKDKAH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 05:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965138AbWKDKAH
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 05:00:07 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:30339 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S965161AbWKDKAF
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 05:00:05 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061104100005.LSWW18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Sat, 4
 Nov 2006 05:00:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id iZzj1V00F1kojtg0000000 Sat, 04 Nov 2006
 04:59:44 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Kevin Shanahan <kmshanah@disenchant.net> writes:
>
>> #!/bin/sh
>>
>> mkdir a b repo
>> echo foo > b/foo
>> diff -urN a b > test.diff
>
> It is *very* surprising that this issue did not come up earlier,
> given that we used to use GNU diff internally to generate our
> own diff.
>
> If you cat the test.diff file, you will see "a/foo" and "b/foo",
> not "/dev/null".
>
> The problem appears that GNU diff _never_ uses "--- /dev/null"
> or "+++ /dev/null" to indicate creation or deletion of the file,
> but the "traditional patch parser" builtin-apply has assumed
> that is what the traditional diff output from day one.  Where we
> got that idea is mystery to me (this is Linus's code), but I
> suspect it is what other SCMs did.

*BLUSH*  A prime example of "you should not speak before
thinking".

Please forget everything I said.  The patch parsing is just fine
with or without "/dev/null".  This must be a recent breakage
around write_out_one_result().  Will take a look.
