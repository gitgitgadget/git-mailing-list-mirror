From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log --children
Date: Tue, 04 Oct 2011 13:21:35 -0700
Message-ID: <7vpqicbj8w.fsf@alter.siamese.dyndns.org>
References: <1317736923-20539-1-git-send-email-jaysoffian@gmail.com>
 <4E8B68AC.7020009@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Oct 04 22:21:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBBUo-0004XQ-Rd
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 22:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933647Ab1JDUVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 16:21:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59471 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933631Ab1JDUVl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 16:21:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D16FD56FA;
	Tue,  4 Oct 2011 16:21:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kLhNgJaUmqKW8vayFgvWe4qF/iY=; b=tAPnzy
	hnWXPCubWjXsugcs8athvQTDuzQKHaEf0uG3Vgq6kzfmI00lHsmTP0i9EoUuNa1d
	btpB8SNh8piz9cDKd3+XXgQSawKvBO7XgZXEsmoUiz7cCmhhuGz2O9FuXbIk9ABH
	qnTyx3nnJ4d9IANPWP6lCaWSAmeZMBsl9DZTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TquBkGHRX2jHtGzVE0wAoDKyLtbyiNFt
	BBe3UWD32dQd8xffZbH7R1gtarwZbSHBrAYHLX3Lg7xcXcKRSx/3XIugx0e5ALdX
	ZNlkA/ndxs3TWYggjpM2cVXESFck+yaDnSbc1n0VkjR9kzKdaEk/EjVMjXtLIJ/S
	0XWVHbnhK3U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C626756F8;
	Tue,  4 Oct 2011 16:21:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 42EF956F5; Tue,  4 Oct 2011
 16:21:38 -0400 (EDT)
In-Reply-To: <4E8B68AC.7020009@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Tue, 04 Oct 2011 22:12:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 76A947C4-EEC6-11E0-9C84-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182799>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> @@ -414,6 +422,8 @@ void show_log(struct rev_info *opt)
>>  		fputs(find_unique_abbrev(commit->object.sha1, abbrev_commit), stdout);
>>  		if (opt->print_parents)
>>  			show_parents(commit, abbrev_commit);
>> +		if (opt->children.name)
>> +			show_children(opt, commit, abbrev_commit);
>
> That means that "log --children --parents" will print out the parents'
> sha1s, then the children's. Is that a good default format, or should we
> somehow deal with the case when both are specified?

I think these two options are muturally exclusive, not because of the
"mixed output getting confusing" reasons but because of traversal reasons.
IIRC, when parent rewriting is in effect, you cannot just say "a commit
that has these commits on its parents list is a child of these commits",
as you have to orphan and adopt it as a child of ancestor commits, which
the code introduced in f35f5603 does not do.
