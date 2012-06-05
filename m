From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 3/4] submodule: fix sync handling of some relative
 superproject origin URLs
Date: Tue, 05 Jun 2012 15:49:28 -0700
Message-ID: <7v7gvlnzlz.fsf@alter.siamese.dyndns.org>
References: <1338716810-9881-1-git-send-email-jon.seymour@gmail.com>
 <1338716810-9881-4-git-send-email-jon.seymour@gmail.com>
 <4FCE77AA.6060005@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org,
	phil.hord@gmail.com, ramsay@ramsay1.demon.co.uk, j6t@kdbg.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 06 00:49:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sc2ZF-00087M-CW
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 00:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163Ab2FEWtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 18:49:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64551 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750764Ab2FEWtb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 18:49:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E33089AD;
	Tue,  5 Jun 2012 18:49:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P7WnpVjv9HO7y2lH/eFc6ySCQCQ=; b=UTW4Va
	ZJniSl9c1Sf++NHV4Hg/vmkDp1YvPJrg5UTz5klhe+/fhXBAQ26i6zQPtsvN+FKn
	FNv3wFDdpBuOpCXzzLkJsfFSItKTv6Cnr9eD5j4boU9OwpuQwgU814ubuN6FwsRi
	cvSi86tyql3qFWmkaG9C+qM72EboBZ5a0oHxs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GG/iVnOFN25jpphGo+cajywl+gs5mCjX
	Ix0sBiCOg8ZeDh0VDWSzUwmvRxq8OPgmO9WQuRUZoDn7moYsvtrgJ++X7pdEU+Vd
	qUApajfT0f5f6Tk9o3OiPvLibMuo96sDonjs34ktmrZ5hB/34iKg5Tw9oI0yYgeZ
	7iDpDo7Fgw0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 051A989AB;
	Tue,  5 Jun 2012 18:49:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C81189AA; Tue,  5 Jun 2012
 18:49:30 -0400 (EDT)
In-Reply-To: <4FCE77AA.6060005@web.de> (Jens Lehmann's message of "Tue, 05
 Jun 2012 23:18:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B60DC56A-AF60-11E1-9E32-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199296>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 03.06.2012 11:46, schrieb Jon Seymour:
>> @@ -959,19 +985,32 @@ cmd_sync()
>>  	while read mode sha1 stage sm_path
>>  	do
>>  		name=$(module_name "$sm_path")
>> -		url=$(git config -f .gitmodules --get submodule."$name".url)
>> +		# path from superproject origin repo to submodule origin repo
>
> This comment is misleading as it only describes part of the truth, in a lot
> of cases it'll just be an absolute URL of the submodule.
>
>> +		module_url=$(git config -f .gitmodules --get submodule."$name".url)
>
> And I see no real value of renaming "url" to "module_url" here (but maybe
> that is just me).

I tend to agree; there is no other kind of URL involved, and I do
not see a clear motivation behind this renaming.  Renaming url to
module_url would not help much if it is to differenciate URLs to the
repositories of submodule and superproject, so that can't be it.

In any case, I suspect that you would be involved in maintaining
this code in the long haul, so even if it were "just you", your
opinion counts.

> So I'd vote for dropping that comment and the "url" to "module_url" change.
> But apart from that and the issues Junio mentioned in his response this
> series is looking good to me.

Thanks for looking this over.
