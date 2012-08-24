From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] git svn: optionally trim imported log messages
Date: Fri, 24 Aug 2012 16:38:53 -0700
Message-ID: <7vk3wnyi5u.fsf@alter.siamese.dyndns.org>
References: <50315ED1.6080803@debian.org>
 <1345413170-2519-1-git-send-email-robert@debian.org>
 <7vsjbio2ky.fsf@alter.siamese.dyndns.org> <5038027B.4090208@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Robert Luberda <robert@debian.org>
X-From: git-owner@vger.kernel.org Sat Aug 25 01:39:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T53Sx-0000aT-LF
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 01:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756714Ab2HXXi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 19:38:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36075 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755805Ab2HXXiz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 19:38:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57EBF8E9D;
	Fri, 24 Aug 2012 19:38:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7fnbLrByPDMGoeERIrKRLBs/t3I=; b=YZfwk5
	6hbkEhOvJOLpGXI7Dd974b8i282l9uO/LJ7rdY5OjECq9VrcO0URpDnEmdEQW9T0
	SQzVyOf6E58RsTUHozwbXICeZ8RbDOtOyCiZSUlFfGwHliZF23sPKko51lN7zWtL
	hS5NcAwwahda3wUiHTsduvB2mSMTyhbxB9hys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MhED7mRKm+XE4d8llQlVJhoCBQcfbtXm
	js1PQLIVIP77lQt/fHJmADJQ+jRRx0kg2rfayq1Ij5bOeRjqij10CSOIbXe4XKwg
	OAszC/ogMiAnjHzs548HDUs/RkbLVk4YQqWkHYTr/uTnnObMyQdFMgia039D+5L6
	UWfT8M1SCMU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 451228E9C;
	Fri, 24 Aug 2012 19:38:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3E1C8E90; Fri, 24 Aug 2012
 19:38:54 -0400 (EDT)
In-Reply-To: <5038027B.4090208@debian.org> (Robert Luberda's message of "Sat,
 25 Aug 2012 00:38:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DDF4559E-EE44-11E1-B929-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204241>

Robert Luberda <robert@debian.org> writes:

>> I think it would be saner to call them "trailers" to avoid
>> confusion.
>
> Thanks, I haven't got any idea how to call them, especially because
> existing git documentation refers to them just by using the word `line',
> e.g.:
>
>  git-am.txt:     Add a `Signed-off-by:` line to the commit message,
>  git-cherry-pick.txt:    Add Signed-off-by line at the end of the

Then "line" is fine; they never come before the body, and are
certainly not headers.

>> There needs an explanation to the reader why this is an optional
>> feature.
>
> OK, I'll add some explanation. Basically it is optional, per Eric
> request, for backward compatibility  to make it possible to work on a
> centralized clone of svn repository by people using both old and new
> versions of git svn.

That matches my recollection.  I didn't ask you to explain it to me,
by the way, as I've skimmed the discussion during the review.

I wanted the resulting history and the documentation to explain that
to git-svn users.

> NL means newline. The new line characters implicitly added after each
> commit message line, that's why the value is empty. But, yes, this can
> be misleading. I'd prefer to keep it short, so would EL (i.e.
> `empty-line') be an acceptable name?

I'd rather call it "$EMPTY"; $NL is already obscure, nobody uses $EL.

>> 	next_N () {
>> 		N=$(($N + 1)) &&
>>                 ...
>> 	}
>> 
>> (the above also has two style fixes).
>
> Just to be sure: shall the `...' line start a new level of indentation
> or is it a typo?

It was meant to align with "N=", but perhaps HT and quoting
interacted badly or something.
