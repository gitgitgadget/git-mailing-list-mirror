From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why does git merge --squash fail when merge.ff is set to only?
Date: Wed, 26 Nov 2014 13:32:35 -0800
Message-ID: <xmqqh9xlps0c.fsf@gitster.dls.corp.google.com>
References: <1417030977.23650.42.camel@homebase>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: paul@mad-scientist.net
X-From: git-owner@vger.kernel.org Wed Nov 26 22:32:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtkCg-0005oU-KZ
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 22:32:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbaKZVcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 16:32:48 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58302 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752670AbaKZVco (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 16:32:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A93862196E;
	Wed, 26 Nov 2014 16:32:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eokXB3IaPekS7RLBCXn3mB1aOc4=; b=nsI7rC
	KkEYGm+nebcnCSB+hd4zmdj2FhG7F2NOYHmlDGv/1B6U2HBPB5ZrrnKkwykWMu+7
	8/o4ddVCME7gG9xLv7AgSBjriDjn8TpAmT0E0VFSI+sgc8ZhbK9lAbhZSdW0J4pq
	qodqfW2FOvXZ7zG2/LtMwVox/FX6VlOdxmSHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gVUhfw/1SwiBimb08ibICDJBVWzWEdFh
	A2ScuLfVvRSIejyJ41KKi/kzgirUnIxyT5rtr4vuhkJOKyFKcWQ5a8tD43MVuoGG
	2C4ZIw67hYeYzW14Hzz9xYNIPzbSDrlpXRT50gxMaazZwnih+aICqoK0O4+zOSRG
	XRV2Am0MpBg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A0CAA2196D;
	Wed, 26 Nov 2014 16:32:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 67C4321967;
	Wed, 26 Nov 2014 16:32:37 -0500 (EST)
In-Reply-To: <1417030977.23650.42.camel@homebase> (Paul Smith's message of
	"Wed, 26 Nov 2014 14:42:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BDF2593C-75B3-11E4-89F7-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260309>

Paul Smith <paul@mad-scientist.net> writes:

> In our development process we always want to do rebase and only rarely
> create merge commits, and so we have a recommendation to set the
> merge.ff configuration attribute to "only".
>
> This is great, however it appears to break git merge --squash (which we
> also use constantly).
>
> If I'm squash-merging from a branch which is not based on HEAD (cannot
> use fast-forwarding) then I get the extremely cryptic error:
>
>   $ git checkout master
>   $ git pull
>   $ git merge --squash my-branch
>   fatal: Not possible to fast-forward, aborting.
>
> I couldn't even understand what this error meant for a while: what was
> being fast-forwarded here anyway?  It took me a lot of thought to
> realize it was related to the merge.ff config setting.
>
> Eventually I figured it out, and now have this workaround:
>
>   $ git merge --ff --squash my-branch
>
> But, shouldn't we consider this a bug?  I don't see any reason why
> --squash should pay attention to the ff config setting, or command line
> flags either for that matter.  IMHO when you add the --squash flag, the
> ff options/config should be ignored.
>
> Or, am I missing some subtle issue here?

Offhand I do not think of any, but I do not use --ff-only or quash
merge myself very often.  If I have to guess, this is merely an
implementation glitch where whoever did "merge --squash" did not
think its interaction with --ff-only through (if --ff-only came
first) or whoever did "merge.ff = only" support did not think its
interaction with "merge --squash" through (if things happened in the
other order).
