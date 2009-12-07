From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v3 0/8] Remote helpers smart transport extensions
Date: Mon, 07 Dec 2009 12:07:24 -0800
Message-ID: <7vein635vn.fsf@alter.siamese.dyndns.org>
References: <1260116931-16549-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <7v7hsz9qxj.fsf@alter.siamese.dyndns.org>
 <20091207210608.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 21:07:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHjrv-0007Gy-VP
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 21:07:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758841AbZLGUH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 15:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758803AbZLGUH2
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 15:07:28 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47391 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758786AbZLGUH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 15:07:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 406228666C;
	Mon,  7 Dec 2009 15:07:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=cYMdi5hVOlaN0bjsJWTbs0lQYUo=; b=fc0DL87VyVGhynM6xJOwOIE
	K64Vm6thiVaF3gaA9+enZzeNM+AEFNHWulCviTXA8AIR1NzOnmee4vs4nX1qD3Jq
	4u/dQq+FbBsrQcfxonOQKisi4AxDQG8c1GPYoLZjva8LF9ijbN6ciC2gGixoSBSu
	4Lfh0FKq8kLmyuxsi3Ng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=kbSHc/mjpSddNrULPIgfOmDjhUU8NAthXrwi8+VYtBii+iaQk
	FiyJcmgL89jieF3qOvo0jjjQzldEUWbf6rXVZO2Fw+K/0FhcdcvzR12Kktmguu7m
	GMVzUCckf9WKdrB1M4bw2QmkBeYXgSX9Y1Fu7PGxvR52uRQaz4GPx2U61g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 083A58666A;
	Mon,  7 Dec 2009 15:07:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8108D86668; Mon,  7 Dec
 2009 15:07:26 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2685485E-E36C-11DE-9CFE-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134776>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>
>
>> I queued to ease the discussion in 'pu'.  I had to fix-up some conflicts
>> while doing so.  Please sanity check the result.
>
> I see that you changed many "char* variable" to "char *variable", but
> what is the reason for these changes?

Nico already gave you correct and more concise version; this more verbose
explanation is primarily for you who said a few times that you are not
fluent in C.  Others can skip this message without missing anything.

I haven't asked people why they choose to write like this:

	char* string;

beyond "that is how we were taught and what we are used to".

But if I have to guess, it is because it makes it appear as if you are
being consistent between basic types like "int" and pointer types like
"char *".  E.g. these both look like "<type> <variable>;"

	int     variable;
        char*   variable;

The example in CodingGuidelines gives a clear illustration that this
however is not the way how C language works.  IOW, the syntax for
declaration is not "<type> <var1>, <var2>,...;".  E.g.

	char*	var1, var2;

declares var1, which is a pointer to a char, and var2, which is a char.
That is what Nico means by '* is an attribute of the variable and not of
the type'.

The only sane way to read declaration in C is to read from inside to
outside, starting from a variable name.  When you read "char **argv", for
example, you treat it as "char (*(*argv))", and read it from the variable
name:

    - It declares argv; what's the type of it I wonder...

    - It is a pointer, because the asterisk in front of it tells us that
      we can dereference it. Now, what's the type of the result of
      dereferencing argv, i.e. "*argv", I wonder...

    - That "*argv" is a pointer, because the asterisk in front of it again
      tells us that we can dereference it. Now, what's the type of
      dereferencing that "*argv", i.e. "**argv", I wonder...

    - Ah, it is a "char", that is what this declaration says.

And the style we use (which is the same as Linux kernel style) naturally
matches the way how you read this declaration.
