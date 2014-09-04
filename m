From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2014, #01; Tue, 2)
Date: Thu, 04 Sep 2014 10:14:09 -0700
Message-ID: <xmqqmwafux3y.fsf@gitster.dls.corp.google.com>
References: <xmqqzjehy8vx.fsf@gitster.dls.corp.google.com>
	<CACsJy8C_=aNX9LT2V_zhw++tC22C5SDfwbpTS=juONMxwcV9pA@mail.gmail.com>
	<xmqqtx4nuy5k.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ronnie Sahlberg <sahlberg@google.com>,
	Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 19:14:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPacF-0004Ts-27
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 19:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754586AbaIDROO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 13:14:14 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63136 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754501AbaIDROM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 13:14:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A7A4C37B78;
	Thu,  4 Sep 2014 13:14:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=57Bs3E4K2LKOZjlm+kV5M181PVk=; b=KGIPX1
	QIQBHm0gFuFFNMKG7qKOPU03R8JKY7vNbNL4SYKN0q7XhdUizatk+wX65DBUF+Ld
	L4RyLTehLHpisGdzXUO8u+QkpWwCA5kMuEqwIo7z85W5UzLMa/XgasghrrBkppFz
	WSGQhogYLRoA6RGrCKASKG6NP7Ft1UGXYoqT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qHSSOiZuMxw96AsVwInivPf4+YLusEO6
	sgwoPlZBUuZ68R1zE5mru2gSfc4jHahemcyiLMTsWssq41zc20NG8o7482jAhv0Z
	3vpRlPpUYSbGjRPxN2sQZaqOqMKWLbybcmyupgJoAGXrNqHXq1p9SClMTFFCGEM8
	1Z/nNdvo3/s=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9E36237B77;
	Thu,  4 Sep 2014 13:14:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F27C437B74;
	Thu,  4 Sep 2014 13:14:10 -0400 (EDT)
In-Reply-To: <xmqqtx4nuy5k.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 04 Sep 2014 09:51:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E31BC142-3456-11E4-84D7-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256451>

Junio C Hamano <gitster@pobox.com> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Wed, Sep 3, 2014 at 5:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> * nd/multiple-work-trees (2014-07-29) 39 commits
>>>
>>>  Reroll posted, but haven't picked up yet.  How would this interact
>>>  with rr/transaction series which is pretty much all about the refs?
>>
>> Haven't checked out that topic yet. But ref changes in
>> multiple-work-trees are to make sure ref path construction goess
>> through git_path(), and some cleaning up after strbuf_git_path() is
>> introduced. So basically textual conflicts only.
>
> Up to the point that is queued on 'pu', the other topic(s) still
> keep the assumption that all refs are files in $GIT_DIR/refs/, and I
> think I managed the textual conflicts correctly in 'pu' before.

One point that caused unnecessary conflict resolution was that the
transaction series lacked "let's use strbuf to hold paths".  This
had two immediate side effects, i.e. "instead of returning upon
errors, jump to the end with 'goto done/fail' for necessary
clean-up" and "get rid of git_snpath and use strbuf_git_path", both
of which are good general clean-ups, even if they weren't related to
the multiple worktrees feature, that conflicted with the transaction
series when getting merged.

You can see the interactions by checking

    $ git show 'pu^{/^Merge branch .nd/multi}' refs.c

Perhaps these three changes, without the addition of the multiple
worktree feature, should come first as a general clean-up on top of
which both topics can be built?

> But starting from $gmane/255476 the assumption gradually gets lifted
> and eventually we may have refs and reflogs expressed in a different
> backend, without these files that represent the refs at all.
>
> I am not yet sure how this "I have $GIR_DIR/ but that is not a real
> one but borrows most of the stuff from elsewhere" meshes with that
> new world.
