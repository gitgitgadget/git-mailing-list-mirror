From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-remote rename should match whole string when
 renaming remote ref directory
Date: Mon, 26 Sep 2011 23:07:03 -0700
Message-ID: <7voby6y0vs.fsf@alter.siamese.dyndns.org>
References: <1317045186-25206-1-git-send-email-benny@tonian.com>
 <7v62kf41ud.fsf@alter.siamese.dyndns.org> <4E8138B3.9090909@tonian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Benny Halevy <bhalevy@tonian.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 08:07:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8Qp3-0004uP-JE
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 08:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810Ab1I0GHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 02:07:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32904 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752772Ab1I0GHK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 02:07:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81AA531D7;
	Tue, 27 Sep 2011 02:07:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eyV+UR/+NXLgMlJVajLxNtqDO1I=; b=ZgAsBU
	iCcnxBUM4qbsHnneqLWcprsZq9biukfGmX7O4u/yxAUcaNxiGNPsZVxX4wF0qdsZ
	nf56qAncw/7i+/vq6hlylKHrVuZH2LECm48R+V39sGLYPivnI+Tx16FZKDuyiojZ
	qJSVULYJcxmIv23HngkU77JtY10webqv+XgLk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GkUHJWFMrLq0Errf6D9mM2iT06Ok5cUs
	p1pG/rybWTieGG5dgfIGuuk7z8iVXuf0ehRxE9ZKYiz052dkbOsNpBSIcJ6322w/
	f3cXtBY0u9n9POTOKTe32tO9phmS8YIuPFIdKBmLQtlwK23FbbPS8N/VzfGN1uro
	JJ4N8rMvx7s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7967631D6;
	Tue, 27 Sep 2011 02:07:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E75EF31D5; Tue, 27 Sep 2011
 02:07:04 -0400 (EDT)
In-Reply-To: <4E8138B3.9090909@tonian.com> (Benny Halevy's message of "Tue,
 27 Sep 2011 05:45:07 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EC7C3F18-E8CE-11E0-A83B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182213>

Benny Halevy <bhalevy@tonian.com> writes:

> On 2011-09-26 21:04, Junio C Hamano wrote:
>> Benny Halevy <benny@tonian.com> writes:
>> ...
>>> -	if (!prefixcmp(refname, buf.buf)) {
>>> +	if (!strcmp(refname, buf.buf)) {
>> 
>> At this point of the code, refname has "refs/remotes/test/foo" and it is
>> queued to later rename it to "refs/remotes/test-/foo" (the next invocation
>> of this function will see "refs/remotes/test/bar" in refname). And the
>> strbuf buf.buf has "refs/remotes/test"; your !strcmp(refname, buf.buf)
>> would never trigger, I suspect.
>> 
>> Isn't 60e5eee (remote: "rename o foo" should not rename ref "origin/bar",
>> 2011-09-01) the correct fix for this issue?...
>
> OK, 60e5eee solves the problem too.

Hmm, what do you mean by "too" here?  Martin's patch fixes the issue, but
does yours, too?

> FWIW, here's the test I used:
> ...
> cd main || fail cd main failed
> for i in test test-2; do
> 	$git remote add $i file://$cwd/$i || fail git remote add $i failed
> done
> $git remote update || fail git remote update fail
> $git remote rename test test-
> $git show test-2/master || fail FAILED
> echo PASSED

Before your last "echo PASSED", add this line:

	$git show test-/master || fail FAILED

and see what happens with your patch.

It is unfortunately a rather common trap to fall into, so I wouldn't blame
you too much. People tend to concentrate only on an aspect of the problem
that originally motivated them, and forget about the other issues that are
equally important, if not more. In this case, you were too thrilled to see
that your updated code no longer renames "test-2" mistakenly to "test--2",
and you forgot that the primary task of the resulting code was to rename
"test" to "test-" correctly. The additional line I gave you above is to
test that.

When testing your own code, make it a habit to _always_ test both sides of
the coin. It is somewhat difficult until you get used to it [*1*], but it
is a skill that is really worth acquiring.

Thanks.


[Footnote]

*1* ...and I do not claim that I myself never forget to fully enumerate
other sides; even experienced people still overlook and embarrass
themselves in public ;-)
