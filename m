From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] builtin/interpret-trailers.c: allow -t
Date: Thu, 07 Apr 2016 10:26:33 -0700
Message-ID: <xmqqa8l51gae.fsf@gitster.mtv.corp.google.com>
References: <1460042563-32741-1-git-send-email-mst@redhat.com>
	<1460042563-32741-2-git-send-email-mst@redhat.com>
	<xmqqr3eh1hq6.fsf@gitster.mtv.corp.google.com>
	<vpqtwjduymh.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Michael S. Tsirkin" <mst@redhat.com>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Apr 07 19:26:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoDhZ-0003J9-Dt
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 19:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756961AbcDGR0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 13:26:37 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:64450 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756863AbcDGR0g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 13:26:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 27B8652A65;
	Thu,  7 Apr 2016 13:26:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xBaHV5EAm6mdXIj+SakB6/T5iH8=; b=Q3LYoN
	9fyT/p7hR2d0Z652iNdQ0vVsMW7w0PxbCC1Qcxt2TSxIsK9f/Ytp1bVDcQ6LRglx
	853gmXeTBhhG1U2D4Zj1zRrAS57Hij7s+wmlXDBIY5l8ltJyWrFDmQOXH85Y086o
	2RFDSKoGaJ50DbZWPuj/DhvCtMZR78vBmkWVg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NGkZ8DnoM7YuWvYVMk4B0jdrQlk5k+/F
	zNGVZhZFcFW4Q42V6jQnDjCVHDTRr6cKQaamKAdLlidzD3WuEa5i+JLWSsVpXskM
	lrQ1HisVGUazhTlzQ6+DWF5wB6NfIRxXLp8JZ9ZJNd/tRSffdqwMWVIR24zoc+LJ
	YnQ/abX/cFI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1E52752A63;
	Thu,  7 Apr 2016 13:26:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8A5D852A61;
	Thu,  7 Apr 2016 13:26:34 -0400 (EDT)
In-Reply-To: <vpqtwjduymh.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	07 Apr 2016 19:17:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E0517700-FCE5-11E5-B3D3-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290933>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> I am in principle OK with the later step that teaches a single
>> letter option to end-user facing "git am" that would be turned into
>> "--trailer" when it calls out to "interpret-trailers" (I haven't
>> checked if 't' is a sensible choice for that single letter option,
>> though).
>
> If 'am' has -t == --trailer, I think it makes sense to have the same
> shortcut in interpret-trailers for consistency.

It is the other way around.  "git am" may be OK with "-t" (or it may
not--I do not know yet), but other commands that are currently
unaware of "interpret-trailers" (cherry-pick, revert, etc.) may have
better uses for a short-and-sweet 't'.

In the ideal future, "interpret-trailers" should not have to exist
in the end-users' vocabulary, as all the front-line end-user facing
programs would be aware of it.  But we are not there.

Letting it reserve a short-and-sweet 't' that allows it to dictate
that its callers must have the same 't' is tail wagging the dog that
I want to avoid.
