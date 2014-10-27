From: Junio C Hamano <gitster@pobox.com>
Subject: Re: difftool--helper: exit when reading a prompt answer fails
Date: Mon, 27 Oct 2014 10:38:15 -0700
Message-ID: <xmqqa94hfm60.fsf@gitster.dls.corp.google.com>
References: <544CAC30.7000607@kdbg.org> <20141027004148.GB81127@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 18:38:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XioFK-0007IK-R7
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 18:38:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbaJ0RiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2014 13:38:19 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65104 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751081AbaJ0RiS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 13:38:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C3E0818C74;
	Mon, 27 Oct 2014 13:38:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9ABrolRNLJkUCq29+X6DZc/QHCI=; b=P+1EYU
	VgiLjOQwfjM65+Ce9x73Qi3E1nrY7aRQsLEl9PQUlbrAhSWUTjZCqxHZwbREVZdD
	dmmRzY1LLZvxU16WA/ISR4WwPeO8YrD1TBJeU5MEerNO3xSvzm6ZjDgrWKajAfyd
	zwF1mOYFDa4QbIvRMIo0vaWaWpIPTS53tcBH8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BLv9Th9xMFeo17khXYUrqP2lFgNxrShG
	siNoXSjrPlT7HZfH6uwuK6INKv6gC8tbEX89gl5ddC5tudEdwiGqNpByer+XHNgR
	fSUyAbI7hXUCYOHL3dJt+2L94anTl1QWVyEu6kzCWI4WPQjx9YAYU+z0LecIC3Lk
	az5wpRBmwlg=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BA02A18C73;
	Mon, 27 Oct 2014 13:38:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3D79018C72;
	Mon, 27 Oct 2014 13:38:16 -0400 (EDT)
In-Reply-To: <20141027004148.GB81127@gmail.com> (David Aguilar's message of
	"Sun, 26 Oct 2014 17:41:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0871561E-5E00-11E4-8EEB-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

>> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
>> index dc30a51..9cf5dc9 100755
>> --- a/t/t7800-difftool.sh
>> +++ b/t/t7800-difftool.sh
>> @@ -301,6 +301,14 @@ test_expect_success PERL 'say no to the second file' '
>>  	! grep br2 output
>>  '
>>  
>> +test_expect_success PERL 'ending prompt input with EOF' '
>> +	git difftool -x cat branch </dev/null >output &&
>> +	! grep master output &&
>> +	! grep branch output &&
>> +	! grep m2 output &&
>> +	! grep br2 output
>> +'
>
> Should we use "test_must_fail grep ..." instead of "! grep ..." here?

NO.  We do not expect system-supplied "grep" to dump core and
declare it as a test failure.  test_must_fail is for catching an
expected non-zero status exit from git commands, i.e. when we expect
our binary to correctly notice some condition and report that fact
with non-zero exit status, we do not want to mistake the binary
segfaulting as working correctly.
