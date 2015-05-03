From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Retry attempts to acquire the packed-refs lock
Date: Sat, 02 May 2015 19:12:06 -0700
Message-ID: <xmqqtwvuwgsp.fsf@gitster.dls.corp.google.com>
References: <1430491977-25817-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun May 03 04:12:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YojOA-0004F2-ND
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 04:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbbECCMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2015 22:12:10 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63417 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751398AbbECCMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2015 22:12:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8523B4E817;
	Sat,  2 May 2015 22:12:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z5kF2uTasTq3mgKxgM3MHNR9QBQ=; b=WwaZ0o
	8RV1Ex1lPD5UxKXqfhnh85TqHGFrsDDq3+9JS7H1PKEX1qPg99sfxm5BOSNsKs40
	FnEFoCdhxnS3ccCknFoOZBbI2J4Kj+Y9HPBSomRsmng81fGFdo53hG89ufD5At+X
	0pGQDP5WevTCOV6Ux6QNvgu8cj8A36SOtXicQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b/kAXMBMAjO44HjEsRVxwj4zGmXURoIf
	pqkcxOsjPBpQYNiS99xZ6Zm4klRMC0KTYv12lv28ExSV0GNsPY27sA3ZnZVY0ySZ
	g6+1ti0Wzr3T5HCu9w0SmVVdg0BumXoUAYauoBeqRggzzZlsaWwxUcnEdYvaN8Mg
	cK1IR04uEgg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E5B84E816;
	Sat,  2 May 2015 22:12:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 054D34E814;
	Sat,  2 May 2015 22:12:07 -0400 (EDT)
In-Reply-To: <1430491977-25817-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Fri, 1 May 2015 16:52:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CCDC92EE-F139-11E4-8773-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268249>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> At GitHub we were seeing occasional lock contention over packed-refs.
> It wasn't very common, but when you have as much git traffic as we
> have, anything that *can* happen *will* happen.
>
> The problem is that Git only tries to acquire locks a single time. If
> that attempt fails, the whole process fails. So, for example, if two
> processes are trying to delete two different references, one of them
> can fail due to inability to acquire the packed-refs lock, even though
> it could have succeeded if it had just waited a moment.

Yeah, try and abort may be perfectly fine for Git used interactively
by humans, but is totally unsuitable for the server side.  Thanks
for looking into this.
