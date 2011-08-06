From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-am: ignore leading whitespace before patch
Date: Fri, 05 Aug 2011 22:00:16 -0700
Message-ID: <7vvcub16e7.fsf@alter.siamese.dyndns.org>
References: <1312323646-93427-1-git-send-email-davidbarr@google.com>
 <CALUzUxpn-vCWpTQyB7z9dsu8a+UBL9MPjEycOfTmyws5ndz5kA@mail.gmail.com>
 <CAFfmPPMY5FP8NbZ5Q15pW-NC_qs=i6FY7v6Pi8jkMAhkURFTmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Sat Aug 06 07:00:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpZ02-0000MV-IA
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 07:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925Ab1HFFAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 01:00:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33979 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750835Ab1HFFAd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 01:00:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11D7E5C8D;
	Sat,  6 Aug 2011 01:00:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+t+U2qUUCi8Qz+yx97oIuteMq1o=; b=Kmskgn
	CgKUty+tSyghZTwankIik2ZZ7MmL1+tbwreORcm3h9HBQKRzmztsG/q2HIGhJhkV
	4r0kDoiYVq4GyxE82d1znaxrMdU2YVGBZ+INc/4Kw7KKSE6+v2U4PSvj8XWVZobk
	M2+b9bIVuw/sdWil0I7GJy8QqE55eRLApf5A0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CxjgxAJIoGMGwYL3QSoFC5tVwLcq7mzz
	vZE5a+XxHr+wVI+iP/2hK/DKLYJpVQmie7vQ4P99oVlCRKrskSHpMZgMq258tpLy
	ir6ndRbS/R+WhWtvuUfXAou1WJgTyniWidlptZzCDx4uen5YLGn7ZkgTzFIE2uln
	nW3Z1z1LaWU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 019835C8A;
	Sat,  6 Aug 2011 01:00:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A9D9D5C7E; Sat,  6 Aug 2011
 01:00:17 -0400 (EDT)
In-Reply-To: <CAFfmPPMY5FP8NbZ5Q15pW-NC_qs=i6FY7v6Pi8jkMAhkURFTmQ@mail.gmail.com> (David
 Barr's message of "Sat, 6 Aug 2011 11:56:53 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA8118B8-BFE8-11E0-BCE8-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178826>

David Barr <davidbarr@google.com> writes:

> Hi Jonathan,
> ...
>>> diff --git a/git-am.sh b/git-am.sh
>>> index 463c741..19b2f0f 100755
>>> --- a/git-am.sh
>>> +++ b/git-am.sh
>>> @@ -199,7 +199,11 @@ check_patch_format () {
>>>        # otherwise, check the first few lines of the first patch to try
>>>        # to detect its format
>>>        {
>>> -               read l1
>>> +               # Start from first line containing non-whitespace
>>> +               until [ -n "$l1" ]
>>> +               do
>>> +                       read l1
>>> +               done
> ...
> Do you see any subtle issues in this tiny patch?
> I failed to include a test, I'll add at least one to the next version.
> I did check that it doesn't break any of the existing git-am tests.

It no longer checks "the first few lines" but can read a lot more, so the
comment that precedes this block is now invalid.

Also we are rather old fashioned and we never say "until [ ... ]" anywhere
in our shell scripts.

	$ git grep -e until -- '*.sh'

Personally to me this is a borderline "Meh", in the sense that I wouldn't
bother to waste too much effort rejecting it, as I do not see downsides
other than these minor points.

Thanks.
