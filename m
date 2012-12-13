From: Junio C Hamano <gitster@pobox.com>
Subject: Re: unclear documentation of git fetch --tags option and tagopt
 config
Date: Thu, 13 Dec 2012 10:44:15 -0800
Message-ID: <7v7golzta8.fsf@alter.siamese.dyndns.org>
References: <CAHtLG6Ti7yPFfhTb2qfSKE1+5n4Ftey4DQeqpm3SSL-bOfspUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 19:44:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjDls-0004qG-3D
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 19:44:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756562Ab2LMSoT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Dec 2012 13:44:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37422 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756388Ab2LMSoS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Dec 2012 13:44:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A97C3A920;
	Thu, 13 Dec 2012 13:44:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=b4qvryCflVbF
	4s6bbDIa4ACKrfo=; b=AKe2oXNew70ynE8lqUvdxAItoUb3jwZdzZc9pvsCt7CY
	gteS7jCnSTBjy3uh7WP/lr9jKnQNkuYSFmxJgcQpxTDc6UQHrmoBEKcwqluyRu5C
	+qDbLzGlrLbk+LJ/appQvsQbDqN/RDld7CPD7FBpjeN6yeqi6HUKTj9CvX9fuyo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jLgeED
	4nTxX1ieRJSB+uTiKoUnjzb3Sd4QohtcbFBfSlL0P+6/jEFJcUHvjNuF0cmu5lSl
	Yhl7C8TnzSjq1ElPFEPnl1s1laP47AUXT/TAyCm10SPBO9pQPFEwJ6ly4jScCQQo
	1G24aIZwhWPprpXX1NYHuPE3OIAx57sccOQm4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 964A3A91E;
	Thu, 13 Dec 2012 13:44:17 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EDD6BA91D; Thu, 13 Dec 2012
 13:44:16 -0500 (EST)
In-Reply-To: <CAHtLG6Ti7yPFfhTb2qfSKE1+5n4Ftey4DQeqpm3SSL-bOfspUg@mail.gmail.com>
 (=?utf-8?B?IuS5memFuOmLsCIncw==?= message of "Thu, 13 Dec 2012 14:29:32
 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1913FEA6-4555-11E2-A065-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211464>

=E4=B9=99=E9=85=B8=E9=8B=B0 <ch3cooli@gmail.com> writes:

> With git fetch --tags
> or remote.origin.tagopt =3D --tags
> git fetch only fetches tags, but not branches.
> Current documentation does not mention that no branches are fetched /
> pulled when --tags option or remote.origin.tagopt =3D --tags is
> specified.

In the canonical form you spell out what you want to fetch from
where, and a lazy "git fetch" or "git fetch origin" that does not
specify what are to be fetched are the special cases.  Because they
do not say what to fetch, they would become a no-op, which would not
be very useful, if there is no special casing for them.  Instead,
they use sensible default, taking refspec from the configuration
variable remote.$name.fetch.

Giving refspecs or the "--tags" option from the command line is a
way to explicitly override this default, hence:

    $ git fetch origin HEAD

only fetches the history leading to the commit at HEAD at the
remote, ignoring the configured refspecs.  As "--tags" is a synonym
to "refs/tags/*:refs/tags/*", "git fetch --tags origin" tells us to
ignore refspecs and grab only the tags, i.e.:

    $ git fetch origin "refs/tags/*:refs/tags/*"

which does not grab any branches.

You can of course do:

    $ git fetch --tags origin refs/heads/master:refs/remotes/origin/mas=
ter
