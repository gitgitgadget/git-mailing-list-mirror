From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC 1/3] add: add new --exclude option to git add
Date: Sun, 15 Mar 2015 14:50:41 -0700
Message-ID: <xmqq4mpmszf2.fsf@gitster.dls.corp.google.com>
References: <1426427399-22423-1-git-send-email-kuleshovmail@gmail.com>
	<CAPig+cR52GKNZkgsytUrb0m3wwY2T68cxjNB_OV+uLxvQUh=VA@mail.gmail.com>
	<xmqqtwxmt43h.fsf@gitster.dls.corp.google.com>
	<D9562ECC995343B3A51D449DC2B46CBC@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Eric Sunshine" <sunshine@sunshineco.com>,
	"Alexander Kuleshov" <kuleshovmail@gmail.com>,
	<git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Mar 15 22:50:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXGQs-0001L6-9f
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 22:50:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbbCOVup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 17:50:45 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54115 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751296AbbCOVuo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 17:50:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5EF1740386;
	Sun, 15 Mar 2015 17:50:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g5VHCxpSTdlY5VgC/srp/rZvSj8=; b=wMWVYO
	judYIa7yVtC0ZWlsjlPll7It8yycySYisGe054m8US+IQ+KZzTuGiIcNnqpMeRtL
	eBZ8z5mO8InkDmo5aC0UBd0CldDrLaDPI4Vs5BJ2WWoNd6gJgbhoqmGNLCmDM8Qo
	anJ9+Gl7UJIYZbYAl9LemyWSsw9EOqgGMZ8JQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I4O1vrHb1KWiQJpWOcla+Z930ctJ2Nvc
	LfUkSkqwNiPJk9fCkunFJ3AhRoWFn4mhmsEQKUT4GCD36QsY1YF0BeGY8VxxY/Sz
	gSiwzJzJu5GYmDk+4Qcmge9TcNIUYnSmRE6Vi51UwdgkbanlWck0Za8ihG9zMrV+
	QmdrcPVIVWs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 54C8940385;
	Sun, 15 Mar 2015 17:50:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A4ED140383;
	Sun, 15 Mar 2015 17:50:42 -0400 (EDT)
In-Reply-To: <D9562ECC995343B3A51D449DC2B46CBC@PhilipOakley> (Philip Oakley's
	message of "Sun, 15 Mar 2015 21:12:49 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 53D6A508-CB5D-11E4-8CB9-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265527>

"Philip Oakley" <philipoakley@iee.org> writes:

> Maybe He/We would be better off adjusting the documentation such that
> these 'magic' capabilities are brought out of their hiding places into
> regular view - e.g. a paragraph within the 'git add' documentation
> (and/or other commands) showing how such excludes are easily done with
> a few simple keystrokes....

I agree documenting is good, but I do not think it belongs to "git
add".  For example, shouldn't "git log -- \*.c ':!secret.c'" work
the same way?

> 'git help revisions' doesn't appear to cover it.

Of course not, because "revisions" would cover revisions, and
pathspecs are different animals ;-) Again, I agree there should be a
section somewhere close to the central place that talks about
pathspecs in general and then talk about pathspec magic there.

There are some references in git(1) but they talk about ways to
implicitly enable the magic to _all_ pathspecs, before introducing
the readers to what the magics are and how they can use them.

Perhaps in git(1), before we introduce "GIT COMMANDS", we may want
to have a new section that talks about the general structure of the
Git command line, laying out the general rules such as

 * dashed options come first
 * revisions and ranges come second
 * pathspecs come last

The first one is described in detail in gitcli(7) and how revisions
are spelled is given in gitrevisions(7).  How pathspecs are spelled
and used may want to be its own gitpathspecs(7), or if there are not
too many rules, can be spelled out there inline.  Either way, we
would want a brief section in git(1) to serve as a jumping board for
the former two, at least. Also descriptions for --literal-pathspecs
and friends would want to refer to either the section or have a
direct reference to gitpathspecs(7) if we are going to write it a
new file.
