From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: Q: "git diff" using tag names
Date: Wed, 2 Nov 2011 13:29:45 +0400
Message-ID: <20111102132945.582707aa@ashu.dyn.rarus.ru>
References: <4EAABC15020000A100007D9D@gwsmtp1.uni-regensburg.de>
	<20111028165943.2cc8253d@ashu.dyn.rarus.ru>
	<4EB0FFCA020000A100007DE2@gwsmtp1.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Wed Nov 02 10:30:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLX8x-0007Cl-Nj
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 10:30:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755167Ab1KBJ3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 05:29:51 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65309 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755151Ab1KBJ3t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 05:29:49 -0400
Received: by faao14 with SMTP id o14so210888faa.19
        for <git@vger.kernel.org>; Wed, 02 Nov 2011 02:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=8ntLN9eOZjeUlbpSYg05sRwgkxuagKVNmgNStNLRl20=;
        b=w8hcWn2zQNZSyuiK9wh8+rpk9zkd9Q3S5YdQ/I43AZGL6c8VSHVPx7bmk5WK2R0VYB
         cOwMZ4UdoGdUAiiD4CUXq+YZbA89VNqXUhxi53fjrhzxGStKfFGzJuthk1SLnYWoibB5
         ZyEy6HBOK87pXF6+jrczWHaH43l/c+RzKQQ8M=
Received: by 10.223.5.66 with SMTP id 2mr7229255fau.26.1320226188090;
        Wed, 02 Nov 2011 02:29:48 -0700 (PDT)
Received: from ashu.dyn.rarus.ru ([85.21.218.130])
        by mx.google.com with ESMTPS id l26sm4314565fad.17.2011.11.02.02.29.47
        (version=SSLv3 cipher=OTHER);
        Wed, 02 Nov 2011 02:29:47 -0700 (PDT)
In-Reply-To: <4EB0FFCA020000A100007DE2@gwsmtp1.uni-regensburg.de>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184621>

> Hello Alexey,
> 
> thank you very much for your reply. I felt I did something wrong, but
> couldn't find out what it was. Actually it turned out that I had just
> mistyped one tag name.
> 
> Also it seems that both syntaxes work:
> git diff v0.4..v0.5
> git diff v0.4 v0.5
> 
> The question is: How does git disambiguate between tag names, commits
> and file names? (All may start with a letter) This seems to work
> automagically, and I was desparately looking for an option like "--"
> to separate revisions from file names. I found "SPECIFYING REVISIONS"
> in git-rev-parse(1), so you don't really have to answer.

Yes, you found right answer. "--" option separates file names from
"commits' names". but it usually necessary when you have branches or
tags named as some of your files.
E.g. you have file "test" and you name branch "test"
so "git log test" will complain that it cannot understand your
intention to see log of what and will fail

$ git log test
fatal: ambiguous argument 'test': both revision and filename
Use '--' to separate filenames from revisions

$ git log -- test
will show log of file test

$ git log test --
will show log of branch test


> Also it seems that both syntaxes work:
> git diff v0.4..v0.5
> git diff v0.4 v0.5
honestly, I do not know the difference (at the moment :))
may be gurus or manual will help to discover it
> 
> Regards,
> Ulrich
> 
> >>> Alexey Shumkin <Alex.Crezoff@gmail.com> schrieb am 28.10.2011 um
> >>> 14:59 in
> Nachricht <20111028165943.2cc8253d@ashu.dyn.rarus.ru>:
> > Tag is a pointer to a commit (if to say simply)
> > 
> > e.g. in my repo
> > $ git show-ref --tags --abbrev=7
> > -->8--
> > 676f194 refs/tags/v2.6.7
> > b23c481 refs/tags/v2.6.8
> > -->8--
> > 
> > so
> > 
> > $ git diff v2.6.7..v2.6.8
> > is equivalent to
> > $ git diff 676f194..b23c481
> > 
> > etc
> > > Hi,
> > > 
> > > when using a somewhat older git (of SLES11 SP1 SDK), I could not
> > > find a way to "git diff" between two tag names; I can only diff
> > > between two commit numbers. I can display a changeset using "git
> > > show", but that's not what I wanted. Is it possible to get the
> > > diff I want using older versions, and is such a feature
> > > implemented in the current version? If so, since when?
> > > 
> > > As I'm not subscribed to the list, I'd appreciate CC'ed replies.
> > > Thank you.
> > > 
> > > Greeting
> > > Ulrich
> > > 
> > > 
> > 
> > 
> 
>  
>  
> 
