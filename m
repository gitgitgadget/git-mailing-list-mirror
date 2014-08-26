From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 18/18] signed push: final protocol update
Date: Tue, 26 Aug 2014 12:38:49 -0700
Message-ID: <xmqqiolfhwhi.fsf@gitster.dls.corp.google.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
	<1408485987-3590-19-git-send-email-gitster@pobox.com>
	<CAJo=hJuToRQDTkccV9BfVbs1YnjCrr2iPrG-HmTbJ=ds4r6MzA@mail.gmail.com>
	<xmqqvbplpg2s.fsf@gitster.dls.corp.google.com>
	<xmqqa96wpfqb.fsf@gitster.dls.corp.google.com>
	<CAJo=hJu_T7irRk=fBsJ+GQxbVQ9GgO2ytihxKm+bXSLsL+wQbg@mail.gmail.com>
	<xmqqd2bomowm.fsf@gitster.dls.corp.google.com>
	<CAJo=hJs3m-0u7NkPHJqvk4qZBGtPguck-xn=in3m-+30UxDQoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 21:39:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMMaA-0004FY-DZ
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 21:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957AbaHZTjB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 15:39:01 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60205 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753327AbaHZTjA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 15:39:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 77D95326F7;
	Tue, 26 Aug 2014 15:38:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Daz451LC0G9uYobDe244LmeyKjA=; b=QSm3E2
	Q9xlVwKlkUIPo1Z6243BjEauOAMvAggCHSWDEhxV4+MHqvx+Dm4+qjmJkFLlCsJT
	1Ud+voasPxZLsQVxn77SR9Y+onIGE7J1dsTB1RX/QnYJPT8q2CLrblCvBST9RWzY
	TYrZ6tPaBlvUK78ekPexOI1Ysw9XyXMcBDW8o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pq+JNJQqS/7iWL8fAVDHEHZgpJB7IRS4
	mzc7kFKatTzuL7JHXG36EH/u8eV4qTc+VtrGmmHnyAMfP3zKf6vdoInC18I+DBt2
	2IQsFSiNbWytV+vsD6e6Tv7cx56PMY4OfKAjw6hhxhBpSXSSnXbfy5Y4+qrwemDP
	84okO067rYI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6CF57326F6;
	Tue, 26 Aug 2014 15:38:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5B008326EC;
	Tue, 26 Aug 2014 15:38:51 -0400 (EDT)
In-Reply-To: <CAJo=hJs3m-0u7NkPHJqvk4qZBGtPguck-xn=in3m-+30UxDQoA@mail.gmail.com>
	(Shawn Pearce's message of "Tue, 26 Aug 2014 10:33:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9B4C96E8-2D58-11E4-83E4-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255937>

Shawn Pearce <spearce@spearce.org> writes:

> On Mon, Aug 25, 2014 at 10:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Shawn Pearce <spearce@spearce.org> writes:
>>
>>> A stateless nonce could look like:
>>>
>>>   nonce = HMAC_SHA1( SHA1(site+path) + '.' + now, site_key )
>>>
>>> where site_key is a private key known to the server. It doesn't have
>>> to be per-repo.
>>>
>>> receive-pack would then be willing to accept any nonce whose timestamp
>>> is within a window, e.g. 10 minutes of the current time, and whose
>>> signature verifies in the HMAC. The 10 minute window is important to
>>> allow clients time to generate the object list, perform delta
>>> compression, and begin transmitting to the server.
>>
>> Hmph, don't you send the "finally tell the other end" the sequence
>> of "update this ref from old to new" and the packdata separately?
>
> No. The command list (triples of old, new, ref) is sent in the same
> HTTP request as the pack data, ahead of the pack data. So its one
> request.

That is unfortunate.  Would it be a major surgery to update the
protocol not to do that, perhaps by moving the command list from 3
to 2 (the latter of which is not currently doing anything useful
payload-wise, other than flushing a HTTP request early)?

> Push on smart HTTP is 3 HTTP requests:
>
>   1)  get advertisement
>   2)  POST empty flush packet to tickle auth (literally just "0000").
>   3)  POST command list + pack
>
> The nonce can be sent server->client in 1, and client->server in 3.
>
>>  I
>> think we have a FLUSH in between, and the push certificate is given
>> before the FLUSH, which you do not have to wait for 10 minutes.
>
> Nope I think you need to wait for the pack to generate enough to start
> sending the pack data stream. Nothing forces the smart HTTP client to
> push its pending buffer out. We wait for the pack data to either
> finish, or overflow the in-memory buffer, and then start transmitting.
> If your client needs a lot of time for counting and delta compression,
> we aren't likely to overflow and transmit for a while.
>
> If you send a _lot_ of refs you can overflow, which will cause us to
> transmit early. But we are talking about megabytes worth of (old, new,
> ref) triplets to reach that overflow point.
