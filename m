From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge-recursive: option to disable renames
Date: Tue, 16 Feb 2016 15:43:32 -0800
Message-ID: <xmqqoabgkyqj.fsf@gitster.mtv.corp.google.com>
References: <1455583834-4796-1-git-send-email-felipegassis@gmail.com>
	<xmqqegccmikn.fsf@gitster.mtv.corp.google.com>
	<CALMa68q+TgAXS0=xc1CpZ2nbzGb+TWafWCUXZhGrWPzFL5_AQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Felipe =?utf-8?Q?Gon=C3=A7alves?= Assis 
	<felipegassis@gmail.com>
To: Felipe =?utf-8?Q?Gon=C3=A7alves?= Assis <felipeg.assis@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 00:43:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVpHR-0000kh-2y
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 00:43:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933511AbcBPXnh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 18:43:37 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57869 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933360AbcBPXnf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 18:43:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 06E3445C3F;
	Tue, 16 Feb 2016 18:43:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jfI0ARXW3Nmz
	eydz8dbRZzpzhPs=; b=LFL4QhsEbii38KTvpag5BHSBtU5lMuWW+YzMdRtKxXEB
	Q0yMfNnRiOQTCsEeo7D9iydoiGvupAV9ENrprZfm5EFEFOUOlF8bX6ywp83V8vrj
	jdMIEZoiK9VqlVemcwC/L+n0d3V4JaUUKvpULASFo58g7xKsW3Jy9hpxHn++hXo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rdYUeF
	lOwpvE6d89REALQW/fGkk7z8AoLHzhaD6OuK3abnhR4rKmnOB9rsMUARbzbseaSy
	SGbjQVXhR8XWLXmeK0o21hIiOtma5tW1VkuSki06WRE+W73kvuSz+LM1UZoI7Wr5
	p+UUdM+/kJDt3l9GLZ53f+hupStVg1blnOkXk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F183E45C3C;
	Tue, 16 Feb 2016 18:43:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 71F3545C39;
	Tue, 16 Feb 2016 18:43:33 -0500 (EST)
In-Reply-To: <CALMa68q+TgAXS0=xc1CpZ2nbzGb+TWafWCUXZhGrWPzFL5_AQQ@mail.gmail.com>
	("Felipe =?utf-8?Q?Gon=C3=A7alves?= Assis"'s message of "Tue, 16 Feb 2016
 20:42:05
	-0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 172A5C26-D507-11E5-80C8-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286459>

=46elipe Gon=C3=A7alves Assis <felipeg.assis@gmail.com> writes:

> Just a note: In git-diff, there is no "--renames". Instead, renames
> are enabled by the "--find-renames[=3D<n>]" option.
>
> 1. Do you think "rename-threshold=3D<n>" should enable renames?

I do not think it matters in practice, but if you have

	git merge-recursive --no-renames --rename-threshold=3D50%

in mind, yes, I think it is OK for the latter to flip "do we do the
rename detection?" switch on.  Afger all, that is what happens in

	git diff --no-renames --find-renames=3D50%

> 2. Should we have an option "find-renames" in merge?
> 3. Should git-diff have a "--renames" option?

Good questions.  I think the existing command line options to
merge-recursive are misdesigned.  It should not have invented
rename-threshold at all and instead used --find-renames=3D<n>.

We could declare that "--rename-threshold=3D<n>" that merge-recursive
has is a synonym to "--find-renames=3D<n>" that exists for hysterical
raisins, and start supporting "--find-renames=3D<n>" as the "kosher"
version.  That would align the two commands better.  But I view it
as a much lower priority than adding "--no-renames".

> I personally like your suggestion as it is. Just wanted to make sure
> you considered that while I work on the next patch.

I didn't actually check what longhand "-M" has in the diff land.  It
was a long time ago I wrote that code ;-)

=46or now, I would think the following is sensible:

   * Add "--no-renames" (but not "--renames") to merge-recursive;

   * Teach "--rename-threshold=3D<n>" in merge-recursive to enable
     rename detection if it was disabled earlier.

Optionally:

   * Teach merge-recursive to take "--find-renames=3D<n>" as well, and
     behave the same way as "--rename-threshold=3D<n>" does, after
     doing the two things above.

Thanks.
