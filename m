From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] stash: introduce 'git stash store'
Date: Mon, 13 May 2013 11:35:49 -0700
Message-ID: <7vli7in2wq.fsf@alter.siamese.dyndns.org>
References: <1368449154-21882-1-git-send-email-artagnon@gmail.com>
	<1368449154-21882-5-git-send-email-artagnon@gmail.com>
	<7vbo8fosd9.fsf@alter.siamese.dyndns.org>
	<CALkWK0kMj6q1rppzfxGWrthub4K_+C+jnvF=K4m2Fhk0pAnt7A@mail.gmail.com>
	<7v61ymop61.fsf@alter.siamese.dyndns.org>
	<CALkWK0mQhzrndaEp28nOpLs5STq136PY8hntCpX5RUZKrdJVAA@mail.gmail.com>
	<7vppwun5zk.fsf@alter.siamese.dyndns.org>
	<CALkWK0nmDopEVArofKt42u5JHRBXmGiHP051jhMxtaihWLu95A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 13 20:35:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbxbJ-0002mJ-4b
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 20:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321Ab3EMSfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 14:35:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41635 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752467Ab3EMSfw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 14:35:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98B0E1EA34;
	Mon, 13 May 2013 18:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EeKJgm7p1B5Th4bVrqOquURuZlg=; b=t/Wye9
	389eKgXlamHa9XkkrmJAxToC5QXjXlXyYG00KQ8es3+ExJQD+VcVwpIy6LsclEyL
	/5yopZ138Hk3WrJ0F41V68vO05bFI4ad+JhcLCYZdhJF3VofIZgOQFTGqo9lMW9Y
	HHyenhEyd9qBW5PVuasvxQimvcP2zrXv0uxAg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z7leJlG24SJhUEiM/6k/kXiQMHnTiZya
	UbRR/3Asmd3jb2nMjM73r0xmQvfrPszSks70S6nlr4SAezTIiKCpKN1YCPg96P5Q
	vAjagsrEOddX62BENUJgSG8DcLuzTuMxC8FCejz21+Eg5C9q3uFt1TJzSTVxXGu2
	EIGwXZ6RQ8Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B9041EA32;
	Mon, 13 May 2013 18:35:51 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 072C21EA2D;
	Mon, 13 May 2013 18:35:50 +0000 (UTC)
In-Reply-To: <CALkWK0nmDopEVArofKt42u5JHRBXmGiHP051jhMxtaihWLu95A@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 13 May 2013 23:39:06 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EFE321C4-BBFB-11E2-A718-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224186>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>   git-merge --stat --progress "$merge_name" HEAD 04c5b83c46760573
>
> We made a design mistake at the command-level in merge.  This is at a
> subcommand-level.
>
> 1. Will git stash store ever be more than a one-liner?  Can you think
> of how this function could be larger?

That is not a valid question.  When Linus added the original

    git merge 'message' HEAD $other_branch

there wasn't any merge strategy switch and all the other frills even
envisioned yet.  With what we know about Git today, even you could
have answered "Will git merge be more involved compared to the
original?" 8 years ago, but without that, not even Linus nor I did
anticipate that the command line interface would become a pain point
when enhancing it.
