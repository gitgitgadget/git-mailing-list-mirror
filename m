From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/14] Add submodule test harness
Date: Sun, 13 Jul 2014 18:01:59 -0700
Message-ID: <xmqq4myk21o8.fsf@gitster.dls.corp.google.com>
References: <539DD029.4030506@web.de> <53B41D42.2090805@web.de>
	<53B46425.3030000@web.de> <53B4F0AA.10809@web.de>
	<53B5C7AC.4040701@web.de>
	<xmqqsimddrq3.fsf@gitster.dls.corp.google.com>
	<53BAF7AF.4020901@web.de> <53BC47BD.1000705@web.de>
	<53BCDDE2.1080301@web.de> <53BD87B3.8050901@web.de>
	<xmqqmwci9vn1.fsf@gitster.dls.corp.google.com>
	<xmqqsim96ine.fsf@gitster.dls.corp.google.com> <53C17D16.80106@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jul 14 03:02:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6Ueo-0003Zq-4O
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 03:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbaGNBCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2014 21:02:09 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61736 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751509AbaGNBCH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 21:02:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 19A8B27910;
	Sun, 13 Jul 2014 21:01:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l600KiHnk6f1j74xc9WuGbDnn3o=; b=QaVmBW
	VPRjDbTAEaBW1nDEHG1jMPyEXQQfIIlpzBclHcZoi0L6GOmYH0rE1JJKBje6GxLV
	njNTaEBlZAteLyHl+owCRSmZTCXsWDyz3o/J5p5vddTEKpcANMXJn8z50kGAmZCY
	1e/IKmvZjP9l5fvO9hXlVUBAlBc8Yqb+Oev+0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g0cYAWHCYi63qdgwWXwZPHLGFg/VUwd4
	F5cujNulsvdkgA7w+6wRm9JsFMUwoaxIpyD/16ullRDNHV2/LJshxxCu9gyS4UdJ
	iAaLWXGorNQg4rCIe9vnvVIuO/pHOvT3TshfbZJPBI9Qzp3ZZpUw6s1d1CRmzF8k
	YNoqjuy5gms=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0FD9A2790F;
	Sun, 13 Jul 2014 21:01:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9933C2790E;
	Sun, 13 Jul 2014 21:01:43 -0400 (EDT)
In-Reply-To: <53C17D16.80106@web.de> (Jens Lehmann's message of "Sat, 12 Jul
	2014 20:23:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6BE35C26-0AF2-11E4-A116-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253462>

Jens Lehmann <Jens.Lehmann@web.de> writes:

>> Perhaps squashing this to 7e8e5af9 instead?
>
> Yes please, this is much better than my first attempt.

One thing that I found troubling is the ../../../ "three levels up"
is hardcoded.  Would it be always true for any value of "$1"?  If
the submodule is bound to the superproject at sub/dir/, not at dir/,
for example, would it have to change?

I am not saying that we must support artibrary cases, but if there
is such a limitation in the implementation, people who will use the
helper in their new tests want it at least documented, I think.

>>  t/lib-submodule-update.sh | 19 ++++++++++++-------
>>  1 file changed, 12 insertions(+), 7 deletions(-)
>> 
>> diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
>> index e441b98..fc1da84 100755
>> --- a/t/lib-submodule-update.sh
>> +++ b/t/lib-submodule-update.sh
>> @@ -110,18 +110,23 @@ replace_gitfile_with_git_dir () {
>>  }
>>  
>>  # Test that the .git directory in the submodule is unchanged (except for the
>> -# core.worktree setting, which we temporarily restore). Call this function
>> -# before test_submodule_content as the latter might write the index file
>> -# leading to false positive index differences.
>> +# core.worktree setting, which appears only in $GIT_DIR/modules/$1/config).
>> +# Call this function before test_submodule_content as the latter might
>> +# write the index file leading to false positive index differences.
>>  test_git_directory_is_unchanged () {
>>  	(
>> -		cd "$1" &&
>> -		git config core.worktree "../../../$1"
>> +		cd ".git/modules/$1" &&
>> +		# does core.worktree point at the right place?
>> +		test "$(git config core.worktree)" = "../../../$1" &&
>> +		# remove it temporarily before comparing, as
>> +		# "$1/.git/config" lacks it...
>> +		git config --unset core.worktree
>>  	) &&
>>  	diff -r ".git/modules/$1" "$1/.git" &&
>>  	(
>> -		cd "$1" &&
>> -		GIT_WORK_TREE=. git config --unset core.worktree
>> +		# ... and then restore.
>> +		cd ".git/modules/$1" &&
>> +		git config core.worktree "../../../$1"
>>  	)
>>  }
>>  
>> 
