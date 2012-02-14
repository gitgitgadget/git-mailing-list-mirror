From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] submodules: always use a relative path from
 gitdir to work tree
Date: Tue, 14 Feb 2012 12:34:36 -0800
Message-ID: <7vzkcl5f37.fsf@alter.siamese.dyndns.org>
References: <4F32F252.7050105@web.de> <4F32F465.7090401@web.de>
 <4F338156.9090507@web.de> <7vlio6ec7q.fsf@alter.siamese.dyndns.org>
 <4F3A9B98.6040908@web.de> <7v4nut6u4s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Antony Male <antony.male@gmail.com>,
	Phil Hord <phil.hord@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 14 21:34:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxP5I-0007p9-DK
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 21:34:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760804Ab2BNUek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 15:34:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47689 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757234Ab2BNUej (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 15:34:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A03CA7D9A;
	Tue, 14 Feb 2012 15:34:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u1Uu+ukyw/4eMJoj5GJWjmxWKzA=; b=SPODcS
	HqGIEseo9PadVEIYftFJ5Mvg1WnRZQNWuFGyce5BpYx8rRXVrGE6xG2fAXEQzY8k
	SGiJC6YtFozYAMwtbPpBX5nV3ldWF4olyvkip6th4EfpUzBRRFSofUPsWkl+Pkg6
	MmQpBgKwZ2NPPChkhF847fbrZOFh00ds9w6lU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P8dsBCuKnVNtKsC6VIVFrwwV6+YaiPLr
	i3SAUG8YNoFpsb7hQPNUW9O4DiKuIlINfL0R2/quG8Z4Ye2pG0CzX/kxUNccYYJQ
	E6xCFjXPfmZ5Stz8l3+HANTABVBLoG8cPw+mMAFrxIpEL5w0Ny2X7mEf4rosGdR7
	U5vaYXs2ftw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 970087D99;
	Tue, 14 Feb 2012 15:34:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 722107D95; Tue, 14 Feb 2012
 15:34:37 -0500 (EST)
In-Reply-To: <7v4nut6u4s.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 14 Feb 2012 12:24:19 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 50097826-574B-11E1-B129-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190752>

Junio C Hamano <gitster@pobox.com> writes:

> Jens Lehmann <Jens.Lehmann@web.de> writes:
>
>> After adding a comment, using test instead of [], testing both $a and
>> $b and assigning each variable on it's own line I get the following
>> interdiff. Does that make more sense?
>
> My earlier request for comment was to say
>
> 	# $a is always longer than $b for such and such reasons
>
> to explain why testing $b without testing $a was sufficient.

Heh, after I follow the entire module_clone, $gitdir is defined in earlier
parts of the function to be "$(rev-parse --git-dir)/modules/$path", so it
is clear that it is longer than $path.  Unless "cd $there && pwd" does not
result in a funny situation (such as $something/modules is a symbolic link
to another place that is much closer to the root of the filesystem), that
is.

And in such a case, the prefix part of $a and $b would be different from
the very beginning hopefully.

> It is obvious (at least to me) that the loop continues as long as $a and
> $b begin with the same string before their first '/' and removes that
> common segment from both of them, so I do not think the new comment is
> absolutely necessary, but it would not hurt to have it, especially it is
> short enough and to the point.
>
> Thanks.
>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 3463d6d..ed76ce2 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -172,9 +172,11 @@ module_clone()
>>
>>         a=$(cd "$gitdir" && pwd)
>>         b=$(cd "$path" && pwd)
>> -       while [ "$b" ] && [ "${a%%/*}" = "${b%%/*}" ]
>> +       # Remove all common leading directories
>> +       while test -n "$a" && test -n "$b" && test "${a%%/*}" = "${b%%/*}"
>>         do
>> -               a=${a#*/} b=${b#*/};
>> +               a=${a#*/}
>> +               b=${b#*/}
>>         done
>>         rel=$(echo $a | sed -e 's|[^/]*|..|g')

Perhaps aseert that $a never becomes empty before this line (or set it
explicitly to "." when $a is empty), as otherwise

>>         (clear_local_git_env; cd "$path" && git config core.worktree "$rel/$b")

this will refer to "/$b" from the root?
