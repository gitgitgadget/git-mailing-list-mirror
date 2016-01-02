From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1] Fix t3400 on a case insensitive file system
Date: Sat, 02 Jan 2016 11:30:53 -0800
Message-ID: <xmqqziwnpymq.fsf@gitster.mtv.corp.google.com>
References: <56869689.7030604@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, ps@pks.im
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Jan 02 20:31:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aFRtf-0003hK-3y
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jan 2016 20:31:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbcABTbQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Jan 2016 14:31:16 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52529 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751678AbcABTa4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jan 2016 14:30:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D709437B1E;
	Sat,  2 Jan 2016 14:30:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8EKAKNj0+NjQ
	aoJcj7ITt3pgUVo=; b=en+MMPXw/nRQk4EJZoWuFOBTRuDh6qUZ3kefXsbDtrtB
	cLS6L8lm3bquZMkL1XCvLgSvb3wRVHm6vYxXwePegNNdL9qgj6bZ/bLflUkQvqlo
	T19brl1atPJGCs3PzMQN/UlZIKmyTRPX+kLI193KfoIsTFDWPUubGZSG+s2Ic28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=uknRDe
	vaMsEL2fNtNDPFcEJ8XP4w3rMYJgJ5oZ65erTY7UHefAWGiubOWhQWVSfj3rEHkQ
	u93hxDf3BA+X0rV6ckFbLajk4rPH+mAFQMzaPIuhefeW7kFpy0/vZnDpxxNdtj1U
	enE6UsOk0S069xmekGAAC6c3Q5haOC0seH2sw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CD1D937B1D;
	Sat,  2 Jan 2016 14:30:55 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4EA5D37B1B;
	Sat,  2 Jan 2016 14:30:55 -0500 (EST)
In-Reply-To: <56869689.7030604@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Fri, 1 Jan 2016 16:08:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 579EC268-B187-11E5-B883-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283265>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On a case insenstive file system x is the same as X.
> When a file named "X" exist, e.g. ">x && git add x" does not work as =
expected,
> use file name "Y" instead.
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---

It is a right thing to fix this, but do you have to use capital 'Y'
here?

I see both uppercase X and Y are used in the earlier tests in this
script, and it may be that that earlier Y, unlike earlier X, does
not interfere on your case insensitive system right now, but using a
single letter 'Y' smells like a future breakage waiting to happen.
Wouldn't it make more sense to name this a lot more distinctively
and uniquely?

In any case, I think this is only in the topic that has been listed
as "Will discard", so I won't worry about it myself for now--if the
topic will be resurrected in the future, reviewers should keep an
eye to prevent it from adding this bug.

Thanks.


>  t/t3400-rebase.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 5ed4012..2eebd22 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -259,11 +259,11 @@ test_expect_success 'rebase duplicated commit w=
ith
> --keep-empty' '
>  	git reset --hard &&
>  	git checkout master &&
>  -	>x && git add x && git commit x -mx &&
> -	echo x >x && git commit x -mx1 &&
> +	>Y && git add Y && git commit Y -mY &&
> +	echo Y >Y && git commit Y -mY1 &&
>   	git checkout -b duplicated HEAD~ &&
> -	echo x >x && git commit x -mx2 &&
> +	echo Y >Y && git commit Y -mY2 &&
>  	git rebase --keep-empty master
>  '
>  -- 2.6.2.403.g6abe3ff.dirty
