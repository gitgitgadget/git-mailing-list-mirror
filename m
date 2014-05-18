From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Sun, 18 May 2014 16:13:31 -0700
Message-ID: <xmqq1tvq4r43.fsf@gitster.dls.corp.google.com>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
	<20140516084126.GB21468@sigill.intra.peff.net>
	<xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>
	<20140516225228.GA3988@sigill.intra.peff.net>
	<5376f2ca5c90d_65b915db2f877@nysa.notmuch>
	<20140517062413.GA13003@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 19 01:14:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmAHZ-0003xF-PQ
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 01:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221AbaERXOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 19:14:11 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65114 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752100AbaERXOK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 19:14:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 301E11905B;
	Sun, 18 May 2014 19:14:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=PWWAaoUrKltqYws/Fca3pQ8QpCY=; b=LPDCpW3o3dZ9DhhWF8U5
	5Y2agMrn5B99pmY20rmlAAWvDo2ifP2HmYDIul0rEIotB3mexrp6JhBx/iIJOHAH
	pKoyAYTlN7DbfwVoau437JmxhlCzsxd0WZFygk2XgaAF6W7lPGo37d2MhGdF/SlV
	rsJoRD7hkosKKgp7YFMuFLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=M+sd6wFMiv/dEnyfrgoxeOl1bQz0R6Wjklg4e9BAklMSye
	OCdweGvd9pbBRM8evcmOnYNOLBMQCKlpffEf82vs3Jf9zptFDJwqU79AzWw4yTTW
	oupIyzH72QvRDcqgA0A9yt7leCGH63biY12YJ7m5DqG0+7oTCdkW+s7wmyuLQ=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 25F461905A;
	Sun, 18 May 2014 19:14:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 046FE19058;
	Sun, 18 May 2014 19:14:05 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1BB7F856-DEE2-11E3-A0AC-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249550>

Jeff King <peff@peff.net> writes:

> My concerns were with people not noticing the README. Removing the code
> entirely is the way I thought of to address that. Junio suggested
> another way, which I would also be fine with. And it seems like a
> friendlier way than removal to handle it for v2.0, if we are going to
> remove the code entirely post-v2.0.
>
> As before, if your desire is to have the code out for v2.0, then say so.
> I think we should respect such a request.

OK.  After thinking about it a bit more, I think renaming the
directory at this point is not a "clearly superiour" option and the
judgment largely depends on your philosophy on transition.  Let me
explain, backwards from the desired endgame.

I think all of us (including Felipe) agree that in some future time
[*1*], we won't have either of these two scripts in contrib/, but
just like contrib/vim, we will leave a README to help those who read
a stale page on the Web that says "remote-hg in contrib/ is the
officially recommended tool to interact with Mercurial".  The README
will tell them that they read a stale page that is no longer true,
and direct them to where they can grab remote-hg/bzr.

We will need to keep contrib/remote-helpers in that endgame state
for quite some time.

If a user of 1.9.x updates to such an endgame version and then runs
the same fetch from Hg, he will not just notice the breakage but is
forced at that point to go to the GitHub URL and switch, but it may
not be a convenient time for him to go through that process.  To
help these users, a step that ships the "stale but working" scripts
that give warning is necessary before the endgame state, and
Felipe's 77621193 (contrib: remote-helpers: add move warnings
(v2.0), 2014-05-13) is such a change.

My suggestion to rename the directory without smudging the scripts
was meant to be a step that can come before that step, and I think
its necessity is debatable.  It depends on how gradual a transition
you want to give, and being always the more cautious type, I think
having such a step will give packagers who pay attention to what
they package and users who pay attention to what they install
without packaging an early chance to notice and prepare.

 - The endgame will force the user to update at the point when the
   user needs to use it for his real work, when he may not have time
   for sysadmin. 

 - The "always warn" does not force update at the point of use, but
   it still does not help them to notice well before they try to use
   it for the first time after update;

 - "Break the build" attempts to help them notice when they try to
   update, not when they need to use the updated one right at this
   moment.

But I am fine with an expedited transition schedule without the
"break the build" step.  That was an optional first step, because
"warn but still work" state we must have before the endgame will
give the users the choice of when to adjust anyway.

I also thought about adding an extra step to have even more gradual
transition, by the way.  A step before the endgame will ship these
scripts without anything but "instruct and fail" (this is not "warn
and fail", as it is too late "warn", as the scripts are crippled not
to work at this point).

That will still force the user to update at the point when the user
needs to use it, but seeing the instruction (e.g. "run this curl
command to fetch from this URL and store it in a file called
git-remote-xx on your $PATH") that is easy to follow immediately
would be better than seeing only a failure (i.e. "remote-hg not
found"), having to go fish the README, visiting the GitHub pages
and figuring out how to fetch and install the script, which would
be what the user will get with "README only, no scripts" endgame.

For that matter, the warning message given by 77621193, also README
added by f000c4e6 (remote-helpers: point at their upstream
repositories, 2014-05-15) may want to mention not just the GitHub
URL for the repository as the whole, but the URL to fetch the latest
blob with curl/wget, if we really want to help users go back to
their tasks at hand with minimum interruption.  I know how to
construct a URL to follow the tip of a specific branch and obtain a
full .zip from a GitHub repository, but I do not know offhand if you
can do the same for a single blob.  If we can come up with one, we
should add such a instruction to the warning message and README, as
that instruction will be the only thing to help the users in the
endgame state anyway.

So to summarize, the following timeline is a full possibility:

  1. (optional) break the build by renaming directory and add
     README. Include not just the repository URL but a blob URL
     and instruction to download via wget/curl.

  2. add warning that is given every time the scripts are run and
     give the same instruction as in README.

  3. (optional) cripple the script to make them always fail after
     showing the same warning as above.

  4. Keep README and retire everything else.

but I am perfectly fine with dropping these two optional steps and
follow an expedited transition of doing 2 and 4.


[Footnotes]

*1* Largely of Felipe's choice, and we also agree that that future
    time is not 2.0, as Felipe says he does not want to disrupt the
    upcoming release, and neither do we.
