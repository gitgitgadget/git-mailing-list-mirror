From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG? git log --no-merges shows grafted merges in shallow clones
Date: Fri, 26 Feb 2016 12:13:34 -0800
Message-ID: <xmqqbn73jklt.fsf@gitster.mtv.corp.google.com>
References: <vpq4mcvs146.fsf@anie.imag.fr>
	<xmqqfuwfjl8e.fsf@gitster.mtv.corp.google.com>
	<vpqwpprqlt4.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Feb 26 21:13:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZOli-0006Mb-JE
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 21:13:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbcBZUNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 15:13:38 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60951 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755063AbcBZUNh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 15:13:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 414C3460C8;
	Fri, 26 Feb 2016 15:13:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oIJ+YCdMRQZK/FSp1FY1L1DwRIo=; b=o9fd9Q
	+bP1c++OAhnu4PUOYUczv33hJ4m/WshtPDcEUvKtmxULDTJn4Crj+Dt2ZB8LSbsF
	W8E7RkzbVNnT/eOLwuwdakL3iaKtBxPEyEDA48n3kl4KE3GhlzsAbfXHew9FNjki
	Z9PUiKm8h3x0MkHZN3+TJz4EobKzeY+BtPkzc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JoqO5rB5/q69H/I0Y7HifYdot5X/p4AN
	F/IqEaA6DMzVkLbMP6CklIdgeGgbaS0eGuRXdBg7WJziaaNhUVocMZcsoNz1fIag
	kGmTBQQn+qX5X5sU2BdSVbuWydU8MMWNDN7MOAcYGnxUhCwNPG5Ff/tUtnl5PTyJ
	v3AN3RxtTtk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 38EBD460C7;
	Fri, 26 Feb 2016 15:13:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A70A5460C6;
	Fri, 26 Feb 2016 15:13:35 -0500 (EST)
In-Reply-To: <vpqwpprqlt4.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	26 Feb 2016 21:05:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6A6EFF34-DCC5-11E5-A37B-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287618>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I do not think this is limited to shallow but for grafts in
>> general.  
>
> Probably yes. I happen to only use grafts in shallow clones ;-).
>
>> cat-file is low-level to show the bare metal, but by using these
>> facility you asked Git to give you an imaginary history where that
>> commit is the root commit--and that is why it is shown, I think.
>>
>> What does it do if you say "git -c log.showRoot=false log -p"?
>
> I get the commit without the patch:
>
> commit c3c1cc25b27d448e9ef67b265a11be8735ff2df4 (grafted)
> Author: Matthieu Moy <Matthieu.Moy@imag.fr>
> Date:   Mon Aug 31 16:32:20 2015 +0200
>
>     Merge remote-tracking branch 'edward/utf-8-email-support4'
>
> Without "-c log.showRoot=false" I get a big patch (diff of the commit
> against the empty tree).

... which shows that Git is consistently pretending as if that
commit is the root commit, which in turn means that it is correct
for "log --no-merges" to not peek into the information at "cat-file
commit" level.
