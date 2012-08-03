From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/16] t2104: Don't fail when index version is 5
Date: Fri, 03 Aug 2012 09:12:26 -0700
Message-ID: <7vwr1gar9x.fsf@alter.siamese.dyndns.org>
References: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
 <1343905326-23790-6-git-send-email-t.gummerer@gmail.com>
 <878vdwcrmd.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gummerer <t.gummerer@gmail.com>, <git@vger.kernel.org>,
	<trast@student.ethz.ch>, <mhagger@alum.mit.edu>,
	<pclouds@gmail.com>, <robin.rosenberg@dewire.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 03 18:12:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxKUN-0006ER-PM
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 18:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182Ab2HCQMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 12:12:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38999 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751463Ab2HCQMa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 12:12:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 431356985;
	Fri,  3 Aug 2012 12:12:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qLPn+z2yOEVYHiNhqOgReLnICVk=; b=J+UTVd
	Wx9oMJ/jMKcMJT9YSVm2kI1fPrPC3gY7+6ONO+g/M5Tqor+eLpOnXZZHGc33ObQR
	wVgg1kJz5JN/YGOUsIDw1WKGaLbpc5NnM8hC3OwBxNaR/rxe2lvFacC47bLxrswZ
	fa+qS2l55EFKv/8RqeJDW0FO+FQrpjM/AQWMo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k3AARD7QTcHhxvL5L2Rou5JtNgh5fE4A
	0VQArsWA1WBWXPlPup00RB9Sqo1PN8Upbp8k9AvsliWbH9wFvVAQbrH8V1UpBv92
	yE1FTRwbdARLpqTUGmSMaalu0l7mc+xJEng48M2Hl7QKLWP6XrnvXgg7R8Dlo3xs
	FjKzlMYuBL0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F2826984;
	Fri,  3 Aug 2012 12:12:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 87BB36982; Fri,  3 Aug 2012
 12:12:28 -0400 (EDT)
In-Reply-To: <878vdwcrmd.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Fri, 3 Aug 2012 10:22:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 05869876-DD86-11E1-A27B-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202839>

Thomas Rast <trast@inf.ethz.ch> writes:

> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
>> The test t2104 currently checks if the index version is correctly
>> reduced to 2/increased to 3, when an entry need extended flags,
>> or doesn't use them anymore. Since index-v5 doesn't have extended
>> flags (the extended flags are part of the normal flags), we simply
>> add a check if the index version is 2/3 (whichever is correct for
>> that test) or 5.
>
> Next time we set a new index format as default (which might be when we
> make v4 the default!), we'll have to patch this again.  Wouldn't it make
> more sense to let them depend on a "default index format is v2"
> prerequisite?

My preference is not to change the default index version for now,
and for a test that specifically checks features of a particular
index version, force the index version near the beginning of test
using "update-index --index-version $num".

For t2104, I think forcing the index version to 2 at the beginning
and not worry about v4 or later at all would be the right thing to
do.  That way, we will make sure older versions are still supported
with the new code that is capable of reading and writing newer ones.

>> -test_expect_success 'index is at version 2' '
>> -	test "$(test-index-version < .git/index)" = 2
>> +test_expect_success 'index is at version 2 or version 5' '
>> +	test "$(test-index-version < .git/index)" = 2 ||
>> +	test "$(test-index-version < .git/index)" = 5
>>  '
