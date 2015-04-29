From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git show' with multiple revisions
Date: Wed, 29 Apr 2015 08:53:24 -0700
Message-ID: <xmqqtwvz53t7.fsf@gitster.dls.corp.google.com>
References: <loom.20150428T120412-982@post.gmane.org>
	<20150429020452.GA873@peff.net>
	<loom.20150429T174544-7@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ed Avis <eda@waniasset.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 17:53:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnUIm-0004bM-Cd
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 17:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966239AbbD2Px2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 11:53:28 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64848 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966209AbbD2Px1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 11:53:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1502E4C704;
	Wed, 29 Apr 2015 11:53:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VWe1vVVBg08PBoWygpN+DrVu85Y=; b=vXtzqB
	zJ3lgJZYzWeAKqhKAsGhpNBEqUgm4KAtvo9ozn6C1R+xAkZAGWBCefQ6Od/U5wUv
	YFUhwbmQyaUb9ufFBkTCbXiSztw7BD5a6qnfIS+iaJCKRICImG8M2bftuIN+MplK
	l2WBCQZ6CQsOBiFynoAgbvxITAk4ppLaAUlR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GpeYFpStZVnB0G9mvmitWEn2vqJuBd4X
	ZtS2F7v/EmZuJtKbqYFigdvhMb+nWvHGy12TCfTB8oOg3X8U9c2nitZfa9ZjMiCY
	Gf0B7UYoxb/BWiMxj36xN2zGD4V1j06xKKI6TzOBcRVGHPOEBnN4iDiBobPYMYNU
	6/EPmE8JIko=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0695A4C702;
	Wed, 29 Apr 2015 11:53:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 753C24C6FF;
	Wed, 29 Apr 2015 11:53:25 -0400 (EDT)
In-Reply-To: <loom.20150429T174544-7@post.gmane.org> (Ed Avis's message of
	"Wed, 29 Apr 2015 15:47:33 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DEDC6E74-EE87-11E4-8410-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267979>

Ed Avis <eda@waniasset.com> writes:

> Jeff King <peff <at> peff.net> writes:
>
>>I think you want `git cat-file`:
>>
>>  {
>>	echo REV1:FILE
>>	echo REV2:FILE
>>  } |
>>  git cat-file --batch
>>
>>This prints a header line for each output object which contains the size
>>of the object (so a parser reads a header line, then N bytes, then a
>>header line, N bytes, and so on).
>
> This looks like what I want but the object ids printed appear to be the id
> of the file in a given revision - not the id of the revision itself.
> So the ids in the output are not the same as the ones in the input.

Actually you are asking for REV1:FILE and REV2:FILE, and you are
getting these object IDs in the output (you are not asking for REV1
or REV2 henace you will not see these commit object IDs).

"cat-file --batch" will give you the objects in the order you ask.
I _think_ you can even do that interactively (i.e. you spawn the
process, you feed one object name to its input, you consume its
output by reading the header and then given number of bytes, and
then you feed the next object name to its input, and so on) without
deadlocking yourself.
