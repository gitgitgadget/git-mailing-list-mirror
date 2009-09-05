From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [BUG] 'add -u' doesn't work from untracked subdir
Date: Sat, 5 Sep 2009 10:46:41 +0200
Message-ID: <20090905084641.GA24865@darc.dnsalias.org>
References: <20090902080305.GA11549@neumann> <20090902081917.GA5447@coredump.intra.peff.net> <20090904070216.GA3996@darc.dnsalias.org> <20090905061804.GB29863@coredump.intra.peff.net> <7v8wgt98ms.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 10:48:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjqwE-00018e-1G
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 10:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757208AbZIEIqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 04:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757203AbZIEIqr
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 04:46:47 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:47538 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757118AbZIEIqq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 04:46:46 -0400
Received: by fg-out-1718.google.com with SMTP id 22so1267344fge.1
        for <git@vger.kernel.org>; Sat, 05 Sep 2009 01:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:bcc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=cTihTmsk/jnSrPezyLwn+1MSdIocNMjKdQUMri9mcUc=;
        b=R1UZ6EC6h/VBpuH80DSxp3cc0h8vql+qYdIxwlQ1EWL9V8D9ROvPMwMC4kSXNjx4PX
         MrMZcymQIEjPyf2zCogr2s5exuHq+anCDMQJuKRcx+5aVrfZ+bIcKELcqe4+o8v0PJI8
         pxSvo95AyUKDHKF8EZBEF3QQkvEmVJ/3fpujY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=XZB8jKl9UkTXrk/aNlhW5wvc95+wWaR1Qn/wZ94COKLe3JnG/p9rLgymcED29Axs1O
         SjUBErwa0pQzIYbfTSskPc3aFxQEm4CkVUgSuuoLMbirMGj2+D5e8rtB4Ls1b9Wfl8Tg
         A2nBmOkCQpFVJf1m68JBNTLZrgI3/a0Y7HWEA=
Received: by 10.86.214.34 with SMTP id m34mr5905770fgg.6.1252140408313;
        Sat, 05 Sep 2009 01:46:48 -0700 (PDT)
Received: from darc.lan (p549A56FA.dip.t-dialin.net [84.154.86.250])
        by mx.google.com with ESMTPS id 4sm4301671fge.9.2009.09.05.01.46.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Sep 2009 01:46:46 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1Mjquv-0006tK-B6; Sat, 05 Sep 2009 10:46:41 +0200
Content-Disposition: inline
In-Reply-To: <7v8wgt98ms.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127797>

On Sat, Sep 05, 2009 at 12:02:35AM -0700, Junio C Hamano wrote:

> I personally find "add -u" that defaults to the current directory more
> natural than always going to the root; same preference for "grep".
> Besides, "add -u subdir" must add subdir relative to the cwd, without
> going to the root.  Why should "add -u" sans argument behave drastically
> differently?

Sorry for stating the obvious here, but the following commands affect the
entire repository, even though they limit themselves to the current
directory, if passed a '.'.

	git commit
	git log
	git diff
	git checkout
	git reset

Due to the frequent use of these commands, I believe many users (myself
included) expect "git add" and "git grep" to do the same. AFAICT the
following commands are the only non-plumbing ones that behave differently:

	git add -u
	git add -A
	git grep

So I argue that _that_ is the real inconsistency.

> If "git add -u ../.." (I mean "the grand parent directory", not "an
> unnamed subdirectory") did not work, it would be unexcusable and we would
> want to devise an migration path, but otherwise I do not think it is such
> a big deal.

> I would say the commands that are used to incrementally build
> towards the next commit should be friendly to the practice of limiting the
> scope of the work by chdir.

"git add -u ." is friendly enough. Just like "git commit ." versus "git
commit -a", which is exactly the same concept and should therefore have the
same behavior.

You are assuming that people are in a subdirectory because they want to
limit the scope. But I am usually in a subdirectory for totally
versioning-unrelated reasons. Like running tests in git.git:t/ . I
mistakenly use "git add -u" in there all the time, because I think I don't
have to worry about which directory I'm in. Except in this instance I do.

In any case, I think it is better to have consistent behavior than to try
and read users' minds with defaults.

Clemens
