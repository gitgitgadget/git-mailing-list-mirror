From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 4/5] setup: Add 'abspath_part_inside_repo' function
Date: Tue, 04 Feb 2014 10:09:38 -0800
Message-ID: <xmqqlhxqagwt.fsf@gitster.dls.corp.google.com>
References: <1391306351-13237-1-git-send-email-martinerikwerner@gmail.com>
	<1391358940-17373-1-git-send-email-martinerikwerner@gmail.com>
	<1391358940-17373-5-git-send-email-martinerikwerner@gmail.com>
	<xmqq1tzjewsf.fsf@gitster.dls.corp.google.com>
	<20140203231659.GC15607@mule>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, richih@debian.org, tboegi@web.de,
	pclouds@gmail.com, dak@gnu.org
To: Martin Erik Werner <martinerikwerner@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 04 19:09:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAkRX-0001fn-5r
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 19:09:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867AbaBDSJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 13:09:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63390 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753100AbaBDSJn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 13:09:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F39D867A50;
	Tue,  4 Feb 2014 13:09:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HB1K4eWx94FeqXxhnGMFteoVTCo=; b=XGm9d3
	FuX+3su0p/juh+5rKHqDkfm5aGDvdZnBen1tmFkeBY+CcoFXsrOLlg+3j3aj1EBe
	BPhOWYf8x4UFgoItnFF07cqWWMglREY7N0GlIikKIVznJCEDQNKGiU0ua2PrdU9H
	5wztJnCIQZ6GAdIxrUUApAd6ssEw8pkK+y87I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LPyFMHIY9WkEFQ6doTg0S8YhaSFC18CJ
	zdlHvD+/k8IamY/LoSFFltJqttyYl2c1crY914wMwlFXW632tSdk0ZOWDKeVlCmg
	QCPxFlNX6bO9KNWuZNbTc53NmXBLWGF71XiZ1yaGwCD0/NcQolQc9nipFJl4NFHa
	Q/0sC1x7UJs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E14D267A4F;
	Tue,  4 Feb 2014 13:09:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 123B167A4E;
	Tue,  4 Feb 2014 13:09:42 -0500 (EST)
In-Reply-To: <20140203231659.GC15607@mule> (Martin Erik Werner's message of
	"Tue, 4 Feb 2014 00:16:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 850E0BC2-8DC7-11E3-A93D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241533>

Martin Erik Werner <martinerikwerner@gmail.com> writes:

> Will you add that test or should I place it in the series with you as
> author?

Either is fine.  Thanks.

> On Mon, Feb 03, 2014 at 01:00:48PM -0800, Junio C Hamano wrote:
>> Martin Erik Werner <martinerikwerner@gmail.com> writes:
>> 
>> > The path being exactly equal to the work tree is handled separately,
>> > since then there is no directory separator between the work tree and
>> > in-repo part.
>> 
>> What is an "in-repo part"?  Whatever it is, I am not sure if I
>> follow that logic.  After the while (*path) loop checks each level,
>> you check the whole path---wouldn't that code handle that special
>> case already?
>
> Given "/dir1/repo/dir2/file" I've used 'in-repo' to refer to
> "dir2/file", sometimes interchangably with "part inside the work tree"
> which might be better terminology, and should replace it?

Yes, "inside the working tree" is much clearer than "inside repo",
because the word "repository" often is used to mean only the stuff
inside $GIT_DIR, i.e. what controls the working tree files.

> I was trying to convey that if path is simply "/dir/repo", then the while
> loop method of replacing a '/' and checking from the beginning won't
> work for the last level, since it has no terminating '/' to replace, so
> hence it's a special case, mentioning the "part inside the work tree"
> is arguably confusing in that case, since there isn't really one, maybe
> it should be left out completely, since the "check each level"
> explanation covers it already?

I dunno about the explanation, but it still looks strange to have
the special case to deal with "/dir/repo" before you enter the while
loop, and then also have code immediately after the loop that seems
to handle the same case.  Isn't the latter one redundant?

>> Because it is probably the normal case not to have any symbolic link
>> in the leading part (hence not having to dereference them), I think
>> checking "is work_tree[] a prefix of path[]" early is justified from
>> performance point of view, though.
>> 
>> >  /*
>> > + * No checking if the path is in fact an absolute path is done, and it must
>> > + * already be normalized.
>> 
>> This is not quite parsable to me.
> Hmm, what about
> 	The input parameter must contain an absolute path, and it must
> 	already be normalized.

OK.

>> > +	const char* work_tree = get_git_work_tree();
>> > +	if (!work_tree)
>> > +		return -1;
>> > +	wtlen = strlen(work_tree);
>> > +	len = strlen(path);
>> 
>> I expect that this is called from a callsite that _knows_ how long
>> path[] is.  Shouldn't len be a parameter to this function instead?
>
> Currently, it actually doesn't, since 'normalize_path_copy_len' is
> called on it prior, which can mess with the string length.

OK, strlen() here is perfectly fine, then.

>> Hmph....  How do our callers treat an empty path?  In other words,
>> should these three be equivalent?
>> 
>> 	cd /a && git ls-files /a
>> 	cd /a && git ls-files ""
>> 	cd /a && git ls-files .
>
> Here I have only gone by the assumption that previous code did the right
> thing,...

Good to know.  And the answer to the above question I think is yes,
these should be equivalent.

Thanks.
