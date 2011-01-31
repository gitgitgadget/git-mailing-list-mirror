From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] make two-argument fetch update remote branches
Date: Mon, 31 Jan 2011 14:24:12 -0800
Message-ID: <7vlj204sqb.fsf@alter.siamese.dyndns.org>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <201101312244.10047.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 31 23:24:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk2Ad-0006mw-As
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 23:24:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756319Ab1AaWYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 17:24:20 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39332 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755987Ab1AaWYT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 17:24:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8B0B14D60;
	Mon, 31 Jan 2011 17:25:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MRE2V3vNPSkHXJxNG3yPbj8ktdw=; b=H8vM1O
	9ZTMdxJTrLIhDufu9RjlHw4rudPioKgMraAL0QOWj4cKDUy2qklE8CELMtz1v92P
	V5X7zRPaJbbQoAkH+8zjCEf5arCNrh5654CAHJsrKSWTqxMcPsxjT/2SkAtxI61z
	+5/Vs03QKFyfmkjlJkgqEWz4oXNPYdMgTI2Vw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vbpQayAkJeSxpCXUtSJ6iSMY0CNUTXg4
	RB8DkpXdQ/fYDPfBRj9AdOUcFijgzDWXGpY5UgpH9AGxRJ5iMEpsavgmdW9V8M5l
	xOwQ/tbHSa9kWD6ck79+5bRmKe30G7wM+IrKaLv1FeBnNCRsdRZEiV4Gs4VLakEH
	K2AdAYVCBi4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 60D3A4D5F;
	Mon, 31 Jan 2011 17:25:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 69F6E4D5E; Mon, 31 Jan 2011
 17:25:06 -0500 (EST)
In-Reply-To: <201101312244.10047.trast@student.ethz.ch> (Thomas Rast's
 message of "Mon\, 31 Jan 2011 22\:44\:09 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F661C9AA-2D88-11E0-B0BC-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165764>

Thomas Rast <trast@student.ethz.ch> writes:

> Proposal:
>
> Running "git fetch origin master" only updates FETCH_HEAD, not
> origin/master, which turns out to be quite confusing for newcomers
> especially after running 'git pull origin master'.
>
> Since the remote branches in some sense reflect the "last known state"
> of the remote, it would make sense to also update them to whatever a
> two-argument fetch got.
>
> Risks:
>
> Scripts might rely on the current behaviour.  The most likely case I
> can think of would be to go along the lines of
>
>   git fetch origin master
>   git rev-list origin/master...FETCH_HEAD | do_something
>
> to avoid relying on reflogs to get the same result.  Seems a bit
> arcane to me though.  Such usage would see the updated state, i.e.,
> process an empty range.
>
> Migration plan:
>
> Add a fetch.updateRemoteNamespace (or so) configuration variable that
> defaults to false.  When enabled, it turns on the auto-updating
> behaviour.
>
> In 1.8.0, flip the default.

The overall goal is a good one, I think, but it is not a migration plan
without a period where we issue a loud, in-your-face, warning to force
users to choose, is it?  I suspect you just didn't write it because it is
so obvious, but I am just making sure it is written down somewhere, so
that whoever ends up implementing this will not forget.

Thanks.
