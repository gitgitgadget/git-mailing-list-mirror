From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email: add ~/.authinfo parsing
Date: Tue, 29 Jan 2013 11:53:19 -0800
Message-ID: <7vvcafojf4.fsf@alter.siamese.dyndns.org>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org, Krzysztof Mazur <krzysiek@podlesie.net>,
	Michal Nazarewicz <mina86@mina86.com>
To: Michal Nazarewicz <mpn@google.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 20:53:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0HFY-0007c4-2S
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 20:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754398Ab3A2TxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 14:53:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39019 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754308Ab3A2TxW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 14:53:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE878CE4F;
	Tue, 29 Jan 2013 14:53:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3MsgRl8sa2ehIgkWhgIVkLFgY/0=; b=f0UcN/
	ultUDERIZYbpIhieHbSzcp8p+3Yjyotv2FT/ro4TY0pxkP5IoR0RbaE/HtgEJL3S
	P0BeBXZVhDKolzBOtUw2IKaN3WrwLMDyWt4U57m55+1U7XWrnS0OOC/+x+KGNfNL
	SgT8hhrCbbDV3BOlIn2sDN2ietE1rOrFkcUug=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t+D31c7j68h9FYm2JoivWIMwkreKIuk5
	TmK417I219kXhWSFUOBQi/ciT4w8GtyqKtKLE3ka5Jw94hGlMm1O0DiOTTS1LUns
	yRlxBkNMJmFVPGKgQkY8fzvtZZsS2cXcWp1yqEtLYuAl2idskcOYdwaivNi36Afp
	del+QehxDus=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2739CE4E;
	Tue, 29 Jan 2013 14:53:21 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 03D1ACE4A; Tue, 29 Jan 2013
 14:53:20 -0500 (EST)
In-Reply-To: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
 (Michal Nazarewicz's message of "Tue, 29 Jan 2013 20:13:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8888FD82-6A4D-11E2-B91D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214965>

Michal Nazarewicz <mpn@google.com> writes:

> From: Michal Nazarewicz <mina86@mina86.com>
>
> Make git-send-email read password from a ~/.authinfo file instead of
> requiring it to be stored in git configuration, passed as command line
> argument or typed in.

Makes one wonder why .authinfo and not .netrc; 

http://www.gnu.org/software/emacs/manual/html_node/auth/Help-for-users.html

phrases it amusingly:

        “Netrc” files are usually called .authinfo or .netr
        nowadays .authinfo seems to be more popular and the
        auth-source library encourages this confusion by accepting
        both

Either way it still encourages a plaintext password to be on disk,
which may not be what we want, even though it may be slight if not
really much of an improvement.  Again the Help-for-users has this
amusing bit:

	You could just say (but we don't recommend it, we're just
	showing that it's possible)

	     password mypassword

	to use the same password everywhere. Again, DO NOT DO THIS
	or you will be pwned as the kids say.

> +The '~/.authinfo' file is read if Text::CSV Perl module is installed
> +on the system; if it's missing, a notification message will be printed
> +and the file ignored altogether.  The file should contain a line with
> +the following format:
> ++
> +  machine <domain> port <port> login <user> password <pass>

It is rather strange to require a comma-separated-values parser to
read a file format this simple, isn't it?

> ++
> +Contrary to other tools, 'git-send-email' does not support symbolic
> +port names like 'imap' thus `<port>` must be a number.

Perhaps you can convert at least some popular ones yourself?  After
all, the user may be using an _existing_ .authinfo/.netrc that she
has been using with other programs that do understand symbolic port
names.  Rather than forcing all such users to update their files,
the patch can work a bit harder for them and the world will be a
better place, no?
