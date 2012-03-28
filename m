From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git add -p and unresolved conflicts
Date: Wed, 28 Mar 2012 16:05:51 -0700
Message-ID: <7vfwcss4vk.fsf@alter.siamese.dyndns.org>
References: <CABPQNSYVXMxS3kugu1j=62ArJ_1saYYfMjJdZvqhjgPFGN=Eqw@mail.gmail.com>
 <7vbongyd67.fsf@alter.siamese.dyndns.org> <vpqvclozr7e.fsf@bauges.imag.fr>
 <4F73632E.1060408@ira.uka.de> <vpqk424zfb1.fsf@bauges.imag.fr>
 <4F737027.5020503@ira.uka.de> <7vvclotpp7.fsf@alter.siamese.dyndns.org>
 <4F7395B6.1020506@ira.uka.de> <7vk424s52z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Holger Hellmuth <hellmuth@ira.uka.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	kusmabite@gmail.com, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 01:06:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD1wG-0005h5-1j
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 01:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933053Ab2C1XF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 19:05:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62573 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932567Ab2C1XFy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 19:05:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFDAB61C4;
	Wed, 28 Mar 2012 19:05:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m+z+lTNZDOWan1s/2QndWqdPW+s=; b=beVIFp
	PicejwkAn9p6kcHrGcKD3eW6+VMhIRSCWYbDjcLETNREVEjC5jPUMoS7NSM9SPZH
	Ya0LwFKnLqFnF58Hx4LkDDnFp5dx9FmcT8V/f7T4pwUP8zjHQtooGXpONi4mlaj8
	XtdlWY1i03CPDsjM/nV4ZqZ57DQDEWaPF1AMY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fDBtKKVgxzJwj5E8KBh+4mIaPfo1aLCv
	zXawGejtKUOGWT/AJMe8RRy3/ud3/o5+fESE9NTEN0XOlSDNj6rCspD7gVGFUJuH
	9iFkeU9FTDZS1/spAifICd72OGvoenuxQm2NhYCrDwaNqEzom3ubgSc7fZYTYGIj
	N8mJM4k3EO8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A796561C3;
	Wed, 28 Mar 2012 19:05:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3DF7C61C2; Wed, 28 Mar 2012
 19:05:53 -0400 (EDT)
In-Reply-To: <7vk424s52z.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 28 Mar 2012 16:01:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9163E63E-792A-11E1-B1FE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194216>

Junio C Hamano <gitster@pobox.com> writes:

> There is a crucial step missing.  After running "cherry-pick --no-commit",
> you would eyeball the result, and typically edit the file.  The conflict
> may not be in the part of the file you are interested in picking, in which
> case you may even leave that part as-is.  And then, you would pick what
> you want to apply to the index during per-hunk interactive patching
> session.

Strictly speaking, you do not even have to edit the file.  If the conflict
does not overlap the part of the change you are interested in, a
hypothetical version of "add -p" that is oblivious to merge conflicts
(i.e. running "reset $path" before starting "add -p") could help you apply
the changes the picked commit makes relative to its parents to your
current state.
