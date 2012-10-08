From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/t5400-send-pack: Use POSIX options to cp for
 portability
Date: Mon, 08 Oct 2012 09:55:03 -0700
Message-ID: <7vd30snbtk.fsf@alter.siamese.dyndns.org>
References: <1349683681-18978-1-git-send-email-bdwalton@gmail.com>
 <7vlifgncq8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 18:55:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLGbu-0004eK-Ug
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 18:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145Ab2JHQzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 12:55:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41687 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754043Ab2JHQzH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 12:55:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97CE79B0C;
	Mon,  8 Oct 2012 12:55:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YUFZEhS0jz/P9OdAzMqMdN1M0T0=; b=aGYfno
	7+Dx4IYs0IuBslwccoUcqYGjKEjzbRXBE1XmHpHt7FCQWeNilOfTPrIvZNW3/Vgq
	Joy+z125RfygCxyjHGn+B+F8Y5iCvGi1sbRU04gBj7XRQflV4HHwvGGjyuxEWfuK
	xNQdsrFgTWLusq5S646YoEXr4HM9XgeCLwbzg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qR5NPB29b6l0UeXZOVsxMy1BsPJFe96p
	fU7cv72xW4m3aHLt6tZ8++dOV7u4S/tVPgRQ4ixguCduNf/4lmRuw1m2dMpXK8o+
	vSpZVXpy6Xv8nTfgbb8AtuXUw5yLUYlDkuReyraYt8wwUVog1R+t9UhmLufNgEso
	VASwg6kksYk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86A799B0B;
	Mon,  8 Oct 2012 12:55:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA3719B07; Mon,  8 Oct 2012
 12:55:04 -0400 (EDT)
In-Reply-To: <7vlifgncq8.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 08 Oct 2012 09:35:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8826A04-1168-11E2-B6E4-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207241>

Junio C Hamano <gitster@pobox.com> writes:

> Ben Walton <bdwalton@gmail.com> writes:
>
>> Avoid a GNU-ism in the cp options used by t5400-send-pack.  Change -a
>> to -pR.
>>
>> Signed-off-by: Ben Walton <bdwalton@gmail.com>
>> ---
>
> Thanks, but is "-p" essential for this test to pass, or can we get
> away with just "-R"?

Besides, when you spot a potential problem, please ask "git grep"
to catch them all.

    $ git grep "cp -a" t/
    t/t5400-send-pack.sh:   cp -a parent child &&
    t/t5550-http-fetch.sh:  cp -a .git"$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
    t/t5800-remote-helpers.sh:      cp -a server server2 &&

>>  t/t5400-send-pack.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
>> index 250c720..65b3b0f 100755
>> --- a/t/t5400-send-pack.sh
>> +++ b/t/t5400-send-pack.sh
>> @@ -159,7 +159,7 @@ test_expect_success 'receive-pack runs auto-gc in remote repo' '
>>  	    git commit -a -m "Second commit" &&
>>  	    git repack
>>  	) &&
>> -	cp -a parent child &&
>> +	cp -pR parent child &&
>>  	(
>>  	    # Set the child to auto-pack if more than one pack exists
>>  	    cd child &&
