From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add the --submodule-summary option to the diff option
 family
Date: Mon, 05 Oct 2009 12:08:31 -0700
Message-ID: <7vr5thacb4.fsf@alter.siamese.dyndns.org>
References: <cover.1254668669u.git.johannes.schindelin@gmx.de>
 <67a884457aeaead275612be10902a80726b2a7db.1254668669u.git.johannes.schindelin@gmx.de> <7vbpkmn6oi.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910051027010.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 05 21:11:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Musxf-0004vg-9Y
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 21:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948AbZJETJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 15:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752920AbZJETJZ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 15:09:25 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33208 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888AbZJETJX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 15:09:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3D99B6CA9D;
	Mon,  5 Oct 2009 15:08:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=/aAgD9KfjfJPR7t6agsJsxF6ydA=; b=KeOLd/q6xwFMdi+hyLeFrN9
	NSY+yh8vVIVzNZi8RLxmQphjScmnYenc3eNAcYJkHWYLpE1N8FyvI9m8OqJzvbpX
	S9kzkRoRQ3/k8XO0bwGs5aV16Pw8Zj7NUL197cNJBy7dgiL36Yd370ZeCbYWKxQk
	wreuw+gv9WmKVTrspxX0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=BKMPz2V2aFK0mwBy4wuwhmNK6wkRETeE/iRvcN0vTMPMLTcNc
	eQ3dYxom2HJghP111ghvBRJhZi1hlaG+8p6LFzSN24pnp12+kR0PPrAIJ5ctOYA+
	DjO62R+TAp2ubzW1oaMn8le7yMEpCJSJVmGoWsZ7S3r+idtPdGyRlDXcMA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 120516CA9B;
	Mon,  5 Oct 2009 15:08:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8C1F96CA9A; Mon,  5 Oct 2009
 15:08:33 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7CAFDEEE-B1E2-11DE-9585-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129577>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > +		if (prepare_revision_walk(&rev))
>> > +			message = "(revision walker failed)";
>> 
>> If prepare_revision_walk() failed for whatever reason, can we trust
>> fast_forward/fast_backward at this point?
>
> No, but it is not used in that case, either, because message is not NULL 
> anymore.

It is used in that case a few lines below to decide if you add the third
dot.  That's why I asked.

>> > +	}
>> > +
>> > +	strbuf_addf(&sb, "Submodule %s %s..", path,
>> > +			find_unique_abbrev(one, DEFAULT_ABBREV));
>> > +	if (!fast_backward && !fast_forward)
>> > +		strbuf_addch(&sb, '.');

> Our output methods translate ANSI, so the strbufs only hold the ANSI 
> sequences.

I'll always trust two Johannes's on Windows matters ;-)

> I have no idea why "submodule --summary" uses --first-parent, but 
> personally, I would _hate_ it not to see the merged commits in the diff.
>
> For a summary, you might get away with seeing
>
> 	> Merge bla
> 	> Merge blub
> 	> Merge this
> 	> Merge that
>
> but in a diff that does not cut it at all.

As long as bla/blub/this/that are descriptive enough, I do not see at all
why you think "summary" is Ok and "diff" is not.  If your response were
"it is just a matter of taste; to some people (or project) --first-parent
is useful and for others it is not", I would understand it, and it would
make sense to use (or not use) --first-parent consistently between this
codepath and "submodule --summary", though.

> In any case, just to safe-guard against sick minds, I can add a check that 
> says that left, right, and all the merge bases _cannot_ have any flags 
> set, otherwise we output "(you should visit a psychiatrist)" or some such.

I wouldn't suggest adding such a kludge.  Being insulting to the user when
we hit a corner case _we_ cannot handle does not help anybody, does it?

I see two saner options.  Doing this list walking in a subprocess so that
you wouldn't have to worry about object flags at all in this case would
certainly be easier; the other option obviously is to have a separate
object pool ala libgit2, but that would be a much larger change.
