From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] bash completion: use read -r everywhere
Date: Wed, 21 Dec 2011 20:09:15 +0100
Message-ID: <87wr9pkahw.fsf@thomas.inf.ethz.ch>
References: <4502a0248bb843018335e9b5cdf70736c096ebe3.1324482693.git.trast@student.ethz.ch>
	<7vipl9hht4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, Kevin Ballard <kevin@sb.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 21 20:09:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdRXe-0004EG-Lj
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 20:09:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754322Ab1LUTJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 14:09:25 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:35501 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752253Ab1LUTJW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 14:09:22 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 21 Dec
 2011 20:09:18 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (80.219.158.96) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 21 Dec
 2011 20:09:19 +0100
In-Reply-To: <7vipl9hht4.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 21 Dec 2011 10:59:35 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [80.219.158.96]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187580>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> POSIX specifies
>>
>>   The read utility shall read a single line from standard input.
>>   By default, unless the -r option is specified, backslash ('\')
>>   shall act as an escape character...
>>
>> Our omission of -r breaks the loop reading refnames from
>> git-for-each-ref in __git_refs() if there are refnames such as
>> "foo'bar", in which case for-each-ref helpfully quotes them as in
[...]
> Thanks.
>
> As this script is specific to bash, it is secondary importance what POSIX
> says. The "-r" option is important only because "bash" happens to follow
> POSIX in this case. I'd like to see the early part of the message reworded
> perhaps like this:
>
> 	At various points in the script, we use "read" utility without
> 	giving it the "-r" option that prevents a backslash ('\')
> 	character to act as an escape character. This breaks e.g. reading
> 	refnames from ...

Perhaps we can then just fold it into the first paragraph after the
POSIX quote, like

  We use the 'read' command without -r, so that it treats '\' as an
  escape character, in several places.  This breaks the loop reading
  refnames from git-for-each-ref in __git_refs() if there are refnames
  such as "foo'bar", in which case for-each-ref helpfully quotes them as
  in

Or some such.  Do you want me to resend?

> Does this regress for zsh users in some ways, by the way?

I'm not one of them, but a quick googling for "zsh builtin read" turns
up that it has a dozen options, and -r means

  -r
      Raw mode: a \ at the end of a line does not signify line continuation. 

I can't discern whether it treats \ special at all with or without -r.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
