From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t3010 broken by 2eac2a4
Date: Thu, 22 Aug 2013 14:32:42 -0700
Message-ID: <xmqq7gfdqumd.fsf@gitster.dls.corp.google.com>
References: <82078845-3AB9-4B36-9130-039CC33C8A7A@gernhardtsoftware.com>
	<xmqqbo4qu3g4.fsf@gitster.dls.corp.google.com>
	<CAPig+cQHTvmTWvGfg1Z3KfBrPD+QbSEbYBYz6XWT3KKu3-+jyQ@mail.gmail.com>
	<xmqqbo4pqvde.fsf@gitster.dls.corp.google.com>
	<CAPig+cQmvRDDc3BHbta_UhCQe9QvbtAm0RJgt6HbtgFAKgo0Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git\@vger.kernel.org List" <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Aug 22 23:32:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCcUv-0006Bu-KT
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 23:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934Ab3HVVct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Aug 2013 17:32:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52771 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753813Ab3HVVct (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Aug 2013 17:32:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66DAB3B09A;
	Thu, 22 Aug 2013 21:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Im2tAVSW6xR+zSb/cbluaHfXijo=; b=t9cHSu
	mUHNrQ8fjSektpDTCrzwBITJKIjVWtiIGgLpsMVGCzPPvLgo0/uWQQa3pJuwIBV1
	ZHDXCLItW92uCpG02luSctdXCdev1tz9lQgVuGj3wB/gYI0UcVtkk0t0fGjAguQ8
	4sa0cli6BCNpyKPggyTRAVIxSMTDtsgmYwO5o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s9tmdaVJmjA/UuW7XasTuRTEYLFffL0S
	jnNjVRCGPEE5t//nvW1k57EpaidkWDZNMC1g3vytEyZIlSnYRagIMahNs9knmtij
	en+9MTmMLYpuAv5PtQyVsTg4WTRnH49S262KxT3VziTNUqSfDdiw6e3RQdHrREeF
	3uhN5K1nWOE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E9C23B099;
	Thu, 22 Aug 2013 21:32:48 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2382E3B091;
	Thu, 22 Aug 2013 21:32:46 +0000 (UTC)
In-Reply-To: <CAPig+cQmvRDDc3BHbta_UhCQe9QvbtAm0RJgt6HbtgFAKgo0Vg@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 22 Aug 2013 17:22:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 62B6E8A0-0B72-11E3-90ED-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232780>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Aug 22, 2013 at 5:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>
>>> I can confirm this failure on OS X, however,...
>
> Thanks for the explanation.

Now, I am curious how it breaks on OS X.

My suspition is that "ignore_case" may have something to do with it,
but what 2eac2a4c (ls-files -k: a directory only can be killed if
the index has a non-directory, 2013-08-15) uses are the bog-standard
cache_name_exists() and directory_exists_in_index(), so one of these
internal API implementation has trouble on case insensitive
filesystems, perhaps?  I dunno.
