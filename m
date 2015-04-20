From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why does "git log --author=<pattern>" not work with "regexp-ignore-case" and other regexp-related options?
Date: Sun, 19 Apr 2015 22:59:19 -0700
Message-ID: <xmqqoamjmjbc.fsf@gitster.dls.corp.google.com>
References: <55336775.2020000@tifr.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Tim Friske <me@tifr.de>
X-From: git-owner@vger.kernel.org Mon Apr 20 07:59:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yk4kH-0007T6-7N
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 07:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754632AbbDTF7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 01:59:25 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52755 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754594AbbDTF7V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 01:59:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 235023F428;
	Mon, 20 Apr 2015 01:59:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oh6zsVh28iSsjYQ23Hx5Lr2v+qo=; b=kcZTlk
	Ara+RXglKBaJC4SnCDu7niI79x6n4J1LrNWIRt4aG3vm5dVV0XNIpMaYHkheoIe+
	KtWHojDrukCz9FuKrAPtvs2grgf9LLp5XeGX1uxQ1uvL6tUvZoV/gEfaurKnmJIT
	D60yHzWTI33VZJIfUbN5SR/Nqc/36Zc3c7a1M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s93CRgbukFLzqFffeMBxNP2v+DP9sDFz
	otWqBRgUlGBDPNG6mWFhAWmxiGTbiBr/YGLUUaH5gs42nlG+LUntx4uH4VfZxkew
	UshL1xU3HlS1NYD54uewuarzQvhaXJQMy1mdut4+pqt4lsGXNPy4VeRqOe2Mbiyi
	B6pkUqg9yH8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BBAE3F427;
	Mon, 20 Apr 2015 01:59:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 973BA3F426;
	Mon, 20 Apr 2015 01:59:20 -0400 (EDT)
In-Reply-To: <55336775.2020000@tifr.de> (Tim Friske's message of "Sun, 19 Apr
	2015 10:29:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 63265F7C-E722-11E4-836C-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267454>

Tim Friske <me@tifr.de> writes:

> I wonder why "git log --author=<pattern>" does not work with the
> "regexp-ignore-case" option and the other regexp-related options
> Wouldn't it be useful to make ...

I think the reason is because nobody bothered to make it so.  That
does not necessarily say what you suggest is not useful, but if it
were so very much useful in the real world, perhaps somebody may
have already been motivated enough to make it so, and the fact that
it has not happened might be an indirect indication of its predicted
usefulness.  I dunno.

In any case, I do not offhand see how it would _hurt_ if we added
such a feature.  The only reason it may hurt existing users would be
that people may depend on the current behaviour, trusting that
exactly spelling --author=Tim option, when using case-ignoring
matching of --grep=<pattern> to find the <pattern> in the log string
filters out the other tim whose name is spelled with lowercase.
Your proposed new world order _will_ break such users.  But I do not
think it is very likely to become a real-world issue.

Of course, if the implementation is done poorly, it _will_ hurt the
overall performance or maintainability and that would make such an
implementation unacceptable, but that is a separate matter---it does
not reject the feature, just a specific poor implementation.

So a patch to do so cleanly with proper tests is very much welcomed.

The same comment applies to your other "wouldn't it be wonderful if
-G<pattern> became case-insensitive with an option?" topic (but as I
already said, -S<string> is *not* -G<string> with --fixed-strings).

Thanks.
