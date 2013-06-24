From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] status: really ignore config with --porcelain
Date: Mon, 24 Jun 2013 18:50:26 +0200
Message-ID: <vpq7ghjtpv1.fsf@anie.imag.fr>
References: <1372077912-18625-1-git-send-email-artagnon@gmail.com>
	<1372077912-18625-2-git-send-email-artagnon@gmail.com>
	<vpqhagnwraj.fsf@anie.imag.fr>
	<CALkWK0=F_i95S+53eZmOAJtA+jG=jvi5-sDc3BgW3rNQo=n3Ng@mail.gmail.com>
	<vpqhagnv9xq.fsf@anie.imag.fr>
	<7vk3ljbh5r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 18:50:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur9yR-0000FL-5f
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 18:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752267Ab3FXQuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 12:50:35 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45162 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964Ab3FXQue (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 12:50:34 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5OGoO1G032380
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 24 Jun 2013 18:50:24 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Ur9yE-0000mN-DR; Mon, 24 Jun 2013 18:50:26 +0200
In-Reply-To: <7vk3ljbh5r.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 24 Jun 2013 09:35:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 24 Jun 2013 18:50:24 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228869>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>>> Basically, having the CLI parser and the config parser flip two
>>> different sets of variables, so we can discriminate who set what.
>>> What annoys me is that this is the first instance of such a
>>> requirement.
>>
>> I don't think it's the first instance, but I can't remember precise
>> examples.
>
> "First read config, override with command line" is what we always
> do.  One recent workaround with selective exception I can think of
> offhand is in diff config parser 6c374008 (diff_opt: track whether
> flags have been set explicitly, 2013-05-10), but I am fairly sure
> there are others.

That was the one I had in mind.

>>> The approach I'm currently tilting towards is extending the
>>> parse-options API to allow parsing one special option early.  I would
>>> argue that this is a good feature that we should have asked for when
>>> we saw 6758af89e (Merge branch 'jn/git-cmd-h-bypass-setup',
>>> 2010-12-10).  What do you think?
>>
>> That's an option too, yes. But probably not easy to implement :-(.
>
> Isn't it essentially your second option (running the CLI parser
> before once, then read config, and then run the CLI parser for
> real)?

Not really. The first run should be a kind of dry-run, except for the
--porcelain part.

> In any case, I am still not convinced yet that status.short is a
> real problem if --porcelain readers trip with "## branchname"
> output.  Isn't it that the readers are broken and need fixing?

Before introducing status.short, scripts could call "git status
--porcelain" and get some output. They had no way to know whether
something would be added in the future. Now, they can run the same
command and get a different output. To me, that's exactly what we're
trying to avoid in plumbing.

The configuration file here is really meant for the user, not for
scripts. Scripts that want the branch information can use --branch.
Scripts that do not have absolutely nothing to gain in getting this
extra output (only extra parser complexity).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
