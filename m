From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-hg: do not fail on invalid bookmarks
Date: Mon, 30 Dec 2013 11:12:19 -0800
Message-ID: <xmqqha9qrw4s.fsf@gitster.dls.corp.google.com>
References: <1388316602-22443-1-git-send-email-apelisse@gmail.com>
	<20131229222433.GA31355@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antoine Pelisse <apelisse@gmail.com>, git@vger.kernel.org,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Dec 30 20:12:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VxiGI-00063N-Lo
	for gcvg-git-2@plane.gmane.org; Mon, 30 Dec 2013 20:12:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756136Ab3L3TMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Dec 2013 14:12:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61363 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756124Ab3L3TMW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Dec 2013 14:12:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A46635F0D1;
	Mon, 30 Dec 2013 14:12:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oTNaQYs3mZRanITzxw3x4cKEnIU=; b=jReKmO
	TQj/X2SrJ+MXrdKZTKUfBb6hIQrYCJhazAB9g987DkTFA64XkN5SruQs0/UCReln
	0BWAMsEXVp2b1DrYZLkUUzSPmG/RF1heyon0c92EqvjpFMBN191oyUf695lczhzt
	lv+/F2H0stgW3Gsl3tYDjJ7Ttgaj8iBxN2ewo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gKklHL3QKVQ/cSpYIpOY30L+q3smAiRX
	LuSCqTVdBSCWDVDQeQkGg+JOgiSFZpeFoamCEmeNAkK+HxOwuR3fMp0sStQhqItP
	R8Yez+C5z+cE3X0WkHXqeXrhEhL4lNHm3Cs13AfKitMELAXTGhSfVRCsHT29Sb3F
	uD3vmRguDVc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 946C15F0D0;
	Mon, 30 Dec 2013 14:12:21 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0472C5F0CF;
	Mon, 30 Dec 2013 14:12:20 -0500 (EST)
In-Reply-To: <20131229222433.GA31355@glandium.org> (Mike Hommey's message of
	"Mon, 30 Dec 2013 07:24:33 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4EA5C140-7186-11E3-ACDA-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239815>

Mike Hommey <mh@glandium.org> writes:

> On Sun, Dec 29, 2013 at 12:30:02PM +0100, Antoine Pelisse wrote:
>> Mercurial can have bookmarks pointing to "nullid" (the empty root
>> revision), while Git can not have references to it.
>> When cloning or fetching from a Mercurial repository that has such a
>> bookmark, the import will fail because git-remote-hg will not be able to
>> create the corresponding reference.
>> 
>> Warn the user about the invalid reference, and continue the import,
>> instead of stopping right away.
>
> It's not invalid, it's used to indicate deleted bookmarks. (Tags have
> the same property)

So what should remote-hg behave in such a case, other than what
Antoine's change does (which is to, IIRC, warn, ignore and
continue).
