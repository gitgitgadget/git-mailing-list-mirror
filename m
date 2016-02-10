From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool: reorder vim/gvim buffers in three-way diffs
Date: Wed, 10 Feb 2016 09:45:51 -0800
Message-ID: <xmqqlh6szcfk.fsf@gitster.mtv.corp.google.com>
References: <1454033894-49954-1-git-send-email-dicksonwong@gmail.com>
	<xmqq1t90jkcr.fsf@gitster.mtv.corp.google.com>
	<xmqqr3gl1pyw.fsf@gitster.mtv.corp.google.com>
	<56BB4BDF.3010407@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Dickson Wong <dicksonwong@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Feb 10 18:46:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTYq0-0007oI-Pn
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 18:46:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383AbcBJRp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 12:45:56 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50293 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752274AbcBJRpy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 12:45:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 443CF439CA;
	Wed, 10 Feb 2016 12:45:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q94CtQPhOWich5b3qIX5nrAb9eM=; b=PHHazV
	zr2NtoE+/iyGe0qgeemAxocpPIXtYZMs1P1+Z1pkdwLZep8FVmKAOkQTvIuptped
	mHxc5oL1AaHtHPxwpuFZROT1XV0KS3BIiVYLTv4NkiFMbEDGnvoCja6TtYNMC+7t
	Xhz3SM5CtKDZbhRjCOgJ1kabjx2TljpWblD3M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K9oBivSzz5v/Llw4lWMek6TNCsgrCeav
	wJgLM1lBZmXJerTAKCtOzIO/vMq+zY+WDJHmIEUyQBqL5kqxw2M2zg+KnAJxDBzh
	gR/yoiVYdbVwAqUwLICEWfakVGmCQNkp4PtUeANjwwUkr5s+br87cL0UKh/+k+2K
	hUILLYNt5r8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3C56F439C9;
	Wed, 10 Feb 2016 12:45:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AFF38439C8;
	Wed, 10 Feb 2016 12:45:52 -0500 (EST)
In-Reply-To: <56BB4BDF.3010407@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Wed, 10 Feb 2016 15:40:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2115BE6C-D01E-11E5-8F34-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285918>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> Second call for help.  Any comments on this from anybody other than
>> the author that I missed to support this change?
>
> OK, applied it (on top of next), looks sane and improves the situation
> for the majority of people who read left to right, then top down and
> assign buffers 1 2 3 4 "mentally" to local base remote merge windows
> based on that. Their expectation is met now. Thanks!

Thanks.

Does this mean that I should warn in the release notes that some
existing users might get their expectation broken but we are going
ahead anyway because we think most people read left to right and
then top down?  I am OK with saying that--I just wanted to make sure
we know that it is what we are doing.

> (Also, the other vim variants don't need a corresponding change.)

A stupid question while I am here.  What are these different
variants?  When reviewing this patch for the first time I tried to
find where they are documented, but didn't spot anything.

I can see from the code that vimdiff2 variant does not do anything
special when it is doing a 3-way merge, but vimdiff3 variant does
behave differently when it has $BASE.  It does not need a change
like this because it already arranges and numbers the windows
sensibly (in other words, we can label this patch as aligning the
behaviour of vimdiff to that of vimdiff3)?

Thanks.

> Michael
>
>>>
>>>>  mergetools/vimdiff | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/mergetools/vimdiff b/mergetools/vimdiff
>>>> index 1ddfbfc..74ea6d5 100644
>>>> --- a/mergetools/vimdiff
>>>> +++ b/mergetools/vimdiff
>>>> @@ -2,22 +2,22 @@ diff_cmd () {
>>>>  	"$merge_tool_path" -R -f -d \
>>>>  		-c 'wincmd l' -c 'cd $GIT_PREFIX' "$LOCAL" "$REMOTE"
>>>>  }
>>>>  
>>>>  merge_cmd () {
>>>>  	touch "$BACKUP"
>>>>  	case "$1" in
>>>>  	gvimdiff|vimdiff)
>>>>  		if $base_present
>>>>  		then
>>>> -			"$merge_tool_path" -f -d -c 'wincmd J' \
>>>> -				"$MERGED" "$LOCAL" "$BASE" "$REMOTE"
>>>> +			"$merge_tool_path" -f -d -c '4wincmd w | wincmd J' \
>>>> +				"$LOCAL" "$BASE" "$REMOTE" "$MERGED"
>>>>  		else
>>>>  			"$merge_tool_path" -f -d -c 'wincmd l' \
>>>>  				"$LOCAL" "$MERGED" "$REMOTE"
>>>>  		fi
>>>>  		;;
>>>>  	gvimdiff2|vimdiff2)
>>>>  		"$merge_tool_path" -f -d -c 'wincmd l' \
>>>>  			"$LOCAL" "$MERGED" "$REMOTE"
>>>>  		;;
>>>>  	gvimdiff3|vimdiff3)
