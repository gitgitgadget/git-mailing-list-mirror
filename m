From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Bump core.deltaBaseCacheLimit to 128MiB
Date: Thu, 20 Mar 2014 10:02:39 -0700
Message-ID: <xmqqsiqcztu8.fsf@gitster.dls.corp.google.com>
References: <1395232712-6412-1-git-send-email-dak@gnu.org>
	<xmqq38id3nfs.fsf@gitster.dls.corp.google.com>
	<87ob11g9st.fsf@fencepost.gnu.org>
	<xmqqlhw5260l.fsf@gitster.dls.corp.google.com>
	<CACsJy8C3=bz1HmVgQuJRdixMhhb-JKouM7b1L7M047L_4PBViA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 18:03:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQgN3-0006wz-Ql
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 18:03:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758436AbaCTRCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 13:02:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59343 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757510AbaCTRCn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 13:02:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38AEE748E9;
	Thu, 20 Mar 2014 13:02:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XHpvWyckKDKxfW1s+iNhVs6hw2g=; b=uF4kFJ
	6jJcm6GarJx/kG1PIUQkey9KI1VI+G9t8LgnSH8NjfoMSTrT8Qnup4KvgY8ipxoF
	Rg4f4EXwqeEuIzxssgeHI3XI6OrHtkY5CgtkVDIjLwPjH3WwYPMXG6RXDM3kKt5y
	TgH3t//pT/Tvmuxdrq95HWtr3Pyl5MFV/U0i8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZGk6vg/GoABkFLyGVIXHpwMY5beNbe0W
	/jZCmWbba002t8iV9BsXngdT2syjpqqZkF+jmWThnanS+0OlSQfQZV2Jk0biqJbd
	lbFPfF5tC43V8pL+Xy/G/0SHMuIDzpleKVgNWz3TnXAjjdaFZOcehTcE7SyH6ykg
	K3j3g5kUQFc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 255D1748E8;
	Thu, 20 Mar 2014 13:02:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B9A4748E2;
	Thu, 20 Mar 2014 13:02:42 -0400 (EDT)
In-Reply-To: <CACsJy8C3=bz1HmVgQuJRdixMhhb-JKouM7b1L7M047L_4PBViA@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 20 Mar 2014 08:38:18 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 732EC5CA-B051-11E3-810C-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244559>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Mar 20, 2014 at 5:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> I know that the 512MiB default for the bitFileThreashold (aka
>> "forget about delta compression") came out of thin air.  It was just
>> "1GB is always too huge for anybody, so let's cut it in half and
>> declare that value the initial version of a sane threashold",
>> nothing more.
>>
>> So it might be that the problem is 512MiB is still too big, relative
>> to the 16MiB of delta base cache, and the former may be what needs
>> to be tweaked.  If a blob close to but below 512MiB is a problem for
>> 16MiB delta base cache, it would still be too big to cause the same
>> problem for 128MiB delta base cache---it would evict all the other
>> objects and then end up not being able to fit in the limit itself,
>> busting the limit immediately, no?
>>
>> I would understand if the change were to update the definition of
>> deltaBaseCacheLimit and link it to the value of bigFileThreashold,
>> for example.  With the presented discussion, I am still not sure if
>> we can say that bumping deltaBaseCacheLimit is the right solution to
>> the "description with the current setting is clearly wrong" (which
>> is a real issue).
>
> I vote make big_file_threshold smaller. 512MB is already unfriendly
> for many smaller machines. I'm thinking somewhere around 32MB-64MB
> (and maybe increase delta cache base limit to match).

These numbers match my gut feeling (e.g. 4k*4k*32-bit uncompressed
would be 64MB); delta cash base that is sized to the same as (or
perhaps twice as big as) that limit may be a good default.

> The only
> downside I see is large blobs will be packed  undeltified, which could
> increase pack size if you have lots of them.

I think that is something that can be tweaked, unless the user tells
us otherwise via command line override, when running the improved
"gc --aggressive" ;-)
