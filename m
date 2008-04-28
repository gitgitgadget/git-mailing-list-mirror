From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Yet another Git tutorial
Date: Tue, 29 Apr 2008 02:27:17 +0400
Message-ID: <20080428222717.GA6160@dpotapov.dyndns.org>
References: <2D3D2E55-74C7-4373-BC22-9CF4C26C197D@newartisans.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Wiegley <johnw@newartisans.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 00:28:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqbpa-00042v-CX
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 00:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934197AbYD1W10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 18:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933799AbYD1W1Z
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 18:27:25 -0400
Received: from ik-out-1112.google.com ([66.249.90.176]:16167 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933498AbYD1W1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 18:27:24 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1039511ika.5
        for <git@vger.kernel.org>; Mon, 28 Apr 2008 15:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=80kv+FO+mMtEvf6ViE1QGclmhUanpo8SVhb2fDn/BAw=;
        b=MzJ8G/2ciVLfz9StIRyxNGE4mHGPNK4zH4OOeKELbkev/9S1WpoS5hPK1gCwoAwZSXDZ52zjbnEkgJZ1iu2/h4y8IcIy2N9/tfbBEBvpzohs8lqQ+CFOaBiIx0SCeSxovKr9ewUA52rmsvPMkf9f484qDh8IBplyadPBwJixOtM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=oMt7YvIA86oy0LPLY3IecTze4y+thDt2x0sw1U8fvKRuOorTroLr1rrsvwYeSLXStC2PDBWV1DTpjElet1KXA8w+Y87RKJI50QqEENDFJO75ppVckBUiumoSueYD9+RKhb6NETlkjcQjsvH6lhd3ICyoLeuRT2IZn1VTt6oKhqs=
Received: by 10.78.199.8 with SMTP id w8mr4355899huf.106.1209421641967;
        Mon, 28 Apr 2008 15:27:21 -0700 (PDT)
Received: from localhost ( [85.141.189.217])
        by mx.google.com with ESMTPS id o22sm2973572hub.44.2008.04.28.15.27.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Apr 2008 15:27:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2D3D2E55-74C7-4373-BC22-9CF4C26C197D@newartisans.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80631>

On Mon, Apr 28, 2008 at 02:39:46AM -0400, John Wiegley wrote:
> I published another tutorial on Git today, this one describing the  
> system from a "bottom up" perspective.  I know it's been written about  
> this way before, but I was aiming at a bit more thoroughness, and a  
> paced introduction to the basics.
> 
> There's a link to the PDF is in the following blog post:
> 
>   http://www.newartisans.com/blog_files/git.from.bottom.up.php

In addition to what was mentioned before me:

On page 6, instead of `git show --pretty=format:%T HEAD | head -1`, it
is better to use `git log -1 --pretty=format:'%T' HEAD`. In general,
`git show <commit-object>` is `git log -1 -p <commit-object>`, and
you do not need diff here.

On page 7:
> This blob doesn't live in a tree yet, nor are there any commits.

It is probably nit-picking, but blobs never live in trees. They may
only be referenced by trees, while they always reside in 'objects'.
At this point, the blob is already placed into 'objects', but it is
not referenced by any tree, but only by index. So if you decide not
to commit this file then this blob will become dangling.

On page 10:
> circles are commit objects, and all but the first link to one or more
> parent commits, thus forming a "history"

Though typically there is only one commit object in Git repository
without a parent, it could be more than one.

> every commit holds a tree, and every tree must have at least one blob
> in its leaves

If there is no files in the current commit then the commit object
will reference to an empty tree, i.e. without any blob in it.


On page 12:
> name1..name2
> 
> The syntax to the le refers to all the commits between name1
> and name2, inclusive.

Actually, inclusive name2 but excluding name1. IMHO, it is better to
describe it as:
`name1..name2` is a short-hand for `^name1 name2`, which is equivalent
to `name2 --not name1`, i.e. all commits in name1 excluding those that
are part of name2.

> name1...name2
> 
> For example, if you had two development branches, "foo" and
> "bar", you could show all the commits which had happened on
> bar since their common ancestor using this command:

Not true. It shows all commits on both "foo" and "bar" that's happened
since their common ancestors. In other words, `name1...name2` is
equivalent to `name1 name2 --not $(git-merge-base --all name1 name2)`.
The '--all' flag means to consider their all ancestors, not just first
one.


BTW, maybe it would be useful to mention `git log -S<string>` somewhere
as a better alternative to `git blame`, because people with CVS/SVN
background tend to abuse `git blame` while `git log -S` is usually more
convenient and more efficient.


Dmitry
