From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] shell: pay attention to exit status from 'help'
 command
Date: Mon, 11 Feb 2013 08:28:43 -0800
Message-ID: <7vip5yolvo.fsf@alter.siamese.dyndns.org>
References: <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin>
 <20130211035908.GA4543@sigill.intra.peff.net>
 <20130211041404.GA15329@elie.Belkin>
 <20130211041714.GA12281@sigill.intra.peff.net>
 <20130211042609.GC15329@elie.Belkin>
 <20130211043322.GA12735@sigill.intra.peff.net>
 <20130211055604.GE15329@elie.Belkin> <20130211055847.GG15329@elie.Belkin>
 <7vd2w7pbh5.fsf@alter.siamese.dyndns.org>
 <20130211075245.GO15329@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Sitaram Chamarty <sitaramc@gmail.com>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 17:30:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4wGo-0001P4-Br
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 17:30:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757973Ab3BKQ3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 11:29:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60691 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757971Ab3BKQ2q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 11:28:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25A52B168;
	Mon, 11 Feb 2013 11:28:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oe0PkOs2gwKsqjEVfvyGyzd9+t4=; b=qnEUry
	l4Y9SOW79x/SvUmoZfSbsaEXSRsAdBrZj8lnbPIT0aqyQqfkJYleqFoiy4o7VapY
	+1NenWah9xLLFNBFRX/YjrPc6CMKEa9Q4JHjNCMsWsyjnAMu7bAvGK3YarbODPf6
	M4CTnDGLH1J5IurcLjx0gby/Vv6W7ytOgEVK8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VE7+Py1RT8JhglCTNtLnYe6oqnnEY1xd
	6ivoUdsX3bsbYk6JDNuyQnQEiMVYg4lS35+QF0EKqz2cjvXFinHyiONQEjizsEN+
	0+hxo4MgNCc/qNaVs3+/dhA802eACrpV2Qbdt1L5HFlMotXUY78F2o4YkzggX+u7
	aGONGDx1P/0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18EDBB167;
	Mon, 11 Feb 2013 11:28:46 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8277BB165; Mon, 11 Feb 2013
 11:28:45 -0500 (EST)
In-Reply-To: <20130211075245.GO15329@elie.Belkin> (Jonathan Nieder's message
 of "Sun, 10 Feb 2013 23:52:45 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1B261BF6-7468-11E2-B2EB-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216048>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> +To disable interactive logins, displaying a greeting instead:
>>> ++
>>> +----------------
>>> +$ chsh -s /usr/bin/git-shell
>>> +$ mkdir $HOME/git-shell-commands
>>> +$ cat >$HOME/git-shell-commands/help <<\EOF
>>> +#!/bin/sh
>>> +printf '%s\n' "Hi $USER! You've successfully authenticated, but I do not"
>>
>> Where in the sshd to git-shell exec chain is $USER variable set for
>> the user?  Just being curious if this is the simplest but one of the
>> more robust ways to get the user's name.
>
> That's a good question.  environment= in an authorized_keys file is
> obsolete, so USER generally represents the actual logged in user.
>
> That means the main way to base behavior on private key (letting one
> system user represent multiple people) is a gitolite-style command=
> wrapper that checks SSH_ORIGINAL_COMMAND.  In that setup, there is no
> reason to forward simple no-args "are you there?" requests to the
> git-shell, so we can forget about it here.
>
> So by the time we get to git-shell, most likely either
>
>  A) this is a generic system user, with a username like "git", and the
>     above example would insult the client with "Hi git!" or "Hi
>     project-x-git!"
>
> or
>
>  B) each person has a separate account on the system, perhaps to help
>     the admin to set filesystem permissions based on users and groups,
>     and the above would address the user by her normal name.

What return value getuid(2) would give us was not something I was
worried about.  Use of git-shell would be pointless if that does not
work to offer isolation between users.

I was wondering who would set the $USER variable based on the uid
assigned to the process during the remote login process and it is a
behaviour we can rely on across platforms.  It appears that when
coming over ssh, it is the ssh daemon that sets USER (and LOGNAME,
HOME, etc.) before running the login shell (session.c::do_child()
that is called from do_exec_pty() or do_exec_no_pty() in openssh).
