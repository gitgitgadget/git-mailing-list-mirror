From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible bug in git-completion.sh
Date: Fri, 08 Jan 2010 10:21:51 -0800
Message-ID: <7v8wc8jw3k.fsf@alter.siamese.dyndns.org>
References: <4B474C73.8080100@mtu.net>
 <4B4751EA.8060707@drmicha.warpmail.net>
 <20100108162404.GA5799@coredump.intra.peff.net>
 <7vr5q05z74.fsf@alter.siamese.dyndns.org>
 <20100108164132.GA6171@coredump.intra.peff.net>
 <7vskag1r5o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Schewe <jpschewe@mtu.net>, spearce@spearce.org,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 08 19:22:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTJTV-0006MF-0I
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 19:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753304Ab0AHSWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 13:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753123Ab0AHSWK
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 13:22:10 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33540 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646Ab0AHSWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 13:22:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F5358F44F;
	Fri,  8 Jan 2010 13:22:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GnVLRYOxQSeSo3GZuXFwr7hYgK4=; b=wlLj4P
	5Au45qwTjgGzWYmZnWcKGMrvXFzu0E5wi/SCUD9Ie2GCWCa7DyiAU/1qfZdjbM5f
	L4NFaVzCQD66Xp8ozvmr4tDdaKRY3R4ERns8HwPmkHdwAkMkYuOK20+2zX7HMSEw
	4jlPIkfutfLBKI4InbymqSZfPhHyNCbUa8dz4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=llpn30/FMjB0tzZc/+HGIld7p0uxRk9t
	PguLMKjoBtx12wp2Cr1Df90PW5xUPEqpu+vCjNRJzwjw+FgYIEhidxMlo8LurXgG
	Pp1+gGDm2yaAuQAwjq17FgJjGD1Dt1dnm+tgAUuF/h5MZ97Dk43aBw0RHIATIEWh
	Aqym+xbcyo4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AD0E08F448;
	Fri,  8 Jan 2010 13:21:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 822D78F447; Fri,  8 Jan
 2010 13:21:53 -0500 (EST)
In-Reply-To: <7vskag1r5o.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 08 Jan 2010 08\:45\:55 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B5FADB28-FC82-11DE-A9B8-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136462>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> Well, yes, if you wanted to compare apples to apples. But actually, my
>> point in showing "status" at all was to note that Michael's statement
>> that they would be the same is wrong.
>>
>> But just looking at the ls-files output, do you not agree that there is
>> a bug?
>
> If I agreed, I wouldn't have suggested _you_ to cd up and use pathspec,
> but instead would have suggested to patch ls-files to make it do so for
> you.

Nah, I should have checked the code.

The implementation of ls-files does cd up and uses pathspec, so the intent
is to apply higher level gitignore.

It however feeds paths from the already ignored directories, which _is_
the real bug.

For example, if you have

    .gitignore (ignores t/)
    t/
    t/junk

in your work tree, it will read .gitignore at the top level, and
eventually end up feeding "t/junk" to dir.c::excluded_1(), which does:

		for (i = el->nr - 1; 0 <= i; i--) {
			struct exclude *x = el->excludes[i];
			const char *exclude = x->pattern;
			int to_exclude = x->to_exclude;

			if (x->flags & EXC_FLAG_MUSTBEDIR) {
				if (*dtype == DT_UNKNOWN)
					*dtype = get_dtype(NULL, pathname, pathlen);
				if (*dtype != DT_DIR)
					continue;
			}
			...

where *x has "'t/' that must be directory".  but the path "t/junk" does
not match with "t/" and is not excluded by this rule; this part notices
"t/junk" is not a directory, and continues without giving the later part a
chance to intervene.  Of course, the later part also is not prepared to do
a "leading path" match, as the function is not meant to be fed entries
from ignored "t/" directory in the first place.

I think a proper fix should be in dir.c::read_directory() where it calls
read_directory_recursive() without first checking if the directory itself
should be ignored.  read_directory_recursive() itself has a logic to see
if the dirent it found is worth recursing into and a similar logic should
be in the toplevel caller.
