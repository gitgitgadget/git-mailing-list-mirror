From: Junio C Hamano <gitster@pobox.com>
Subject: Re: blame --reverse selecting wrong commit
Date: Mon, 30 May 2011 13:01:25 -0700
Message-ID: <7vei3glzze.fsf@alter.siamese.dyndns.org>
References: <BANLkTikuFEg686VH_RojEe-zmBZRBOx6eA@mail.gmail.com>
 <BANLkTimAij28ibW3DV2HaHPK5z0D-CrDHQ@mail.gmail.com>
 <BANLkTimXppE9sCW8tMntbD8p5-bRVFLHmQ@mail.gmail.com>
 <7vlixoofaj.fsf@alter.siamese.dyndns.org>
 <BANLkTikvmQgW=x0GYY6Yu=BnOgG+RXOCug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 30 22:01:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR8ef-0004WV-8S
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 22:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757852Ab1E3UBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 16:01:34 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46450 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753144Ab1E3UBc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 16:01:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5AA955781;
	Mon, 30 May 2011 16:03:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vq0t3KmyysIB5Pj3Xsrrdv6UqFM=; b=ifDMnp
	tR91tGg+pgjg4Hz9CoP35TsWGhc8TW67CpCB+V6OOGEs5lU6PDvaVm6MupyEs0HT
	hAdNNq1sM+r/iXYv0pHG0NTGOl74WJ1Oha2/n3b7ZL6CSEbNy8xNWt/t86b5NoVT
	mV23YlJPFC04cGQJGm11lHoTPGCI7KAUz4G/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DbwNVbMOSiwU8ySnXMjE30FInaltIwvi
	oW/8+UZX3vGKHPhSz55ZxsPgKnjX0pS8ZCpWw+Nt4pVjRsJhhhFfBNrO8z+QJeKM
	u9bPB4qjqRsMzwr3aB/ZR9e+GrKGOB/1W2dynAIx0vVPeeuHXDDYfRl07TsWZVVU
	ii1BZJ6rfzY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 37E695780;
	Mon, 30 May 2011 16:03:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0EF0B5779; Mon, 30 May 2011
 16:03:33 -0400 (EDT)
In-Reply-To: <BANLkTikvmQgW=x0GYY6Yu=BnOgG+RXOCug@mail.gmail.com> (Shawn
 Pearce's message of "Mon, 30 May 2011 10:57:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E7CA2866-8AF7-11E0-A1DA-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174773>

Shawn Pearce <spearce@spearce.org> writes:

>> Yeah.
>>
>> It has always been my opinion that asking for "one commit past the blamed
>> one" is a undefined request (after all, blame for the line fell on that
>> commit exactly why the next commit does _not_ have any corresponding
>> line), so that is why I punted there.
>
> I don't think its undefined. Normally with blame/annotate we want to
> discover who put this line here, that is who did the insertion or
> replacement that made this line show up in the result file.

Very true. The question that does not have a defined answer is "what
content was before this commit on that blamed line", and that is very
different from "what commit was there before this commit the line is
blamed for". The topic of this thread is the latter, and I was referring
the former which is offtopic because I was confused and tired.

> The catch is, its slightly more expensive than forward because we pass
> blame down *all* paths of a fork, rather than only the one that was
> identical.

Hmm, I don't know. Isn't it just the matter of running the current
"reverse blame" to find the newest revision that had the line (without any
"dig wider"), and then dig a single level wider by comparing that revision
and all its children to see which child has the line in question removed?
