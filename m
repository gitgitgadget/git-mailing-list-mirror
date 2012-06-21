From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] diff-no-index: exit(1) if 'diff --quiet <repo file>
 <external file>' finds changes
Date: Thu, 21 Jun 2012 09:55:12 -0700
Message-ID: <7vsjdosiz3.fsf@alter.siamese.dyndns.org>
References: <1340047704-8752-1-git-send-email-tim.henigan@gmail.com>
 <7vr4tc2xhy.fsf@alter.siamese.dyndns.org>
 <CAFouethcrw3vOF7SPwHxjH4ABmF8U1df0MfyzcUGq2yTYxs4ow@mail.gmail.com>
 <20120619135814.GA3210@sigill.intra.peff.net>
 <CAFouetgRq1qkqJmThJJeu=Mdx9jS0c9dw7NPSwuJUOSpskCY2A@mail.gmail.com>
 <CAFouetgXkqJPYwjr5ob5ed_ooL-D56zXyjnOAWrVPdt_eZqw7g@mail.gmail.com>
 <20120620160607.GA12856@sigill.intra.peff.net>
 <CAFouethNTzcWq_YKzGz+jRTeCjKZEC2ZYMZuQxkF+5AOTC=x-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 18:55:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShkfD-0007Mk-JJ
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 18:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759888Ab2FUQzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jun 2012 12:55:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60646 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759884Ab2FUQzP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2012 12:55:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DA258C9A;
	Thu, 21 Jun 2012 12:55:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JwFnLZZnHD5N9gbEYHhR6OfxjMM=; b=RrjnOU
	DDAlYb1M78Qcoc/2FNnCKYrfuflj3JVYTZJkaid/J03yf6X94PcXeM2WBAYLkzkz
	S2sIU0AyyguZT3+eGkodBiYkzazGMGwqSI6a/m7ggEFYQfxk3DXbHPz7wxOtMddl
	vqzOFKJly3lO+ThjihK6BYxvxbmDw235AMw2g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r0eTag+nWa1ag4w7IBNYoI2gB9Ssj1HL
	QWDoxomqWO/cQztgeAB8Ubme4AkfWnrRVryb2yMQ/omZIgMeXzxkLexPiUi9KpkL
	7GCSwG2uXq4sMlh529tYHHDnfDHn9Yzn9B0wujsnfIwz82RH/jlKwHIPGiuxs0X2
	+BWOtjSEhJg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9552D8C98;
	Thu, 21 Jun 2012 12:55:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21A708C97; Thu, 21 Jun 2012
 12:55:14 -0400 (EDT)
In-Reply-To: <CAFouethNTzcWq_YKzGz+jRTeCjKZEC2ZYMZuQxkF+5AOTC=x-A@mail.gmail.com> (Tim
 Henigan's message of "Thu, 21 Jun 2012 11:07:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DEF4E89C-BBC1-11E1-9416-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200405>

Tim Henigan <tim.henigan@gmail.com> writes:

> It looks like the best place to add tests is t4010-diff-pathspec.sh.

Well, pathspecs are all about limiting the changes in the repository
by patterns, while "diff --no-index" is about exact pathnames, so I
am not sure if that is a good place to put them.  Isn't there a test
script that is dedicated to the "diff --no-index" codepath (perhaps
4053) that is more appropriate for doing this?
