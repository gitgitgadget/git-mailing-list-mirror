From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] MSVC: Do not close stdout to prevent a crash
Date: Sat, 19 Nov 2011 19:27:02 -0800
Message-ID: <7vpqgniid5.fsf@alter.siamese.dyndns.org>
References: <1321710345-2299-1-git-send-email-vfr@lyx.org>
 <m2sjlkcgyl.fsf@igel.home> <7v39dkj5ad.fsf@alter.siamese.dyndns.org>
 <m2obw7dg1e.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vincent van Ravesteijn <vfr@lyx.org>, git@vger.kernel.org,
	msysgit@googlegroups.com, kusmabite@gmail.com,
	Johannes.Schindelin@gmx.de
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Nov 20 04:27:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRy3v-0007yl-2W
	for gcvg-git-2@lo.gmane.org; Sun, 20 Nov 2011 04:27:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755117Ab1KTD1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Nov 2011 22:27:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52625 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754993Ab1KTD1G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2011 22:27:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF9C75981;
	Sat, 19 Nov 2011 22:27:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xNCkUiwL83c1pOaypvJwVemBMeM=; b=r0ejVM
	RZbf+Ok4SzSOTnFFpuzrvyO91IBu+b7ltmoMcuY2iOSrqaV/p/4TxW1PYHuzZIJI
	pGPbMUlfrwZcKIgrCatAXf7fca5dffWIoY8iLo69e6Jz+0b2vA1cbnSnz6tYhhQ5
	PHxuEumiZHH2SvxssdPEee33W5bYBheEVNqAg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jv8iTEUi1E3srnZr4z3U8D8W0YzmYMDi
	bFOtdBqVzxsoFn20e8oXxFvhtnO6cmvp90UxUl2DPWSxNLONhDH6uyz1ZS2qRDOy
	cNeNNmciwR8OBMVh92u0FL6kYg7HjLffveRl4vE7ufLWw311itkgHqZyZIJOiD+/
	wyyCUxR+73M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C360C5980;
	Sat, 19 Nov 2011 22:27:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5759F597F; Sat, 19 Nov 2011
 22:27:04 -0500 (EST)
In-Reply-To: <m2obw7dg1e.fsf@igel.home> (Andreas Schwab's message of "Sat, 19
 Nov 2011 21:16:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 846525CE-1327-11E1-BD96-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185715>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> We have relied on fstat(-1, &st) to correctly error out, and if MSVC build
>> crashes, it is a bug in its fstat() emulation, I would think.
>
> fileno(stdout) is alread wrong if stdout was closed.

The "-1" in my message comes from here:

    DESCRIPTION

    The fileno() function shall return the integer file descriptor
    associated with the stream pointed to by stream.

    RETURN VALUE

    Upon successful completion, fileno() shall return the integer value of
    the file descriptor associated with stream. Otherwise, the value -1
    shall be returned and errno set to indicate the error.
