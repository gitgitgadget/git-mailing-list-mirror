From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Disabling status hints in COMMIT_EDITMSG
Date: Tue, 10 Sep 2013 09:42:06 -0700
Message-ID: <xmqqeh8wzl0h.fsf@gitster.dls.corp.google.com>
References: <vpq4n9tghk5.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 10 18:42:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJR1C-0001za-No
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 18:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176Ab3IJQmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 12:42:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58463 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753070Ab3IJQmN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 12:42:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA46C40EC4;
	Tue, 10 Sep 2013 16:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mc0ekKA9jVip/txd21jUbHK4TYk=; b=rS9qX1
	qzsE5e6ykM8baQaggMdDIV2ZZ5RcsoCjLYx05eKfk1r+OwFjSU6JjTSG0BnDxlnJ
	rt3fuWTfGnZIY7FQIy/0Tpsw1M/BF7gBcqAb7bm9JRkLJggLnK/y2MfWxrKR8MYP
	ApVOCvgy0vGeGMsGgGNiWm5dvucgHiZP8UpC8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m34JFhBgysXMOZ8NkKCbeYd6nbUX5jMd
	tLhC3ZFSRl1Alg6X+5PhKzOFXTOskLEMkmn02LzZEyxTS2i9uAhFGWBZuI/U+0k1
	8HFHpDWnl1CQlc2JTNjbyTip/eMgSVMPnb7Tb4PTpPFJefvd4Dkwr7U0goE5fFZy
	Wv22uagYlH8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A391940EC3;
	Tue, 10 Sep 2013 16:42:12 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BCB3B40EBA;
	Tue, 10 Sep 2013 16:42:09 +0000 (UTC)
In-Reply-To: <vpq4n9tghk5.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	10 Sep 2013 11:19:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F009F17E-1A37-11E3-87C1-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234442>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Hi,
>
> I just noticed that the template COMMIT_EDITMSG was containing status
> hints, and that they were not particularty helpfull _during_ a commit. I
> think it would be sensible to ignore advice.statusHints and disable
> hints unconditionally when writting to COMMIT_EDITMSG.
>
> Any objection?

I agree that the extra "this is how you may rectify the situation"
lines like these look useless at the first glance.

    # Changes to be committed:
    #   (use "git reset HEAD <file>..." to unstage)
    #
    #       new file:   foo
    #
    # Untracked files:
    #  (use "git add <file>..." to include in what will be committed)
    #
    #       bar
    #

The whole point of showing the list is to give the user a chance to
notice mistakes, and after noticing a mistake, what the user does is
to abort the commit, not "git reset HEAD <file>" nor "git add <file>".

But at the same time, I feel that these redundant lines, especially
the latter one, would give the users a stronger cue than just saying
that "bar is Untracked"; "do X to include" reminds that bar will not
be included if nothing is done.

So I am on the fence on this one.  No strong objection, but I
suspect those who do not have any voice in this discussion
(i.e. those who are about to start using Git) may be helped by
keeping these lines.
