From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [GSoC] Git to SVN bridge
Date: Thu, 19 Apr 2012 17:56:59 -0500
Message-ID: <20120419225659.GA4971@burratino>
References: <CALkWK0=Mqo=PMv7+_sr22Dnm6xxzxzaXL=Zh+2LsvT=usC7csw@mail.gmail.com>
 <20120418201050.GB30625@burratino>
 <CALkWK0=7SPR-4Km5TUwg+rHm30aC7Uru9GJkkfYnL3OORV7nfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 00:57:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SL0Hu-0000eu-VM
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 00:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756826Ab2DSW5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 18:57:13 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41426 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754710Ab2DSW5M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 18:57:12 -0400
Received: by iagz16 with SMTP id z16so12522394iag.19
        for <git@vger.kernel.org>; Thu, 19 Apr 2012 15:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=58B92dTcRhb8Uoa5rVnRe+twT/TrHS6yCBcHHWaWm3k=;
        b=he7NsIzyJ6knsw2IFVQIvOl7hfswz8mk5mt2e05NEKp/Ni4mGPRnnRKwCxtzxl8Yv1
         NLHkkqm5J2pgjrRgo7+2A8OR7PuSmVGdvxTY813LgY+Y26ApMPoaYZhi04/RMRk2FiCg
         NHa3RetWd04QB+ZOnhx7qKr9R4+7UvcWnCK1IDq4IBaVDhwfWC3Gpzva36sRlJTJPs76
         OMjuWNYPb7xe6BU473HRQqcERo1DXWECdTw8CPVqHqh7aVnXkoSxXVQRrdHukxf4mOAA
         JnWB0k8DD9I1St1Tj11KlixpVKf+goJVw6m3VLiS/hSx+cQ1UNqBIe/c5kjNoKolQt/M
         SkYA==
Received: by 10.50.216.232 with SMTP id ot8mr8553265igc.22.1334876232144;
        Thu, 19 Apr 2012 15:57:12 -0700 (PDT)
Received: from burratino ([64.134.171.237])
        by mx.google.com with ESMTPS id i6sm1130125igq.3.2012.04.19.15.57.07
        (version=SSLv3 cipher=OTHER);
        Thu, 19 Apr 2012 15:57:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0=7SPR-4Km5TUwg+rHm30aC7Uru9GJkkfYnL3OORV7nfg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195972>

Ramkumar Ramachandra wrote:

> Give 'vcs-svn/' the ability to spit out a Subversion dumpfile.  If you
> remember, we hit a brick wall last time when we needed a way to
> persist mark-referenced-blobs in the fast-import stream.

Yeah.  Ok, let's start there.

If I remember correctly, before we had this idea that svn-fi would be
a generic fast-import backend, so we could get support for pushing to
Subversion from other version control systems like Mercurial and RCS
for free.  An earlier idea was to use a very minimal subset of the
fast-import format.  You started with a patch that taught fast-export
a switch to produce that minimal subset, which was rejected because it
seemed like too much of a niche use case to be worth the cost to
compatibility.

However, that leaves whole swaths of the design space unexplored.  For
example, maybe "git fast-export" doesn't need to write the restricted
format but there would be a filter that takes an arbitrary fast-import
stream and converts it to the restricted thing.  Or maybe it would be
easiest to get something off the ground using that restricted
"fast-import lite" format and only afterwards expand svn-fi to handle
more commands so it can talk to the rest of the world.

In other words, if you are hitting a wall with that part which doesn't
seem to have much to do with differences between git and Subversion
anyway, I imagine there are easier places to start.  Alternatively, if
you prefer to work on making it easy for an importer to handle "ls"
and "cat" commands and mark references, I think our previous attempts
were misguided and we can do better. :)  What do you think?

Jonathan
