From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cloning a tree which has detached branch checked out
Date: Tue, 07 Feb 2012 09:11:00 -0800
Message-ID: <7v4nv236xn.fsf@alter.siamese.dyndns.org>
References: <20120207070628.GA24698@redhat.com>
 <m362fjklb7.fsf@localhost.localdomain> <20120207104100.GA24828@redhat.com>
 <CACsJy8DtmQLX+Lfng-QRzVg9sfo8gQMXB-xTtPYpt+R2gModTg@mail.gmail.com>
 <20120207153225.GA14773@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 07 18:11:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuoZS-00014u-IH
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 18:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755486Ab2BGRLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 12:11:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48734 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754643Ab2BGRLD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 12:11:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE5EB5693;
	Tue,  7 Feb 2012 12:11:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1Onn/beZ0vW5X+JfbFg4GkNX7Y0=; b=CS+eD7
	hKe9ppT1i+OofWU2fB3kvexTCbVqG0i2ILThIZpTGLLefTKdWk+lAa1sJxLB9w7X
	SsbeNeb7v7aoQEKSlChA2M/1A90Xa30UZb3/cMq3nNY/QZmmFYdd/9zEpYZGqhfu
	6BvP+GGMxJmDR99zgb6pgQTABf3SBOePA1wOw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TOG4M6nxlePQ4PgcRW4g93sgzf9Tau9w
	wUAssEZyoYQTJYtWFZodhJdsITzsBTvZguIKuZzT629t1EqwaCKy/2MO66HeMDjO
	Y0jMGLvTwhqh2sXU9hUAhQl2HfZELpqR2Z3HY4zFgGtdULSSJbNuAgcPgUi6kJ4/
	0H6AHT6iT9k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E44B45692;
	Tue,  7 Feb 2012 12:11:02 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5070C5691; Tue,  7 Feb 2012
 12:11:02 -0500 (EST)
In-Reply-To: <20120207153225.GA14773@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 7 Feb 2012 10:32:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B65B263A-51AE-11E1-8230-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190184>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 07, 2012 at 07:57:08PM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> On Tue, Feb 7, 2012 at 5:41 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> >> > #git clone -n lab:/home/mst/scm/linux
>> >> > ....
>> >> > error: Trying to write ref HEAD with nonexistant object
>> >> > cec64082f689f949a397cb9b39423dc41545fa0e
>> >> > fatal: Cannot update the ref 'HEAD'.
>> >> >
>> >> > Looks like a bug, doesn't it?
>> >> ...
>
> This particular bug should have been fixed before that, even, with my
> c1921c1 (clone: always fetch remote HEAD, 2011-06-07). And it is tested
> explicitly in t5707,...

That was my thought when I first saw it.  The failure case was that HEAD
was pointing at something no ref reaches, and clone was only grabbing the
tips of branches, which failed to transfer the history leading to HEAD.

> ... So I think your guess about a subtle error in the local ref
> processing is a reasonable one.

What is funny is "error: Trying to write ref HEAD with nonexistant object".
"git grep -e nonexistant f3fb0" does not register any hit.

Could it be that mysterious "lab:" protocol handler that is misbehaving?
