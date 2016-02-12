From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Gated Merge?
Date: Fri, 12 Feb 2016 09:44:13 -0800
Message-ID: <xmqqr3ghvn6a.fsf@gitster.mtv.corp.google.com>
References: <xmqqvb5uvr40.fsf@gitster.mtv.corp.google.com>
	<CAH5451=rVmdTra0rVNEkfdfOeSyeETSMo7YGWdYozZr_=YyAtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 18:44:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUHlU-0000sb-CS
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 18:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbcBLRoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 12:44:16 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61076 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751236AbcBLRoP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 12:44:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D5408411D7;
	Fri, 12 Feb 2016 12:44:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z97JlIa6yB4RfTLGvpqgv4znpgY=; b=ClUvKn
	imVuCPlS14da210dTH+maf6L5zgEVhNfgATekNo/Mh9qEh4rSC4tz202Sybs58/l
	ktvbZAlHUYWuw44ZVcWWMbVFPLER5NRnyakTiwNChTOC33Q6tZ1Ag51JA0kjgRAk
	1WOqvI7ESxpqEDIwVO/mDJXuNHRb/Z47XXisI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K9TkB/S6/5NY9rPjpYB4AeLBu1atDEbO
	PKY6q/a3RwdiJn/TFEbTVTu7rlg5sKHWyIv2qY3rBFraiAQYWYqZgzW63df3IkCc
	KX1gJypHQ6bhMxlaVrR7UeqYsEmfRejXKaWqW5Q5o5MEr7FtrfFRIuhfigPdva3g
	nXRtPPGd6Rw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CAF15411D6;
	Fri, 12 Feb 2016 12:44:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2F34D411D1;
	Fri, 12 Feb 2016 12:44:14 -0500 (EST)
In-Reply-To: <CAH5451=rVmdTra0rVNEkfdfOeSyeETSMo7YGWdYozZr_=YyAtw@mail.gmail.com>
	(Andrew Ardill's message of "Fri, 12 Feb 2016 09:42:51 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3B2F474E-D1B0-11E5-8D4E-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286059>

Andrew Ardill <andrew.ardill@gmail.com> writes:

> What is the benefit in doing this in notes vs having the tests in the
> working tree?

Interesting.  I have never thought of adding this information to the
project history proper---I've viewed this as primarily an aid for
keeping track of topics in-flight by an individual, i.e. something
that the rest of the project do not want to even see.

> Pros:
>
>  - merge-gates can be added after the commit, but will stick with the
> commit if it moves around (as opposed to creating a second commit to
> add the merge-gate to the working tree)

I think that this will not be a problem in practice if we took your
alternative approach to cap the topic with an extra commit that adds
the Merge Gate test; because the workflow this targets treat a topic
as a single unit, the extra commit will be rebased together with the
real commits in the topic.

>  - cross repository standards can be established that allow
> merge-gates to be detected and run automatically (arguably could be
> done with a standardised folder structure too, but that is more
> disruptive)

Yeah, I think that this is very similar to "something that the rest
of the project do not want to even see" problem, if you use an in-tree
approach.

> Cons:
>
>  - difficult to see the current complete set of merge-gates

Yes, we would need to have a quick way to enumerate commits with
these notes in the rev-list output.

>  - difficult to make changes to a number of merge-gates at the same time

Hmm, I am not sure if/how that will be an issue.

>  - poorly defined behaviour when multiple merge-gates overlap in
> functionality. Which gates execute first? What if I reorder the
> commits?

True. With an in-tree approach, you can define the order with the
filenames, for example, and the above will be clearer. Instead, you
would need to worry about name clashes, though.
