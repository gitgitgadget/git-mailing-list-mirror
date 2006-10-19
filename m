From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "stage files" vs "cached files"
Date: Thu, 19 Oct 2006 08:58:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610190853180.3962@g5.osdl.org>
References: <eh7vl2$unr$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 19 18:00:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaaI4-0000ri-QJ
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 17:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946135AbWJSP6h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 11:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946138AbWJSP6h
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 11:58:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19625 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946135AbWJSP6g (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Oct 2006 11:58:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9JFwRaX011450
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 19 Oct 2006 08:58:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9JFwRO4014403;
	Thu, 19 Oct 2006 08:58:27 -0700
To: Jerome Lovy <t2a2e9z8ncbs9qg@brefemail.com>
In-Reply-To: <eh7vl2$unr$1@sea.gmane.org>
X-Spam-Status: No, hits=-0.472 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29361>



On Thu, 19 Oct 2006, Jerome Lovy wrote:
> 
> after having read tutorial1+2, I thought the following were more or less
> synonyms: index ~ directory cache ~ staging area
> 
> But then I discover that --cache and --staged are two different things,
> notably when using ls-files.
> 
> The documentation states indeed:
>  "--cached   Show cached files in the output"
>  "--stage    Show stage files in the output"

That is indeed confusing.

It shouldn't be "stage files". It should be "file stages".

The "stage" of a file is something that is meaningful on merges. Normally 
all files are in "stage 0", which means that it's fully merged. So when 
you do

	git ls-files --stage

you'll see a listing of all the files, with their file modes, SHA1's, 
"stage" and filename. And you'll basically always see "0" in the stage 
column.

But if you have had a merge that didn't resolve automatically, you can see 
the same filename listed up to three times, with stages 1, 2 and 3 (a zero 
will never be combined with any other stage - you'll only see a zero 
alone).

That just shows how that particular file came to be: a "stage 1" entry is 
the base branch version (the "common ancestor"), while stages 2 and 3 are 
the first and second branch respectively.

> I'm a bit confused. Is maybe a "stage file" entry missing in the glossary?

That term doesn't exist, so it shouldn't be in the glossary (or in any 
man-pages). But the "merge stage" _of_ a file is a real concept.

			Linus
