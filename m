From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3700 (add): add failing test for add with submodules
Date: Mon, 08 Apr 2013 15:03:41 -0700
Message-ID: <7v8v4svfwi.fsf@alter.siamese.dyndns.org>
References: <CACsJy8BAQUms9sgNh5_VFOx0_9LkobytjDk33VB+U_J-S44o_A@mail.gmail.com>
 <1365416809-4396-1-git-send-email-artagnon@gmail.com>
 <20130408213006.GD9649@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 09 00:03:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPKAG-0002WN-Po
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 00:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935218Ab3DHWDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 18:03:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48773 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934846Ab3DHWDn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 18:03:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 693571473B;
	Mon,  8 Apr 2013 22:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NMI3xXcJsfFmuqK25xmZwLlYqTE=; b=rDBHFl
	V5XJC88Qpes8HHIiIrkQyr1vL5ahj7UhLKE8pSDphnnX7J5IHpF09XppL4suv8/o
	UdLKqy0bFr/XXeloAV4Y4gyVJpTCEI2ZDnhXdVdQdDF6s0EYx8CrXQMwAZM6Shbh
	yCS0ZlOMe13gH2j0xzt8KRqbqNgWfXku6IlJk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XbwOgEe9d8CT0g/Bx+M4yYmmUmBo6A4m
	BvgjyVyqLw//TpoO9/kVPvBSJ+mGhuaawEiYbVTny0crXcA8ju56EQ7qL8fCMHTX
	46MXFkczyD6lCIkjrFX8TE76n4TdZL4y/CEJPasZO2vi+ZThTUM+P4lcQxsbers2
	m79a1WGgGHM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6043914739;
	Mon,  8 Apr 2013 22:03:43 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A0B014735; Mon,  8 Apr
 2013 22:03:42 +0000 (UTC)
In-Reply-To: <20130408213006.GD9649@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 8 Apr 2013 17:30:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2D0D3C9E-A098-11E2-9AB3-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220531>

Jeff King <peff@peff.net> writes:

> On Mon, Apr 08, 2013 at 03:56:49PM +0530, Ramkumar Ramachandra wrote:
>
>> git add currently goes past submodule boundaries.  Document this bug.
>
> It's not just submodules, but we should not recurse into any
> sub-repository. If I have an unrelated Meta/ repository, I should not be
> able to "git add Meta/foo", whether I have used "git submodule" or not.
>
> This topic came about 2 years ago, and I had a quick-and-dirty patch:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/170937/focus=171040
>
> I do not recall anything about the patch at this point (i.e., whether it
> was the right thing), but maybe it is a good starting point for somebody
> to look into it.
>
>> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
>> index 874b3a6..a1ea050 100755
>> --- a/t/t3700-add.sh
>> +++ b/t/t3700-add.sh
>> @@ -310,4 +310,18 @@ test_expect_success 'git add --dry-run --ignore-missing of non-existing file out
>>  	test_i18ncmp expect.err actual.err
>>  '
>>  
>> +test_expect_failure 'git add should not go past submodule boundaries' '
>> +	mkdir submodule_dir &&
>> +	(
>> +		cd submodule_dir &&
>> +		git init &&
>> +		cat >foo <<-\EOF &&
>> +		Some content
>> +		EOF
>> +		git add foo &&
>> +		git commit -a -m "Add foo"
>> +	) &&
>> +	git add submodule_dir/foo
>> +'
>
> That is not actually a submodule, but rather just a repo that happens to
> be inside our working tree. 

I think we should treat it as a submodule-to-be, waiting for the
user to run "git add submodule_dir".

If it is a file in the working tree of an unrelated and separate
repository, it still is wrong to allow it to be added to our
repository, no?

If we had "git add submodule_dir" before the last "git add", as you
pointed out, we should already error out.

> I know the distinction is subtle, but according to the thread I
> linked to above, we may actually treat paths with gitlinked index
> entries separately already (I did not try it, though).
