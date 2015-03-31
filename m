From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] docs: Clarify what git-rebase's "--preserve-merges" does
Date: Tue, 31 Mar 2015 10:04:16 -0700
Message-ID: <xmqq8uedrtdb.fsf@gitster.dls.corp.google.com>
References: <CAHGBnuO5Y=ejJLxktk0GsnXx8h2LwPW1i7TqDePhfZ_zLR_X9A@mail.gmail.com>
	<xmqqd23vzkon.fsf@gitster.dls.corp.google.com>
	<871tkblapv.fsf@javad.com> <55147D27.1060204@kdbg.org>
	<87lhidlebw.fsf@javad.com>
	<xmqqh9t1rv0r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sergey Organov <sorganov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 19:04:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YczaX-00042H-J8
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 19:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755661AbbCaREY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 13:04:24 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63501 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751138AbbCaREV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 13:04:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F5A744C6C;
	Tue, 31 Mar 2015 13:04:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wFABzjwFpobTHqtOSzabD8VkBuY=; b=S4mY9N
	IJUL/WYobwl4O/NHzoVx/WFSyBhhBBgzbUk2YBBelbHnQFgYyLxiZlFi/Y1SGmmo
	Cf2EAO52XUXyz+L/RSBJOnw7520HwY773Kdxh4XJ0TTDOt8/GQQF3jbVcEQ1JcNU
	Duhwhh9def+et3DhFI+23joWQXTMGOrADtzbs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kXBz/qJS1UGvyVzwiTl1oE7m2L6gquR5
	vi/u2EfE7rTJMzrh+aob7U0DREq1FAF+C21+PgHZ/jr0UYkn1sATMmvG1901gjmM
	IWEutF5hbaJAr4E7eZJrjH4pqbWwZn4hAdL7A834502HbZftuwApWdSmf3vBctjw
	Fk9/AL+SQv4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 26B0644C6B;
	Tue, 31 Mar 2015 13:04:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8622C44C6A;
	Tue, 31 Mar 2015 13:04:18 -0400 (EDT)
In-Reply-To: <xmqqh9t1rv0r.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 31 Mar 2015 09:28:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F7E92500-D7C7-11E4-B4E8-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266531>

Junio C Hamano <gitster@pobox.com> writes:

> I wonder if it will be the right way to get a correct result to
> apply the difference to go from B to Z on top of an old commit when
> you are side-porting.
>
> Imagine you want to backport the same X-Y history by redoing the
> merge Z on top of another child of O (i.e. A's sibling).  That is,
> you start from this:
>
>
>          X---Y
>         /     \
>    O---A---B---Z---
>     \
>      M---N
>
> and would want to create this:
>     
>     
>    O           X'--Y'
>     \         /     \    
>      M---N---A'--B'--Z'--
>
> As long as everything down to the merge-base of the parents of the
> original merge (in this example, merge-base across Y and B that are
> Z's parents, which is A) is being transplanted, "apply the
> difference going from B to Z, on top of B', to obtain Z'" should
> work, I would think.

And just after I send the message because I needed to catch a bus, I
notice that there is a problem.

Actually, "replay diff going from B to Z instead of merging" must be
done very carefully.  Imagine when Y in the original history were a
cherry-pick of M.  What you would be creating would look more like
this instead:
     
    O           X'--.
     \         /     \    
      M---N---A'--B'--Z'--

because Y' becomes a no-op, as the transplanted history already has
M applied.  But the original "diff going from B to Z" has the effect
of M already in there.  You would end up adding the same hunk twice
without noticing.  You somehow need to come up with a way to deal
with this.

If you did a real merge between X' and B' to recreate Z', you would
not have such a problem.

One way to be careful when recreating Z' out of Z might be:

    - Retry a merge between the original B and Y, with conflict
      markers intact;

    - Compare the result with what is recorded in Z.  The
      differences are textual conflict resolution and evil merge
      changes;

    - Now try a merge between B' and Y', with conflict markers
      intact;

    - Apply the difference you obtained in the second step to the
      result of the third step.

which is essentially the same as what rerere does.
