From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/9] git p4 test: simplify quoting involving
 TRASH_DIRECTORY
Date: Tue, 26 Jun 2012 09:26:53 -0700
Message-ID: <7vk3yuca42.fsf@alter.siamese.dyndns.org>
References: <1340673505-10551-1-git-send-email-pw@padd.com>
 <1340673505-10551-4-git-send-email-pw@padd.com>
 <4FE95586.8090803@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jun 26 18:27:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjYbh-0000uT-3s
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 18:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758436Ab2FZQ1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 12:27:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38420 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757161Ab2FZQ1H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 12:27:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9D709B78;
	Tue, 26 Jun 2012 12:27:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0z/JLKT2/pEn8Kq6jzhJfBZtnXM=; b=ooVx/Q
	TyrLXMnoeHO4P85Hf/fC8Y32kpzoUgUkPCosI5FtV7E2O7unqERRnZH8S8tFpPHW
	UM5xo2zN1sUwb0I48WnvaXKL/vlNB9KFZWiWl5OAp73aPUXq6rlAzg5WITRyBpnz
	JnnztL1Rj8CoOpxmWp3A45gycXbf7tdR/NX58=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZAAjjDuejMqijV43kS00S2bBjhLGMOPh
	O8vXyeTyZarSqT8Tm/KUONY5z4V3oV/L7JdKN0cS+eoa0VjDSPyom69jbSttB1hh
	akswjvWpUYO0ZCfChzfjhCx8YYk9F8OcZ0NDOIpEBRhm0NBr2LtFGUPva/Cfrjpj
	nCuCMkaHtVc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A09659B77;
	Tue, 26 Jun 2012 12:27:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 26F929B57; Tue, 26 Jun 2012
 12:26:54 -0400 (EDT)
In-Reply-To: <4FE95586.8090803@viscovery.net> (Johannes Sixt's message of
 "Tue, 26 Jun 2012 08:24:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BE59F35A-BFAB-11E1-9864-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200660>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 6/26/2012 3:18, schrieb Pete Wyckoff:
>>  test_expect_success 'exit when p4 fails to produce marshaled output' '
>> -	badp4dir="$TRASH_DIRECTORY/badp4dir" &&
>> -	mkdir "$badp4dir" &&
>> -	test_when_finished "rm \"$badp4dir/p4\" && rmdir \"$badp4dir\"" &&
>> -	cat >"$badp4dir"/p4 <<-EOF &&
>> +	mkdir badp4dir &&
>> +	test_when_finished "rm badp4dir/p4 && rmdir badp4dir" &&
>> +	cat >badp4dir/p4 <<-EOF &&
>>  	#!$SHELL_PATH
>>  	exit 1
>>  	EOF
>> -	chmod 755 "$badp4dir"/p4 &&
>> -	PATH="$badp4dir:$PATH" git p4 clone --dest="$git" //depot >errs 2>&1 ; retval=$? &&
>> +	chmod 755 badp4dir/p4 &&
>> +	PATH="$TRASH_DIRECTORY/badp4dir:$PATH" git p4 clone --dest="$git" //depot >errs 2>&1 ; retval=$? &&
>>  	test $retval -eq 1 &&
>
> The long line here is severly broken, because the semicolon breaks the &&
> chain; retval would be assigned to even if one of the earlier commands
> fails, and that you don't want to treat as success. The least that is
> needed is to put the line in braces. But I suggest to rewrite the two
> lines above as
>
> 	(
> 		PATH="$TRASH_DIRECTORY/badp4dir:$PATH" &&
> 		export PATH &&
> 		test_expect_code 1 git p4 clone --dest="$git" //depot >errs 2>&1
> 	) &&
>
>>  	test_must_fail grep -q Traceback errs
>
> We don't expect that grep fails due to segfault or something. Write this
> line as
>
> 	! grep Traceback errs
>
> Also drop the -q; if the test detects a failure, you do want to see the
> grep output in a verbose test run.

All true.  Thanks for carefully reading.
