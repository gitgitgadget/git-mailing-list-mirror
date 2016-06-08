From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] bundle v3: the beginning
Date: Wed, 08 Jun 2016 11:05:20 -0700
Message-ID: <xmqq4m93mu8v.fsf@gitster.mtv.corp.google.com>
References: <xmqqfuw84uhb.fsf@gitster.mtv.corp.google.com>
	<1456950761-19759-1-git-send-email-gitster@pobox.com>
	<1456950761-19759-5-git-send-email-gitster@pobox.com>
	<CAP8UFD1xqRMFE2Wzntu=XevCyj+acGLEO-cTq1fqn+NMe3x0vg@mail.gmail.com>
	<CACsJy8Dr_Z886Jb-O8gbAv_vzBLicNH6bPPpKwb9HWZTKQ9muw@mail.gmail.com>
	<CAP8UFD3jPQFk2deSk5JXC3PTz5yWcvXJ4=Qjam5Qw6P9SrLzFQ@mail.gmail.com>
	<CACsJy8DB_17DZ7REBzicyA_GZCnvNkoYEzftjfyM72QVmEb_Vg@mail.gmail.com>
	<CAP8UFD2t=2wJ=1U1ctMYNuMSejBYLh2yeLU7ZfP5Q6KLxUApjQ@mail.gmail.com>
	<xmqqinxkpzur.fsf@gitster.mtv.corp.google.com>
	<20160607202351.GA5726@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:06:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAhr7-0001ke-IA
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 20:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756728AbcFHSFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 14:05:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55554 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753485AbcFHSFY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 14:05:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C41A1F537;
	Wed,  8 Jun 2016 14:05:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PVE+ykOlTZAz+2Cx4oGQ0T504Ao=; b=Sa02Bm
	ygHCdDlXIdzyHwOs6yCwIT+XSjh6W+aFb92eXg4i+nu0Urq087btgCm8m//Dosc0
	PEQ9knJAMvU4Pg8+uNSjibiEPGPNu+mhscx/YyWkWsLQtYCM8p7f7ze405ZpIbWY
	jS+/VLyIRylByxa9uWgPrjs1bxZ+WqmD0J5rs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zka6v7tYdaQKIIBoOst5F0RmzeAmufmm
	Mle21b0ouRRp2SNOSMkMtQdhBzBNjXRAhIQfvdSRF+TQjRNTkd4Dm0GI5bL6oG67
	6TsgPqnTlPwFqDHVubK8B8sPjR3+rUoPb1PmpVXHY0DENmQNYVdGhPJkGeJVwFn7
	CSel1c0hdik=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 82F251F536;
	Wed,  8 Jun 2016 14:05:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F0F4C1F535;
	Wed,  8 Jun 2016 14:05:21 -0400 (EDT)
In-Reply-To: <20160607202351.GA5726@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 7 Jun 2016 16:23:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 912DCDD8-2DA3-11E6-9481-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296820>

Jeff King <peff@peff.net> writes:

> This interface comes from my earlier patches, so I'll try to shed a
> little light on the decisions I made there.
>
> Because this "external odb" essentially acts as a git alternate, we
> would hit it only when we couldn't find an object through regular means.
> Git would then make the object available in the usual on-disk format
> (probably as a loose object).
>
> So in most processes, we would not need to consult the odb command at
> all. And when we do, the first thing would be to get its "have" list,
> which would at most run once per process.
>
> So the per-object cost is really calling "get", and my assumption there
> was that the cost of actually retrieving the object over the network
> would dwarf the fork/exec cost.

OK, presented that way, the design makes sense (I do not know if
Christian's (revised) design and implementation does or not, though,
as I haven't seen it).

As "check for non-existence" is important and costly, grabbing
"have" once is a good strategy, just like we open the .idx files of
available packfiles.

>> >   - "<command> have": the command should output the sha1, size and
>> > type of all the objects the external ODB contains, one object per
>> > line.
>> 
>> Why size and type at this point is needed by the clients?  That is
>> more expensive to compute than just a bare list of object names.
>
> Yes, but it lets get avoid doing a lot of "get" operations.

OK, so it is more like having richer information in pack-v4 index ;-)

>> >   - "<command> put <sha1> <size> <type>": the command should then read
>> > from stdin an object and store it in the external ODB.
>> 
>> Is ODB required to sanity check that <sha1> matches what the data
>> hashes down to?
>
> I think that would be up to the ODB, but it does seem like a good idea.
>
> Likewise, I'm not sure if "get" should be allowed to return contents
> that don't match the sha1.

Yes, this is what I was getting at.  It would be ideal to come up
with a way to do the large-blob offload without resorting to hacks
(like LFS and annex where "the same object contents will always
result in the same object name" is deliberately broken), and "object
name must match what the data hashes down to" is a basic requirement
for that.

Thanks.
