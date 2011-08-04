From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Tolerate zlib deflation with window size < 32Kb
Date: Thu, 04 Aug 2011 10:11:03 -0700
Message-ID: <7vhb5x5cgo.fsf@alter.siamese.dyndns.org>
References: <1312410730-12261-1-git-send-email-roberto.tyley@gmail.com>
 <7vsjpi82x7.fsf@alter.siamese.dyndns.org>
 <CAFY1edZyO7oYDi+tV2mxbhBHY_cf2F0bD7+KF9rxmKYygSFAjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Roberto Tyley <roberto.tyley@guardian.co.uk>
To: Roberto Tyley <roberto.tyley@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 19:11:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qp1Rx-0003dx-59
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 19:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501Ab1HDRLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 13:11:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42006 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751631Ab1HDRLF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 13:11:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29C774B6B;
	Thu,  4 Aug 2011 13:11:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u7piFeZiemhtgFI5LXqoPLQHsgY=; b=v5Ej08
	RSiW6CGW2LNGaGGS1pQBeHZFOo5/be/YP/57dFNmWK5j/Rn+5RRMMvOzoPH+/gjs
	4Nu7c4v1s8YDJ2mMZDJ2S7W1UtehvtpLgqGYUxiIZaL8x+KCG3gJQAVLmrpT3SLL
	OvoaRNNWMsdpJdeRIJIipw5/YQM+h6VpYyhyw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qOG22wP9NUq3M7X25nWjGB2Z5GKa8Nc2
	Ha5yca7WRlylM1zm5ko3Gh3DH2LFSARM6pMOi2tR0G0h70P1zab7YisM5A4oaQ+D
	gPNL9A3O0qY6Wp9sJPq6p63Trv1hrPZ8/mLzhQ6VWUieGrVkBoVRgBMmS2a2Dsuu
	gxU9SQGu0DM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21DF44B6A;
	Thu,  4 Aug 2011 13:11:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D6444B69; Thu,  4 Aug 2011
 13:11:04 -0400 (EDT)
In-Reply-To: <CAFY1edZyO7oYDi+tV2mxbhBHY_cf2F0bD7+KF9rxmKYygSFAjA@mail.gmail.com> (Roberto
 Tyley's message of "Thu, 4 Aug 2011 08:35:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BC730F9A-BEBC-11E0-8276-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178752>

Roberto Tyley <roberto.tyley@gmail.com> writes:

> On 4 August 2011 00:56, Junio C Hamano <gitster@pobox.com> wrote:
>
>> roberto.tyley@gmail.com writes:
>> > -     if (map[0] == 0x78 && !(word % 31))
>> > +     if ((map[0] & 0x88) == 0x08 && !(word % 31))
>>
>> Are you sure about this 0x88? Isn't it 0x8F or something?
>
>
> Ah- yes, you're right - the bitmask should be 0x8F, because the
> lower nibble of a deflated zlib stream is 8 (8=deflate) and we want
> to match all 4 bits.
>
> Thankfully the rest of the logic still applies - I'll submit an
> updated patch in a minute, once I've conquered my embarrassment :-)

Heh, don't get embarrassed. It was your well-written in-code comment that
helped me to follow the new logic well enough to spot it.
