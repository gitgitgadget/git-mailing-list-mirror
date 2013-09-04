From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Wed, 04 Sep 2013 10:17:49 -0700
Message-ID: <xmqqa9jso69u.fsf@gitster.dls.corp.google.com>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
	<xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
	<CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
	<xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
	<20130904081047.GB2582@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Sep 04 19:17:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHGiL-00032S-1I
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 19:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763156Ab3IDRRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 13:17:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39663 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763152Ab3IDRRw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 13:17:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D69543EA35;
	Wed,  4 Sep 2013 17:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dmD+BWbKUEMMv0oxZ2Ui0tnyhJs=; b=JPU4ue
	aki19tMvb0vC/K+Ll3//k2NGhc4ALRvCp6iFWX/il2cNzsLxOTYpYggnRM6FcuLk
	sd6RQZJnR789Wjf0WgtikBYbxSBW54uPRhGZMAkTxnQO8ngiUS8hZhLR+0o9gUd+
	eRlen7GbgzTuL22EfkrjHYsOygRZWAqD99aUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AXvcj/UX8iHGG52V8FSEz5r9t0/KCQbb
	xcdWzxfnF+YKOa3IyDUy5pQ1MvQvn0jV87aPrH1Kyg0jbMTfQRi924IB4uCcPQIx
	laxah6cV2+M0K79TNlS2bbZfYKYxLHWgBtEYVgM/SYLvrORAbh457sWyivxTpEoA
	CLszFiaS4yo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9FF83EA31;
	Wed,  4 Sep 2013 17:17:51 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D02C83EA25;
	Wed,  4 Sep 2013 17:17:50 +0000 (UTC)
In-Reply-To: <20130904081047.GB2582@serenity.lan> (John Keeping's message of
	"Wed, 4 Sep 2013 09:10:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: ED62F22E-1585-11E3-9BE7-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233850>

John Keeping <john@keeping.me.uk> writes:

> I think there are two distinct uses for pull, which boil down to:
>
>     (1) git pull
>     (2) git pull $remote $branch
>
> For (1) a merge is almost always the wrong thing to do since it will be
> backwards and break --first-parent.
>
> But for (2) a merge is almost always the correct thing to do (in fact it
> may even be correct to create a merge commit even when this fast
> forwards) because this most likely comes for a pull request workflow.

Peff already covered (1)---it is highly doubtful that a merge is
"almost always wrong".  In fact, if that _were_ the case, we should
simply be defaulting to rebase, not failing the command and asking
between merge and rebase like jc/pull-training-wheel topic did.

We simply do not know what the user wants, as it heavily depends on
the project, so we ask the user to choose one (and stick to it).


I am not sure about (2), either.  Is it really "almost always the
correct thing to do"?  I tend to think myself that (2) is a lot more
likely to prefer merging than (1) would, but I certainly wouldn't
say "almost always".  Again if "almost always" were the case,
wouldn't it make sense for that mode of invocation of the command to
even defeat "pull.rebase" configuration and default to merge, unless
explicitly told to "pull --rebase" from the command line?

(the last question is rhetoric, if anybody is wondering).
