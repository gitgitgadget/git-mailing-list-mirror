From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Support for HP NonStop
Date: Fri, 24 Aug 2012 14:50:43 -0700
Message-ID: <7vvcg8x8lo.fsf@alter.siamese.dyndns.org>
References: <005501cd822d$bf844bb0$3e8ce310$@schmitz-digital.de>
 <7v4nnsyrp7.fsf@alter.siamese.dyndns.org>
 <005701cd8239$1a828300$4f878900$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Fri Aug 24 23:50:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T51mG-000241-4r
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 23:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757812Ab2HXVur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 17:50:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59194 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752905Ab2HXVup (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 17:50:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13A9B9A6B;
	Fri, 24 Aug 2012 17:50:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RUD2fvPaHMtnMJeBYK/bxPfoAiU=; b=sbkxaU
	RMsd+9hauwbx5P7qMLFcpsQIWLScWaKlN/hmyLMPo3en18JHrSBWXiN5ejscKFFG
	J1uDiqxKeQ6YdW7WasFsRELXzCnixfbr1X4fNxrIRVdDwsnyCCMD4IgvvvB9ueKP
	xyySUA5Qx8VRlZIc4VfE0xHmagUEYVitnaPRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=woRAFlDzs7m+xTVFQ7lkvmSLEY1LG5b6
	Gc+DQVDZDz0x/yPltiREMHw2GHjqjaZj4n70nbp3SDz/poqMmFKsac2rS44M63WD
	2jvBJpnz2ZnHLurZ0c6obXQOwzz/hSmQKxbWRrLcreTzI0IS6OgBG3jF3AhqxUum
	tHER+rRK7/Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3A7F9A6A;
	Fri, 24 Aug 2012 17:50:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7161D9A69; Fri, 24 Aug 2012
 17:50:44 -0400 (EDT)
In-Reply-To: <005701cd8239$1a828300$4f878900$@schmitz-digital.de> (Joachim
 Schmitz's message of "Fri, 24 Aug 2012 22:43:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C17D3D18-EE35-11E1-AAEA-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204236>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

> Reminds me of a related issue: in compat/fnmatch/fnmatch.c there is this:
> #if HAVE_STRING_H || defined _LIBC
> # include <string.h>
> #else
> # include <strings.h>
> #endif
>
> There's no place where HAVE_STRING_H get set
> This looks wrong to me,...

This is because it is a borrowed file from glibc, and we try to
minimize changes to such a file.

If you need HAVE_STRING_H to force inclusion of <string.h> on your
platform, doing this:

>        COMPAT_CFLAGS += -DHAVE_STRING_H=1 # needed in compat/fnmatch/fnmatch.c

is perfectly the right thing to do.

> Do platforms exist without string.h?
> Maybe fnmatch.c should look like this instead?

We try to minimize changes to such a file we borrow from upstream;
especially we do not do so lightly when we have to ask "do platforms
exist?"  Of course, they do---otherwise glibc folks wouldn't have
written such a conditional.
