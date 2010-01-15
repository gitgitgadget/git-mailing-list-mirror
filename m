From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git clone against firewall
Date: Fri, 15 Jan 2010 10:17:44 -0800
Message-ID: <7vzl4fz0zb.fsf@alter.siamese.dyndns.org>
References: <4B4FACB1.2080902@hartwork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sebastian Pipping <webmaster@hartwork.org>
X-From: git-owner@vger.kernel.org Fri Jan 15 19:17:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVqkA-00051F-Mo
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 19:17:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757983Ab0AOSRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 13:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757975Ab0AOSRv
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 13:17:51 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33569 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757940Ab0AOSRv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 13:17:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D31D919A9;
	Fri, 15 Jan 2010 13:17:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=OPfyE6VjwP7YN4cKLUewUdtDqmo=; b=P/mmNsDOlcBMZ4R5jyO0sKY
	+mLJY38c6kJwGHApcvbt84XvWvOiwKsjq0dPCqQXQjNnkzPpMOFjisSbfCrxpPxb
	xth5tZgzH9K93aW2ETgays+9znC96vtXNJR0Mhu+LDWTcaC306D/U52B63h+eZLm
	jCo4bhoKjAiZPgHXunoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=HnWCsL2V/bxmbo0K8+m6JG6+TdgVYlB+Luj0F2E4Wedm9ZSCw
	2qsmBdM6Igw5Zb34a9eqNmZSQi/wvHh/zFIMqQ1qwEkFTwED2Yy5rwSDrTSMSJ7C
	ZTCKybpdWfF2YjqZKls/a44DNjhBPrKxilYUSKNktd3MW5lYXm1vntaXQg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7601E919A8;
	Fri, 15 Jan 2010 13:17:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A1AF8919A6; Fri, 15 Jan
 2010 13:17:45 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 49214412-0202-11DF-A988-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137093>

Sebastian Pipping <webmaster@hartwork.org> writes:

> with a firewall blocking outgoing connections to port 9418 a
>
>   git clone git://...
>
> of git 1.6.6 seems to never return, i.e. loop forever.  in my rather
> automated environment (gentoo's tool layman calling git) this behavior
> is rather troublesome - i need some kind of abort-and-error instead:
> what i'm trying to do is loop over a number of clone URL alternatives of
> the same repository like ..
>
>   git://git.overlays.gentoo.org/dev/dberkholz.git

What do you exactly mean by "blocking"?

In my environment at work, there is a firewall and I immedately get this:

    $ git clone git://git.overlays.gentoo.org/dev/dberkholz.git/
    Initialized empty Git repository in /var/tmp/dberkholz/.git/
    fatal: Unable to look up git.overlays.gentoo.org (port 9418) (Name or service not known)

as my environment is quite isolated (it is not just a "NAT with selective
port blocking").

I am guessing that you can resolve the hostname in your environment
(i.e. you configured your NAT to let DNS go directly outside).  What
happens when you try the following?

    $ telnet git.overlays.gentoo.org 9418

Do you get:

    Trying 66.219.59.40...
    telnet: Unable to connect to remote host: Connection refused

If you get something like:

    Trying 66.219.59.40...
    Connected to pelican.gentoo.org.
    Escape character is '^]'.

then I don't think you are blocked, and if that is the case, there is not
much we can do about it.

I think your firewall can help, though, by not pretending to be allowing
the connection and then blocking you halfway.
