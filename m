From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help.c: add a compatibility comment to cmd_version()
Date: Wed, 17 Apr 2013 17:13:29 -0700
Message-ID: <7vehe8d7bq.fsf@alter.siamese.dyndns.org>
References: <1366144405-61438-1-git-send-email-davvid@gmail.com>
	<3D6BDB8830FC44A38B1AC508488049C0@PhilipOakley>
	<7vvc7mhzok.fsf@alter.siamese.dyndns.org>
	<EAD161814DB34F5AAC61A9EF06873314@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "David Aguilar" <davvid@gmail.com>, <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Apr 18 02:13:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UScTw-000744-T2
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 02:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935744Ab3DRANh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 20:13:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50170 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935697Ab3DRANe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 20:13:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF68417AA5;
	Thu, 18 Apr 2013 00:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=wsP7XHsBmKGx07T42B0y8lOPuxA=; b=YmKVgJmAtUcYm8GrsNa2
	9BZaIEkJKRD7SGPKlwoV0QfVf7fQcNqMoBqXXjLAL7PBhD4e2o6B+McmpnQMmh7m
	CJF5MUcn4H8o5swRG1xcfgDILfwD2OIGlcWKd05GmFmq7TUr5+swKf1Vj55Iw9aJ
	ttXM9QxXNJnxPSkRttbtvgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Oync/GBDOhB7jtmbD1oJKcsQBFc6XLAj7AFc4PZCK/vvO8
	vAM8lryLQzoYeK8aBP08viFr18fUM4emX8eITPtO3lh7m80Wv4RW9BjxbcEvUX1F
	JRp+ugt+l48opKMHYOk/xAdnglZ6WGou0xdRGVfIyRFBPgOMvwv9FB4CCuRSU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6AC617AA4;
	Thu, 18 Apr 2013 00:13:33 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E3C117AA2;
	Thu, 18 Apr 2013 00:13:33 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CE605CE0-A7BC-11E2-B884-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221594>

"Philip Oakley" <philipoakley@iee.org> writes:

> How about
>    * E.g. git gui uses the extended regular expression "^git version
> [1-9]+(\.[0-9]+)+.*"
>    * to check for an acceptable version string.
>
> The ERE is from git-gui.sh:L958.

That is exactly the kind of guarantee we do _not_ want to give.

> ... Hence my suggestion of the basic test that a "passing" git
> would produce a consistent version string.

I have been assuming that you are trying to avoid an exchange like
this one we had in the past:

  http://thread.gmane.org/gmane.comp.version-control.git/216923/focus=217007

I also have been assuming that you are pushing to limit the possible
versioning scheme, but I do not know what that extra limitation
would achieve in the real world.

By sticking to the pattern "git gui" happens to use, "git gui" may
be able to guess that the next version of Git says it is verison
"1.8.3".  That is the _only_ thing your "test" buys.

But having parsed the "1.8.3" substring out of it, "git gui" does
not know anything about what 1.8.3 gives it.  As far as it is
concerned, it is a version whose "git version" output it has never
seen (unless it has been kept up to date with the development of
Git).

By matching against "git version [1-9]+(\.[0-9]+)+", it is accepting
that future versions may break assumptions it makes for some known
versions (which is warranted) and all future versions (which is
unwarranted) of Git.  Maybe the version 2.0 of Git adds all changes
in the directory "d", including removals, when you say "git add d",
but it may have assumed that with Git version 1.5.0 or newer, saying
"git add d" would result in added and modified inside that directory
getting updated in the index, but paths removed from the working
tree will stay in the index.

The only thing the scripts that read from the output of "git
version" can reliably tell is if it is interacting with a version of
Git it knows about.  If it made any unwarranted assumption on the
versions it hasn't seen, it has to be fixed in "git gui" _anyway_.

Of course, we would not change the output of "git version"
willy-nilly without good reason, but that is a different topic.

So I do not know what you want to achieve in the real world with 
that extra limitation on the "git version" output format.

Maybe you are proposing something else.  I dunno.
