From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/12] pretty: add %C(auto) for auto-coloring on the
 next placeholder
Date: Fri, 05 Apr 2013 10:13:02 -0700
Message-ID: <7v8v4wdhpd.fsf@alter.siamese.dyndns.org>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
 <1364636112-15065-1-git-send-email-pclouds@gmail.com>
 <1364636112-15065-10-git-send-email-pclouds@gmail.com>
 <7vzjxihztj.fsf@alter.siamese.dyndns.org>
 <CACsJy8C0wb92QOhh=e27Cqd=e5yJYnQWYkYi4uPd+vPXGqVbdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:00:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWLh-0002u6-Iz
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162117Ab3DERNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 13:13:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50305 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162068Ab3DERNE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 13:13:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31F99149B1;
	Fri,  5 Apr 2013 17:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=MxDUZWR5xTR03s/5ZpxdM+1tAhc=; b=EY4N3WhplU8xm5Z0Cadg
	3lil+oUe0r0nkbfNgrG54OBgOTSYg6eArB4q/RmcDsjXo6bF9X+Odc5NJUec6mEe
	n4wJORXXrmJJwFSg7Wxra7RqamEIfqk+3gD6doxSr4hYzsukz3d3w+8qkgyyRzFK
	UbvGRt78zZ+Dat1+pN7StSw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=wzsK124kN2Co9JqQuqtSxhI7zScL1QOfpf8wnEVwJrASEY
	TEgWiT9CDoA/Ydd/8hhgEXFCA/Z5fxY54iuPhN5sZ40uV1+Yjqh+M1YB44UuAHOc
	5p5cLvNO6iQaPGRBsFyMBOfLlRXDNgb0KhvTNdUw/cnzv59rNy6DwF9jby8Y8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27556149AF;
	Fri,  5 Apr 2013 17:13:04 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8934C149AD; Fri,  5 Apr
 2013 17:13:03 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 13598A4A-9E14-11E2-819C-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220179>

Duy Nguyen <pclouds@gmail.com> writes:

> The above should have written "will turn on auto coloring on the
> following _textual_ placeholder". I didn't intend %C(auto) to be
> followed by %C(color) as it's already covered by %C(auto,red). But of
> course we could make it work too.

You are right that there is no need to say "%C(auto)%C(red)", it is
"%C(auto,red)", but that misses the point.

If %C(auto) applies to some %<placeholder> but not to some others,
the user needs to learn which %<placeholder> will eat the "auto" (so
it no longer applies to the next one) and which one will not even
look at "auto" (so the next %<placeholder> is affected by the auto,
i.e. making the effect of auto skip a %<placeholder>).  If the rule
were "%C(auto) applies to -next- placeholder", then the user does
not have to worry about which ones are what you call textual and
which ones are not (and there is no textual placeholder defined in
the glossary).

That would make it harder to learn. It would be much easier to
explain if you said "%C(auto) affects the next %-placeholder and
then resets".

I wonder if "Everything after %C(auto) will not be coloured if the
output is not going to the terminal.", i.e. not resetting once
colouring decision is made, makes more sense, though...
