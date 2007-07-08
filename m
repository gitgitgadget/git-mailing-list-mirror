From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [Qgit RFC] commit --amend
Date: Sun, 8 Jul 2007 15:49:27 +0200
Message-ID: <e5bfff550707080649r493616cw4bbf3396e059698d@mail.gmail.com>
References: <20070610150839.GG4084@efreet.light.src>
	 <e5bfff550706101510x6d685944ja70c9d9dbb3668f6@mail.gmail.com>
	 <20070611044258.GJ4084@efreet.light.src>
	 <e5bfff550706102245p27aea579w65ee96161630a624@mail.gmail.com>
	 <20070705185426.GB3991@efreet.light.src>
	 <e5bfff550707060112p29b9565bw9ccba6601745b850@mail.gmail.com>
	 <20070708133825.GE3991@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Jul 08 15:49:43 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7X8w-0005U7-5e
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 15:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667AbXGHNt3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 09:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753487AbXGHNt3
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 09:49:29 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:57825 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624AbXGHNt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 09:49:28 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1026434wah
        for <git@vger.kernel.org>; Sun, 08 Jul 2007 06:49:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BMae4n778sXwXd5oFUq4SVckjp4V8mSEDcYwsyBALO3kK6a1lagrIYQugtfOcjR1m4n87s+Js7wx86xGN6jtjcqcj+QpbLvKY6Gl4x0T7E/e/bqJ862IZVyJYMiBypAxxZ53x7pK908RALQXWpipwJgiTfIyGt2b+/b6OmUO50g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q25z8NJ3s8q34VQkn+6w3CmBvyNP8VB1tvAHYg9iqrEVeZM0lJ+n9+xU1RRM1V3uTn9OXwIGnYBdcTird1pMdT3XG1u0g/1aRRSReS5XOWjTfz7OsR5rNzt+B7eWalz4taHk4zM646bew+AKIiPjXinHo8HDuA25c/MkrLzRR9w=
Received: by 10.114.110.1 with SMTP id i1mr2258318wac.1183902567525;
        Sun, 08 Jul 2007 06:49:27 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sun, 8 Jul 2007 06:49:27 -0700 (PDT)
In-Reply-To: <20070708133825.GE3991@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51883>

On 7/8/07, Jan Hudec <bulb@ucw.cz> wrote:
> On Fri, Jul 06, 2007 at 10:12:50 +0200, Marco Costalba wrote:
> > On 7/5/07, Jan Hudec <bulb@ucw.cz> wrote:
> >> Therefore I'll either have to always ask git via run("git-rev-parse HEAD",
> >> head), add HEAD into the map, or store HEAD somewhere in the Git object.
> >> Which do you think makes most sense?
> >
> > Asking git when you need it and keep HEAD value only for the minimum
> > time required to execute the commit command.
> >
> > - HEAD is very 'volatile'
> >
> > - commit is _not_ performance critical.
> >
> > - commit, being a write operation, is instead bugs/misbehaviour
> > critical (a big point to use an high level "git-commit" BTW)
> >
> > - asking git with getRefSha("HEAD", ANY_REF, true)  is very quick and
> > in any case much quicker then the whole commit dance.
>
> Yes. It is also much faster to write in code, but...
>
> > - someone can always change the repo behind you, qgit is not the only
> > interface to git ;-) does exist also the command line.
>
> And the commit in qgit should better fail loudly if that happens, because the
> list of files or something else might no longer make sense.
>
> There is actually just one thing I need the head for -- passing it as 3rd
> argument to git-update-ref. That should be done purely as safety measure --
> if the value does not match, the command will fail. And for that safety
> measure to be useful, I need value of the head at the time user openend the
> commit dialog, NOT the time user clicked on commit button.
>

It it has "commit dialog" life span I would suggets to save in a
"commit dialog" object member data.

Marco
