From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] git-am: support any number of signatures
Date: Mon, 16 Jun 2014 11:06:20 -0700
Message-ID: <xmqqy4wwraoz.fsf@gitster.dls.corp.google.com>
References: <1402589505-27632-1-git-send-email-mst@redhat.com>
	<xmqqioo654mg.fsf@gitster.dls.corp.google.com>
	<20140613080036.GA2117@redhat.com>
	<xmqqy4x03ecm.fsf@gitster.dls.corp.google.com>
	<20140615102736.GA11798@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 20:06:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbIk-0005V4-Vw
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbaFPSG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:06:29 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65306 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932408AbaFPSG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:06:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1AB131FD89;
	Mon, 16 Jun 2014 14:06:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L4Ex2WYdMoghQ/ctq9pfShA3a8E=; b=Ee4UQh
	MIzC6zF1IpnjR3Rv5Gt7zO155LCmoOARxt9LTuTdIo+SrNszsfS/YT0tL39SwVz4
	MmF04FQ/rlakJiPXegvSbXwfsM7Ptfp+BaM4jjIbU0rDgcBjQk7fKnC2yCoH5+CP
	e9xxSmYVYfm7HIGYI5pDrITzIoWLElkKtWBW4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R8yvJ2Ut6fqK6u7+Ggb3X22gNQWjz/Mh
	fqcKkhz5LtBMzlanhwipZfQclsqFu0zdSFLW+9LIyN0aGYNqi2bfneHsD9mejXvo
	ZunezlK6gWlISYLVqB0FzOmoI9JKB3D8TW5NC1WfHOufR9ds1uFytRqjwqxa6tGt
	4EiCsCKxsBg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 105411FD88;
	Mon, 16 Jun 2014 14:06:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A62141FD87;
	Mon, 16 Jun 2014 14:06:19 -0400 (EDT)
In-Reply-To: <20140615102736.GA11798@redhat.com> (Michael S. Tsirkin's message
	of "Sun, 15 Jun 2014 13:27:36 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EAE89F40-F580-11E3-AEFF-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251760>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Now A wants to sign this patch.
>
> I think there are two reasonable ways to behave:
> 1. What you describe above:
> A
> B
> A

That is the only sensible thing to do for Signed-off-by footers.

> 2. For things like Tested-by: tags, removing tag from
> where it was and adding it at the bottom:
>
> B
> A

You can make it arbitrarily more complex.  A sends with sign-off, B
tweaks and tests *that* version and forwards with sign-off, A
further tweaks, which may invalidate the earlier tests, so A asks B
to retest and then forward it to Linus when everything checks out.

What should the end result look like?

	SoB: A
	SoB: B
        Tested-by: B
        SoB: A
        Tested-by: B
	SoB: B

perhaps?

> This probably calls for a separate feature:
> maybe adding "acks" along with "signoffs"?
> acks would be unique, re-adding ack removes it from
> the message and adds at the bottom.

This kind of complication is mostly up to the policies of the
projects that are users of Git, and not something we as the Git
project want to set in stone inside "git am" implementation.

Perhaps consult what has been discussed on Christian's "trailer"
series in the list archive and then think about how to integrate /
make use of it inside "am"?
