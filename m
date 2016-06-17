Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.3 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B016D20179
	for <e@80x24.org>; Fri, 17 Jun 2016 13:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755554AbcFQNNW (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 09:13:22 -0400
Received: from kitenet.net ([66.228.36.95]:43902 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752668AbcFQNNV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 09:13:21 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=V+Nl7hym;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1466169191; bh=jG7vtfYjb2hrL1yLdK9gK9e/7AkQHSfBj1jUeluyfic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V+Nl7hymIWFVxWfq3CNhdjAAcx3GU8d057xnSYMzntx/NzzjdPnIdq12ZFCzxQrR0
	 Psawhe6hFtN6FwnwWy+jPBfZZVjhL+0wrE8Yi5J+1px5WheEF+5iYebOfgrq2eQs+K
	 921oz6ryvTzJ6TzWyjATrx0ajDMnds4YhpIIS2Mo=
Date:	Fri, 17 Jun 2016 09:13:11 -0400
From:	Joey Hess <id@joeyh.name>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 2/4] add smudge-to-file and clean-from-file filter
 configuration
Message-ID: <20160617131311.GC24025@kitenet.net>
References: <20160616203259.5886-1-joeyh@joeyh.name>
 <20160616203259.5886-3-joeyh@joeyh.name>
 <xmqqy4643ig1.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy4643ig1.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano wrote:
> There is what we would want to fix, though.  "worktree file" should
> be spelled "working tree file". This used not to matter before "git
> worktree" was invented (before that we used these two terms
> interchangeably), but these days the distinction matters.

The existing documentation that I am patching uses the term "worktree
file" which is why I continued to use that wording.

(Unless this is a documentation transition that you want to happen
peicemeal as documentation is updated for other reasons?)

> > +filter.<driver>.clean-from-file::
> 
> Documentation/config.txt hopefully lists all the configuration, but
> I do not see anything that uses 'words-joined-with-dash' format.
> Please do not invent new out-of-convention names.

Point taken; I'll use cleanFromFile and smudgeToFile.

Here's a revised version of the documentation that I think takes the other
suggestions onboard. I emphasise that clean and smudge operate as filters,
to contrast better with cleanFromFile and smudgeToFile not operating as
regular stdio filters.

 filter.<driver>.clean::
-       The command which is used to convert the content of a worktree
+       The command which is used as a filter to convert the content of a worktree
        file to a blob upon checkin.  See linkgit:gitattributes[5] for
        details.
 
 filter.<driver>.smudge::
-       The command which is used to convert the content of a blob
+       The command which is used as a filter to convert the content of a blob
        object to a worktree file upon checkout.  See
        linkgit:gitattributes[5] for details.
 
+filter.<driver>.cleanFromFile::
+       Similar to filter.<driver>.clean but the specified command 
+       directly accesses a worktree file on disk, rather than
+       receiving the file content from standard input. 
+       In the command, "%p" is replaced with the name of the file. 
+       Only used when filter.<driver>.clean is also configured.
+       See linkgit:gitattributes[5] for details.
+
+filter.<driver>.smudgeToFile::
+       Similar to filter.<driver>.smudge but the specified command
+       writes the content of a blob directly to a worktree file,
+       rather than to standard output.
+       In the command, "%p" is replaced with the name of the file.
+       Only used when filter.<driver>.smudge is also configured.
+       See linkgit:gitattributes[5] for details.
+

This could be extended more, but I think this should describe the config
settings concisely and point to the more involved discussion of filter drivers
in gitattributes.

-- 
see shy jo
