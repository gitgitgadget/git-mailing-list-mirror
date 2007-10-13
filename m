From: Dan Zwell <dzwell@gmail.com>
Subject: Re: [PATCH] Color support added to git-add--interactive.
Date: Sat, 13 Oct 2007 15:03:29 -0500
Message-ID: <47112491.8070309@gmail.com>
References: <471045DA.5050902@gmail.com> <19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com> <20071013172745.GA2624@coredump.intra.peff.net> <20071013175127.GA3183@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 13 22:04:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgnE6-00089c-Bw
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 22:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609AbXJMUEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 16:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753530AbXJMUEf
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 16:04:35 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:28895 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428AbXJMUEe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 16:04:34 -0400
Received: by py-out-1112.google.com with SMTP id u77so2245319pyb
        for <git@vger.kernel.org>; Sat, 13 Oct 2007 13:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=L2t8am+decIPVFQ83qMNtWU3J82mBVRRmSsQCEvOxbY=;
        b=HBVil8sy/920j8AWhoesPxI9cuxpEoWUWagpn2GJYrHfkLxbs1jKlKTFKlgWdhcmhKQnQZ5irhOZf9sk++o0wLOvAZiQac5+MZpEe44qs1zUUce6iFMs7g4/b+erD8t42I6oVkHH4qMLjl3TdiWtPe6SKJ0aEL5SQYdtk/noarc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=IEB17zy6XX9TgcxynS3uXLky3d84F7j3Rwg8D25/MZhBnXVfSO3Lh/uxkS25g3+Xt1OqyZeb0yqH3aj563sPF/l7CekKY5ARpXQE6hH3ir6tnemghlEQhIeqszrBMAPmWN2UEdGSmYMgPQ0vQXhltnMpwpRBCM/8cD4sjWG4MMg=
Received: by 10.65.180.9 with SMTP id h9mr9436163qbp.1192305873134;
        Sat, 13 Oct 2007 13:04:33 -0700 (PDT)
Received: from ?143.44.70.185? ( [143.44.70.185])
        by mx.google.com with ESMTPS id 6sm1366074nzn.2007.10.13.13.04.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Oct 2007 13:04:32 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070922)
In-Reply-To: <20071013175127.GA3183@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60756>

Jeff King wrote:
> On Sat, Oct 13, 2007 at 01:27:45PM -0400, Jeff King wrote:
> 
> <snip> Though I am still concerned about the
> robustness of the re-parsing scheme.
> 
> -Peff
> 

The importance of the diff coloring pales in comparison to the prompt 
coloring. Diff coloring is useful, but prompt coloring is a basic 
usability concern (if people can't easily tell where a hunk begins, the 
tool becomes annoying). Perhaps we could split this into two patches, 
merging the first after a few small changes can be taken care of, while 
the second may need more discussion and testing. The coloring of the 
prompts is relatively low risk. It just needs to be modified to take 
color settings from .git/config. I was thinking that this might be the 
example that I would take settings from:

[color]
         add-interactive = auto
[color "add-interactive"]
         prompt = bold blue
         header = bold
         help = blue

For the sake of a unified interface, the "Stage this hunk?" prompt 
should be colored the same as the other prompts. I will give a bit of 
thought to the default colors, though it's important to avoid red and 
green (as those will look like diff output when the second patch is 
applied).

Also needed is some command line parsing so that "--color" can be 
specified on the command line (very small change), and all of this 
should be added to the documentation.

Obviously, the suggestions/fixes from other parts of this thread must be 
taken into account, as well. I can probably do all this tomorrow (and 
send low-risk/high-risk patches), unless someone takes it before me.

Dan
