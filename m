From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] "git clean" deletes excluded files in untracked directories
Date: Tue, 22 Jul 2014 14:39:27 -0700
Message-ID: <xmqq8unlf4z4.fsf@gitster.dls.corp.google.com>
References: <20140702184429.GA32538@sigill.intra.peff.net>
	<20140702191114.GA3474@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 22 23:39:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9hmh-0006fk-Gy
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 23:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756831AbaGVVjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 17:39:40 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55610 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752460AbaGVVjj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 17:39:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9E6882CA1C;
	Tue, 22 Jul 2014 17:39:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ccfeZPH8LbjG3q0vyrGBAgkQLus=; b=uOQiYk
	bobDbSFVAAjX+i/RsimmWiiye7jDutCEjkRjFuUFH2aD2hZOSnoJjg39OhMmpGr7
	u6E+fe272+oCqSvAQtXFCSzdnPuIxwplhWUSMBsk259SkVGmBZa+Wn3mUFfp316k
	GBwhwsXMb+gnwNw8G7kzWnnff3dBx9hMhqGL0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WIfOo+rCOLCTQtxrNp+PLOpIY5zHBtY1
	LMZu+FBDeqx190OvQ9y7jAgyifs0hYb5RsGh8gDLZNEbzLV+0U9t2klrWY5X1osG
	eK+EFgOnoE0jXud4c9gJq36FUpoBcupTdIq6vN5jz4EfEXJ9zjwD+GovVJcTOLRF
	h9mIMSNq7Qg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 94F332CA1B;
	Tue, 22 Jul 2014 17:39:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CC6662CA09;
	Tue, 22 Jul 2014 17:39:28 -0400 (EDT)
In-Reply-To: <20140702191114.GA3474@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 2 Jul 2014 15:11:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A8B52C4A-11E8-11E4-ADD0-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254044>

Jeff King <peff@peff.net> writes:

> If you have an untracked directory that contains excluded files, like
> this:
>
>   mkdir foo
>   echo content >foo/one
>   echo content >foo/two
>   echo "foo/one" >.gitignore
>
> then "git clean -d" will notice that "foo" is untracked and recursively
> delete it and its contents, including the ignored "foo/one".

Hmph, starting from an empty repository and doing the above four
commands, and "git clean" without "-d" does not bother removing
either foo/one or foo/two.  Is this correct?

It gets worse.  Following the above four commands and then these two:

    >foo/three
    git add foo/two

and "git clean" (with or without "-d") suddenly notices that
"foo/three" is expendable, but not foo/one nor foo/two, which sounds
about right.

Honestly, as I do not use "git clean" myself, I do not know what the
"right" behaviour is for that command.  Anything it does seems just
arbitrary and wrong to me ;-)
