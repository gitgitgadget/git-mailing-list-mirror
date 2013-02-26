From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Add pthread support in QNX. Do not declare NO_
 macros if they can be autodetected.
Date: Tue, 26 Feb 2013 10:01:47 -0800
Message-ID: <7vbob7lzsk.fsf@alter.siamese.dyndns.org>
References: <CAHXAxrPTe6Q4BPtsGjiRnfFjZjUjwY6qXSAtZCzzAthODzA6EA@mail.gmail.com>
 <7vhal0z4a5.fsf@alter.siamese.dyndns.org>
 <CAHXAxrO8c8=d+og7rJexY4MKyKMYrWAzFYLMLRKVqtoaB6DUdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matt Kraai <kraai@ftbfs.org>
To: Mike Gorchak <mike.gorchak.qnx@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 19:02:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAOrE-0006Ja-Jf
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 19:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529Ab3BZSBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 13:01:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40569 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759619Ab3BZSBw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 13:01:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD2A6AD63;
	Tue, 26 Feb 2013 13:01:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lm4V2Y8tpTB8f5cmg3Vzn3sA8r0=; b=QYnCPO
	oQgyRFNTCLJDoHEriA3vvz0x0BBbq/d6+XISVkJ1z/NCAlH0KUVCQ2a8u2lbFT4/
	m9Y/GMMNMJSNOPodiKcrcxey2NwZ8G3w1qNqu3s/nz1IdVBx4kYCLYK+/jlpwUe7
	ujB/iDx3PkCkHebNB6SQQIjYm8/lHmOpSMhiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LQFzjPPLqsZN5QRtQqWPXXCTqOGnIqFu
	XePBCiRf9IQJDLiWXDbZRpnt2jgFpQrGu3cZ6p4ir4Dk2MVwlq+xIt55MfSPhTTN
	ySSzAhq/g8gokAqpC6bKP66ggDX/MVugwwVOaCtNnz6cOe/+Fce9/V7axxnMaRgV
	BZppzjqSorA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 435D6AD5D;
	Tue, 26 Feb 2013 13:01:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8665BAD4A; Tue, 26 Feb 2013
 13:01:50 -0500 (EST)
In-Reply-To: <CAHXAxrO8c8=d+og7rJexY4MKyKMYrWAzFYLMLRKVqtoaB6DUdQ@mail.gmail.com> (Mike
 Gorchak's message of "Mon, 25 Feb 2013 20:19:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 984E9E5A-803E-11E2-ACE1-F3C82E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217153>

Mike Gorchak <mike.gorchak.qnx@gmail.com> writes:

>> Also, please leave the "autodetection" out.  If it is common to have
>> strcasestr (or any other) on a newer QNX, then not defining the
>> symbol NO_STRCASESTR in this file may still be the right thing to
>> do, but the justification for such a change should not be because we
>> rely on "autodetection".  The defaults given in config.mak.uname is
>> primarily for people who do not use the optional ./configure script,
>> so pick the default to help the most common configuration for the
>> platform.
>
> I see. I thought configure is the only legal way to build the git and
> config.mak.uname is used to override settings produced by configure.
> But it works vice versa configure settings override config.mak.uname
> settings. Please do not commit this patch. This patch brokes QNX 6.3.2
> build.
>
>> I'd rewrite the patch like the attached, and tentatively queue the
>> patch to 'pu', but I do not use or have access to QNX myself, so you
>> may have to adjust the default set of symbols and the log message
>> and in such a case, please do re-submit a fixed version.
>
> I will re-do the patch.
>
>> Specifically, I do not know if "... and others are also supported"
>> is universally true with QNX 6; if not, we need to define NO_* for
>> them to help people who build without using the ./configure script.
>
> Ok.

I saw Matt has comment on this patch, so I'll keep the patch out of
'next' for now and let you two figure it out.

Thanks.
