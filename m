From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] mergetool: run prompt only if guessed tool
Date: Tue, 22 Apr 2014 02:56:22 -0500
Message-ID: <535620a6e8274_3d2216372ec9d@nysa.notmuch>
References: <1398039454-31193-1-git-send-email-felipe.contreras@gmail.com>
 <1398039454-31193-3-git-send-email-felipe.contreras@gmail.com>
 <20140422045951.GA60610@gmail.com>
 <20140422060120.GA10198@hashpling.org>
 <53560b09bbe96_2400128531085@nysa.notmuch>
 <20140422065549.GA11224@hashpling.org>
 <535611fac1b7b_268bd0b308f5@nysa.notmuch>
 <20140422073008.GA11584@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 10:06:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcVjC-0006Yp-BO
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 10:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043AbaDVIGu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 04:06:50 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:36599 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbaDVIGq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 04:06:46 -0400
Received: by mail-ob0-f175.google.com with SMTP id wp4so5285243obc.6
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 01:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=40Wkz9zmFF2KXQYn6mj4UDB5jdMlxyamgrH9sgi8QcQ=;
        b=K6r6GL2nGE0s5wbXwiPcxhz/KlP+jdr9EJxNyBqvu8XFH4DscNQ27vecXyuOKC8t4v
         Kikfz7JIcbvZb1WpF1wn7gQDY51a4XNWWvJgzHYlhngtP2ZkI+OqZNyHteUGmZcKj22J
         961K0kQJIQCLUEPqKXIufm/7qQ47W0RUkSzv4A85bAHTMrZNhi/NtrSweGJkKO26UegU
         HzjgZXRPljLyzufCoE/fNhoINYC0eT8f6zBEDUIHZsJiC6LBsNBYU3Iu1GIPxSR8Lsz8
         Bwyu6qju8N7NL9XM/+Ya5FO7AJLTcFHPkmdl1MSn6jWovmYX/hpXfsBkGz8E1GekiQlQ
         FIEQ==
X-Received: by 10.60.62.34 with SMTP id v2mr31357635oer.37.1398154006014;
        Tue, 22 Apr 2014 01:06:46 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id e8sm174978936oed.7.2014.04.22.01.06.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Apr 2014 01:06:45 -0700 (PDT)
In-Reply-To: <20140422073008.GA11584@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246712>

Charles Bailey wrote:
> On Tue, Apr 22, 2014 at 01:53:46AM -0500, Felipe Contreras wrote:
> > Charles Bailey wrote:
> > > On Tue, Apr 22, 2014 at 01:24:09AM -0500, Felipe Contreras wrote:
> > > > 
> > > > This is what I get when a tool is not working:
> > > > 
> > > >   Documentation/config.txt seems unchanged.
> > > >   Was the merge successful? [y/n]
> > > 
> > > Does this happen now even with merge tools for which we do trust the
> > > exit code? If so, my original concern is addressed.
> > 
> > Which tools are those?
> 
> I didn't remember off hand, but checking the mergetools directory
> suggests that kdiff3 is one (there's no call to check_unchanged). I
> stopped checking after I found one.

So:

	% cat > ~/bin/kdiff3 <<-\EOF
	#!/bin/sh
	false
	EOF
	% chmod +x ~/bin/kdiff3
  % git -c merge.tool=kdiff3 mergetool
  merge of Documentation/config.txt failed
  Continue merging other unresolved paths (y/n) ?

> > You don't see anything wrong with asking the user *every single time* he runs
> > `git mergetool`, even though he *already told us* which tool to use?
> >  
> > If so, I'm pretty sure everybody else disagrees with you.
> 
> I think that you may have misunderstood me. As I said, I've no
> particular objections to changing the default (subject a few concerns
> that may or may not still apply).
> 
> Having said that, the fact that the user has configured the merge tool
> doesn't mean that he necessarily doesn't want to see the prompt.

Not necessarily, but in 99% of the cases it does. And for the remaining there's
always mergetool.prompt = true.

> In a part of my reply which you snipped, I said that it's sometimes the
> particular file that's due to be resolved that might prompt a user to want to
> skip launching the tool.

That's a possibility, however, in almost all the situations I've wanted to stop
a merge, it's *after* I've seen the actual conflicts in the file.

Anyway, I've revisited the code, and it's only now that I've realized that this:

  Hit return to start merge resolution tool (kdiff3):

Is not actually asking me for the tool I want to use; the value in parenthesis
is not the default, and I can't type in another tool.

So the purpose of the prompt is very different from what I was thinking, yet I
still think the value of such prompt is marginal at best.

> Either way, I think we shouldn't unconditionally override an explicitly
> set mergetool.prompt and if we are (effectively) changing the default we
> should probably update the documentation to say so as well. 

An explicitly set mergetool.prompt = true would override the default. See the
patch.

I looked, the documentation doesn't mention any default. We could add it, but I
don't think it's necesarily part of this patch.

-- 
Felipe Contreras
