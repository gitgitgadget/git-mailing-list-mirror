From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status: be prepared for not-yet-started interactive rebase
Date: Fri, 22 Jan 2016 10:38:27 -0800
Message-ID: <xmqqio2lv4rg.fsf@gitster.mtv.corp.google.com>
References: <99f6de4be107044fdf01ee796f42e124ac147891.1453480067.git.johannes.schindelin@gmx.de>
	<vpqlh7h5zrh.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jan 22 19:38:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMgbd-0001bY-NQ
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 19:38:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767AbcAVSib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 13:38:31 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64941 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754140AbcAVSia (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 13:38:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 65BCD3D2C0;
	Fri, 22 Jan 2016 13:38:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cNUvZvmaOVe96kc01N33EO1ijrM=; b=iVsxrk
	3jc96irzpCSFKPeJ44xuk54IvpMfXPE83mM262gLZSZ2GO4G+NSxWuDcl8CjbOhq
	Zuk3QzXIQwl7xCuFHNdBU7xxJO/Bv6PaWzNEznldkXWF1li1DlJMrmYBUrzpKJff
	0WPA8ua6R7OVfoyB52Fcn4pGTwjWjVplfWacs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vhZAEmhPs+JEf+ghnAkE8Rhbw8ep27TZ
	1naxUCyVppe4aMKnoM59rJZls9AIqoATwUidhmkLpjW4r7+7881yxVeGs4jj6ahz
	tVtXqZwr4GaCH7ED7+f8njVUitfF/mefpuBi2jwpRhyJaEBmq5GcQ+v0hIYPS+BZ
	aRIQIk1sEzk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5C48C3D2BF;
	Fri, 22 Jan 2016 13:38:29 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BEA2E3D2BE;
	Fri, 22 Jan 2016 13:38:28 -0500 (EST)
In-Reply-To: <vpqlh7h5zrh.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	22 Jan 2016 17:45:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 546FD658-C137-11E5-9FBD-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284577>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
>>  wt-status.c | 22 +++++++++++++++-------
>>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> Looks good to me. You may want to add a test by overriding $EDITOR to a
> script doing "git status >actual" if you want to have fun with testing.

I am unhappy that the code does not read 'rebase-todo' at all when
'done' is missing.

If we cannot read 'todo', that would mean we shouldn't be in this
function in the first place, which is a sign of something more
serious; somebody created 'interactive' but did not leave 'todo' to
read for us--why?

A missing 'done' is much more benign and making us not to barf is a
worthy thing to do, but we shouldn't be removing protection against
a more serious error as its side effect.  That is what I am unhappy
about this change.
