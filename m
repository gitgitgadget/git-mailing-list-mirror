From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/8] reflog_expire(): lock symbolic refs themselves, not their referent
Date: Fri, 13 Feb 2015 10:26:38 -0800
Message-ID: <xmqqk2zloeg1.fsf@gitster.dls.corp.google.com>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
	<1423473164-6011-9-git-send-email-mhagger@alum.mit.edu>
	<CAGZ79kaBGAOt-R1=mSG5H-5p=2UWjZEesktVwQcDAWFC-OW2Eg@mail.gmail.com>
	<xmqq61b8t65x.fsf@gitster.dls.corp.google.com>
	<CAGZ79kaaQWRXhph=0g3SRHKXMoW8eAp7QG21yuWXWd7OW4M+uA@mail.gmail.com>
	<54DCDA42.2060800@alum.mit.edu>
	<CAGZ79kZgjRNS3zd4Tif6M66mjkP6-tDpy4FAtio8jiwqHxUtgw@mail.gmail.com>
	<54DE259C.4030001@alum.mit.edu>
	<xmqqoaoxoffe.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZpCjcGeifbLztpNUSq7-3Yy2_GEVPGEQsxrgoZfLFU+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Carlos =?utf-8?Q?Mart?= =?utf-8?Q?=C3=ADn?= Nieto 
	<cmn@elego.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 19:26:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMKwv-0005M7-0G
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 19:26:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbbBMS0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 13:26:41 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53868 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751263AbbBMS0k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 13:26:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D82D936632;
	Fri, 13 Feb 2015 13:26:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EiXTgPSTZzf8Oo8W//XZm1Kx+jA=; b=DuR4IG
	19S/3YXM/eaVOdKNGBWbfuxK7OcK1/Qpg3rVpV/deFd56THh6t2LPEkzHrvl9nip
	WkYgfFnDfI5Bz2STKP52WqAGQUFsumIbu9RXHm2USCrYNHTS0RFIAM+X2OFp4hbq
	uEKgwJFTBV/QFnpZnAr/Vmpfc+MXNVBqGr8ts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=suKzthv/K+MtH2AQXSwDYo3p3zrcis+q
	PkKqmOh8w3g2hXLwrKFry5GmM5bqXQ+oB/XOzwqGhEYeXCUYQhfieow9pWjgFTy9
	RDgLLzELiPXP31EXVrjBPtspTu9fwRA0OJdEcFnitzoVSUJilSGYXzDtlwJXIJyr
	qBxlu113mQw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CD9C036631;
	Fri, 13 Feb 2015 13:26:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 355EE36630;
	Fri, 13 Feb 2015 13:26:39 -0500 (EST)
In-Reply-To: <CAGZ79kZpCjcGeifbLztpNUSq7-3Yy2_GEVPGEQsxrgoZfLFU+g@mail.gmail.com>
	(Stefan Beller's message of "Fri, 13 Feb 2015 10:21:22 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D9D015BC-B3AD-11E4-8FFC-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263818>

Stefan Beller <sbeller@google.com> writes:

> On Fri, Feb 13, 2015 at 10:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> We convinced ourselves that not locking the symref is wrong, but
>> have we actually convinced us that not locking the underlying ref,
>> as long as we have a lock on the symref, is safe?
>>
>> To protect you, the holder of a lock on refs/remotes/origin/HEAD
>> that happens to point at refs/remotes/origin/next, from somebody who
>> is updating the underlying refs/remotes/origin/next directly without
>> going through the symbolic ref (e.g. receive-pack), wouldn't the
>> other party need to find any and all symbolic refs that point at the
>> underlying ref and take locks on them?
>
> As we're just modifying the ref log of HEAD in this case, we don't bother
> with where the HEAD points to. The other party may change
> refs/remotes/origin/next without us noticing, but we don't care here as
> all we do is rewriting the ref log for HEAD.
>
> If the other party were to modify HEAD (point it to some other branch, or
> forward the branch pointed to), they'd be expected to lock HEAD and
> would fail as we have the lock?

I was not talking about HEAD in what you are responding to, though.
Don't we maintain a reflog on refs/remotes/origin/HEAD?  Is it OK to
allow its entries to become inconsistent with the underlying ref?
