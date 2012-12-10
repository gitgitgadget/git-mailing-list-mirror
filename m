From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Use of a mailmap file with git-log
Date: Mon, 10 Dec 2012 12:16:14 -0800
Message-ID: <7vfw3dacj5.fsf@alter.siamese.dyndns.org>
References: <CALKB1SXdNVsQop5VYmShOMx93+j5SPdkGF9yNU5k7nXg87TwMw@mail.gmail.com>
 <7v38zdbv6d.fsf@alter.siamese.dyndns.org>
 <CALWbr2ydMkR_O-Gev7k-HjGadRJMv0UH3XdqtM0Jt=vC82GwJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rich Midwinter <rich.midwinter@gmail.com>,
	git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 21:16:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ti9mE-0006tE-Bu
	for gcvg-git-2@plane.gmane.org; Mon, 10 Dec 2012 21:16:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279Ab2LJUQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2012 15:16:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48266 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751140Ab2LJUQR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2012 15:16:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84D94941F;
	Mon, 10 Dec 2012 15:16:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=otOqk8DA4pbCH56t/zK+7G4kKms=; b=p2jbs8
	nS4aJp7/G7cuI1kf/rOMnX1ukcy5/JmDob00keoZdqBK4iyPYEnwqfEHQaLAFopJ
	IyrDw16j4n9KhAOxTdSLwQUL891a+CV0/dHh7nVYuYgV5eh3OhcyvfWSyAiLdXpk
	vbdpCisjhKmyq8RqyzAQUghYYac6jzM7A/0GY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cD6veGVcWMBxN6Y0PyXvqvCljRgz95zH
	Z+ttDnoJdi5R3TA3V0FlNpAi/tVFTFDJApMafgYEkKz5gcJ6Exf3ew8m/2U33bfW
	InZK6TvOLQhmyHxCSamW7w+5jh4ZgYXM+D/tkaboV4Navi+iFIbSHPQxM+wh/5qF
	xuEYyv458JU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72F93941D;
	Mon, 10 Dec 2012 15:16:16 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E6151941C; Mon, 10 Dec 2012
 15:16:15 -0500 (EST)
In-Reply-To: <CALWbr2ydMkR_O-Gev7k-HjGadRJMv0UH3XdqtM0Jt=vC82GwJw@mail.gmail.com> (Antoine
 Pelisse's message of "Mon, 10 Dec 2012 20:47:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 73668816-4306-11E2-877A-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211273>

Antoine Pelisse <apelisse@gmail.com> writes:

> It could indeed be very interesting to have mailmap applied to git-log and
> especially to git-log --author/--committer.
> ...
> The choice of parse_commit_buffer to do the modification is due to
> the grepping being done directly on buffer when grepping author/committerer.

For pattern matching, I think revision.c::commit_match() is probably
the right place to do this kind of thing.  I just noticed that we
grep for the string inside a raw buffer, even when "encoding" is
specified, which I think is a bug.
