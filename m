From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: enhance gitignore whitelist example
Date: Tue, 05 Apr 2011 14:39:24 -0700
Message-ID: <7v4o6cml83.fsf@alter.siamese.dyndns.org>
References: <1302032214-11438-1-git-send-email-eblake@redhat.com>
 <20110405194005.GA32427@elie> <201104052315.54375.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Eric Blake <eblake@redhat.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Apr 05 23:39:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7DyV-0008Qg-NA
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 23:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927Ab1DEVjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 17:39:42 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59861 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019Ab1DEVjl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 17:39:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 068504B63;
	Tue,  5 Apr 2011 17:41:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FooC3BG3Z0OBBMInObnyWZwbz10=; b=kHmMWl
	bRR+7ycGLptIiTtOP17GYvuZmkK62SFflbtrOvDzj1GRgpxRALnbU45PFprcLGem
	Ev1Za6AGlLl3t/jjOYA9gzKwPZyyVfhAwi6WD6Vlf6DU3RMy24MG7smkPkuy190c
	gK6Ba2X0j/qJp0alVZMxdeSODwuN0lUM1GefU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WYXf7WTw5ObpOJxdFKXHp/UBvAGz1Fba
	JDCDF+Yy3V36mLO7hC2PIST0E1AvscBPAx5BATf32/xQcXNp8iyqhkzFIHs85aMW
	uf3JSLPlmn8/a9zmEnJs1MToIFX/rI6eCaSoqWIersyXiqwNlZmHZUlnFEd+bqkr
	B0c9qb7l2M4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 958A64B62;
	Tue,  5 Apr 2011 17:41:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B4B704B5C; Tue,  5 Apr 2011
 17:41:18 -0400 (EDT)
In-Reply-To: <201104052315.54375.j6t@kdbg.org> (Johannes Sixt's message of
 "Tue, 5 Apr 2011 23:15:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 748F8A3A-5FCD-11E0-A542-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170920>

Johannes Sixt <j6t@kdbg.org> writes:

>> > @@ -87,7 +89,8 @@ PATTERN FORMAT
>> >
>> >   - Otherwise, git treats the pattern as a shell glob suitable
>> >     for consumption by fnmatch(3) with the FNM_PATHNAME flag:
>> > -   wildcards in the pattern will not match a / in the pathname.
>> > +   wildcards in the pattern will not match a / in the pathname,
>> > +   and do not ignore files with a leading . in the pathname.
>
> I don't think this is correct. * matches .gitignore. I tried it.

It is badly phrased to begin with.

It shouldn't say "do not ignore", which is determined by the presense or
the lack of the leading '!' before the pattern.  The pattern either
matches or does not match paths that begin with dot.

I think we pass FNM_PATHNAME but not FNM_PERIOD, so * would match a period
hence ".gitignore".  What Eric wrote may be correct in the sense that "the
pattern matcher does not _ignore_ .gitignore as not matching but catches it
with '*'", but as the result the path ends up getting ignored ;-)

> I propose a paragraph like this in the NOTES section:

I think it makes sense to have something like that, but please state it
like "to do Y, do X and Z" (optionally followed by "with just X, Y won't
happen because..., hence you need to do Z as well"), instead of starting
with "you cannot do Y with only X".

IOW, start from a positive and helpful recipe, and then explain why "you
cannot do Y with only X" after that.

> --- 8< ---
> When a directory is ignored, it is not possible to un-ignore a single file 
> somewhere in the directory using another pattern. E.g., with the patterns
>
> --------------
> /build/
> !/build/tests/results
> --------------
>
> the file "build/tests/results" is still ignored because when a directory is 
> ignored, its contents are never investigated. In a situation where a few 
> exceptions in an otherwise ignored hierarchy are needed, the recommended 
> procedure is to specify to ignore the root of the hierarchy and then to 'git 
> add -f' the exceptional files. Subsequent changes to the files will not be 
> ignored.
> --- 8< ---
