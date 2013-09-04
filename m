From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Wed, 04 Sep 2013 09:59:23 -0700
Message-ID: <xmqqhae0o74k.fsf@gitster.dls.corp.google.com>
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
X-From: git-owner@vger.kernel.org Wed Sep 04 18:59:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHGQV-00038l-Hh
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 18:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904Ab3IDQ71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 12:59:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50215 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756540Ab3IDQ71 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 12:59:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 91E293C78A;
	Wed,  4 Sep 2013 16:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6d6aLFNx2v1LS5Z8uZPiGi5Cy5Y=; b=jqKpho
	ScZ/PaeFy2bLZqbnMcrAUdvQW311W95XBdAnn45tvrGnDJAUTlXu6rGoaLg4oIF4
	sCmMzz/h9pWGY+O1PE200vcdLmn12bOyjOKxTCf29RNOY3vL0CKHDIbZ6vlzkTds
	uc99Ue7EOSqcfpSHzJNtHaIQHvCE26OmCN+sg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ESvf2LJ3CjRMApRz4A8R7VOMkf4/rSEr
	AKYQGSoOabrCjCj1LOk5zK/5B0eXBhqepDNJG1cYMuFy4MCwJyJLhqGNvUu2gt14
	lrYgq4HWXd7Vx65hfGzP2eycHDpZ04cf0lGp9zCxZllXkfB1IYEFpgUP/RVAhrHG
	Jdx9kq4deAM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 881993C789;
	Wed,  4 Sep 2013 16:59:26 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E3A53C784;
	Wed,  4 Sep 2013 16:59:25 +0000 (UTC)
In-Reply-To: <20130904081047.GB2582@serenity.lan> (John Keeping's message of
	"Wed, 4 Sep 2013 09:10:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5A823192-1583-11E3-82D6-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233848>

John Keeping <john@keeping.me.uk> writes:

> On Tue, Sep 03, 2013 at 03:38:58PM -0700, Junio C Hamano wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> 
>> > On Tue, Sep 3, 2013 at 12:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> >>
>> >>> Junio already sent a similar patch, but I think this is simpler.
>> >>
>> >> I agree that this is simpler, but I am not sure if the behaviour is
>> >> necessarily better (note that this is different from saying "I think
>> >> the behaviour of this patch is worse").  The motivation I read from
>> >> the original discussion was that new people did "git pull" (no other
>> >> parameters) to "sync my tree with the central repository" as if it
>> >> were SVN, and because we are not SVN, projects that prefer rebases
>> >> were unhappy, and the other one was to address *only* that use case.
>> >> I do not personally like that special casing (i.e. "only when no
>> >> 'integrate with what from where' is given"), and applying the "you
>> >> must be explicit between rebase and merge" like this series does
>> >> uniformly might (or might not) be a good thing.  I dunno.
>> >
>> > As I already said; there's is essentially no difference between "git
>> > pull" and "git pull origin".
>> 
>> We know what you said earlier. That does not make it right or wrong,
>> but I do not think it is in line with the original discussion (that
>> is why John Keeping is kept on the Cc: line).
>
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
>
>> I do not think we know what we want is to affect "git pull origin".

I didn't mean to limit this to "with an explicit 'from where'
without 'which branch'", but it appears you took it that way.
I should have added:

    I do not think we know what we want is to affect "git pull
    origin master", either.

to clarify.  But it seems that Peff's later message in this thread
already clarifies this point for me ;-)


> I consider "git pull $remote" to be an artifact of the way git-pull is
> implemented on top of git-fetch; perhaps I'm missing something but I
> can't see a scenario where this is useful.  In the series currently in
> "next", we treat this as (2) above but that's primarily because it is
> difficult to differentiate these in git-pull.sh without adding code to
> understand all of the options to git-fetch (or at least those that can
> accept unstuck arguments).
>
> Changing this so that "git pull $remote" is treated as (1) would be
> better, but I think it is more important to avoid catching case (1) in
> the same net which is why jc/pull-training-wheel simply checks if "$#"
> is zero; the cost of getting this completely right outweighed the
> benefit of getting code in that will catch 99% of users.
