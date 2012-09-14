From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 6/6] rev-list/log: document logic with several limiting
 options
Date: Thu, 13 Sep 2012 18:19:03 -0700
Message-ID: <7vsjal4d14.fsf@alter.siamese.dyndns.org>
References: <7v7grzdue6.fsf@alter.siamese.dyndns.org>
 <cover.1347544259.git.git@drmicha.warpmail.net>
 <49f89f65cd39306655a9b382a1244e34fb90fff1.1347544259.git.git@drmicha.warpmail.net> <7v7grx5zfq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 14 03:19:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCKYz-0004xx-1o
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 03:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752361Ab2INBTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 21:19:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54496 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752174Ab2INBTI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 21:19:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A96B8441;
	Thu, 13 Sep 2012 21:19:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=29BRrbE00xP5cXmAA+xpdR73QCY=; b=iriDAu
	LqStyH7wF9TQKZjNo1rfaYkciDNJn9p+sKeExUYWqnLpv6Bk01bwhJzTlVTpW/Ti
	EIf4JC2RObmot7mI5CpfQlaXlaJVBAxBrGxmNPINuQvc4udTrPTu/YwAStEPSdMW
	QC5BNUL9HgwmgtrcmeuYkDZB5oFX6CGBXSFvs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m3xeAVVQn8i699Wwn6rjse7rvB2SYLvV
	Lb9Qi3NIHPtT5gnc4hZWbla0nwXoOFHRGvxE383K6mIP/WKV1PQ9BqjMwByE5C39
	CQaSpCLNrADjFUsAc0vCUHyGer4sbANGQLrI+huE8tG5iBwJE7/f1FBKFUsv6zw5
	rJayLPQjAbw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 676438440;
	Thu, 13 Sep 2012 21:19:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A559843F; Thu, 13 Sep 2012
 21:19:05 -0400 (EDT)
In-Reply-To: <7v7grx5zfq.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 13 Sep 2012 15:29:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2CE90ED6-FE0A-11E1-B9E1-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205442>

Junio C Hamano <gitster@pobox.com> writes:

>> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
>> index 5436eba..b2dbfb5 100644
>> --- a/Documentation/rev-list-options.txt
>> +++ b/Documentation/rev-list-options.txt
>> @@ -6,6 +6,19 @@ special notations explained in the description, additional commit
>>  limiting may be applied. Note that they are applied before commit
>>  ordering and formatting options, such as '--reverse'.
>>  
>> +Different options are ANDed: '--author=bar --grep=foo'
>> +limits to commits which match both conditions.
>> +
>> +Several occurences of the '--grep' option are ORed: '--grep=foo --grep=bar'
>> +limits to commits matching any of these conditions.
>> +(If '--all-match' is given, the conditions are ANDed.)
>> +
>> +Several occurences of the '--author' and '--committer' options are ORed
>> +(because there can be only one each per commit).
>
> As I would really want to eventually see the revision command option
> parser understand the full power of grep expressions in the future,
> I would really want to avoid a misleading explanation that calls
> what "--all-match" does as "ANDed".

Assuming that the patch I posted earlier actually works, I think the
description can become vastly simpler, if you stop explaining author
and committer in terms of "grep".  It is implementation detail that
the same grep machinery is handling these two header fields and the
end users do not have to even be aware of.

	You can use "--grep=foo" to limit the output to commits that
	mention "foo" in their messages.  If you use more than one
	of them, e.g. "--grep=foo" and "--grep=bar", by default, the
	command shows commits that mention "foo" or "bar" (or
	naturally, both) in their messages.  If you want to limit
	the output to commits that mention both "foo" and "bar" in
	their messages (note that they do not have to appear on the
	same line), you can use "--all-match".

	You can use "--author=Linus" to limit the output to commits
	authored by Linus.  If you use more than one of them,
	e.g. "--author=Linus" and "--author=Junio", the command
	shows commits that are authored by either Linus or Junio.
	As a commit cannot be authored by more than one person,
	there is no option to choose commits that are authored by
	Linus and Junio (and there is no need for such an option).
	To limit the output with the committer information, use
	"--committer=<person>" instead of "--author=<person>".
