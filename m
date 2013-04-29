From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git.pm with recent File::Temp fail
Date: Sun, 28 Apr 2013 20:59:16 -0700
Message-ID: <7vr4hung17.fsf@alter.siamese.dyndns.org>
References: <20130322205758.09ca9107@pc09.procura.nl>
	<CAP30j14=_U8iEZAodnfACnBHgF0+j0_OK7n7PvsUnwSDj_Y40A@mail.gmail.com>
	<20130428110933.436786bd@pc09.procura.nl>
	<20130429021651.GA2751@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>,
	Ben Walton <bdwalton@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 29 05:59:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWfFZ-000477-Hg
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 05:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756869Ab3D2D7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Apr 2013 23:59:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50727 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756817Ab3D2D7V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Apr 2013 23:59:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CEBD512A8B;
	Mon, 29 Apr 2013 03:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BTUPjNZ9ep/+M7shVDfcgPCuWJw=; b=nnoz+Z
	NUYO0iLwWoIKSZsvfhlLXpT8Qyu7Aza3K6YUDrUia7WLNARtgoJHL9Lqqzov6Nsc
	WKJcED7Kay5M5iogPIJ6PnyPLQ6p4SKZcOyfMJJ/agERsrh30AIYtAGu2jWF0nqY
	4xNvhat0ed8oeg6w342dyEPKxNf38iK3DoWX8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tahp/G1sUxNdZNHsrOXeBDyFHaWMteOr
	1xdd09eV31A5QY01uD4Dw9ylB1GIMlB13TT1iz/5XMqt0O8cMoz/Qd8ZWghMnpvU
	AgZEnqUOjcYmv2Y/7RWX2aUFy14XpsmGDDsSgo+Us9MvRiMbzAN0MhpShCKrIYd5
	iyKRd5asuOY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1ADC12A8A;
	Mon, 29 Apr 2013 03:59:18 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31EC912A86;
	Mon, 29 Apr 2013 03:59:18 +0000 (UTC)
In-Reply-To: <20130429021651.GA2751@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 28 Apr 2013 22:16:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2A56FCC6-B081-11E2-83D4-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222764>

Jeff King <peff@peff.net> writes:

> On Sun, Apr 28, 2013 at 11:09:33AM +0200, H.Merijn Brand wrote:
>
>> Still failing in 1.8.2.2
>> 
>> Short fix:
>> --8<---
>> diff --git a/perl/Git.pm b/perl/Git.pm
>> index dc48159..7a252ef 100644
>> --- a/perl/Git.pm
>> +++ b/perl/Git.pm
>> @@ -1265,7 +1265,7 @@ sub _temp_cache {
>>                         $tmpdir = $self->repo_path();
>>                 }
>> 
>> -               ($$temp_fd, $fname) = File::Temp->tempfile(
>> +               ($$temp_fd, $fname) = File::Temp::tempfile(
>>                         'Git_XXXXXX', UNLINK => 1, DIR => $tmpdir,
>>                         ) or throw Error::Simple("couldn't open new temp file");
>
> I think this fix is the right thing. Your patch probably didn't get
> applied because it did not follow the guidelines in SubmittingPatches.

It was more like "It managed to miss people's attention because the
subject didn't say [PATCH]", but yes you are right that the change
the patch text itself shows looks reasonable and that I cannot apply
a patch that is not signed off (and worse yet in multipart/mixed).

> ...
> So I think the right commit message is something like:
>
>   We call File::Temp's "tempfile" function as a class method, but it was
>   never designed to be called this way. Older versions seemed to
>   tolerate it, but as of File::Temp 0.23, it blows up like this:
>
>     $ git svn fetch
>     'tempfile' can't be called as a method at .../Git.pm line 1117.
>
>   Fix it by calling it as a regular function, just inside the File::Temp
>   namespace.
>
> -Peff

Thanks.
