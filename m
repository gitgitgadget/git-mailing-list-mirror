From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/12] tests: add initial bash completion tests
Date: Sat, 07 Apr 2012 22:41:32 -0700
Message-ID: <7v62daye43.fsf@alter.siamese.dyndns.org>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
 <1333854479-23260-2-git-send-email-felipe.contreras@gmail.com>
 <7vpqbiyhmu.fsf@alter.siamese.dyndns.org>
 <20120408044825.GA4296@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 08 07:41:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGksw-0007LF-IU
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 07:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326Ab2DHFlg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Apr 2012 01:41:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34324 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751919Ab2DHFlf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2012 01:41:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9731F7EF3;
	Sun,  8 Apr 2012 01:41:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9wrhBgYTplulkEJVX0oiljcxtZg=; b=T8Otnm
	yMwoMPiFx6LB+kAu0Kj5+a2RdTLwz6uaYzWqMjc3QEJZo0q62Jqc+fO+ATT8P0Rh
	0XhyPqq2rgzNITJFiksBpk6dFeaoranz1aZHiJnDM2bOkt/R+DqaTnraqa0Cq6CN
	LGtbSctcc0Kswg9Aq5rNzN33a0RhZZ5uoNco0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LWVMV4wPnIeyNM2CAGjekbbCg4eIFhyt
	ef4GodEmwtEJ6Rc+a90zJqxs2KF6HJjTPU/uzUGNt6gXSPF8TD5waNGku0TPYXo9
	hmz1htEQgvp09qJrZP29/89UwrPcEigya0cCI5EY/MLDy8azUQataObY4QVqxANB
	iQqtFUtTtwQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 837757EF2;
	Sun,  8 Apr 2012 01:41:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1414F7EF1; Sun,  8 Apr 2012
 01:41:33 -0400 (EDT)
In-Reply-To: <20120408044825.GA4296@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 8 Apr 2012 00:48:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 80287F2C-813D-11E1-BC2D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194979>

Jeff King <peff@peff.net> writes:

> On Sat, Apr 07, 2012 at 09:25:29PM -0700, Junio C Hamano wrote:
>
>> Bash has a special case code to behave in a "posixly correct" mode, where
>> a lot of extensions are disabled, when invoked as "sh".  Unfortunately, it
>> still defines BASH_* variables, including BASH, when operating in this
>> mode.
>> [...]
>> So we may want to be a bit more careful like this:
>> 
>> if test "z${BASH%/bash}" != "z${BASH}"
>> then
>> 	: ends with bash so we are already running bash as bash
>
> If bash is in posix mode (including "bash --posix" and being invoked as
> "bin/sh"), it will set POSIXLY_CORRECT (but not export it). Similarly,
> if POSIXLY_CORRECT is set in the outer environment, it will act more
> like sh. So maybe that would be a better test.

Yes, but the check needs to be careful to make sure the shell that is
running the check is indeed bash, so that it will explicitly exec bash for
somebody who is running dash but exports POSIXLY_CORRECT to make GNU
programs (other than bash) behave more standard compliant way.

In other words,

	if test -n "$POSIXLY_CORRECT" && test -n "$BASH"
	then
        	: we are running bash under posix mode
	elif ...

or somesuch.
