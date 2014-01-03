From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] completion: introduce __gitcomp_2 ()
Date: Fri, 03 Jan 2014 09:49:55 -0800
Message-ID: <xmqqwqihlzuj.fsf@gitster.dls.corp.google.com>
References: <1388415138-11011-1-git-send-email-artagnon@gmail.com>
	<1388415138-11011-3-git-send-email-artagnon@gmail.com>
	<xmqqeh4qndxs.fsf@gitster.dls.corp.google.com>
	<CALkWK0mgqJFz1Lf_UVX8fdvnT+u+rp705dak7kXVFFBSr2bTQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 03 18:50:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vz8t0-00056q-P5
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 18:50:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbaACRuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 12:50:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43984 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751217AbaACRuL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jan 2014 12:50:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5525A5C7C5;
	Fri,  3 Jan 2014 12:50:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KRKknMYE/FfGd4nQjgbofnzmSWw=; b=tqG/jK
	/QQsQycfu3iNsrKNDtqCO9Cqi0Adu9/y7AvX7Cptr8bz5l4Wb0MKfXRpltFOrQSA
	MAPsOkZZoOPQKo2pK3rcuIbkwvzhZh3Nl7iA/iLJkawbJtTxg/kMcs0BgY4VWfnS
	//RKLiw6Fbx957TdqYG096sHqgOljCXL7VZf8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l+PCXd0AY08y2b2onsmP84UtyuqMI00F
	RXRvQL710KVi7czcBzZAXEQv695GZid0pDds4bJ24tgljUX9Fr/eXWQSZUNAhz1l
	Hg0v580+R17kwmO8URduNcvh8/wDKN3r3Do9OIRUzmKB4ICsB//JGLGqJ/ungDyr
	uEVH3x+5vuY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 283145C7C4;
	Fri,  3 Jan 2014 12:50:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E394A5C7BC;
	Fri,  3 Jan 2014 12:49:58 -0500 (EST)
In-Reply-To: <CALkWK0mgqJFz1Lf_UVX8fdvnT+u+rp705dak7kXVFFBSr2bTQA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 3 Jan 2014 13:21:17 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 769630EC-749F-11E3-908C-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239918>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>>         __gitcomp_nl "$(__git_heads)" "$pfx" "$cur_" "."
>>         __gitcomp_nl_append $"autosetupmerge\nautosetuprebase\n" "$pfx" "$cur_" " "
>
> This is not a bad idea at all. I'm just afraid that we might be
> leaving open ends: What happens if the $pfx isn't the same in both
> cases? Who keeps track of the index "i" of COMPREPLY (it's currently a
> local variable)? If we make it global, doesn't every function that
> deals with COMPREPLY be careful to reset it?

I am not sure what you are worried about $pfx; what does it do when
you have strings with different prefix in COMPREPLY? If it breaks,
then the answer is "don't do it then".

Doesn't an array know its own length and give you a way to ask?

> More importantly, can you see a usecase for more than two completion classes?

I am not sure why you think it is more important.

Somebody lacked forsight and designed an interface that would allow
only one "completion classes" (whatever that means) and called the
result sufficient. It has been sufficient for a long time.

Later you came, found that one was not enough, and added an inteface
that would allow only two, and called the result sufficient.  See a
pattern?

Anticipating unforseen possibilities for enhancement and preparing
an easy way to support them without overengineering is what the
"prepare an appending variant" suggestion is about, and by
definition, unforseen possibilities have not been seen yet ;-)

Imagine if one is flipping 47 topic branches from 6 contributors
whose names all begin with 'j'.  I can see that such a person would
appreciate if "git config branch.j<TAB>" did not dump all 47 topics
at once but offered "jc/ jk/ jl/ jm/ jn/ js/" instead, and then a
follow-up completion of "git config branch.jk/<TAB>" expanded to
names of topics from that single contributor "jk".  Wouldn't the way
to give these be either to return these two-letter hierarchy names
with slash as the suffix or to return list of two-letter plus a
slash with an empty suffix?  Either way, that is using something
different from a dot or a space, so that may count as the third, I
guess.
