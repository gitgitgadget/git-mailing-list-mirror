From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/18] rebase -i: Make the condition for an
 &quot;if&quot; more transparent
Date: Thu, 14 Jan 2010 09:42:47 -0800
Message-ID: <7v8wc0fuqw.fsf@alter.siamese.dyndns.org>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
 <aa37ee8a68d460df172b23b4999fbe4ce7d77c1e.1263447037.git.mhagger@alum.mit.edu> <loom.20100114T164214-897@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Blake <ebb9@byu.net>
X-From: git-owner@vger.kernel.org Thu Jan 14 18:43:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVTip-0000Ak-Ke
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 18:43:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757387Ab0ANRm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 12:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757353Ab0ANRm5
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 12:42:57 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47679 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757234Ab0ANRm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 12:42:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D3AD891429;
	Thu, 14 Jan 2010 12:42:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=iTyM3AwXlDNYY89T0TMGGl50c74=; b=eFFJz9MEwucC8Y2BZDRZC5z
	6vNXsRvX5UwCaXE+zRFO4AIGKhyXyF2Ygi1IRilXM2oplmiJSfF4lx2KrqFapOH1
	oRPFC6QZutz56aF7JYeZHaXGRjSCyAZpQm12ewNlHyu4qTGEVU37OS9neO77RhqP
	q07+Kdi5ALBFeQ0bZDEE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=mJxm5XFXUB4fgkkKcIUkfH0+j+Xwr7GzGDE6GIQSQ++yzGx7m
	NRA08tzYSuOqgywH5jc6G/UEL5571NRW7iW75GxHTlK2oKU8KWtNzX1H4B7MKTgS
	MCSE7G+4HmWSONMjtCWSjCYETRBL4Sudf9n0ag+n55wT4hsfgRDlCdHbbw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DA1691428;
	Thu, 14 Jan 2010 12:42:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D644B91427; Thu, 14 Jan
 2010 12:42:48 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3D7FC620-0134-11DF-98B6-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137006>

Eric Blake <ebb9@byu.net> writes:

> Michael Haggerty <mhagger <at> alum.mit.edu> writes:
>
>>  	current_sha1=$(git rev-parse --verify HEAD)
>> -	if test "$no_ff$current_sha1" = "$parent_sha1"; then
>> +	if test -z "$no_ff" -a "$current_sha1" = "$parent_sha1"
>
> 'test cond1 -a cond2' is not portable.  Use 'test cond1 && test cond2'.

I avoid "test -a/-o" myself without even thinking (I am from old-school),
but at the same time I thought the progress in the world made such caution
obsolescent.

Not so.  Even though POSIX.1 lists -a/-o as options to "test", they are
marked "Obsolescent XSI" ("Strictly Conforming POSIX Applications and
Strictly Conforming XSI Applications shall not use obsolescent features").

We may want [PATCH -01/18] to clean up the existing code first.  Even
outside git-rebase--interactive.sh there are quite a few of them.

    $ git grep -n -e 'test .* -[ao] ' -- '*.sh' | wc -l
    38
