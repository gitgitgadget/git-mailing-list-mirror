From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Diff format in packs
Date: Mon, 31 Jul 2006 19:08:12 -0400
Message-ID: <9e4733910607311608v4938c940pe922257c13a149d2@mail.gmail.com>
References: <9e4733910607311408i10e17dse776920de7c5076a@mail.gmail.com>
	 <ealruh$sq9$1@sea.gmane.org>
	 <9e4733910607311420n8537b76lbde4d60062195403@mail.gmail.com>
	 <20060731223221.GB24888@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 01 01:08:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7gry-00088j-LK
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 01:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWGaXIP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 19:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWGaXIP
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 19:08:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:35886 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751155AbWGaXIO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 19:08:14 -0400
Received: by nf-out-0910.google.com with SMTP id o25so58492nfa
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 16:08:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JQL6p5B53GYSc115SEpC7wb1UQuvRx9kDucLPTWIZoM5aZ4JGLOoAIAd9ABySMakhk9ebqf43ccrOGfZqxrRY8h2n5p23vwyT4zgsFFtiWk6DUT3Er/iNOjlpJ3ilZNY0jfftsuhBxnV9S0Ek5PdQ85/4/xZZLzYhjsjXHHBb3o=
Received: by 10.78.177.3 with SMTP id z3mr59010hue;
        Mon, 31 Jul 2006 16:08:12 -0700 (PDT)
Received: by 10.78.149.8 with HTTP; Mon, 31 Jul 2006 16:08:12 -0700 (PDT)
To: "Shawn Pearce" <spearce@spearce.org>
In-Reply-To: <20060731223221.GB24888@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24555>

On 7/31/06, Shawn Pearce <spearce@spearce.org> wrote:
> It should be reasonably simple to extract each revision from a
> single ,v file into its full undeltafied form, compute its SHA1,
> compress it with zlib, and append it into a pack file.  Do that
> for every file and toss the SHA1 values, file names and revision
> numbers off into a table somewhere.

cvs2svn has put everything needed into a nice db4 database that I can
generate the trees from once I get the revisions into git. I'll modify
cvs2svn to record the SHA1 for the deltas when they are originally
scanned. The change set algorithm used by cvs2svn is the only one of
the bunch that can process moz cvs without errors or losing check-ins.
It takes 3.5hrs to generate the changeset db. There are over 1M deltas
to sort and 250K commits.

> So I think I'm suggesting you find a way to generate the base objects
> yourself right into a pack file, rather than using the higher level
> GIT executables to do it.  You may be able to reuse some of the
> code in GIT but I know its writer code is organized for writing
> loose objects, not for appending new objects into a new pack file,
> so some surgery would probably be required.

This makes sense, just put the objects into the pack and forget about
deltas for now. I can add deltas in the next rewrite or just use
git-repack. Since cvs2svn is in Python I need to figure out how to
write a pack file from that environment. At least Python has sha1 and
zlib support built-in.

What is more important is that I get a working incremental update
functioning. I'm hoping that I can rely on cvsps for that. Cutting
everyone over at once is unlikely to happen.

-- 
Jon Smirl
jonsmirl@gmail.com
