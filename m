From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: New Proposal (simple) for Metadata in Git Commits: git-meta
Date: Tue, 15 Dec 2009 14:05:29 -0800
Message-ID: <20091215220529.GD18319@spearce.org>
References: <93857A5A-744E-4A7C-B42D-23A56A48AAF7@lenary.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Elliott <sam@lenary.co.uk>
X-From: git-owner@vger.kernel.org Tue Dec 15 23:06:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKfXH-0004bF-1P
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 23:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761341AbZLOWFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 17:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761314AbZLOWFh
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 17:05:37 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:46111 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755618AbZLOWFe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 17:05:34 -0500
Received: by ywh12 with SMTP id 12so416825ywh.21
        for <git@vger.kernel.org>; Tue, 15 Dec 2009 14:05:33 -0800 (PST)
Received: by 10.150.47.16 with SMTP id u16mr422424ybu.149.1260914733314;
        Tue, 15 Dec 2009 14:05:33 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 5sm121767yxg.10.2009.12.15.14.05.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 15 Dec 2009 14:05:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <93857A5A-744E-4A7C-B42D-23A56A48AAF7@lenary.co.uk>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sam Elliott <sam@lenary.co.uk> wrote:
> I had this idea a day or so again, and have written a simple  
> implementation to storing some semi-structured data in a git commit  
> message. This means that it's much easier for data to be found and  
> scraped from a certain commit, for instance what issue numbers commits  
> refer to or close.

So from your web page, this is basically just YAML shoved into the
footer of the message:

--8<--
	Written half of the functionality. Namely the querying half.

	---git-meta---
	awesome: true
	Github:
	  user: lenary
	---git-meta---
-->8--


Why do we need the --git-meta-- delimiter lines?

JGit and Gerrit Code Review have already been following Git tradition
by using footer messages as metadata.  E.g. we have lines like:

--8<--
    init: Don't abort on empty directory
    
    The following sequence should work:
    
      mkdir testgit
      java -jar gerrit.war init -d testgit
    
    Since testgit is empty, it should be acceptable for us to populate the
    directory with our files.
    
    Bug: issue 358
    Change-Id: Ia85f31802066f8d39b042d3d057d33950a5035fd
    Signed-off-by: Shawn O. Pearce <sop@google.com>
-->8--

The JGit commit message parser has special logic to handle lines
that smell like one of these tag lines.  So long as there is no
blank line in the footer paragraph, each of these tags can be read
and processed.  Continuation lines should start with whitespace.

I don't remember my YAML well enough, but isn't this existing
standard still parseable by a YAML processor?

If you dropped the --git-meta-- tags above, JGit would happily
recognize the awesome: and Github: tags, but it might need a bit
more work to recognize the nested user: tag.  Also, you'd be able
to use git-meta on the git and Linux kernel repositories to pull
out and work with Signed-off-by, Acked-by, etc.

-- 
Shawn.
