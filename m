From: "Zakirov Salikh" <salikh@gmail.com>
Subject: Re: RCS keyword expansion
Date: Sat, 13 Oct 2007 08:52:24 +0900
Message-ID: <eb5812d90710121652g24b1177ao685c1ce4e0626c2d@mail.gmail.com>
References: <Pine.LNX.4.64.0710111542420.23849@ds9.cixit.se>
	 <86fy0hvgbh.fsf@blue.stonehenge.com>
	 <20071011155956.GC11693@cs-wsok.swansea.ac.uk>
	 <Pine.LNX.4.64.0710112144380.4174@racer.site>
	 <Pine.LNX.4.62.0710120723480.11771@perkele.intern.softwolves.pp.se>
	 <470FC64B.8010707@gmail.com>
	 <Pine.LNX.4.64.0710122341160.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Peter Karlsson" <peter@softwolves.pp.se>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 13 01:52:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgUJ3-0005c6-Oj
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 01:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757907AbXJLXw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 19:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757336AbXJLXwZ
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 19:52:25 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:10031 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757374AbXJLXwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 19:52:25 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1148162wah
        for <git@vger.kernel.org>; Fri, 12 Oct 2007 16:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=RAo1I4nsfEp8K34J7wE/knxGNavCi8xrM2zzDT5ynfo=;
        b=d/s2cxCJy7r/2DrWqOEfbxTgQpwN60BBXTQlxxEPHdeX6Yo+JEZhl4FkgiXpPyydn1huC6tsFHQ5GKidA0zj7vS5NBkO2XEKTfvMtu+lMKFySdY9HGDv95qC+aoBEKmGSoX0uBCjPw0DHfAeB7uO4OyiiUQ5X7jlDOfnqZHzJ4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kLgnk7sv6/6tY4i9PJXA1yNbsocmvxhOkGBQPiwHwMNKZd9Y3yAvn0mm3Wh1EGiMPo2MYIm9b3bOp5jgmtRJphSCY/SROsJo0xHu9O6Gm5jSaglardgql9WG+BitG34NKu0olvjZz6VzabWLuT3v+6xlc8/h3RRKeaLY38DsHhk=
Received: by 10.114.183.1 with SMTP id g1mr4114991waf.1192233144240;
        Fri, 12 Oct 2007 16:52:24 -0700 (PDT)
Received: by 10.114.74.14 with HTTP; Fri, 12 Oct 2007 16:52:24 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0710122341160.25221@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60710>

On 13/10/2007, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > * smudge filter is not passed a name of file being checked out,
> >   so it is not possible to exactly find the commit identifier.
> >   However, this is alleviated by the fact that 'smudge' is only being run
> >   for the changed files, so the last commit *is* the needed one.
>
> No.
> When changing branches, this is not the commit you think it is.

Exactly. When switching branches, or merging or fast-forwarding several commits,
the last commit may not be correct. The last commit is only correct
for the files
being updated by the fast-forward to exactly one commit.
Which seem to be pretty natural for the use case of checkout-only
web-published workspace.

> But maybe you humour me and tell me in which context such a smudge filter
> is of use.  I have yet to encounter an argument that convinces me.

Your comment prompted me to think about a narrower case of
fast-forwaring to one revision.
In that case, 'smudge' script can have commit identifier in
FETCH_HEAD, so the example
script from previous message with a little modification:

    $rev = `git-rev-parse FETCH_HEAD`

gives *exact* solution to the originally stated problem, though for
the specific case
when the web server directory is a checkout-only working directory,
which pulls changes
automatically from master server (as opposed to, e.g., pushing changes
to web server).
Even if the server pulls several revisions at once, it is likely that
they are done in a close succession (otherwise automated update would
have picked them separately), and
important part in web page timestamp is usually date.

Too bad I do not really have a web server and do not need to maintain
timestamps in web pages ... :) git scriptability always amazed me.
