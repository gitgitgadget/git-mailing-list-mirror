From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 4/4] remote-curl: main test case for the OS
 command line overflow
Date: Tue, 27 Mar 2012 10:43:17 -0700
Message-ID: <7vzkb2hrd6.fsf@alter.siamese.dyndns.org>
References: <loom.20120318T083216-96@post.gmane.org>
 <m3fwd550j3.fsf@localhost.localdomain>
 <20120318190659.GA24829@sigill.intra.peff.net>
 <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com>
 <20120319024436.GB10426@sigill.intra.peff.net> <4F69B5F0.2060605@gmx.net>
 <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com>
 <20120321171423.GA13140@sigill.intra.peff.net> <4F715CF7.5070903@gmx.net>
 <4F715DF6.7080401@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Ivan Todoroski <grnch@gmx.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 19:43:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCaQg-0007Zl-Mu
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 19:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754708Ab2C0RnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 13:43:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62775 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754635Ab2C0RnT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 13:43:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5ED0460F2;
	Tue, 27 Mar 2012 13:43:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k7WGoiCIs9Ec8mjz1MeN0BEkHZ0=; b=C950vm
	xOSuSizmSSnBaAVJ1YblIA75vHYsJZTza7fOkGrmE+KCC0C8LoSHGWlWmiG9wzPC
	VcsVwr95qRGX0Ink6KJouhl14kTL/FqKcI42ZoYdwXeT7vZOlf2zQZRcqe9jRcWT
	lCIcbarB5C9K8IX/s96k/lKN8bKzK6FvYjacs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lIRl2qJUPvS5Vhv9CFJKJWYeczAoYqHi
	Ae9L94+bJXgtltkP+9suDafUjyEJBHUWPKeaGjAqjsXfmceZK9sjjSFv9disY+jw
	YdbXMfWT4RpUlOpqJzyBOAkX+MwdrsZwYig363CSWpD6qP3MRnnpVOXyUwbhaXRL
	2QC7Ld7C1VI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56E3060F1;
	Tue, 27 Mar 2012 13:43:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF94960EF; Tue, 27 Mar 2012
 13:43:18 -0400 (EDT)
In-Reply-To: <4F715DF6.7080401@gmx.net> (Ivan Todoroski's message of "Tue, 27
 Mar 2012 08:28:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 56E4EEB4-7834-11E1-AC4E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194062>

Ivan Todoroski <grnch@gmx.net> writes:

> +test_expect_success EXPENSIVE 'create 50,000 tags in the repo' '
> +	(
> +	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> +	N=50000 &&
> +	for ((i=1; i<=$N; i++)); do

That's bash-ism isn't it?

	N=50000 I=1
        while test $I -le $N
        do
		...
                I=$(( $I + 1 ))
	done

The body of the test itself looked reasonable.

Thanks.
