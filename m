From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 08/12] Teach the notes lookup code to parse notes trees
  with various fanout schemes
Date: Thu, 27 Aug 2009 20:35:07 -0700
Message-ID: <7vmy5ka9w4.fsf@alter.siamese.dyndns.org>
References: <1251337437-16947-1-git-send-email-johan@herland.net>
 <20090827212710.GV1033@spearce.org> <7vy6p5ncz0.fsf@alter.siamese.dyndns.org>
 <200908280103.06015.johan@herland.net>
 <20090827233900.GA7347@coredump.intra.peff.net>
 <7viqg8hj98.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0908271740i53ec7d69td696d955366ad23c@mail.gmail.com>
 <7vocq0d86p.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0908271951t1f2db976jb1de1e7687ad9791@mail.gmail.com>
 <7v4orsbpzd.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0908272005i4bf9b906xba08a711d384dd83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes.Schindelin@gmx.de, trast@student.ethz.ch,
	tavestbo@trolltech.com, git@drmicha.warpmail.net,
	chriscool@tuxfamily.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 05:35:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgsFm-0007Nz-5v
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 05:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbZH1Dfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 23:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbZH1Dfp
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 23:35:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45418 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbZH1Dfo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 23:35:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DA7E23A639;
	Thu, 27 Aug 2009 23:35:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EUd1kd78uaWDc9rIOH2aD1vILVw=; b=HPYmaV
	wWZmbkJcK7KuwUqptItB+DQrwQAeynMY7efO9Ld20fJE6BIHmf1c39imDWlE9eI3
	BM7o/ItbAsBOK7nv+AdibFMWHEy3qQUg5WzRkuGN1Jw4GaoaP4iwJgThdSGVtV0o
	u1+QgS2mRdvOzHBRuSyBo4iTZvbWYHQKf33lI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lUXaN3b4L6+5pbQzrn4FY/z+KbgHb6dl
	Y2AgO2tuOMBAOMfMrb8drObxmhemowI56CLPxBCIpfpvHb/uDxGtAGWAg5oijzD2
	afo5wTcPxG+P4WcCzCwhA6YWjzZK5ooCs1vCq0iq3MzA24GnO0ojc0gYZSM7i677
	sE959E24ZGM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 58EF23A635;
	Thu, 27 Aug 2009 23:35:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 667973A632; Thu, 27 Aug 2009
 23:35:09 -0400 (EDT)
In-Reply-To: <fabb9a1e0908272005i4bf9b906xba08a711d384dd83@mail.gmail.com>
 (Sverre Rabbelier's message of "Thu\, 27 Aug 2009 20\:05\:31 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D818A9FA-9383-11DE-ABC9-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127250>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Thu, Aug 27, 2009 at 20:02, Junio C Hamano<gitster@pobox.com> wrote:
>> In such a case would you rather want to see the commit itself first, or at
>> least, commit _and_ notes _together_?
>
> Assuming you do download all notes, I think it would be nice to be
> able to read the note; and since there's no way to download the commit
> separately it would require one to guess which head the commit belongs
> to and fetch the entire branch...?

Some random thoughts...

 * If there are very many branches (in the worst case, they are so many
   that the upstream uses the expand extention to serve the project),
   maybe the notes namespace will also have many branches.  It is unclear
   how a user is expected to know which notes branch a note to a
   particular commit is to be found.

 * Perhaps to solve that problem, such a project may use notes in the
   corresponding "notes branch"?  Then your assumption does not hold, as
   you first guess which notes branch to fetch to find the note that may
   not even exist for this issue to become a real problem.

 * If you assume all the notes are downloaded in such a project, you can
   still go through all the top-level trees (that are date based fan-out)
   and find the note to the commit object you do not have.  At that point,
   it only becomes performance issue for an unusual case where you have
   a note but the commit the note applies to.
