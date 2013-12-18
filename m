From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 07/10] builtin/replace: teach listing using short, medium or full formats
Date: Wed, 18 Dec 2013 09:37:08 -0800
Message-ID: <xmqqioumjc1n.fsf@gitster.dls.corp.google.com>
References: <20131211074147.11117.1155.chriscool@tuxfamily.org>
	<20131211074614.11117.96106.chriscool@tuxfamily.org>
	<52B196F1.3060003@gmail.com>
	<CAP8UFD3UsdcDg2D2nysMZgGAxLebYm-qQX3LZfqdwF9gNbyxgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 18:37:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtL3m-00032H-3Y
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 18:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427Ab3LRRhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 12:37:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34224 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753388Ab3LRRhT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 12:37:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B02B659880;
	Wed, 18 Dec 2013 12:37:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BmnCyvsa0lECeJ+HNfIV54coZGM=; b=evP7C6
	jlMFxs72EeS+WST96C1LjsnQHzjsCApbfeZqLt+vwEfl/Ze3afZkdiwpI6oxDh+p
	/1NqlO6RbiRAIaTIEqHS1ElHtwDKDYqycRcHQmZh6FHAa35RDVDhcLsX1HPQGvEt
	m8hTB2+UrNvcGSUu6kGErskGcKIIl4xAzMTBE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b1AwC+D6/GPAxWxYcb19ZnbkcUSasBsR
	EORM1wzhvC8MUOuahos+vxA6RuMlm5HJTSBVoZzb+E3yZVhF672/0wjB3LuCtWO4
	EKfYXtrg6hhjSw8+TI3ZF7pzNvsmG9JKRAj8MpuN0pW6xoUimTy5BUEL5LC/9QuU
	xahd8pwycn0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDA1B5987F;
	Wed, 18 Dec 2013 12:37:14 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F78E5987A;
	Wed, 18 Dec 2013 12:37:13 -0500 (EST)
In-Reply-To: <CAP8UFD3UsdcDg2D2nysMZgGAxLebYm-qQX3LZfqdwF9gNbyxgA@mail.gmail.com>
	(Christian Couder's message of "Wed, 18 Dec 2013 17:49:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 07C027EA-680B-11E3-84F6-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239459>

Christian Couder <christian.couder@gmail.com> writes:

> On Wed, Dec 18, 2013 at 1:37 PM, Karsten Blees <karsten.blees@gmail.com> wrote:
>> Am 11.12.2013 08:46, schrieb Christian Couder:
>>> +enum repl_fmt { SHORT, MEDIUM, FULL };
>>
>> SHORT is predefined on Windows, could you choose another name?
>
> Ok, I will change to:
>
> enum repl_fmt { SHORT_FMT, MEDIUM_FMT, FULL_FMT };

What are these for in the first place?  Your "SHORT" conflicting
with something totally unrelated is a sign that you should be naming
them in a way that is more specific to your use.  SHORT_FMT is still
not specific enough to tell what they are for.  With SHOW_REPLACE_
prefix, perhaps?  Also perhaps give characterization better than
their output lengths?

My quick read of show_reference() tells me that they are "name
only", "name and value", and something else that does not seem
very useful unless you are debugging.
