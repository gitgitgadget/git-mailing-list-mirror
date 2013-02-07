From: Junio C Hamano <gitster@pobox.com>
Subject: Re: overriding/removing inherited credential.helper, Do not add an
 empty value from config credential.helper
Date: Thu, 07 Feb 2013 10:23:20 -0800
Message-ID: <7vvca47zl3.fsf@alter.siamese.dyndns.org>
References: <CAHtLG6QaHOOYgVFPyOWo44-jTX__cd0dCyu+vs+Uf4_U-HxySw@mail.gmail.com>
 <87pq0cchsz.fsf@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>, git@vger.kernel.org
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 19:23:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3W8W-0000FB-7p
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 19:23:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759222Ab3BGSX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 13:23:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36489 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758690Ab3BGSX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 13:23:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 133DBC186;
	Thu,  7 Feb 2013 13:23:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fRYEuh7Q+WUsZSpOo+9VySjZ6+0=; b=DHI9qv
	zTIj65JramqXObn4sQuZ0qQO+l/6kTWykveQbqpBc42T4bVtMNeAsHAKJgTuKMbP
	nBGZaoW2wYcOVs4PKaJlQAb1ZYHMl0fGvT+isxcpiNvZcg+J4cujjOrjz5wfxiXR
	0TEwshLh/daH+oz/D2Egv4xO0071tiyb7v6Ok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lUJLQSIjzO1CI4TkGqbtUljdBYZ6F9vx
	iQ2MlwYSchmCFwjqkIV6Sf1ubprr8KOVp9YWgV0S0g6GDYHl1UVzhVsibR7tK05b
	K4vpjM4963PKsssq7zO11kIbnGfmGUnGJ995dfKpLuDFrXj9hmAKEli8Hl6YYnge
	khBkzubrmrs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A6D8C181;
	Thu,  7 Feb 2013 13:23:27 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F370C153; Thu,  7 Feb 2013
 13:23:24 -0500 (EST)
In-Reply-To: <87pq0cchsz.fsf@lifelogs.com> (Ted Zlatanov's message of "Thu,
 07 Feb 2013 09:36:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 772772AA-7153-11E2-85E6-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215706>

Ted Zlatanov <tzz@lifelogs.com> writes:

>> Below is current git message when a local config credential.helper has
>> an empty value. Please skip an empty value.
>
>> $ git push --force origin master
>> git: 'credential-' is not a git command. See 'git --help'.
>> Did you mean this?
>>	  credential

Why isn't "do not add empty string, or any random string that ends
up referring to a helper that you do not have" a solution?

>> Total 0 (delta 0), reused 0 (delta 0)
>> To https://user@github.com/user/myrepo.git
>>  + d23aa6a...3405990 master -> master (forced update)
>
> I would like that too (needed it today).  Maybe the empty string (as
> suggested) or "none" could be acceptable.

Whatever you do, I do not think introducing a per-variable hack

	[credential]
        	helper = none ;# or "helper = clear"
                helper = mine ;# this is the only thing I use

like that is a sane way to go.  "Clear everything you saw so far"
would be useful for variables other than "credential.helper";
shouldn't it be done by adding a general syntax to the configuration
file format and teach the configuration parser to clear the
cumulative definitions so far?
