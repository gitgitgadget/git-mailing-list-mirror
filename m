From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Useful tracking branches and auto merging
Date: Tue, 05 Oct 2010 13:10:49 -0700
Message-ID: <7vvd5g5rjq.fsf@alter.siamese.dyndns.org>
References: <AANLkTimq0sKUavKiXepDOz+DvrymuRAVUyAyV+FzbCBD@mail.gmail.com>
 <20101004204625.GH6466@burratino> <7vk4lw7g2m.fsf@alter.siamese.dyndns.org>
 <AANLkTinXJ5E_U=5uP_zvWLQBssQsYC74JyVv1N3-eMXK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 22:11:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3Dqu-0005wx-78
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 22:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756821Ab0JEULA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 16:11:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56858 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755767Ab0JEUK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 16:10:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E99A5DC1B2;
	Tue,  5 Oct 2010 16:10:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZRjL6M6qxBFmjR5k9oo6EVLnFdI=; b=Z6M9LC
	yNchoF/0q9CpdbpP90LsslYx0XDdGRbi2tOB9oeicz4CArSwEw4O07Kwgr01QQpH
	G7iIB15R4y85A3Q3GdXja4xESPCpo5mwPmctM/jXwHiNX8ifYXJ0//0a53wPorRC
	TwRZh/QuQ9U4QoOUUdnPnwZ2DGuO2hjydxB8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FILr98ZRLHxTbEN1RCjSnqA8cS6NlAm9
	fEd65JraV3762Sor6Vhcrfr5bWZ6WvNnFfbSF9/b94euS1GLm+tihLDD6YNYXDYB
	H75ZXzY7fGdMN+ZCd/10PLglx0Wus9hWkzLUV0tuuUXLZqXDYCYisznus9aS4jne
	rwRcYyFwbDI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B6107DC1AE;
	Tue,  5 Oct 2010 16:10:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C19F7DC1A5; Tue,  5 Oct
 2010 16:10:50 -0400 (EDT)
In-Reply-To: <AANLkTinXJ5E_U=5uP_zvWLQBssQsYC74JyVv1N3-eMXK@mail.gmail.com>
 (Felipe Contreras's message of "Tue\, 5 Oct 2010 20\:49\:25 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A8B3A300-D0BC-11DF-ABF8-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158230>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> I believe this use-case is valid:
>
> * The user wants *all* his remote tracking branches to point to the
> latest branch head in all the repos in the case the can be
> fast-forwarded, and in the case they can't, print an error and
> continue with the rest.

I would not be so sure about the validity of that use case.

If your tracking branches are always trailing, never having any real work
of your own, there is no reason to have them locally, instead of checking
them out on demand.  So let's forget about that case.

When you are collaborating with somebody else, sharing a topic branch, and
you are behind because you were not working on it while the other parties
progressed the shared topic, it would be convenient if your local branch
is fast-forwarded before you start to work on it.  One possible solution
for that would be to teach "git pull" to fast-forward such backgrounded
tracking branches that are not checked out.  Another obvious alternative
is to teach "git checkout" tell you where you are, and even tell you that
you could fast-forward [*1*].

On the other hand, if you have forked a topic branch to build your new
nifty feature at some known point (e.g. immediately after the upstream
reached a new stable point), but you haven't done any real work on it, it
is doubtful that it is even a good idea to fast-forward it automatically
to begin with.  C.f.

   Message-ID: <AANLkTim85sH_2o=xCiDuoQrHq_7ZL96Y91xQMGxUP5Fy@mail.gmail.com>

   "The real problem is that maintainers often pick random - and not at
    all stable - points for their development to begin with. They just
    pick some random "this is where Linus -git tree is today", and do
    their development on top of that. THAT is the problem - they are
    unaware that there's some nasty bug in that version."

IOW, once I decided one point is a good place to fork a topic, created a
branch off of it, but didn't have a chance to do a real work on it yet, it
would be very irritating if "git pull" updated that branch only because I
do not have my own commit on it yet.

I see little sanity in doing this with any option whose name has "all"; it
largely depends on the workflow, and in a single repository, some branches
may want to get fast-forwarded automatically while others don't [*2*].


[Footnotes]

*1* It is plausible that you could go one step further and define
branch.frotz.autofastforward configuration variable to tell "git checkout"
to fast-forward in such a case, perhaps only when the working tree and the
index are clean.

*2* It also is plausible that the same branch.frotz.autofastforward
configuration variable can be noticed by "git pull".
