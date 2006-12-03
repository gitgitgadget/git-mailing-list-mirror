X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Submodules in GIT
Date: Sun, 3 Dec 2006 09:54:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612030946150.3476@woody.osdl.org>
References: <20061130170625.GH18810@admingilde.org> <457061A7.2000102@b-i-t.de>
  <Pine.LNX.4.64.0612011134080.3695@woody.osdl.org> 
 <200612012306.41410.Josef.Weidendorfer@gmx.de>  <Pine.LNX.4.64.0612011423100.3695@woody.osdl.org>
  <4570AF8F.1000801@stephan-feder.de>  <Pine.LNX.4.64.0612011505190.3695@woody.osdl.org>
  <4570BFA4.8070903@stephan-feder.de>  <e7bda7770612021057mc9f3eb9q7fc047dd1b5c235f@mail.gmail.com>
  <Pine.LNX.4.64.0612021114270.3476@woody.osdl.org>
 <e7bda7770612030119v197cbc95h6b3fa9e22b78c058@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 3 Dec 2006 17:56:55 +0000 (UTC)
Cc: sf-gmane@stephan-feder.de, sf <sf@b-i-t.de>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <e7bda7770612030119v197cbc95h6b3fa9e22b78c058@mail.gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33119>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gqva5-0005Q3-6g for gcvg-git@gmane.org; Sun, 03 Dec
 2006 18:56:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758281AbWLCR4i (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 12:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758277AbWLCR4i
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 12:56:38 -0500
Received: from smtp.osdl.org ([65.172.181.25]:4285 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1758275AbWLCR4i (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 12:56:38 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB3HsajQ024199
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sun, 3
 Dec 2006 09:54:37 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB3HsZH6024671; Sun, 3 Dec
 2006 09:54:36 -0800
To: Torgil Svensson <torgil.svensson@gmail.com>
Sender: git-owner@vger.kernel.org



On Sun, 3 Dec 2006, Torgil Svensson wrote:
>
> On 12/2/06, Linus Torvalds <torvalds@osdl.org> wrote:
> > 
> > In other words, I don't think people expect or want something hugely more
> > complicated than the CVS/modules kind of file.
> 
> What about the case when you want _everything_, do you then have to
> know the names of all submodules, present and past?

Afaik, the way people do this historically is simply:

 - often have an alias for "everything" (eg "all" or "src" or "world"), 
   and if you want everything, you basically ask for it by checking out 
   the "src" module.

   Ie this is the "upstream" way to let downstream check out everything.

 - if you're downstream, and you have a partial repo, and you realize that 
   you want everything else, you just look at gitweb (assuming it is 
   extended to show module information, of course ;) or the .gitmodules 
   (or whatever it would be called) file to get the other pieces manually.

But hey, I also think it would be fine to have "git clone --allmodules" or 
something ("fetch" too). I think this whole question will depend more on 
how people end up _using_ module support than on any technical issues per 
se. Again, I suspect the people who now set up modules in CVS are likely 
to have a better idea than I do about how they usually do it (and why).

> If you have an old irrelevant submodule in the history that happens to
> have the same name as one of them you are interested in, do you get
> this as well?

I dunno. Details, details. I'm also not sure this is hugely important.

It could be "solved" by simply having the requirement that all modules 
need to be named differently (notice that "module name" is _not_ the same 
thing as "the directory name where the module shows up". That's not the 
case even in CVS modules, and with a "link" type in the git tree object, 
the directory where a module shows up would basically be totally 
independent of the "name" of the module).

> During a debugging session it might be convenient to do a "all but X"
> kind of fetch if you have a project dependent on several small modules
> and one of them is the big black sheep.

I suspect it's more common to name the modules you want to fetch 
explicitly, rather than make it a "negative" choice, but that sounds 
largely like just an interface issue.

