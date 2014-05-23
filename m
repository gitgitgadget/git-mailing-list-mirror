From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 1/3] replace: add --graft option
Date: Fri, 23 May 2014 14:22:14 -0700
Message-ID: <xmqqd2f4i41l.fsf@gitster.dls.corp.google.com>
References: <20140522211836.27162.80311.chriscool@tuxfamily.org>
	<20140522213307.27162.14455.chriscool@tuxfamily.org>
	<20140523195153.GB19088@sigill.intra.peff.net>
	<xmqqlhtsi7l7.fsf@gitster.dls.corp.google.com>
	<20140523202853.GH19088@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 23 23:22:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wnwv4-0003du-93
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 23:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbaEWVWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 17:22:22 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51401 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750995AbaEWVWV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 17:22:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A80A81B7B9;
	Fri, 23 May 2014 17:22:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7id0Qb/E+gJoPC5RE2yJCc28l3M=; b=w++Vqv
	4B9TNnoJcDiWLVtzWtZI2Q35C/Ual5w9zkZsRI9hI2BTkzisVwtN5J2zeAvCqDgp
	8fSFXGNMcdDxpd768lnGkFmfe5kFOMy32w486O+H2lkSt5J8Dvg8VkwQTbTsnvxL
	wdJsok495UGpolD5BvO/ieU5eL7ihmkA/wQiw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tHd18l8g1uWYaXyFjHwdUc4irHafRU6Z
	ao9eViI4sOcLXo8pho0cq0gFujouuNYxnU1TVqONVR/jrn4b53TQ3/9x4swxaBxZ
	9P1nzqYMU+Gcpvxjt4WZSf1MdUMuw+COzzY6/s3J+4j4VCXqDiodc1MhZ3p920qK
	Db8hN36kZoU=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9BC681B7B8;
	Fri, 23 May 2014 17:22:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C53051B7B2;
	Fri, 23 May 2014 17:22:15 -0400 (EDT)
In-Reply-To: <20140523202853.GH19088@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 23 May 2014 16:28:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 50308B52-E2C0-11E3-AEEC-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250033>

Jeff King <peff@peff.net> writes:

> On Fri, May 23, 2014 at 01:05:40PM -0700, Junio C Hamano wrote:
>
>> I just read read_graft_line(); it allows an empty line (both
>> length-0 before the terminating LF or CRLF, and a line with
>> isspace() only) and ignore them, so "grep '^[^#]'" is not
>> sufficient.
>
> Thanks, I missed the space trimming. I think:
>
>   grep '^[^# \t]'
>
> would be enough, though I am not sure that "\t" is portable over a raw
> tab.

Perhaps.  That would filter out an empty line as well, which would
be good.

>> Perhaps a more future-proof way to write Christian's code may be:
>> ...
>> which may not be too bad.
>
> Sounds familiar:
>
>   http://article.gmane.org/gmane.comp.version-control.git/249575

Yup, instead of having to memmove() repeatedly, copying into it
while skipping 'parent ' lines may be better.
