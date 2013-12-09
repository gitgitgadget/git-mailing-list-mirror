From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 06/10] fast-export: add new --refspec option
Date: Mon, 09 Dec 2013 13:00:09 -0800
Message-ID: <xmqqbo0pyc2u.fsf@gitster.dls.corp.google.com>
References: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
	<1384210507-26561-6-git-send-email-felipe.contreras@gmail.com>
	<xmqqd2m6jyue.fsf@gitster.dls.corp.google.com>
	<CAMP44s2ubU_R0GkEUpEh24TxER3uONQJprh9Ot7+PL0QiDRmDg@mail.gmail.com>
	<5281DB46.2010004@bbn.com> <5282977b2ecd_3b98795e785e@nysa.notmuch>
	<xmqq38n1guo8.fsf@gitster.dls.corp.google.com>
	<xmqqob5pfa6j.fsf@gitster.dls.corp.google.com>
	<52a2f1c59de6f_29836d5e9830@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 09 22:00:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq7wF-0003J5-QU
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 22:00:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005Ab3LIVAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 16:00:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55827 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751280Ab3LIVAS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 16:00:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F4BB5920A;
	Mon,  9 Dec 2013 16:00:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=ubZ47gL2uzHCa0GOTF0d+yGtA24=; b=kyF16mOY+MNiiBFfCSvC
	sOeTFvX2hQ8Rybi3ixWcjzu1RyNo5E5vLqwvgMwXJX9jUpWHFh8bs52NGZZmUoY0
	UB+lsBlNck9VP/t1zenfEr1C6baZE5325n1xuL+S9ou7HThh+N7Qa0cDgT82rmu7
	JBGs2WyGkc+L07gxd6OYv0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=FaXToAZiOGRs35tQl8qMhWOJFakesg0pWtdIIbigUVTzKj
	de/gG1tQZmT31sC/ytbr7AGE6/XR3Jq1wd2sBIG/q6l6VXe4+DTetOBUZYZWAkqb
	L6Uvk6hi0FEP9AcK/+1FYjda4yJCzs/AXsbxTNmzvPUCD4Cpac3YwhabomwVM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC14859207;
	Mon,  9 Dec 2013 16:00:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DB42591FE;
	Mon,  9 Dec 2013 16:00:14 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E6CCBB7C-6114-11E3-8C04-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239098>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> > Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> But it does not have to stay that way.  In order to move things
>> forward in that direction, this new configuration has to be
>> distinguishable from the traditional "refspec", as it embodies a
>> different concept.
>
> Is it a different concept?
>
>  % git config remote.origin.fetch '+refs/heads/*:refs/remotes-test/origin/*'
>  % git fetch origin master
>
> What do you call this thing? ------^

The answer to that question is the "value of the 'remote.*.fetch'
configuration variable".

The refspec mechanism and syntax used in "fetch" and "push" were
invented and designed to express two things [*1*]:

 1) what is the set of objects that are necessary and sufficient to
    complete some histories need to be transferred; what are the
    tips of these histories that are being completed?

 2) after the object transfer, some refs on the side that receive
    the objects are optionally to be updated;

    2-a) which refs are they?
    2-b) what objects are they updated to point at?

A refspec consists of one or more elements, each of which has
right and left hand side separated by a colon, i.e. RHS:LHS, and

 1) is determined by the RHS
 2-a) is determined by the LHS
 2-b) is determined by the correspondence between RHS-to-LHS.

A wildcarded "refs/heads/*:refs/remotes/origin/*" dynamically
expands to what the side that sends objects have, e.g. if fetching
from a repository with 'master' and 'next' branches, it becomes

	refs/heads/master:refs/remotes/origin/master
        refs/heads/next:refs/remotes/origin/next

So with

	$ refspec='refs/heads/master:refs/remotes/origin/master
	        refs/heads/next:refs/remotes/origin/next'
	$ git fetch origin $refspec

we transfer objects to allow us to have complete histories leading
to 'master' and 'next' from the origin repository.  And we update
our refs/remotes/origin/{next,master} refs.

Traditionally, when there is _no_ refspec on the command line, the
value of 'remote.*.fetch' configuration variable is used as the
fallback default, and that usage is still true.  When used in that
way, the value of the variable _is taken as_ a refspec.

However, we can no longer say that the variable _is_ a refspec with
the modern Git, and here is why.

"git fetch origin master" used to ignore the 'remote.*.fetch'
configuration variable completely, but since f2690487 (which is a
fairly recent invention), the variable participates in the "fetch"
process in a different way [*2*].  With this in the config:

    [remote "origin"]
    	fetch = refs/heads/master:refs/remotes/origin/master
        fetch = refs/heads/next:refs/remotes/origin/next

the command with 'master' refspec on the command line transfers the
objects required to complete the history only for the 'master', and
not 'next':

	$ git fetch origin master

In this usage, 'master' on the command line is the only thing that
determines what histories are completed (because it does not say
'next', the objects necessary to complete its history are not
transferred unless they are needed to complete 'master').  The value
of the 'remote.*.fetch' configuration does not participate in the
determination of the history being transferred at all.  It is not
used as a refspec.

But unlike Git of the last year, we do map this 'master' using the
'remote.*.fetch' configuration variable, in order to decide 2)
above.  We find that the given remote ref, 'master', has an element
that corresopnds to it in the 'remote.*.fetch' configuration, and
that element tells us to update refs/remotes/origin/master to point
at the object they call 'master', effectively turning the above
command line into this form (using "refspec" that has only one
element, refs/heads/master:refs/remotes/origin/master):

	$ git fetch origin refs/heads/master:refs/remotes/origin/master

There is no "refs/heads/next:refs/remotes/origin/next" here, because
the 'fetch' configuration is not used as a refspec, but as something
else.

My understanding of the added option parameter to "git fast-export"
is that it is not about specifying the history being transferred,
but is about mapping the name of the destination.  For example, does
object between 'master' and 'next' participate in the datastream
produced with this?

	fast-export \
            --refspec=refs/heads/master:refs/remotes/origin/master \
            --refspec=refs/heads/next:refs/remotes/origin/next \
            master

If this parameter were a refspec, as we have discussed already in
previous rounds [*3*], we should be able to give it on the command line,
like any normal refspec, instead of repeating the same thing
(i.e. up to what commit should the history be transported) as in:

	fast-export --refspec=refs/heads/master:refs/remotes/origin/master master

but just

	fast-export refs/heads/master:refs/remotes/origin/master


[Footnote]

 *1* Note that readers are hearing the authoritative definition
     given by the person who invented and designed it back in August
     2005.

 *2* And a recent $gmane/238832 moves "push" in the direction to be
     in line with "fetch" in this regard.

 *3* And I think I even outlined the code to do so.
