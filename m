From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge: refuse to create too cool a merge by default
Date: Fri, 18 Mar 2016 13:33:45 -0700
Message-ID: <xmqqoaabplue.fsf@gitster.mtv.corp.google.com>
References: <xmqqshznpmfe.fsf@gitster.mtv.corp.google.com>
	<CA+55aFz7309BkfHjD5H7tp9WE0yf1VWncxfmB3hgimJ00fbT-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 18 21:33:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah15l-00084n-LS
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 21:33:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011AbcCRUdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 16:33:50 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:64863 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751762AbcCRUds (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 16:33:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 14E954DB27;
	Fri, 18 Mar 2016 16:33:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cveojNR4u8VrjJAjB7NEj3q3Q0U=; b=GeJme5
	hIQx/+OIbY/BRgVWFGNvdO4EA/oQgcbW8c7QK9sDRpby+At8nmZNLf0U6RX6IkCP
	WU8ptbmZwYAwiO/6vFw9Lebu1FM9KQYF7Tj5OytxDHfqkgRrNJcYXvRHSZXvDw2y
	r6wFOy3isM/I9ymvnUTKxqinolsLzRKdgzbP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gqytj/Y1ImbtFLAwtW7NcalZ/zQJuIWq
	M/n1kgSNofjv3hcUhcYn/zd6viImI8EiV9IC1vqTL+SVLOyrkPn7h4SnyoS2PfEq
	95d2QhMh3eZvA/G+DeTOe0VYWyBqeS0sSd4bI4AfWhJTWFxbDXRfyQoco2ObTGti
	ciiLqauCV54=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0A63D4DB26;
	Fri, 18 Mar 2016 16:33:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6E3DA4DB25;
	Fri, 18 Mar 2016 16:33:46 -0400 (EDT)
In-Reply-To: <CA+55aFz7309BkfHjD5H7tp9WE0yf1VWncxfmB3hgimJ00fbT-Q@mail.gmail.com>
	(Linus Torvalds's message of "Fri, 18 Mar 2016 13:25:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B6C825F2-ED48-11E5-BDA8-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289250>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Mine was slightly different, I just went with a "unrelated" merge option.

Yeah, I was debating myself if this should be -Xunrelated specific
to recursive or an option that is meant for all strategies.  I can
go either way, but I think a command-wide option is logically the
right way to go, because you do not want two-project merge by
default no matter what strategy is used (and some of you may know
that I had a long term plan with no lines of code yet to do yet
another merge strategy).

> I'll attach my two patches anyway, if for no other reason than the
> fact that I actually wrote a new test for this.

Thanks, but after updating existing scripts, I think those changes
already make sure that two-project merges work with the option.
What is missing in my version is a new test that ensures the command
fails a two-project merge by default.
