From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a svnrdump-simulator replaying a dump file for
 testing.
Date: Mon, 23 Jul 2012 13:38:52 -0700
Message-ID: <7v8veakyar.fsf@alter.siamese.dyndns.org>
References: <7v4noyo6tc.fsf@alter.siamese.dyndns.org>
 <1343074107-23262-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, davidbarr@google.com,
	git@vger.kernel.org
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 22:39:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StPPA-0002ue-QI
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 22:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754726Ab2GWUiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 16:38:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44359 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754610Ab2GWUiy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 16:38:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 714BB75FA;
	Mon, 23 Jul 2012 16:38:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HQ0g+nRLOT7s9Hi2+vAOf2Hq8k0=; b=vipNmA
	xXtvO18d2VARbXONMTfSmJAliX/g0jEkxjPb3p0FUqnGT9YAUc7jlFpnHR+3yd0H
	VbkB9t/XCqyvwUVL/9ggrjE48ijtPp981bs1wA/wg8As5ffh0MfJdoRthd/zVxN4
	kEzYD1W7sn0BSK6vf0GahQReEVwmJ1B5lwSr0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iFxNiPocf4adQKZdxUJ5pn9xr3NKKvpu
	+OuIbrilO4O+H9q2MTZYYxyvr0ha9uokf8iu6+PQHOHFoW4+p5gcf44CVnY035xq
	r2f2j1ntcqD8HmZTJ5LPjM6LeHGvfxJ+TM8ChhoU3rScVu2b+Y81QeOQlqjpU78z
	rdzY+kDncYY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EA4F75F9;
	Mon, 23 Jul 2012 16:38:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC6E575F8; Mon, 23 Jul 2012
 16:38:53 -0400 (EDT)
In-Reply-To: <1343074107-23262-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 (Florian Achleitner's message of "Mon, 23 Jul 2012 22:08:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6AE66F8A-D506-11E1-820F-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201975>

Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:

> To ease testing without depending on a reachable svn server, this
> compact python script mimics parts of svnrdumps behaviour.
> It requires the remote url to start with sim://.
> Eventual slashes at the end of the url are stripped.

s/ventual/xcess/ perhaps?

> The url specifies the path of the svn dump file (as created by
> svnrdump). Selectable parts of it, or the whole file, are written
> to stdout. The part is selectable by giving start and end revision
> on the command line.
>
> Start and end revisions can be specified on the command line
> (-rSTART:END, like for svnrdump).
> Only revisions between START and excluding END are replayed from
> the dumpfile specified by the url. END can also be HEAD.
>
> If the start revision specified on the command line doesn't exist
> in the dump file, it returns 1.
> This emulates the behaviour of svnrdump when START>HEAD, i.e. the
> requested start revision doesn't exist on the server.

Much more understandable than before.

> To allow using the same dump file for simulating multiple
> incremental imports the highest visible revision can be limited by
> setting the environment variable SVNRMAX to that value. This
> effectively limits HEAD to simulate the situation where higher
> revs don't exist yet.

It is unclear how this is different from giving the ceiling by
specifying it as the "END" in -rSTART:END command line.  Is this
feature really needed?
