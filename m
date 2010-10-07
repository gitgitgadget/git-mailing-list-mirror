From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] worktree: provide better prefix to go back to
 original cwd
Date: Thu, 07 Oct 2010 07:56:57 -0700
Message-ID: <7vvd5evyo6.fsf@alter.siamese.dyndns.org>
References: <4cad50da.0e958e0a.40e3.5efd@mx.google.com>
 <7veic2y2c5.fsf@alter.siamese.dyndns.org>
 <AANLkTim8R2ZxJ1_KnxxRwTjf2mz=NtgQ9MyV_7iAqEpG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, judge.packham@gmail.co, Jens.Lehmann@web.de,
	jrnieder@gmail.com
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 16:57:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3ruK-0000P7-6i
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 16:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760385Ab0JGO5O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 10:57:14 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47406 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537Ab0JGO5N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 10:57:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A0039DC9BF;
	Thu,  7 Oct 2010 10:57:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=+/6npXwn16mg80Tr2M40rDImM
	g8=; b=t1EpzEYUqVlMtRZCduE+e+7dKkWx3OHahxZILby+FSkqPgihqZfvfg6xG
	OpV7R96aHgZLZRVZx99y78M+JqfdUs6Ti75ivjctOBeX3DPrc0dHZJUD0wo+kgNh
	LngRXQElXLmiabbMiWYqOpcKIrsHpun+Ex39v7pgNZpWGpsB6o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=cl99wM+k64IsMr9GABT
	e1CxwNJHXUFerLXELHJuqJcuXd/dYFl5RfihruTbmsXtbLAHRm72Prqwu7rcakyi
	LSsd0S94wg0U8tFt2c63bJazBjHcIfj+98LBNz3az7Jyk2qfhTMIf/ifW3ONlu6m
	AxDCeUv75SIfP9JADBwhvxio=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4224CDC9BD;
	Thu,  7 Oct 2010 10:57:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E36BDC9BA; Thu,  7 Oct
 2010 10:56:59 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2648D652-D223-11DF-84E7-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158405>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Thu, Oct 7, 2010 at 12:54 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> pclouds@gmail.com writes:
>> ...
>> If the original cwd is inside GIT_WORK_TREE, limiting ourselves insi=
de
>> prefix naturally limits the operation to the subdirectory we started=
 from
>> (if the original cwd is at GIT_WORK_TREE, that would make it a whole=
-tree
>> operation). =C2=A0A natural extension of this idea to limit the oper=
ation to
>> the part of the subtree of the working tree we started from is to re=
fuse
>> to work in the case where the original cwd is outside GIT_WORK_TREE =
(the
>> current implementation of GIT_WORK_TREE may or may not correctly imp=
lement
>> it, though---I never use it myself).
>
> I tend to think that as we go up to worktree's root, prefix is shorte=
n
> and the operation area is widen. When cwd is at worktree's, we operat=
e
> on full worktree. If it goes up one level higher, the operation area
> remains full worktree (but not everything under cwd because cwd now
> can have non-worktree directories).

I have a feeling that you did not understand my /srv/git/git.git (no, i=
t
is not a bare repository) vs /var/tmp example.

I think it makes the new semantics much less yucky if the special case =
is
limited to "the working tree is a subdirectory somewhere under cwd".  B=
ut
does your patch check and notice that /var/tmp is not above the working
tree and they are completely unrelated?
