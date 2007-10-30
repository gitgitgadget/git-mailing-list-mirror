From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: remote#branch
Date: Tue, 30 Oct 2007 07:59:45 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710300738550.30120@woody.linux-foundation.org>
References: <20071027204757.GA3058@efreet.light.src>
 <Pine.LNX.4.64.0710280000240.4362@racer.site> <20071029174000.GA4449@efreet.light.src>
 <alpine.LFD.0.999.0710291112590.30120@woody.linux-foundation.org>
 <20071029214925.GH21133@thunk.org> <alpine.LFD.0.999.0710291545250.30120@woody.linux-foundation.org>
 <20071030030104.GK21133@thunk.org> <7vtzo9s221.fsf@gitster.siamese.dyndns.org>
 <20071030044026.GA9600@thunk.org> <alpine.LFD.0.999.0710292150400.30120@woody.linux-foundation.org>
 <20071030053732.GA16963@hermes.priv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: Tom Prince <tom.prince@ualberta.net>
X-From: git-owner@vger.kernel.org Tue Oct 30 16:01:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imsb3-0008FP-Bv
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 16:01:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbXJ3PAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 11:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753056AbXJ3PAu
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 11:00:50 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53609 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752481AbXJ3PAt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Oct 2007 11:00:49 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9UExlrh016077
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Oct 2007 07:59:48 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9UExkH6012878;
	Tue, 30 Oct 2007 07:59:46 -0700
In-Reply-To: <20071030053732.GA16963@hermes.priv>
X-Spam-Status: No, hits=-2.135 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_12,J_CHICKENPOX_66
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 30 Oct 2007, Tom Prince wrote:
> > The push url is generally written as
> > 
> > 	repo.or.cz:/srv/git/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git
> > 
> > Tough.
> 
> But gitweb (on git.kernel.org and repo.or.cz) both give git:// locators.

Yes, for anonymous pulling.

The thing is, git takes something much more extended than a "RFC url".

We use pathnames. Not a "quoted mess". Regular, bog-standard, normal unix 
pathnames.

On Windows, I assume (and hope) that git uses the native-style Windows 
pathnames, and you can do "git pull d:\system\ugh" if you want to.

And I think we should care a whole lot about interacting with the *user* 
and actual programs that git shares code with, than interacting with some 
idiotic RFC that has absolutely zero to do with us, regardless of whether 
we use the name "url" or not.

For example, the reason we use "host:/path" for pushing over ssh (and 
pulling, for that matter), is that that's the same syntax that scp uses. 
It's a natural fit. And I hope to God nobody seriously argues that we 
shouldn't use regular pathnames on the local disk? 

> > Quick! WHO THE F*CK CARES?

[ Btw, sorry for the french. I blame being tired and ina bad mood, but I 
  also blame the fact that I absolutely *detest* arguments based on 
  standards. If you cannot back it up with a real usage scenario, you 
  shouldn't even mention the standard ]

> So, how should git deal with
> 
> git://repo.or.cz/linux-2.6/linux acpi-2.6/ibm-acpi-2.6.git
> git://repo.or.cz/linux-2.6/linux+acpi-2.6/ibm-acpi-2.6.git
> git://repo.or.cz/linux-2.6/linux%20acpi-2.6/ibm-acpi-2.6.git

The way it has always cared. Git itself does no quoting what-so-ever 
(except for the *argument* quoting etc that it needs).

Now, the *transport* back-end may end up quoting it, of course, the same 
way it may end up using some random protocol. The user shouldn't care 
about the implementation details!

In the case of the git transport, there is no quoting even by the 
transport protocol. In the case of http, libcurl would hopefully quote for 
us.

> compared to 
> 
> http://repo.or.cz/linux-2.6/linux acpi-2.6/ibm-acpi-2.6.git
> http://repo.or.cz/linux-2.6/linux+acpi-2.6/ibm-acpi-2.6.git
> http://repo.or.cz/linux-2.6/linux%20acpi-2.6/ibm-acpi-2.6.git

No difference, what-so-ever, that I can see. Git doesn't quote it.

Notice how the fact that we use http:// doesn't actually mean that you can 
feed the result to a web browser anyway? It's not like you get a "link" 
that git follows. You get a name.

Yes, you can try to "co-locate" things so that something smart 
disambiguates (maybe have an "index.html" file, so a web browser gets a 
gitweb page, and git gets the raw data). But even then, notice how even 
web browser will do the quoting for you: try

	firefox "http://www.google.com/search?q=Html spaces"

just for fun.

Notice? The thing is, "strict RFC following" makes no sense:

 - the git syntax is (and HAS TO BE to be user friendly) a real extension 
   on any "strict RFC URL" anyway, since it is a lot more important to 
   interact well with normal unix tools (ie use regular filenames, and use 
   the same syntax as "cp", "mv" and "find" etc uses!)

   Ergo: we cannot and MUST NOT care about the "URL RFC" too deeply 
   anyway.

 - 

> Not that I care, but git should probably handle things consistently.

Git has been, and *is* entirely consistent. It uses convenient repo names. 
If you don't want to call them url's, then call them "repository name". 
Call them whatever. But they are 100% obvious, even if there are multiple 
forms of them (and *none* of the forms do any quoting at all):

 - <remote shorthand> ("origin")
 - <path> ("../git.git")
 - <host>:<path> ("master.kernel.org:/pub/scm/...")
 - <protocol>://<host>/<path> ("git://repo.or.cz/...")

See? We may not follow RFC's, but we follow "easy to use".

And btw, that's really much much MUCH more important. It's why the git 
config file is in a "ini"-like format. It's readable. It's not the insane 
RFC crap that would result if somebody had decided that standards are more 
important than being sane.

			Linus
