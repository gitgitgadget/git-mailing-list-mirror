From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 0/3] Towards a Git-to-SVN bridge
Date: Sat, 15 Jan 2011 01:22:11 -0600
Message-ID: <20110115072211.GB25253@burratino>
References: <1295074272-19559-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 15 08:22:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pe0TJ-00038x-MS
	for gcvg-git-2@lo.gmane.org; Sat, 15 Jan 2011 08:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347Ab1AOHW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jan 2011 02:22:26 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61855 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258Ab1AOHWT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jan 2011 02:22:19 -0500
Received: by yxt3 with SMTP id 3so1405494yxt.19
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 23:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=3cf+5b3pfZENkm5Wu4+FthCbKnI4VMM2y3LXQxqyqm0=;
        b=o+1vlyCp0CUyZFNjPpdHuyUpjlmBDqOYNgivLJPktiSaNyxBER9hpzze6W7izrsBrT
         6rWJ6610W9LP/JJrGzWLYIF1ObPZrNb/6GhboctJYZsh7+w4bJu0aKV5r6AKoYlLASgb
         MjjbEoyLEu2gVDpn2bTx5m4x17T65K+/9YvN0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=g7421EMmJOyZWByfizPhlgjJeaHz76jX0XihkKItcR5Z4md0T4yKr7r2RUuYCgYGAJ
         w2CbOMLHqzylKCTfexcplrjYygSBKKWzicVNzS3IMCWfMhrwSdfuFkbOoatuvJSX0Zai
         cyADo2rvjhBvH97XKMLacnUGgNcD5fOCTOvv0=
Received: by 10.91.8.20 with SMTP id l20mr2199724agi.147.1295076138803;
        Fri, 14 Jan 2011 23:22:18 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.sbcglobal.net [69.209.76.37])
        by mx.google.com with ESMTPS id f10sm2443664anh.25.2011.01.14.23.22.16
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 14 Jan 2011 23:22:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1295074272-19559-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165140>

Hi Ram,

Ramkumar Ramachandra wrote:

> Over the last couple of days, I've been working on a parser that
> converts a fast-import stream into a SVN dumpfile. So far, it's very
> rough and works minimally for some common fast-import
> commands.

Some early questions:

 - what are the design goals?  Is this meant to be super fast?
   Robust?  Simple?  Why should I be excited about it?[1]

 - what subset of fast-import commands is supported?  Is it well
   enough defined to make a manpage?

 - does this produce v2 or v3 dumpfiles?

 - why would I use this instead of git2svn?  Does git2svn do anything
   this will not eventually be able to do?  (Not a trick question ---
   I don't have enough experience with git2svn to tell its strengths
   and weaknesses.)

> I've decided to try re-implementing fast-export
> to eliminate blob marks

Hopefully "re-implement" means "patch" here. :)

I can comment on the code but it's probably better if I have a sense
of the design first (in any event, thanks for sending it).

Regards,
Jonathan

[1] I found the original svn-fe design interesting because
 (1) it reused code from an existing svndump parser, at least in
     spirit,
 (2) the repo_tree data structure was well fitted to the design
     constraints,
 (3) the line_buffer input abstraction was oddly satisfying, even
     though it does not buy anything obvious out of the box over
     direct use of strbuf and stdio;
 (4) speed; and, most importantly
 (5) the command-line interface was easy to debug, very flexible,
     and dead simple.

I find the current svn-fe satisfying in a different way --- a sort of
"line by line" translation between dump formats is becoming possible.
