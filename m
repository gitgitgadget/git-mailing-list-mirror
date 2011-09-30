From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH]: reverse bisect v 2.0
Date: Fri, 30 Sep 2011 11:13:25 -0700
Message-ID: <7v62k9q4oq.fsf@alter.siamese.dyndns.org>
References: <20110929142027.GA4936@zelva.suse.cz>
 <20110930114220.GA742@zelva.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Michal Vyskocil <mvyskocil@suse.cz>
X-From: git-owner@vger.kernel.org Fri Sep 30 20:13:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9haY-0002QZ-5o
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 20:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756183Ab1I3SN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 14:13:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58162 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756018Ab1I3SN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 14:13:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3EAB597E;
	Fri, 30 Sep 2011 14:13:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vfXmk85UuaFGHDTB935XF6RrSD4=; b=eOUxK1
	hffO2IxoCzKASAe/LegA3odj4FiKL8sJdHWjKFMwd2XWjfWTs+M05MhnTZkGaD7x
	Pc6Bu8s0cPak8f4aVp5WY0NAz9dQ4tRAFuWS8PuQIFkaMhH1qQqNKap24PvoW/nA
	W/sjKqqebQB1IMSEFO1C+8CKYJDnAEkhG+8oU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oClszwd8yVqDJs5RTYnlueUNLdKMXyaE
	JJTnOx5neqcO+JHtiU9f9rRZ2bHiE2+TwPk8AaPKeR/j72jkfoJrJJ11qqxMadmj
	vdaGaZ6k5XP2Ao89p7Jkrfm0eohk0f50AYwJVcBVrW9gnNSBJ83qQbVLRAUWkLIV
	kFMJxeMVnPo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA64F597D;
	Fri, 30 Sep 2011 14:13:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4680A597C; Fri, 30 Sep 2011
 14:13:27 -0400 (EDT)
In-Reply-To: <20110930114220.GA742@zelva.suse.cz> (Michal Vyskocil's message
 of "Fri, 30 Sep 2011 13:42:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4D36462-EB8F-11E0-A125-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182496>

[administrivia: added people involved in the main discussion thread back
on CC line, and also added CCouder who seems to be fond of the command]

Michal Vyskocil <mvyskocil@suse.cz> writes:

> The bugfix command works like the previous git bisect start --reverse.

Does any released version of git have "bisect start --reverse"?

$ git bisect start --reverse
unrecognised option: '--reverse'

Let's suppose that we had a "git frotz" Porcelain subcommand, that used to
say "xyzzy" when all is well, but says "nitfol" these days. I released a
(bad) script that parses the output from the subcommand, and want to say
something like "This script only works with Git version after X", and to
find out the value of X, I need to bisect the history to find when "frotz"
started to say "nitfol".

I am not trying to find a commit that introduced a bug/regression to cause
the recent "frotz" to say "nitfol". Neither am I trying to find a fix that
corrected the earlier bogus output "xyzzy". No value judgement is involved
in this scenario.

I wonder if something along the following line would make the usage more
pleasant and self-explanatory:

    $ git bisect start --used-to='git frotz says xyzzy' v0.99 master
    Bisecting: 171 revisions left to test after this (roughly 8 steps)
    $ ... build and then test ...
    $ git bisect tested
    You are trying to check: git frotz says xyzzy
    Does the result satisify what you are trying to find [y/n]? yes

Saying 'yes' would be like saying 'good' and 'no' would be like saying
'bad' here.

When trying to find regression, you would say:

    $ git bisect start --used-to='it works' v0.99 master

and you say 'yes' if it works (equivalent to 'good'), and 'no' if it does
not (equivalent to 'bad').

When trying to find a fix, you would say:

    $ git bisect start --used-to='checkout $tree $path clobbers $path' v0.99 master

and you say 'yes' if it is still broken at the tested version (equivalent
to your reversed 'good'), and 'no' if the tested version contains a fix
(equivalent to your reversed 'bad').

I am not married to the name of the option, but --used-to='...' felt more
or less self-explanatory name to signal users what to describe in that
text. The condition "You are trying to check:" cue wants to remind the
user is "we used to do *this* but now we don't", and the command is trying
to see when it changed.

Thoughts?
