From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Edit a rerere conflict resolution
Date: Mon, 12 Mar 2012 13:34:17 -0700
Message-ID: <7vd38hr22e.fsf@alter.siamese.dyndns.org>
References: <4F5E4B20.5080709@lyx.org>
 <7vobs1r3kn.fsf@alter.siamese.dyndns.org> <4F5E5A77.1070605@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Mon Mar 12 21:34:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Bx5-00041D-8C
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 21:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757255Ab2CLUeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 16:34:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48492 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756383Ab2CLUeV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 16:34:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF0426D9A;
	Mon, 12 Mar 2012 16:34:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xbCB7xqTMW72Z5HZvYH0L0v1oGI=; b=n6bQjR
	1ULdOC5DA3fD6+3K7TW5xIuzvA+COQ+q1j8E7DUxvp7YIi9Par2VhkeFrrgvTKDF
	bAKspy0c8GI52X4aFhocKbTeFQ969etIS5yxWrHQq4Ya+LT+Clnr6laFseabtP2j
	CPLb2be6ShA/s7RD5RT5UWV/6ZIMmUdPxxloY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mSgX+laRt3AS4O5Q7rk+WlE9Wbpl0TEV
	o7c2nMy5DH+8BgAB/5vjtonSBS/d91Jc1+3EfXlGRRK7KQt5aKsmAQhRaRDf92RU
	nNpiiPDO3goYU0i9gf5xQF0dijt6oj4USr5n5u+jMsR1eoTIj5xn4a17EuKnf7rX
	QgvGzPIVO2g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C60686D98;
	Mon, 12 Mar 2012 16:34:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 280286D97; Mon, 12 Mar 2012
 16:34:19 -0400 (EDT)
In-Reply-To: <4F5E5A77.1070605@lyx.org> (Vincent van Ravesteijn's message of
 "Mon, 12 Mar 2012 21:20:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BE47C0EE-6C82-11E1-A95A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192942>

Vincent van Ravesteijn <vfr@lyx.org> writes:

> Op 12-3-2012 21:01, Junio C Hamano schreef:
> ...
>> I haven't find it necessary in practice, as the re-fix for me
>> typically would go like this:
>>
>>      $ git merge other-branch
>>      ... rerere kicks in; eyeball the results
>>      ... ah, my earlier resolution is no longer correct
>>      $ edit $the_path
>>      ... test the result of manual edit in the context of the merged whole
>>      ... and be satisified
>>      $ git rerere forget $the_path
>>      $ git add $the_path
>>      $ git commit
>>      ... rerere records the updated resolution
>>
>> What scenario do you have in mind that you would need to re-fix more
>> resolution than you need?
>
> Context:
> I have a number of topic branches that modify the fileformat version
> and also the fileformat conversion routines. When merging all those
> branches into an integration branch (like you regenerate pu),...
> ...
> But well, if the experts don't feel the need, I will search further to
> implement something that you do think is useful ;).

"It is not useful for experts" is not a reason to reject a feature.
As long as it is useful for general audience, it is OK to have it;
the experts can just choose not to use it.

I have experienced the same "Ah, no longer that earlier resolution
is a good one" or "Oops, that earlier resolution was busted" when
reintegrating 'pu', just like you do in your integration branch, and
the way I illustrated above is only a small part of the larger
workflow.  I run the automated integration the usual way, rewind the
HEAD to the problematic commit, run the above procedure to update
the rerere database, and then re-run the automated integration.

That way, I have a chance to _test_ the updated entry in the rerere
databae in isolation, without the other noise that comes on top of
the problematic merge in 'pu'.

The problem I have with "rerere edit" is it is an offline process,
and to validate that the update is correct, I would have to have the
problematic merge in my working tree once _anyway_.  And at that
point, updating the target file in the working tree and recording
the updated resolution using the usual "git rerere" feels a more
natural way to do so, and more importantly, it is a more convenient
way to do the "update and validate".  On the other hand, "rerere
edit" is a more convenient way to "update but not validate the
result".

So I do not think the distinction is "expert" vs "others".
