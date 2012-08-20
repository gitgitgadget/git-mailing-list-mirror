From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [RFC 1/5] GSOC: prepare svndump for branch detection
Date: Sun, 19 Aug 2012 23:26:04 -0700 (PDT)
Message-ID: <5679616.CtEd2rlvlO@flomedio>
References: <1345236010-1648-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <CACPE+fvkTNNHXbFTwhoH7=aQKoc9YqtfTBOkJDugUogni0sYww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: David Michael Barr <b@rr-dav.id.au>
X-From: git-owner@vger.kernel.org Mon Aug 20 08:26:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3LRG-00052r-2I
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 08:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367Ab2HTG0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 02:26:08 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:38308 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542Ab2HTG0H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 02:26:07 -0400
Received: by weyx8 with SMTP id x8so3691436wey.19
        for <git@vger.kernel.org>; Sun, 19 Aug 2012 23:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=1+i5Z8w24jscD/1vKyiMUIgnzmumwJSsCXuIAGnu9wU=;
        b=eOklyoRLKf/YxfYwF2HBVIWrIlCUZLQ9xRU+7cBqZf+HaUMBjb8W0VqYNQFXp/eFVy
         iacPJthL2IsSH8WuXLkDvNHEnMxtgVa8L/49oUWeKJ8ydv8vHsFWyLI1a0bdnQZ2WkhL
         gziCwYbQiSMyxMvvfeNmj6mwXF90uwL1GIPkywom3/8EKeyevMM5IEzBPBtxdEeF+uE1
         Q9EbSmjnxeiQGaitWKRqJf0nph9ofdjoqIa1bdIWbsUbR37hitxiIwXP2wcDrP0jmbg1
         V2Qb8fzcAcPUCo5ZkZpa6t23xTa0iTqWtKfqAxFG7id/9kpMUjGam2HNI+qnqdIugY6/
         moPg==
Received: by 10.216.144.234 with SMTP id n84mr1361561wej.78.1345443965053;
        Sun, 19 Aug 2012 23:26:05 -0700 (PDT)
Received: from flomedio.localnet (089144206224.atnat0015.highway.a1.net. [89.144.206.224])
        by mx.google.com with ESMTPS id z11sm39232922wiv.10.2012.08.19.23.26.02
        (version=SSLv3 cipher=OTHER);
        Sun, 19 Aug 2012 23:26:04 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.0.0-24-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <CACPE+fvkTNNHXbFTwhoH7=aQKoc9YqtfTBOkJDugUogni0sYww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203759>

On Sunday 19 August 2012 04:37:35 David Michael Barr wrote:
> On Sat, Aug 18, 2012 at 6:40 AM, Florian Achleitner
> 
> <florian.achleitner.2.6.31@gmail.com> wrote:
> > Hi!
> > 
> > This patch series should prepare vcs-svn/svndump.* for branch
> > detection. When starting with this feature I found that the existing
> > functions are not yet appropriate for that.
> > These rewrites the node handling part of svndump.c, it is very
> > invasive. The logic in handle_node is not simple, I hope that I
> > understood every case the existing code tries to adress.
> > At least it doesn't break an existing testcase.
> > 
> > The series applies on top of:
> > [PATCH/RFC v4 16/16] Add a test script for remote-svn.
> > I could also rebase it onto master if you think it makes sense.
> > 
> > Florian
> > 
> >  [RFC 1/5] vcs-svn: Add sha1 calculaton to fast_export and
> 
> This change makes me uncomfortable.
> We are doubling up on hashing with fast-import.
> This introduces git-specific logic into vcs-svn.

You might need to read the rest of the series to see why I did this.
Short version: For fast-import, I seperated sending data from the commits, it 
is sent using the 'blob' command.
You have two choices of referencing that blobs later, by using a mark, or by 
giving their sha1. Marks are already used for marking commits, and there is 
only one "mark namespace". So I couldn't use marks to reference the blobs in  
a nice way. This allows for referencing them by their sha1.

> 
> >  [RFC 2/5] svndump: move struct definitions to .h.
> >  [RFC 3/5] vcs-svn/svndump: restructure node_ctx, rev_ctx handling
> >  [RFC 4/5] vcs-svn/svndump: rewrite handle_node(),
> >  [RFC 5/5] vcs-svn: remove repo_tree
> 
> I haven't read the rest of the series yet but I expect
> it is less controversial than the first patch.

Hm.. I'm not sure ;)
> 
> --
> David Michael Barr

Florian 
