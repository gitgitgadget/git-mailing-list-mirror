From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/16] refs: add methods for the ref iterators
Date: Mon, 04 Jan 2016 19:29:51 -0800
Message-ID: <xmqq37ucln4g.fsf@gitster.mtv.corp.google.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
	<1449102921-7707-4-git-send-email-dturner@twopensource.com>
	<20160103000623.GB14424@gmail.com>
	<CAL=YDW=3JE==2s7Y3-fVRnTgaAzT674CAnypuXOKynpfD0q=Bg@mail.gmail.com>
	<xmqqegdxnlba.fsf@gitster.mtv.corp.google.com>
	<20160105011711.GA31667@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Aguilar <davvid@gmail.com>,
	David Turner <dturner@twopensource.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 05 04:30:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGIJt-0007Em-6m
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 04:30:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048AbcAED34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 22:29:56 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57031 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751925AbcAED3y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 22:29:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B2B7538658;
	Mon,  4 Jan 2016 22:29:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bTmLuIgtSWTavje1dv3owZL+e/s=; b=wv8SRR
	eYCdrzRsynbKBrzmVuTsN3iEbtbgfKYNgcr/AYcbtZZnAg63II30mzFZfevF/3As
	GyrtdN9ylyRuv9l00joPPePQKIZE/xazGmjzCIZ+SchI9gKXn4Ejwgrs0JYXZD6v
	OziNypgK1dCSExLN6+l8yGOqLYRUY6Tk7LoAg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GftenA8eRSjQRoQGzTVd8fBoCg35QU5i
	RLCm08AIQ9SUlRGqFXIJENDmW0oB0hZxk4RyeG0uaZmW1qGFu8smYpDY+p9RjYnc
	4S16f8oARxefv861LJLGdRL/80FjNjef7FVnvhbSy5i27ZlRkrYGpXYbPQpuq3Yi
	vbYpxyorHtk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A927338657;
	Mon,  4 Jan 2016 22:29:53 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1EBCA38656;
	Mon,  4 Jan 2016 22:29:53 -0500 (EST)
In-Reply-To: <20160105011711.GA31667@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 4 Jan 2016 20:17:11 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 958D75C0-B35C-11E5-9BAD-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283342>

Jeff King <peff@peff.net> writes:

> As much as it would be nice to clean this up before moving to multiple
> backends, though, I don't think we should make it a pre-requisite. This
> is a difficult topic as it is, and I'd rather see us make incremental
> improvement (backends, then hopefully more flexible mixing of backends)
> than get bogged down and get neither.

Oh, yes, if I sounded like this needs to be cleaned up before it can
go in, that wasn't what I meant.  After all, the single in-core
index support was adequate for our use even before the multiple
in-core index support was introduced, and we still use the API to
access the single default instance in most of the codepaths.  I'd
expect that the ref API will evolve in the same way.
