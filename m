From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Make test "using invalid commit with -C" more strict
Date: Sat, 24 Aug 2013 23:38:17 -0700
Message-ID: <xmqqfvtyl1gm.fsf@gitster.dls.corp.google.com>
References: <1377316906-70338-1-git-send-email-draenog@pld-linux.org>
	<1377316906-70338-2-git-send-email-draenog@pld-linux.org>
	<20130824200128.GB2960@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kacper Kornet <draenog@pld-linux.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 25 08:39:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDTz4-0004eJ-EV
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 08:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756052Ab3HYGiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 02:38:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47568 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756027Ab3HYGiV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 02:38:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C7342F073;
	Sun, 25 Aug 2013 06:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZBYVEMYMFQt4XEh1WUcjcoh7KUQ=; b=mrDYDd
	ERVLCgaPo9miWL3mbszSSlX9daJiDuvTovxYVHPoMqxZmEoXNs2KW2JuNMB5JLv8
	QUEObPI3CNLbddARF9v4FVpt9Wuok8YSOmStcEdMFGDrZyROhzkDqJWZ2ub52ay6
	GLWZBjOMIoRS9BMqiUuv2q+7fM/J/oeZ7t/j0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Eh59vt3jcVnO2B49CkUYY128WxIK4jF5
	QOjt9xJB+EUTfLPEyg7GxqRf+qQTtkOPHJNXUkzuvfkvYpxG7mQ6JvIc/dN1XLkq
	vp5j5rkhuoUQ6zP8df9qyH5vlfUtC0H798eZOdJ2e687j7IQVq6MSjpylwXh/aiO
	XaNcc9xH4Ks=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3334D2F072;
	Sun, 25 Aug 2013 06:38:20 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A6D72F06F;
	Sun, 25 Aug 2013 06:38:19 +0000 (UTC)
In-Reply-To: <20130824200128.GB2960@elie.Belkin> (Jonathan Nieder's message of
	"Sat, 24 Aug 2013 13:01:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EE37BD7A-0D50-11E3-AE42-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232930>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Kacper Kornet wrote:
>
>> In the test 'using invalid commit with -C' git-commit would have failed
>> even if the -C option  had been given the correct commit, as there was
>> nothing to commit.
>
> Good catch.
>
> [...]
>> --- a/t/t7501-commit.sh
>> +++ b/t/t7501-commit.sh
>> @@ -53,7 +53,10 @@ test_expect_success PERL 'can use paths with --interactive' '
>>  '
>>  
>>  test_expect_success 'using invalid commit with -C' '
>> -	test_must_fail git commit -C bogus
>> +	echo bong >file &&
>> +	git add file &&
>> +	test_must_fail git commit -C bogus &&
>> +	git reset
>
> I guess to be pedantic this should say
>
> 	echo bong >file &&
> 	git add file &&
> 	test_when_finished "git reset --hard" &&
> 	test_must_fail git commit -C bogus
>
> to avoid interfering with later tests even when this one fails and
> the && prevents the 'git reset' from being executed.

Makes sense.

Also it would be much simpler to say "git commit --allow-empty".
