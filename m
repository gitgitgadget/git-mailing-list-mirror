From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 3/3] Documentation: replace: add --graft option
Date: Fri, 23 May 2014 11:26:43 -0700
Message-ID: <xmqqioowjqqk.fsf@gitster.dls.corp.google.com>
References: <20140522211836.27162.80311.chriscool@tuxfamily.org>
	<20140522213307.27162.3251.chriscool@tuxfamily.org>
	<537F8021.8080304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 23 20:26:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnuBB-00048a-C7
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 20:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbaEWS0t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 May 2014 14:26:49 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56991 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751153AbaEWS0s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 May 2014 14:26:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3CAC8180D4;
	Fri, 23 May 2014 14:26:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=MBW0qGY7mEPq
	2WnkliAT2RQUbvU=; b=vGsB0dahCDTYxz+o5WoKJM2HdenlEiq1yYz5kWqcZiJ0
	Mo1l54gLsHqCYX+xBVGxlWAUin9Jny0yxo7a8YZbu7sdp94LGAENAXIC235W/Ynm
	lBUIh0Y3JlTWsWN3aD/euAhDdxsB/YL/A4OC/FyZPjbJNER7ZWWjZg/ZFI19tII=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=DOtEzL
	hQ+D6m6klOieD+UfAw3G0zMiJR27Dj9+sg9mqnYQ+Nb/LnziVCkH2DxGSRozIj4C
	gq9t2d9hMeiKZI9FBbKScczDVu1KqisZkgoKs1Tj42zKvZ20oNeIypwiaU6ugdLk
	QlNg85OQ2xi1FGkltbxLnhueGDwXD9iLB3Ebc=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 330F3180D3;
	Fri, 23 May 2014 14:26:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B9B85180CF;
	Fri, 23 May 2014 14:26:44 -0400 (EDT)
In-Reply-To: <537F8021.8080304@gmail.com> ("Jakub =?utf-8?Q?Nar=C4=99bski?=
 =?utf-8?Q?=22's?= message of "Fri,
	23 May 2014 19:06:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CB3267E4-E2A7-11E3-B518-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250009>

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> W dniu 2014-05-22 23:33, Christian Couder pisze:
>
>> +--graft <commit> [<parent>...]::
>> +	Create a graft commit. A new commit is created with the same
>> +	content as <commit> except that its parents will be
>> +	[<parent>...] instead of <commit>'s parents. A replacement ref
>> +	is then created to replace <commit> with the newly created
>> +	commit.
>> +
>>   -l <pattern>::
>>   --list <pattern>::
>>   	List replace refs for objects that match the given pattern (or
>
> Here I think you can add the graft replacing example:
>
>   cat .git/info/grafts | while read line
>   do git replace --graft $line; done

Do not cat a single file into a pipeline.

    while read definition
    do
    	git replace --graft $definition
    done <"${GIT_DIR:-.git}/info/grafts"

or something.  You might also have to be careful to use "read -r"
and/or avoid feeding a comment line (if info/grafts supports it) to
the command inside do ... done, but I didn't check what the graft
reading code does myself ;-)
