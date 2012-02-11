From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git SSH Authentication
Date: Fri, 10 Feb 2012 23:54:30 -0800
Message-ID: <7vty2xn6tl.fsf@alter.siamese.dyndns.org>
References: <loom.20120211T045801-602@post.gmane.org>
 <CAMK1S_jmY5KvBH8z6YKszroMai4O5ULeCBYGAGFT4CgVUAfmwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: isawk <kwasi.gyasiagyei@4things.co.za>, git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 08:54:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rw7nB-0004bb-GR
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 08:54:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753904Ab2BKHye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 02:54:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59451 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753448Ab2BKHyc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 02:54:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2932E405B;
	Sat, 11 Feb 2012 02:54:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d9rkKjcNUkfdSoOVJ6SPJRAy6nM=; b=LaQF13
	etokaa56fxUSH33nzI1Q38Ixwci10DgAQ0aAoO6klsXEkR08cs53h+I+ZVfkAGdz
	pmPbbB320SxVJErcYPRfE613BaNGJJIKXYEAnZSVrQELeVioi+xXVNLjpyl9a41M
	D0KNePwVmlgXW82bO+z+yRshQCTbSRBksX5I0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GnoCqskQyfxlj/emKX9J3/mLve6XNN3g
	hxKz7zvX2ug5P0dp1BxrhZlL1aHFHHHEvqzUpRbFnGa+zKJl9LIikPMVVeJNrxOL
	FMaw7HQHplwDipS8d95DRfU20rNCtnIKHCgZUB0Nembl1JNeaWBBg6RPBrOsMR7L
	p/InZ3JA9Kk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20629405A;
	Sat, 11 Feb 2012 02:54:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9990C4056; Sat, 11 Feb 2012
 02:54:31 -0500 (EST)
In-Reply-To: <CAMK1S_jmY5KvBH8z6YKszroMai4O5ULeCBYGAGFT4CgVUAfmwg@mail.gmail.com> (Sitaram
 Chamarty's message of "Sat, 11 Feb 2012 10:35:42 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A199AB52-5485-11E1-9646-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190499>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> Common causes of pubkey access fail:
>
>   - wrong pubkey being offered: if you are using ssh-agent, make sure
> you have 'ssh-add'ed the key you want to offer.  Confirm with 'ssh-add
> -l'

A failure related to this I saw is to have (too) many keys in ssh-agent,
and running ssh without telling it which exact key to use.  The client
tries each key in turn and the server rejects the connection attempt after
seeing too many keys tried.  "ssh -v" is useful to diagnose this mode of
failure, and an entry in ~/.ssh/config like:

    Host example.com
	User myusernameoverthere
        IdentityFile ~/.ssh/id_rsa-for-example.com

would fix it.
