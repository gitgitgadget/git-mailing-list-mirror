From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: Index format v5
Date: Wed, 16 May 2012 23:54:07 +0200
Message-ID: <20120516215407.GA1738@tgummerer.surfnet.iacbox>
References: <20120508141137.GA3937@tgummerer.surfnet.iacbox>
 <4FAA2CAF.3040408@alum.mit.edu>
 <20120510121911.GB98491@tgummerer>
 <4FAC0633.90809@alum.mit.edu>
 <20120511171230.GA2107@tgummerer>
 <4FB01080.6010605@alum.mit.edu>
 <20120514150113.GD2107@tgummerer>
 <4FB1746A.6090408@alum.mit.edu>
 <20120515134916.GA2074@tgummerer.unibz.it>
 <4FB334C7.2070201@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com,
	peff@peff.net, spearce@spearce.org, davidbarr@google.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed May 16 23:54:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUmAn-0003Y1-Ec
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 23:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758514Ab2EPVyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 May 2012 17:54:16 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42751 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753758Ab2EPVyP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2012 17:54:15 -0400
Received: by pbbrp8 with SMTP id rp8so1660981pbb.19
        for <git@vger.kernel.org>; Wed, 16 May 2012 14:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=c1wx53WZw4SWhih4aHxiavtTDBCJGGT0MgH8VLd7IQQ=;
        b=zP21h+sZ6rnnBBZLJUX49bdhufHdsbi998o0uYxSxNLI6UxZvXyxoDUTC3hiqHoAsb
         g6fDdkUWCA5nUh89TRxiMo3CF5j5zDMZgFiBrs4MIkJ0J5elyWvN2xuZ/gs//tv/vFff
         sqZsk2tTKFlo2dnOK20mPrnYH3F+4veeYVpcMDU5VicsxNfbr6EjU9YSgon42youjtAA
         SM5wYRKz7vXXqW4sEoTyIP2yK+36R0RtjVhqBsMEKJKCVJ+j2SVBAXU5lE8JjfcdUWra
         qVnfThD8WgTFTSj1BNjZiks96GrOhPKbLQdFNI6hpPG5h/sR7dkwhMzJunXAOd1Cafts
         WVQw==
Received: by 10.68.223.138 with SMTP id qu10mr6938368pbc.124.1337205255252;
        Wed, 16 May 2012 14:54:15 -0700 (PDT)
Received: from localhost ([216.18.212.218])
        by mx.google.com with ESMTPS id iw4sm6741849pbc.7.2012.05.16.14.54.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 May 2012 14:54:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FB334C7.2070201@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197902>



On 05/16, Michael Haggerty wrote:
> I just reviewed version 1369bd855b86 of your script, and it is MUCH
> better.  It's easy to read and review.  The functions that it
> defines are now self-contained and could therefore be reused for
> other purposes.  There are fewer magic numbers (though there are
> still a few; I wonder if there is a way to get rid of those?)
> You've done a nice job polishing up the code.

Thanks for the feedback! I could get rid of the magic numbers for
the crc code, but I'm not sure if it makes sense to replace the
others with constants, since they only occur once in the file. I
added comments instead explaining where those numbers come from
instead.

> I have only a few remaining niggles::
> 
> 1. The struct module can handle fixed-length strings, so you could
> read and parse the SHA1s as part of FILE_DATA_STRUCT and
> DIR_DATA_STRUCT rather than handling them separately.
> 
> 2. At least some of the functions deserve docstrings, especially
> when they are nontrivial.  For example, what arguments read_files()
> needs and how they are used is far from obvious.
> 
> 3. It would be easier to read the multiline string formatting
> templates if they are written as multiline strings (even though this
> kindof requires that they be made file-level constants); e.g.,
> 
> FILE_FORMAT = """\
> %(name)s (%(objhash)s)
> mtime: %(mtimes)s:%(mtimens)s
> mode: %(mode)s flags: %(flags)s
> statcrc: """

Thanks, I have changed those. I added the docstrings for all read
functions, they however don't seem to make sense for the print
functions, since you're probably faster just reading the code for
them.

One since I changed in addition is to those changes, is that I
gave the exceptions names to make them more meaningful.

> In the future, please try to commit one self-contained change at a
> time and make your commit messages really describe what is changed
> in the commit.  For example, commit fb2654c648a does at least three
> things, only one of which is mentioned in its commit message.  It
> would be better to break this into three commits with three commit
> messages.  Use "git rebase -i" and the other commit-rewriting tools
> liberally to tidy up commits before publishing them (but not after
> publishing them!); for example, commit be8d01c22c should really have
> been squashed on top of "Changed main to a function" so that the
> rest of the world doesn't have to see the broken latter commit.

Ok, I'll try my best to do that.

--
Thomas
