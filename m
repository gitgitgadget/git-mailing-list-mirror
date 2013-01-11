From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Turning a complete repository to a shallow one
Date: Thu, 10 Jan 2013 20:53:01 -0800
Message-ID: <7vk3rkcocy.fsf@alter.siamese.dyndns.org>
References: <CACsJy8Bv+AfDbttFdJ5a0PaoMrMtv1seda7VqLpfdevR4BMj4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 05:53:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtWcS-0006Dz-P2
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 05:53:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035Ab3AKExF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 23:53:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44183 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753400Ab3AKExD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 23:53:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C3C8A7E2;
	Thu, 10 Jan 2013 23:53:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4YcohXbvux7/l/aGxTGFi5JzWUc=; b=r5Al5H
	uJXj2pwuteMuyUaeCQ6jptkIudnjMTJuGMqbxaHZsa2ZxPKeKCEDd1NZj0c+SyAr
	SlhHKfIc9a0WB1DFOHzX3S/Tl2WH5LmFCbrZkWMM+4x+nU8Mol54N3dlxGYl3OBL
	RlHM9Vhb4zHvIE6+HnDT1iyL/iwy/yZpZkit4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XP9rT0aXCc61D9Zb/2FdzU42dmGZiSZ9
	CcYXG1JvUWVxZ4F6xfgtK+HfKZnwlUwVEGJB7eJvomkG6EYYg+fh0RWr0u2IF99r
	oVLFGlkadbwrp3yo/b8X9ZQzTEmAwoM1feJwrSUNk3E1wyatCPUFBN+egDn6LS4D
	z3KNkntKF6c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4050AA7E1;
	Thu, 10 Jan 2013 23:53:03 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD4DFA7E0; Thu, 10 Jan 2013
 23:53:02 -0500 (EST)
In-Reply-To: <CACsJy8Bv+AfDbttFdJ5a0PaoMrMtv1seda7VqLpfdevR4BMj4A@mail.gmail.com> (Duy
 Nguyen's message of "Fri, 11 Jan 2013 11:40:03 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7AE0068-5BAA-11E2-A170-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213180>

Duy Nguyen <pclouds@gmail.com> writes:

> Apparently we could do it:
>
> git clone --single-branch git.git
> cd git
> git tag -l|xargs git tag -d
> git fetch --depth=1 origin master
> git repack -ad

I may have been unclear in the earlier message, but this is one of
the reasons why I think "fetch --depth" is misadvertised (it says
"deepen the history", when the real thing it does is to truncate to
the new depth counting from the updated tip), and misdesigned (it
forces the user to guess what the new depth should be).  It should
be advertised correctly, as a way to reset its depth starting from
the current history (and of course --depth=1 is truncates).

We should introduce a separate "fetch --deepen" that does what
normal people would want (see my earlier message with ASCII art).
