From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Fri, 08 Feb 2008 12:25:02 -0800
Message-ID: <1202502302.12966.32.camel@brick>
References: <200802081828.43849.kendy@suse.cz>
	 <m3ejbngtnn.fsf@localhost.localdomain>
	 <9e4733910802081126r5bf19c95rec817a1b6648ee4d@mail.gmail.com>
	 <1202502007.12966.30.camel@brick>
	 <9e4733910802081224k28310b0cj171453c96802ec7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Jan Holesovsky <kendy@suse.cz>,
	git@vger.kernel.org, gitster@pobox.com
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 21:25:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNZnB-0008P4-UL
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 21:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762181AbYBHUZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 15:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755210AbYBHUZM
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 15:25:12 -0500
Received: from rv-out-0910.google.com ([209.85.198.189]:51013 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761627AbYBHUZK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 15:25:10 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2644385rvb.1
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 12:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=sqZF/aFON6WpWr2UX2Ab6I/ahlcDDMyLVnOaIOVm9eY=;
        b=L1vmsG5ai8A2u9Dws6ZiSs2fA2JU4gIBeT+1RkGNJf/5BL+RcgXY2cjxPFQ8HZ+zeEZVhn2fmfOzR73QxUe5VLeF/pgLvoARXn8ZQZT7q7+zRWiA3RjKUflw4YwspHzzon1h1sPtvUexRmyt7wSfcyFeUOzs0SlRNS8zAXRDz4c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=T7JYVSyeyvCU/9d2/h74yFdfk+fGv1H4JIPhgXWnZKWLqXb7rkT+FA6Ucdei0aN1Wjd5Ih6F1onyrAIQFIRNd5RKdiYbjS/uK74QKHSMhGwd0826moaziYJnd2vS3TqPqm4Un1W8n9MTuL6Zws4Zqa/78gJbuCeayKdL6E3G9aA=
Received: by 10.141.141.3 with SMTP id t3mr3519202rvn.226.1202502309474;
        Fri, 08 Feb 2008 12:25:09 -0800 (PST)
Received: from ?128.189.248.121? ( [128.189.248.121])
        by mx.google.com with ESMTPS id f36sm12351758rvb.4.2008.02.08.12.25.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Feb 2008 12:25:09 -0800 (PST)
In-Reply-To: <9e4733910802081224k28310b0cj171453c96802ec7f@mail.gmail.com>
X-Mailer: Evolution 2.12.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73135>

On Fri, 2008-02-08 at 15:24 -0500, Jon Smirl wrote:
> On 2/8/08, Harvey Harrison <harvey.harrison@gmail.com> wrote:
> > On Fri, 2008-02-08 at 14:26 -0500, Jon Smirl wrote:
> > > On 2/8/08, Jakub Narebski <jnareb@gmail.com> wrote:
> > > > Jan Holesovsky <kendy@suse.cz> writes:
> > > > One of the reasons why 'lazy clone' was not implemented was the fact
> > > > that by using large enough window, and larger than default delta
> > > > length you can repack "archive pack" (and keep it from trying to
> > > > repack using .keep files, see git-config(1)) much tighter than with
> > > > default (time and CPU conserving) options, and much, much tighter than
> > > > pack which is result of fast-import driven import.
> > > >
> > > > Both Mozilla import, and GCC import were packed below 0.5 GB. Warning:
> > > > you would need machine with large amount of memory to repack it
> > > > tightly in sensible time!
> > >
> > > A lot of memory is 2-4GB. Without this much memory you will trigger
> > > swapping and the pack process will finish in about a month.
> >
> > Well, my modest little Celeron M laptop w/ 1GB of ram did the full
> > repack overnight on the gcc repo, so a month is a bit of an
> > exaggeration.
> 
> Try it again with window=250 and depth=250. That's how you get the
> really small packs.
> 

Yes, I know, and I did if you remember back to the gcc discussion.

Harvey
