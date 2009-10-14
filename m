From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Wed, 14 Oct 2009 15:34:05 -0700
Message-ID: <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
 <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
 <alpine.LNX.2.00.0910141509200.32515@iabervon.org>
 <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
 <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Oct 15 00:35:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyCR4-0003uN-EI
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 00:35:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761112AbZJNWe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 18:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760782AbZJNWe7
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 18:34:59 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37431 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760736AbZJNWe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 18:34:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CFCE58E3B;
	Wed, 14 Oct 2009 18:34:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qi1q2m4YyG4G7nLmEFSsZ9JxteI=; b=x5v55F
	m7JSWMi407rC/mISJkZGnA+uT8xhkDjd/w6ynvI/Cf1Sec3NM8Bt8FApqbWCctOE
	GjIdaKwHFVY1pBXgBvfyaml0fTuRWA0ITm1u2SV0BdopnjTk6bD9DYzX7ThbeIr4
	wlYe7LmFJyRZYkIYd7y9oyesDnJkJpOU3Lnb0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oepI6q5bfcyGvkCIMU5kgbPyCpuWr6Wt
	B+ry5hc5jRE16uqnriRmL823b8LfSu8es/eoDciWmMgOyQ5TmOdzODPbg/JDy8tj
	SrA+ztRb7EhnMgApf+x6jX3ekP/i392KP6jDn2r/NXDKohxe0z1bp10w9xH1oRm8
	MuUl+WcNj8A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D9ADD58E37;
	Wed, 14 Oct 2009 18:34:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C18558E34; Wed, 14 Oct
 2009 18:34:06 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0910141647390.20122@xanadu.home> (Nicolas
 Pitre's message of "Wed\, 14 Oct 2009 16\:48\:29 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B1F10CBE-B911-11DE-A80D-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130344>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Wed, 14 Oct 2009, Junio C Hamano wrote:
>
>> Nicolas Pitre <nico@fluxnic.net> writes:
>> 
>> > On Wed, 14 Oct 2009, Daniel Barkalow wrote:
>> >
>> >> On Wed, 14 Oct 2009, Jay Soffian wrote:
>> >> 
>> >> > $ git commit -m "blah"
>> >> > Cannot commit while not on any branch. Please use git commit -b <branch> to
>> >> > specify the name of a new branch to commit to, or use git commit -f to
>> >> > force a detached commit.
>> >> 
>> >> The difference is that some experienced users depend on being able to 
>> >> commit while not on a branch, and want to not get a warning for every 
>> >> commit while not on a branch.
>> >
>> > I assume that the -f would silence any warning?
>> 
>> It won't help to alleviate my irritation if I need to give -f to each and
>> every invocation of "git commit" while detached, though.
>
> Agreed.  Presumably some expert mode config would imply -f 
> automatically.

No, I do not want an expert mode.  I can probably live with "per session"
setting, that makes me decide to set or not set it when I detach, though.
