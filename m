From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: merging .gitignore
Date: Mon, 1 Oct 2007 14:48:16 +0100
Message-ID: <200710011448.17701.andyparkins@gmail.com>
References: <20071001130314.GA5932@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: martin f krafft <madduck@madduck.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 01 15:48:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcLdd-0002QB-5V
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 15:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbXJANsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 09:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbXJANsh
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 09:48:37 -0400
Received: from mu-out-0910.google.com ([209.85.134.184]:33826 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbXJANsg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 09:48:36 -0400
Received: by mu-out-0910.google.com with SMTP id i10so6203806mue
        for <git@vger.kernel.org>; Mon, 01 Oct 2007 06:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=QmMlheFvg4tgOBPLB/neGLjrKeI/u4jbVtZvUWMByiI=;
        b=Jk52a+17WP2e6GFQMCgVyS76PIEEK2iOQBkvA84fekwpxwq2JrXqFBw793yEObEbRWcbQWWZH9nXUHOoAUBc0EXCSnktAbMeMc6H4fU2DU0ajUKgFtUXutRVl23OpIEGr0D87nCU8pb7kL1r4JshdetR4hgh/GfUzAP2m+e/SdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WlT8y883yX6LCDvfOp/9FA9+bqcifnWwJeFGZcZAiKhzxvgC74K6k5VuIpnbDJHQ0pnPkNg1hOR5QHKBhU4krw/DGnHHIi1lKzWm+LAsqMjHgZynIR3mmdzs3QOcIAUDH28M1UK+GhgrsUNYfIW7f8g9gTORnBamYwEYhLTBuuI=
Received: by 10.82.106.14 with SMTP id e14mr7088279buc.1191246503932;
        Mon, 01 Oct 2007 06:48:23 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id f6sm102152nfh.2007.10.01.06.48.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Oct 2007 06:48:23 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <20071001130314.GA5932@lapse.madduck.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59616>

On Monday 2007 October 01, martin f krafft wrote:

> Feature branch A has a .gitignore file, and it's been merged into
> master for a while. Today, feature branch B failed to merge into
> master because it also provides a .gitignore file. We can obviously
> resolve the conflict, but I wonder whether there is a better way to
> deal with this since we deal with quite a large number of new
> feature branches and it's only a matter of time until the next one
> will conflict because of .gitignore.

But it _is_ a conflict.  Conflicts have to be resolved.  I'm having difficulty 
understanding what you think git should be doing in these cases?

> (and yes, this is basically a reincarnation of my case for
> .gitignore.d [http://lists.zerezo.com/git/msg627581.html]).

I don't see that that would help.  All you are doing with a gitignore.d is 
swapping lines for files, the conflicts would still exist.  Presumably you 
are hoping that the separate branches will make different files in 
gitignore.d and hence can't conflict; but then you've just pushed the 
conflict to a place where it won't be seen (and also made a terrible mess of 
the merged branch gitignore.d).

 branchA:.gitignore.d/branchAignores
 branchB:.gitignore.d/branchBignores

Over time you would get:

 master:.gitignore.d/branchAignores
 master:.gitignore.d/branchBignores
 master:.gitignore.d/branchCignores
 master:.gitignore.d/branchDignores
 master:.gitignore.d/branchEignores
 master:.gitignore.d/branchFignores

Then, assuming the conflicts you get now occur for a reason, you will get 
conflicts within the .gitignore.d/ directory.  Let's say branchCignores adds 
*.o and branchFignores removes *.o from the ignores.  Who is right?  Who 
knows, and worse than that you didn't see the conflict when it happened so it 
wasn't resolved and the master branch was left with conflicts in it.

Of course the conflicts in that case aren't in the form of "<<<<<" markers, 
but they are no less conflicts just because they're invisible.

Eventually someone is going to want to combine this ever-increasing set of 
ignore files into one.  i.e. they'll merge them.  In which case why couldn't 
you do the merge at the correct time - when the branch was merged?



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
