From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 03/10] refs.c: Refactor code for mapping between shorthand names and full refnames
Date: Tue, 14 May 2013 10:50:06 -0700
Message-ID: <7vobcdjvsh.fsf@alter.siamese.dyndns.org>
References: <1368289280-30337-1-git-send-email-johan@herland.net>
	<1368289280-30337-4-git-send-email-johan@herland.net>
	<7vmwrzsck1.fsf@alter.siamese.dyndns.org>
	<CALKQrgf0m8r-Ofb+Ss1OpEF67dPS73b8nB+usVxH=Y=h3441Wg@mail.gmail.com>
	<7v8v3jqsy7.fsf@alter.siamese.dyndns.org>
	<7vwqr2liv6.fsf@alter.siamese.dyndns.org>
	<CALKQrgcDBMPeXPzTnpGyeosipR6Ln_zLh4Q_i1A7-eFUnTnBcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue May 14 19:50:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcJMe-0004ms-Rd
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 19:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755681Ab3ENRuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 13:50:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34557 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753398Ab3ENRuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 13:50:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 860FB1E8C4;
	Tue, 14 May 2013 17:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9xD78hg9lc5hhdzDolMxy0Cusv4=; b=rZcdEd
	S8hwoq4H8Vd+DzPOUrlj6BuytyvXWxED/YDK1DN0ofzn2MfkdLrQ7aGjtXkCTdBr
	d5Aq+yxgIRsBMOrxLBaBtB26l0euKXTuV03I8tSXsMadYwOM41xVOimgK//2VLUY
	BrGyCEYWZcFgQoQJOh+uwjMalbFXYQTjA+FBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UZkrAGkkElZBpnek1l2YlM1xmxLFf9tO
	146XVvm+cuKCsnEp4FVd78Efpn7BwZhAn7804X0gQYEOHnVdz7OuFXT6EXbhtglV
	t0AnJyK4S7QRnBLl+FoxrPj99TfxN6RBAStqJ+VkcZgDJLXWVKQE2ouD9YwhCOgA
	6H+I80CRvgQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CA571E8C2;
	Tue, 14 May 2013 17:50:08 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA17D1E8C0;
	Tue, 14 May 2013 17:50:07 +0000 (UTC)
In-Reply-To: <CALKQrgcDBMPeXPzTnpGyeosipR6Ln_zLh4Q_i1A7-eFUnTnBcA@mail.gmail.com>
	(Johan Herland's message of "Tue, 14 May 2013 16:24:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B743CFBC-BCBE-11E2-879E-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224307>

Johan Herland <johan@herland.net> writes:

> I think I like "refs/peers/%1/heads/%*" better than
> "refs/peers/%1/heads/%2", since the latter sort of makes me wonder
> whether the 3rd, 4th, etc. components would be discarded.

Makes sense.

> I am not sure why we would want "refs/remotes/%1/%2" instead of
> "refs/remote/%*".

The former way makes it easier to see what "refs/peers/%1/heads/%2"
means, I think, but otherwise aren't they equivalent?  I do not see
a strong reason to favor one over the other.

> remote-tracking branch "baz" from remote "foo/bar", but we might say
> that's ok, because (a) multi-level remote names are so rare, and (b)
> the simple workaround of explicitly saying
> "refs/peers/foo/bar/heads/baz" would always be available in any case.

Sounds sensible.

And if you limit things that way, "%1" again starts to make sense,
as you are representing "the first path component" with it.
