From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 0/3] some enhancements for reporting branch tracking info
Date: Sun, 18 Aug 2013 12:51:56 -0700
Message-ID: <7v7gfiojz7.fsf@alter.siamese.dyndns.org>
References: <7vzjsio99d.fsf@alter.siamese.dyndns.org>
	<cover.1376618877.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 18 21:52:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB91A-0005qG-Ct
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 21:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754427Ab3HRTwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 15:52:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64889 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752495Ab3HRTv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 15:51:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 056FA3A4F3;
	Sun, 18 Aug 2013 19:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NP6xZu9gbmMdhe8vj4tVh59LfNs=; b=DyTyz1
	sezYcCM6NVZLo96+7S04zvuPnimaoMkU9sjB0eIWkAyENF2bYOe+1PY4rRo3/wsY
	aQ+h1KBdf9sEvzIaK2V47msY8iuhEb0hUlOYJ4+CRm29xvtHyji+hcAKbDpM2uVF
	qgrrKoS8rdpMLjElj7zomz7ZghRhnHnPwLypM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tM2gCtjpWbdi4qYHV9kqhm8eiTeeGhr0
	yTisNVF0hts4O2Z12zxb6pDIkqdTmOSLSUv0xnrDP7UwfzAUdbhL7A1xBDBFBktl
	2qhaEq2QhG1y9aiM86WwSWvfdN7didp97jLrHI1KKT3GTBgjN5GecPIyS7gAQ2Lh
	OAZPtGlOEDk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBDAD3A4F2;
	Sun, 18 Aug 2013 19:51:58 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 328243A4EF;
	Sun, 18 Aug 2013 19:51:58 +0000 (UTC)
In-Reply-To: <cover.1376618877.git.worldhello.net@gmail.com> (Jiang Xin's
	message of "Fri, 16 Aug 2013 10:29:31 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A435545A-083F-11E3-B205-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232513>

Jiang Xin <worldhello.net@gmail.com> writes:

> Changes since v6:
>
> * s/broken/gone/ in [PATCH 2/3] (branch: mark missing tracking branch
>   as gone)
>
> * rewrite commit log for [PATCH 3/3] (status: always show tracking
>   branch even no change)
>
> Jiang Xin (3):
>   branch: not report invalid tracking branch
>   branch: mark missing tracking branch as gone
>   status: always show tracking branch even no change
>
>  builtin/branch.c         | 36 ++++++++++++--------
>  remote.c                 | 72 +++++++++++++++++++++++++--------------
>  t/t6040-tracking-info.sh | 89 +++++++++++++++++++++++++++++++++++++++++++++---
>  wt-status.c              | 26 +++++++++++---
>  4 files changed, 175 insertions(+), 48 deletions(-)

Thanks; getting clearer to read.

I however feel that [1/3] is introducing a regression (what we used
to report, gone branches, are hidden), only to correct the
regression immediately after it with [2/3].

I wonder if these patches should be combined into one, with
justification like "with the current code, a branch that is in sync
with its upstream, a branch whose upstream no longer exists and a
branch that does not build on anything else cannot be distinguished;
show the first class as 'same', mark the second class as 'gone', and
show only the last one as not having any uptream', or something.
