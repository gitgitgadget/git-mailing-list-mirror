From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git pull doesn't get the tags
Date: Fri, 22 Oct 2010 15:25:52 -0700
Message-ID: <7vy69pkgpb.fsf@alter.siamese.dyndns.org>
References: <20101022053747.a5427cad.coolzone@it.dk>
 <4CC153A0.7080605@debugon.org> <20101022142308.f275aefe.coolzone@it.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rico Secada <coolzone@it.dk>
X-From: git-owner@vger.kernel.org Sat Oct 23 00:26:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9Q3u-0005Mq-2x
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 00:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736Ab0JVW0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 18:26:04 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53255 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078Ab0JVW0B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 18:26:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F6C2E0473;
	Fri, 22 Oct 2010 18:25:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nlb0LqWpKO6haLKwNsy1F/LiO9M=; b=dRTRBp
	OHE5/d1kyPu1vasbqX3XTyMqkGdMva5L8ll3RSInH7b8stFNBx1yaXCX2rAWNAjc
	3ZhleJ7HOghU91Fpffq1SuCuSaVNl9yRPH5U8gOWGNwrSK3A4rsvhrD3on5RO35N
	kEYXJNLgH+uNkpiZT8qACabse0wfbPhQics94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fd6xem+wYn+Xz8dpoy6BT0ouEA3lmwmY
	qxaTJ8etk/22aAC05O6YyEovoHsRb1+I1GXEEM8m0dO+V2bBhirbW0a1AcvmvDZd
	9JGzxJgntlBckyhz7CEVrtVuxv75Q69DY7lHSO3vRQkHH3TCaVHeWuzyv2WaWNEg
	ZPM2jK+s1oc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AEB0E0472;
	Fri, 22 Oct 2010 18:25:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 506DCE0471; Fri, 22 Oct
 2010 18:25:54 -0400 (EDT)
In-Reply-To: <20101022142308.f275aefe.coolzone@it.dk> (Rico Secada's message
 of "Fri\, 22 Oct 2010 14\:23\:08 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 571C3B2A-DE2B-11DF-8520-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159759>

Rico Secada <coolzone@it.dk> writes:

> On Fri, 22 Oct 2010 11:04:32 +0200
> Mathias Lafeldt <misfire@debugon.org> wrote:
>
>> From git-pull's manpage:
>> 
>> -t
>> --tags
>>         Most of the tags are fetched automatically as branch
>>         heads are downloaded, but tags that do not point at
>>         objects reachable from the branch heads that are being
>>         tracked will not be fetched by this mechanism.  This
>>         flag lets all tags and their associated objects be
>>         downloaded. [...]

[jc: please do not top post, because people tend to read from top to
bottom not the other way around]

> I managed to overlook the info from the man page, sorry.
>
> But what does "but tags that do not point at objects reachable from the
> branch heads that are being tracked will not be fetched by this
> mechanism" mean?

The above passage in the manual page may be stated rather poorly.

When "git fetch" is run, unless told otherwise by an explicit --no-tags,
it automatically fetches tags that point at new commits on branches you
fetch.  For example, I just tagged v1.7.3.2 last night, so if you fetch
from me to get 'maint', 'master' or other integration branches of mine
that includes 8a90438 (Git 1.7.3.2, 2010-10-21), "git fetch" would also
copy v1.7.3.2 tag from me to your repository.

In the above example, 'maint', 'master', etc. are the branch heads that
are being tracked (i.e. you will copy them to the refs/remotes/origin
hierarchy in your repository) and v1.7.3.2 is a tag that does point at an
object 8a90438 reachable from these branch heads.  So you will get the tag
without giving the --tags option from the command line.

If you were fetching only 'html' or 'man' branches from me, on the other
hand, you would not have gotten v1.7.3.2 tag, as they are separate
histories and that particular tag does not live in their ancestry.

Also tags that point at non-commits (e.g. in git.git, junio-gpg-pub and
spearce-gpg-pub are pointing at blob objects, and v2.6.11 and v2.6.11-tree
tags in the kernel repository are pointing at tree objects) will not be
fetched automatically either.  You would need to explicitly ask for them
if you want them by either (1) find them via ls-remote and name them on
the command line, or (2) use --tags option
