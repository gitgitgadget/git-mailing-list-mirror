From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/GSOC] Git Beginner | Warnings for potentially destructive commands
Date: Fri, 25 Mar 2016 10:38:41 -0700
Message-ID: <xmqqd1qi4fvi.fsf@gitster.mtv.corp.google.com>
References: <56F51089.2050703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	philipoakley@iee.org, Jacob Keller <jacob.keller@gmail.com>
To: Sidhant Sharma <tigerkid001@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 18:38:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajVhC-0006vE-0v
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 18:38:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753975AbcCYRip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 13:38:45 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:64451 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753534AbcCYRio (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 13:38:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1C8844EB74;
	Fri, 25 Mar 2016 13:38:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LiL0V4YiNOmg9j9CG4uJB6GsV/Q=; b=kjxtHT
	BEsvtxZxcGY8vR5tsbHXCeLWaOjyghLPRH+4wtKI+icN60plw+EcEtQ2f/5FXnau
	6QZCrYqqMqgtZ3/J36KvAsd/UX3EUXlqeNKGF/cN3+hfefYzgfiOLMRIcUEQWVXu
	7Aln+ikJUjxthtWlrtcsvnOT14jZFmUPR8oTU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tMWoiRaYrpVjor2gzsBU02ryM4/NSwju
	EF54UUmePkSqG68Fq5kVW7vbtU4gWmeWupLpqeSmVcgB7gbHukoAC0KgH3xxUdKm
	nt25DYthEPlKAJe/2FTQmQgvSODY3q6tUNpnLUC0nCTXunPziOJUG6vQ/6+Hq0nO
	4qr38LiASBY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 143D54EB73;
	Fri, 25 Mar 2016 13:38:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8A7BB4EB72;
	Fri, 25 Mar 2016 13:38:42 -0400 (EDT)
In-Reply-To: <56F51089.2050703@gmail.com> (Sidhant Sharma's message of "Fri,
	25 Mar 2016 15:48:49 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6ADEEC30-F2B0-11E5-A754-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289914>

Sidhant Sharma <tigerkid001@gmail.com> writes:

> $ ggit rebase
>
> [WARNING] You are about to rebase your commits in <topic-branch> onto the
> $BASE_BRANCH, which will essentially replay the work done in $TOPIC_BRANCH
> since last merge onto $BASE_BRANCH.
> For instance,
> Current state:
>
>     o---o---A---B  $BASE_BRANCH
>          \
>           X---Y  $TOPIC_BRANCH
>
> State after rebasing:
>
>     o---o---A---B---X'---Y'  $BASE_BRANCH
>          \
>           X---Y  $TOPIC_BRANCH
>
> where X' and Y' are the commits making changes identical to those made by X and
> Y respectively.

The topology may be correct, but the branch labels are both wrong,
no?  The tip of the base branch will stay at B, and the tip of the
topic will point at Y'.

> Rebasing is not usually problematic except in cases when you are rebasing
> commits that do not exist in your repository.

This cannot be correct, as you fundamentally cannot work on (not
limited to rebasing) commits that do not exist in your repository.

> $ ggit reset --hard
>
> Resetting to <destination-commit-hash>
> [WARNING] You are about to hard reset the current HEAD (master) by <n> commit(s).

If I were on B and did "git reset --hard Y", i.e.

     o---o---A---B  $CURRENT_BRANCH
          \
           X---Y  $CURRENT_BRANCH_AFTER_RESETTING

does the phrasing "about to reset by <n> commit(s):" make any sense?

> This will take you back to commit <destination-commit-hash>, and discard all
> changes make thereafter. For instance,
> Current state:
>
>     o---o---A---B---C---D---E  $CURRENT_BRANCH
>
> After resetting 3 commits:
>
>     o---o---A---B  $CURRENT_BRANCH

The above two examples make me wonder if these should be static
text.  "ggit rebase" and "ggit reset" have full information of the
concrete branch names, commit object names and the actual topology
of the history, so it should be able to give a description more
tailored to the user's situation.  Instead of giving a fictional
drawing with "For instance, Current state:", it should be able to
draw the actual before-and-after picture based on where the end-user
actually is.  I see _some_ attempts (e.g. with "<n>", mention of
"(master)" and $BASE_BRANCH, you may have meant that they will be
replaced with actual values), but I suspect that telling some truth
(i.e. use of the real branch names) while showing pictures that do
not match the reality (i.e. if the topology and the description are
done as fixed text) would only confuse the users.
