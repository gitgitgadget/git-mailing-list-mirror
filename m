From: John Keeping <john@keeping.me.uk>
Subject: Re: Unknown option for merge-recursive: -Xdiff-algorithm=minimal
Date: Tue, 24 Sep 2013 11:01:29 +0100
Message-ID: <20130924100129.GA27238@serenity.lan>
References: <E523B437-A9D4-40DD-9720-C419CB6AC016@integrate.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Luke Noel-Storr <luke.noel-storr@integrate.co.uk>
X-From: git-owner@vger.kernel.org Tue Sep 24 12:02:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOPRf-0002Gt-CX
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 12:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754262Ab3IXKCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 06:02:07 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:53002 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754242Ab3IXKCD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 06:02:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id E5076CDA66F;
	Tue, 24 Sep 2013 11:02:01 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2xs2P8mJ7qTb; Tue, 24 Sep 2013 11:01:58 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 6D40B866005;
	Tue, 24 Sep 2013 11:01:52 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <E523B437-A9D4-40DD-9720-C419CB6AC016@integrate.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235296>

On Tue, Sep 24, 2013 at 10:00:30AM +0100, Luke Noel-Storr wrote:
> I'm trying to use the diff-algorithm option for recursive merge, but
> get the above error.  I've tried various different ways of specifying
> the option, but none work.
> 
> To try and find what the correct syntax is I tried peeping into the
> source code, and it looks like it may actually be an error in the
> code.
> 
> This is from merge-recursive.c line 2072:
> 
> 	else if (!strcmp(s, "diff-algorithm=")) {
> 		long value = parse_algorithm_value(s+15);
> 		if (value < 0)
> 			return -1;
> 		/* clear out previous settings */
> 		DIFF_XDL_CLR(o, NEED_MINIMAL);
> 		o->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
> 		o->xdl_opts |= value;
> 	}
> 
> I believe !strcmp(s, "diff-algorithm=") should actually be !prefixcmp(s, "diff-algorithm=")
> 
> Could someone confirm this is a bug, and is there any other way I can specify the diff algorithm?

I think you're right - this should be prefixcmp.

The simplest thing to do would be to patch it locally and run your own
build - Git's Makefile installs in your home directory by default, so
providing $HOME/bin is on your path, "make install" will just give you
something that works.

Of course, you should then submit the patch here ;-)
