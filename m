From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] cache-tree: Create/update cache-tree on checkout
Date: Tue, 01 Jul 2014 14:03:22 -0700
Message-ID: <xmqq4mz0x04l.fsf@gitster.dls.corp.google.com>
References: <1404173597-24713-1-git-send-email-dturner@twitter.com>
	<53B23605.40705@web.de> <1404242126.6112.7.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 23:03:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X25DC-0000EE-Ut
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 23:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbaGAVDa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jul 2014 17:03:30 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63345 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676AbaGAVDa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jul 2014 17:03:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D5B0825DFF;
	Tue,  1 Jul 2014 17:03:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2QivlVjkU7Sr
	3JfOuiWZ3Szedys=; b=OCQ9lHRD/ByzVFR3NVRRa8KYwv5WJinUmciy5PWPv4Nw
	hXe+2L6RqUGSaOCg113MQuqyMtnX5vKSLvN2qkeR8o0ZmER0qReE1fx+SA8aRFYI
	lhcMZFUbzgIBQj3Z2H6orKeMVGLD6teGRtrk1SyxzhMF/glBQwZEJqSiH6p93g8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=G4/jmy
	/GyfPHjnpbVFGzEAaV0LOggmcu5+f20Wn1OFxw14Zbh2RGHcWT7FD6mVvJqvw+h0
	pcTB8pw3SVH3QcCNS5qSO/QSY7ehQPSDt/XkI7D9ae0HcdDmDmiwX2zGje6Ko5Z/
	hB3X7Be5W1Ru+y2BGjm222QO4e1PhtkXUxly0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CC35B25DFE;
	Tue,  1 Jul 2014 17:03:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D33E125DFA;
	Tue,  1 Jul 2014 17:03:13 -0400 (EDT)
In-Reply-To: <1404242126.6112.7.camel@stross> (David Turner's message of "Tue,
	01 Jul 2014 12:15:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1DA6DA9E-0163-11E4-969D-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252742>

David Turner <dturner@twopensource.com> writes:

> On Tue, 2014-07-01 at 06:16 +0200, Torsten B=C3=B6gershausen wrote:
>> diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
>> index 6c33e28..7c60675 100755
>> --- a/t/t0090-cache-tree.sh
>> +++ b/t/t0090-cache-tree.sh
>> @@ -85,9 +85,22 @@ test_expect_success 'reset --hard without index g=
ives cache-tree' '
>>   	test_shallow_cache_tree
>>   '
>>  =20
>> -test_expect_failure 'checkout gives cache-tree' '
>> +test_expect_success 'checkout gives cache-tree' '
>> +	git tag current
>>   	git checkout HEAD^ &&
>>   	test_shallow_cache_tree
>>=20
>> The && chainis broken here.
>> Does the test now pass, because "git tag" is added ?
>
> The tag does not cause the cache-tree to be created, so git tag does =
not
> cause the test to pass.

That does not explain why it is a good idea to declare success of
this test if this new "git tag current" fails here for whatever
reason (e.g. somebody updated "git tag" for a reason that is
completely unrelated to cache-tree and made it segfault without
creating the "current" tag).
