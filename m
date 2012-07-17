From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Fix overwritten remote ref on with fast-import.
Date: Tue, 17 Jul 2012 16:02:12 -0500
Message-ID: <20120717210212.GB15624@burratino>
References: <1342013933-14381-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1948960.GdZ6fLVixa@flobuntu>
 <20120717134820.GE3071@burratino>
 <1571690.jxJy5HzrPO@flobuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 23:02:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrEuV-0008OA-Ix
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 23:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756678Ab2GQVCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 17:02:19 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:34053 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248Ab2GQVCS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 17:02:18 -0400
Received: by gglu4 with SMTP id u4so894080ggl.19
        for <git@vger.kernel.org>; Tue, 17 Jul 2012 14:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=nj/v+9fIHwygUWGRgA0x8TZ3yoO92zJ1UbvcQeCswtU=;
        b=E1zSHHxuOO/uJcNS2keb5jZphX7z2NSRhFpta0Jo9os1VE1yhSymp6ffa88U+uvfDq
         /5RhESRb7D7nf5rF6ILrNBIX+z4nyHW52xmkurd9uXjv8CCUYdNvqy60UHBsks0cL9u0
         eY5PcbmJOj46FjCkv7zbTm6mXOzR4UN5Q2nK1GbGbqWF0Lqr1aZdM22pjfJbvTV1gZxn
         9/lq+GVfJhZOuGgYmwh72RRPTqLmkzTg2A4cLp1iEhKoWDHGSdm2iR5tKhw0a+AgJEmw
         RPXbPDdzu15Kv3siffK1EgG7beFHfoXOq7CJFohw8l0whQTfMznIKaDjtlyrHWCfgZAe
         Y/dA==
Received: by 10.50.183.200 with SMTP id eo8mr63833igc.63.1342558937193;
        Tue, 17 Jul 2012 14:02:17 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id gl1sm26091627igc.1.2012.07.17.14.02.15
        (version=SSLv3 cipher=OTHER);
        Tue, 17 Jul 2012 14:02:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1571690.jxJy5HzrPO@flobuntu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201622>

Hi,

Florian Achleitner wrote:

> So we want the transport-helper to touch only private refs, i.e. some subdir 
> of refs/, ok.
> On the other hand I thought we expect git-fetch to update the RHS of the 
> passed refspec (or the default one ). How?

Now I am getting confused by terminology.  By "the transport-helper"
do you mean the remote helper (e.g., git-remote-svn) or
transport-helper.c?

By the "default" refspec do you mean the one specified in .git/config
or some default when none is specified there?  "git fetch" updates
refs according to the specified fetch refspec in
builtin/fetch.c::store_updated_refs().

> Btw, whats FETCH_HEAD for?

"grep FETCH_HEAD Documentation/*.txt" gives some hints.  Most notably:

	git-fetch(1)
	------------
	The ref names and their object names of fetched refs are stored
	in ".git/FETCH_HEAD".  This information is left for a later merge
	operation done by 'git merge'.

	gittutorial(7)
	--------------
	Alice can peek at what Bob did without merging first, using the "fetch"
	command; this allows Alice to inspect what Bob did, using a special
	symbol "FETCH_HEAD", in order to determine if he has anything worth
	pulling, like this:

	------------------------------------------------
	alice$ git fetch /home/bob/myrepo master
	alice$ git log -p HEAD..FETCH_HEAD
	------------------------------------------------

Hope that helps,
Jonathan
