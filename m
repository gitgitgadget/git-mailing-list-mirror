From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [PATCH 2/2] check-ignore.c: fix segfault with '.' argument
 from repo root
Date: Thu, 21 Feb 2013 12:15:36 -0800
Message-ID: <7vehg9v2xj.fsf@alter.siamese.dyndns.org>
References: <CAOkDyE_96Ef5CjoxNk3mbsNi+ZAuv6XeHcO7r8RQ-Of5ELsuKw@mail.gmail.com>
 <1361282783-1413-1-git-send-email-git@adamspiers.org>
 <1361282783-1413-2-git-send-email-git@adamspiers.org>
 <7v1ucc6vgd.fsf@alter.siamese.dyndns.org>
 <CAOkDyE9VVuFn6B=Fe4XHxGCEW0MFgndx1X0+9hO36Soxb37YQw@mail.gmail.com>
 <7v1ucc5b7n.fsf_-_@alter.siamese.dyndns.org>
 <20130220020046.GC7860@pacific.linksys.moosehall>
 <7vppzv3dd8.fsf@alter.siamese.dyndns.org>
 <20130220104720.GD7860@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Thu Feb 21 21:16:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8cYz-0008Dv-4Y
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 21:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754223Ab3BUUPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 15:15:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60884 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753006Ab3BUUPk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 15:15:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CA67B9DA;
	Thu, 21 Feb 2013 15:15:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3G0vq8e6ZVHzgDLkQIiuDOjzJpA=; b=vtfuMZ
	hsBPkbP3+9cC5TaPrkfmtQi7a5FTE/D/AkFCiYEU4ApT+UMCI1P8wDtrEIrqFwJg
	487akeVtzjVJOqNAfNyZ4WFo72y11m0L+eQyVgRqvjEQNLwjEfp3Bc0yCgw786oH
	KipdUaaUjN1KpxUdRMF2WO3Q5f6pDEwOwW/Hk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GZAWxGhu19L8xyQd4/NFlhCDrxPEHrTE
	LaIgTebQ4x8MMsazN82QhMEdqxAOnnXSN9Go2Zw98F+sFe89xiO8zeiIIgc8axq9
	XmBbQOU+GwQSbqI5TuM/+pYrISk7Le7wei1YQAKBjISip4z9Z6VUnKBsEzjKHYBl
	y9A8dWfwREw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5ECE8B9D9;
	Thu, 21 Feb 2013 15:15:39 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C878DB9C8; Thu, 21 Feb 2013
 15:15:37 -0500 (EST)
In-Reply-To: <20130220104720.GD7860@pacific.linksys.moosehall> (Adam Spiers's
 message of "Wed, 20 Feb 2013 10:47:20 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 74D5D094-7C63-11E2-B2B9-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216789>

Adam Spiers <git@adamspiers.org> writes:

> On Tue, Feb 19, 2013 at 06:53:07PM -0800, Junio C Hamano wrote:
>> Adam Spiers <git@adamspiers.org> writes:
>> 
>> > OK, thanks for the information.  IMHO it would be nice if 'git
>> > format-patch' and 'git am' supported this style of inline patch
>> > inclusion, but maybe there are good reasons to discourage it?
>> 
>> "git am --scissors" is a way to process such e-mail where the patch
>> submitter continues discussion in the top part of a message,
>> concludes the message with:
>> 
>> 	A patch to do so is attached.
>> 	-- >8 --
>> 
>> and then tells the MUA to read in an output from format-patch into
>> the e-mail buffer.
>
> Ah, nice!  I didn't know about that.
>
>>  You still need to strip out unneeded headers
>> like the "From ", "From: " and "Date: " lines when you add the
>> scissors anyway, and this is applicable only for a single-patch
>> series, so the "feature" does not fit well as a format-patch option.
>
> Rather than requiring the user to manually strip out unneeded headers,
> wouldn't it be friendlier and less error-prone to add a new --inline
> option to format-patch which omitted them in the first place?  It
> should be easy to make it bail with an error when multiple revisions
> are requested.

Perhaps.
