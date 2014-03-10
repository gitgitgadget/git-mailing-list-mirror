From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] upload-pack: send shallow info over stdin to pack-objects
Date: Mon, 10 Mar 2014 08:23:13 -0700
Message-ID: <xmqqeh2arsbi.fsf@gitster.dls.corp.google.com>
References: <1393936205-15953-1-git-send-email-pclouds@gmail.com>
	<1394095783-24402-1-git-send-email-pclouds@gmail.com>
	<xmqqfvmvyxzv.fsf@gitster.dls.corp.google.com>
	<CACsJy8B8=N6R6nVa12jjhxdqxMA2eGXOV6jR-XqRRbb-6Xppdg@mail.gmail.com>
	<xmqq8uslvp86.fsf@gitster.dls.corp.google.com>
	<CACsJy8AcYBXi6LjyJDeEnogPTXfqYXqijXaLY=bUgNnd4cT_Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 16:23:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN235-0000Ck-QO
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 16:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754106AbaCJPXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 11:23:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34226 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754029AbaCJPXR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 11:23:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0E4B7349A;
	Mon, 10 Mar 2014 11:23:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+IKnKQvhShoLARTKUlvjdJRkOpQ=; b=LqexOB
	cqBhrkJbwGIadIyK3cO9z54ynCM1ZP7YvQ/oap3Dh31DcTFA1gsMy5TvXoCz5ukP
	JWBPZdgvy3AQKLR3gIg+rPOKQB84Hqi3EexklXgqkSvy5UsOlTYizf0drN0HkEQH
	6e1Qm+2Zf38PBF0NOE0J0G2t8R+vbXRnBDlCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RCvfHdcLTI/ZUkl97rTLXzlkYMivfJHD
	Dr56nASUMcTXQUgpcv0hA+ZJtry8vOh/ILYlKHeyRVFaRMtxsxpMVBCRm0qBnP/q
	T7E8rxSD2fSTf6KjbtZzIwI2ShhQUaJD1ZMbjmZ2oPoxXynye82DGWg+/3XMaeEJ
	p9aXqjKgEr8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E16F173499;
	Mon, 10 Mar 2014 11:23:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 11C8473496;
	Mon, 10 Mar 2014 11:23:15 -0400 (EDT)
In-Reply-To: <CACsJy8AcYBXi6LjyJDeEnogPTXfqYXqijXaLY=bUgNnd4cT_Fg@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 8 Mar 2014 07:08:05 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E6EF9A12-A867-11E3-900D-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243765>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Mar 8, 2014 at 1:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> On the receive-pack side, the comment at the bottom of
>>>> preprare_shallow_update() makes it clear that, if we wanted to use
>>>> hooks, we cannot avoid having the proposed new shallow-file in a
>>>> temporary file, which is unfortunate.  Do we have a similar issue on
>>>> hooks on the upload-pack side?
>>>
>>> No. I don't think we have hooks on upload-pack.
>>
>> The question was not only about "do we happen to work OK with the
>> current code?" but about "are we closing the door for the future?"
>>
>> If we ever need to add hooks to upload-pack, with the updated
>> approach, its operation will not be affected by the temporary
>> shallow file tailored for this specific customer.  Which I think is
>> a good thing in general.
>>
>> But at the same time, it means that its operation cannot be
>> customized for the specific customer, taking into account what they
>> lack (which can be gleaned by looking at the temporary shallow
>> information).  I do think that it is not a big downside, but that is
>> merely my knee-jerk reaction.
>
> When upload-pack learns about hooks, I think we'll need to go back
> with --shallow-file, perhaps we a secure temporary place to write in.
> I don't see another way out. Not really sure why upload-pack needs
> customization though. The only case I can think of is to prevent most
> users from fetching certain objects, but that does not sound
> realistic..

I was more thinking along the lines of logging.

But you are right that we can easily revisit --shallow-file
interface later.

> Of course.. So what should we do with this? Go with this "no temp
> file" approach and deal with hooks when they come, or prepare now and
> introduce a secure temp. area?

I was rather hoping that we did not have to worry about temporary
files.  This patch solves the issue for the service people would
expect to be read-only the most, and it is a good step in the right
direction.  So let's follow through with the approach and not worry
about "secure temporary" for now.
