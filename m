From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Wed, 04 Sep 2013 15:59:18 -0700
Message-ID: <xmqqr4d4jird.fsf@gitster.dls.corp.google.com>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
	<xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
	<CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
	<xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
	<20130904081047.GB2582@serenity.lan>
	<xmqqa9jso69u.fsf@gitster.dls.corp.google.com>
	<7DC052455C7C4B50A4EAFC1EF63D006C@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "John Keeping" <john@keeping.me.uk>,
	"Felipe Contreras" <felipe.contreras@gmail.com>,
	<git@vger.kernel.org>, "Andreas Krey" <a.krey@gmx.de>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Sep 05 00:59:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHM31-0005lK-J3
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 00:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901Ab3IDW7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 18:59:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35401 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752599Ab3IDW7W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 18:59:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48C2A3F61A;
	Wed,  4 Sep 2013 22:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lnERwjPEMe8yFipjG9q/Tjm1Ggw=; b=m7wNCC
	1GdTKrK9IUSftMQ3RduOowGn1+5Jb1HPwob8azDrtYqNOAISOfHsmRqwQUDYZA1H
	G6SKOSi0vAllDufi4U+ehRCiliyq6pFtjLexA9+BOqdAU17SH65SeXd2Dy5Cu232
	4cYDpDRSNNa0dwh9ScP4ngG7eLkPPA7wCQkYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ssCtOCZocC2oBotuVyS/7BUbq+ld2TZr
	SxqOF5Cq6OptzarMyygGN6RWahPy/9TkT1gnJ3+mSb5Sasue+TiyewSxyeF+m60S
	X2CkUQ2Ia4Q6Grh6thFpDaf2iUWThy6gVZROfVXFGj13lQzahy2aRyJK7+pFpYAg
	o3/oO0vHMKE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3ADD53F618;
	Wed,  4 Sep 2013 22:59:21 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D5943F612;
	Wed,  4 Sep 2013 22:59:20 +0000 (UTC)
In-Reply-To: <7DC052455C7C4B50A4EAFC1EF63D006C@PhilipOakley> (Philip Oakley's
	message of "Wed, 4 Sep 2013 23:08:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A22B1176-15B5-11E3-BD31-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233883>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Junio C Hamano" <gitster@pobox.com>
>> John Keeping <john@keeping.me.uk> writes:
>>
>>> I think there are two distinct uses for pull, which boil down to:
>>>
>>>     (1) git pull
>> ...
>> Peff already covered (1)---it is highly doubtful that a merge is
>> "almost always wrong".  In fact, if that _were_ the case, we should
>> simply be defaulting to rebase, not failing the command and asking
>> between merge and rebase like jc/pull-training-wheel topic did.
>>
>> We simply do not know what the user wants, as it heavily depends on
>> the project, so we ask the user to choose one (and stick to it).
>
> We only offer a limited list. It won't be sufficient for all use
> cases. It wasn't for me.

Very interesting. Tell us more.

When "git pull" stops because what was fetched in FETCH_HEAD does
not fast-forward, then what did _you_ do (and with the knowledge you
currently have, what would you do)?  In a single project, would you
choose to sometimes rebase and sometimes merge, and if so, what is
the choice depend on?  "When I am on these selected branches, I want
to merge, but on other branches I want to rebase?"

If that is the issue you are trying to raise (I cannot tell yet), a
repository-wide "pull.rebase = merge/rebase" is still too blunt an
instrument, but then "branch.<name>.rebase" can be set to
selectively override it, so that case is covered.

	[pull]
        	rebase = merge
	[branch "po/topic"]
        	rebase = yes

Are there cases where you do not want to either rebase nor merge?
If so what do you want to do after "git pull" fetches from the other
side?  Nothing?

	Side note: a knee-jerk response to a "yes" answer to the
	last question from me has always been "then why are you
	running 'git pull' in the first place. The next paragraph is
	my attempt to extend my imagination a bit, stepping outside
	that reaction.

I can imagine users might want to say "when I am on these small
number of branches, I want to merge (or rebase), but when I am on
other, majority of my branches, because they are private, unfinished
and unpublished work, please stop me from accidentally messing their
histories with changes from upstream or anywhere else for that
matter".  If that is the issue you are trying to raise, because
there is no

	[pull]
        	rebase = fail
	[branch "master"]
        	rebase = yes

to force "git pull" to fail by default on any branch while allowing
it to rebase (or merge, for that matter) only on a few selected
branches, we fall a bit short.

Which can be solved by adding the above "fail" option, and then
renaming them to "pull.integrate" and "branch.<name>.integrate" to
clarify what these variables are about (it is no longer "do you
rebase or not---if you choose not to rebase, by definition you are
going to merge", as there is a third choice to "fail"), while
retaining "pull.rebase" and "branch.<name>.rebase" as a deprecated
synonym.

Am I on the right track following (eh, rather "trying to guess")
what you are trying to get at?
