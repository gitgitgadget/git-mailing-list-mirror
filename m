From: "Robert Anderson" <rwa000@gmail.com>
Subject: Re: An alternate model for preparing partial commits
Date: Fri, 27 Jun 2008 10:14:05 -0700
Message-ID: <9af502e50806271014l661dcfc9o4f61ee2b54677bd6@mail.gmail.com>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com>
	 <alpine.DEB.1.00.0806271408290.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 27 19:15:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCHXO-00087e-P7
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 19:15:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561AbYF0ROK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 13:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752257AbYF0ROJ
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 13:14:09 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:42260 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbYF0ROH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 13:14:07 -0400
Received: by fk-out-0910.google.com with SMTP id 18so523779fkq.5
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 10:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=KWyMP6gZnYSADwtXns+RcD6sXYtKqfYBOfY3PacsPJs=;
        b=qRsMl9IMtIME+XqmvKHZ54mYylmBn6NZjzqig0IAhVDyuasP1HsixsAPXBEheLr1F9
         IwlggUkbtm2kkmJQl94Jiq0drutHHAIuNnqP9Foc4r/8XZgGc9W1ULSKm6zN4GqPqXlZ
         5VLGAmxQm/yLr7fHRI2lbZNYIhcvgyxXhs0+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=tV3wgxeojGVO/GsuTHkD9IJBaWjeboSHCIEGUe8Lso1wLTZ7bLg/g//JmSV5+Cfz4e
         V7t5MNOSmkFNf7AZpgeAD7d2SjqyxjsDDOGGOj+6RbVc+zKTB5/ePFTDeley828vwD/E
         rDWRYwflBWtyuzB9BlPSpEfUxpFOHiwqaAYjE=
Received: by 10.82.169.4 with SMTP id r4mr68551bue.66.1214586845436;
        Fri, 27 Jun 2008 10:14:05 -0700 (PDT)
Received: by 10.82.178.10 with HTTP; Fri, 27 Jun 2008 10:14:05 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0806271408290.9925@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86603>

On Fri, Jun 27, 2008 at 6:33 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 26 Jun 2008, Robert Anderson wrote:
>
>> Seems to me the concept of the "index" is a half-baked version of what
>> I really want, which is the ability to factor a working tree's changes
>> into its constituent parts in preparation for committing them.
>
> Half-baked is probably too strong a word.

It is too subtle.  That the index state - which becomes the next
committed state - is not available for building or testing before
committing is a deep flaw.

> What you are basically asking for is to have the working directory
> as staging area, and to be able to stash away changes that are not to be
> committed.

Correct.

> Now, this is not necessarily what everybody wants, which is why many
> people are fine with the index.

But it is something they should want, and should have, if they care
about the quality of their commits.  Especially in the common case of
a project with development lines which have some sort of policy about
build/test requirements.  How do you ensure your commits obey that
policy if you cannot verify it?  That is why the index is not a
sufficient mechanism for preparing partial commits.  It's fine for
quick and dirty operation when the factorization of the conflated
changes is obvious and trivial.  It is not sufficient otherwise.

> Having said that, I played with the idea of a "git stash -i", which would
> allow you to select the changes to stash away.  (And by extension, "git
> stash -e" using the "git add -e" command.)
>
> Hmm?

I meant to mention that - at least in the model I described - this has
some overlap with "stash" and could possibly be folded into it.

In my ideal UI, changes (from all changes to hunk level) could be
moved back and forth between the stash and the working tree equally
easily.  Would git stash -i allow that?

For example, if I moved a couple of files into the stash, and then
realized I needed one hunk back, could I easily retrieve just that
from the stash?

Thanks,
Bob
