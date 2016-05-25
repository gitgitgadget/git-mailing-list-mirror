From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add: add --chmod=+x / --chmod=-x options
Date: Wed, 25 May 2016 09:10:09 -0700
Message-ID: <xmqqoa7u15lq.fsf@gitster.mtv.corp.google.com>
References: <20160525020609.GA20123@zoidberg>
	<xmqqh9dm37xk.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1605251406020.4449@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Edward Thomson <ethomson@edwardthomson.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 25 18:10:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5bO9-0007NQ-Km
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 18:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644AbcEYQKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 12:10:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65358 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932636AbcEYQKN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 12:10:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E49D1DBFE;
	Wed, 25 May 2016 12:10:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a1G7qR6nRiPzogjXupoz7O/uJow=; b=tX//P+
	ucvu6iJJe1tpOvxfIpf3Az8xE5pLIycfoPJ71AG/lHP+IZhiMw/rIZiBuhAgj/aN
	1pB9zMz6vrMjWonAH8WO2A4fsDcnLntyX/F1Vfk1FQ/+E14o19vNNv0NqDmKzqQ4
	RFOnyM0xj7IkyOwsbWwYMWlGwlI3hgn/zOa+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ugsBVlG7xQPeIwc8tJdUtRXk2C4xPGRj
	++fAePe0vU6EBPzbGYfiWW8ovN6OUuZuLuigYkiJOIjuqOZGNXdhTziujcu84AS0
	M/lUSujlmgDZ0zX5tWvmkoyXpCoKjDG29s6mkVBMu5G7dxwekusc/ApkW4qXqde3
	ooPVXKpo4Y8=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 36CDC1DBFD;
	Wed, 25 May 2016 12:10:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B88D81DBFC;
	Wed, 25 May 2016 12:10:11 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1605251406020.4449@virtualbox> (Johannes
	Schindelin's message of "Wed, 25 May 2016 14:19:35 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 28939264-2293-11E6-8028-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295577>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 25 May 2016, Junio C Hamano wrote:
>
>>  * I am not familiar with life on filesystems with core.filemode=0;
>>    do files people would want to be able to "add --chmod=+x" share
>>    common trait that can be expressed with .gitattributes mechanism?
>
> I think it is safe to say that the biggest example of core.filemode == 0
> is Windows. On that platform, there simply is no executable bit in the
> sense of POSIX permissions. ...
> ... I still like Ed's idea and would love to have it: it is murky waters to
> require users to call plumbing only because our porcelain isn't up to par.

I thought that I made it absolutely clear that I like the addition,
too.  If it wasn't clear enough, I can say it again, but I do not
think you need it ;-).

The "attribute" thing was an idea that was hoping to make the system
as a whole even more helpful; if pattern matching with paths is
sufficient for projects to hint desired permission bits per paths,
then those working on such a cross-platform project on Windows do
not have to even worry about "git cmd --chmod=+x", whether cmd is
add or update-index.  If they can just do "git add" and need to use
the new "--chmod=+x" option only when the patterns are not set up
correctly, wouldn't that be even more helpful?  In other words, it
wasn't "with this we can _eliminate_ need for 'add --chmod'".

The only thing I was unsure about that scheme was if "pattern
matching with paths" is sufficiently powerful (if not, such an
addition would not work as a mechanism to reduce the need for the
users to run "git add --chmod=+x").  And that was my inquiry.

Unfortunately, your answer does not help answer that question;
it was a question to Edward, so that's OK anyway.
