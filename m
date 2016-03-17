From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Makefile: allow po generation through po target
Date: Thu, 17 Mar 2016 15:42:08 -0700
Message-ID: <xmqq8u1gzpz3.fsf@gitster.mtv.corp.google.com>
References: <56EAC47F.6000708@drmicha.warpmail.net>
	<2296423d1c46365f1fdeaa12cd1917bc859ff8d9.1458227678.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 17 23:42:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aggcp-0003DZ-NI
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 23:42:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936915AbcCQWm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 18:42:26 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60343 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S936856AbcCQWmS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 18:42:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 82AEE4C447;
	Thu, 17 Mar 2016 18:42:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nSsx8dB/RfPYKPqmbfvsVwVZyu0=; b=uR5ctq
	bxvNtL4VQkQpXOazNpq42kw14K2xSVVbMh612eSmjHUfxT8ACINgW3FbevDqsTIL
	GTjQ4POR1Tm/VpmVlUSZBes0uYZo01w268fm5qhZD+RtIYI3EAjJJokxn3+ZB7YG
	u3lcdt5sl8uUe8GDlfrZutMGEaKANSTXCfq60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QJ1O7z2gkC/6C8mOcpLcA0UFkvLxSFS5
	J/yRFdbUE4DliLBXXZOc6B09958jGlHkj4crs5i9//ajAB7OHVS+Lk9TjjUtx9Bx
	Mz2Iy+LA0jYlmBL0u806KvB839nkSU6brZMSSzqE8+19O5+rDwxzTZejzGTxz3pb
	JHzUyO17l20=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7986E4C446;
	Thu, 17 Mar 2016 18:42:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F30EA4C445;
	Thu, 17 Mar 2016 18:42:09 -0400 (EDT)
In-Reply-To: <2296423d1c46365f1fdeaa12cd1917bc859ff8d9.1458227678.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Thu, 17 Mar 2016 16:14:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7C09BBF4-EC91-11E5-999F-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289165>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> The main Makefile has a "pot" target that recreates the git.pot file of
> strings which are marked for translation.
>
> Add a "po" target that recreates the $(LANGUAGE).po files which contain
> the translations (or stubs).
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>
> Notes:
>     This makes it easier to recreate po (and mo) without reading po/README.
>     Alternatively, one may think about a Makefile in po/ which does both pot
>     and po updates, just like we have makefiles in t/ and Ducumentation/.
>     
>     This doesn't give you proper before-after diffs yet, but at least the after
>     state.

More seriously, the "before state" does not exist anywhere, because
*.po and *.pot are expected not to be in sync with the source, and
after a code developer runs "make po", because she does not know all
the languages we have *.po for, she has to "git checkout" to erase
the changes made by "make po".

So while your starting discussion (i.e. RFC-ness of this patch) is
very much appreciated, I do not think this is a good change we would
want to base further work on top.  For "before-after-diff" purposes,
the targets for before and after should drop their output in an
untracked build artifact, instead of overwriting tracked files, I
would think.
