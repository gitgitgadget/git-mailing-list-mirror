From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: what's a useful definition of full text index on a repository?
Date: Mon, 1 Oct 2007 13:25:24 -0400
Message-ID: <9e4733910710011025y790800b5s4e8cf65409bc2cce@mail.gmail.com>
References: <e1dab3980710010933u6a7324f0wa8230d67ee0846e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "David Tweed" <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 19:25:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcP1Z-00026o-Lz
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 19:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753884AbXJARZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 13:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753692AbXJARZ2
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 13:25:28 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:28749 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753332AbXJARZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 13:25:26 -0400
Received: by wa-out-1112.google.com with SMTP id v27so4647557wah
        for <git@vger.kernel.org>; Mon, 01 Oct 2007 10:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=VszLZgKJ7AD2XL4+FPCbjmbNVLOCmxgiPy8n3yjvd/8=;
        b=tNoH8eVNKmQQKhKZck17uO/fNDyOjRulRAXDl8orw9WpQ3tgSRkBJFUInZ+CYrcFkgbj/QMgp9MafRmXbuR3k5ShjDH3hDpoCAgE2VFLHui3Hcnh0qr4tDRFuvyl8izbzfOPIfSUjHP0Mmb6NJ+Fdd0ctNlJS0DY+2HqhSAj3PA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Um/e0sVfLJw9DZH5F/PABHtQw2YNOcGTElP4YgictBhvD0t8KJF0ENxsr481/DQEd826EZi/7GXUagpzexx9X08B1HFUShqynM/NEsfVUlGxQk/VdGeO9TWOwr99RGSIczxduBpntqCogHtDULEeIMN6GV4Oj4HcIK5Z/h3bLvU=
Received: by 10.115.23.12 with SMTP id a12mr877432waj.1191259524527;
        Mon, 01 Oct 2007 10:25:24 -0700 (PDT)
Received: by 10.141.70.4 with HTTP; Mon, 1 Oct 2007 10:25:24 -0700 (PDT)
In-Reply-To: <e1dab3980710010933u6a7324f0wa8230d67ee0846e2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59628>

On 10/1/07, David Tweed <david.tweed@gmail.com> wrote:
> Basically a "blue sky" question about full-text indexing git repositories.
>
> A while back, whilst talking about overall git structure
> (see
>
> http://marc.info/?l=git&m=118891945402778&w=2
>
> ), Jon Smirl raised the question of putting a full-text index on a
> repository. I doubt I full text index is of much use on a code
> repository because the question tends to be focussed around either
> released versions or immediate git-blame stuff. However, for
> repositories of things like evolving documents/presentations/notes
> where content is deleted because it doesn't fit the context rather
> than being superceded by better stuff, it might be more natural to
> search for "where's that paragraph I wrote on 'human' 'vision' and
> 'kinematic' 'feedback' ?". So I got to thinking about experimenting
> with a full text index and even started writing some code. However, I
> then realised that it's not obvious what the most useful definition of
> a full text index is on evolving files. (To be clear, I'm _not_
> thinking about changing the database fundamentals as discussed in the
> referenced thread and indeed would put the full-text index into a
> different file that just references the existing git db stuff
> precisely because I doubt the text index will be of use to most
> people.)

This is what full text is used for with code:
http://lxr.mozilla.org/

It makes grep instant.

For source code you can take the full text concept further and store
parse trees. This lets you instantly find the callers of a function,
or all users of a variable.

Once you have parse trees in the database you can offer refactoring
too. I have used powerful proprietary system that used parse trees to
make complicated refactoring quite easy.

Note that a parse tree database doesn't have to be generated for all
the old revisions, it is mainly usefully for the current HEAD. Same
for the full text index. When you generate this data you end up with
lots of tiny files that need to be kept in sync with the current HEAD.
git is good for holding those files.

You want all this analysis coordinated with git so that when you
commit a change the right parts get regenerated. Linux seems to be
missing good, automated refactoring assistance. Instead the kernel
janitorial work is being done manually.

An example I noticed today. Use of pr_debug() is chaotic in the kernel
source. Many drivers have #if DEBUG their own versions of pr_debug().
Fixing everything to have consistent use of pr_debug is a refactoring
that could probably be mostly automated.

Mozilla is undergoing some massive automated rewrites.
http://blog.mozilla.com/tglek/category/decomtamination/

Full text indexing can also achieve high levels of compression as
stated in the earlier threads. It is full scale dictionary
compression. When it is being used for compression you want to apply
it to all revisions.

> A "classical" full-text index seems inappropriate because, if I've got
> a long text document that in a blob in commit n1 uses word 'x' in one
> section and the corresponding file in descendant commit n2 has the
> same text using word 'x' but has changes to a different section of the
> document, there's probably no point showing me both documents (and I
> can always track through the history once I've got one (commit-id,file
> pair)). So in the case of a single word, a "useful" definition would
> be the entry for word w in the full-text index should consist of those
> (commit-id,file) pairs whose diff with their parent contains an
> addition of text containing word w. (This will catch the creation of
> the text containing w and then precisely those files which are close
> modifications of it but ignore changes to other areas.) This seems to
> make sense for a single word. Let's call this the "appearance diff"
> definition of a full text index.

You would full text index the expanded source text for each revision,
not the delta. There are forms of full text indexes that record the
words position in the document. They let you search for "vision NEAR
feedback"

A good feature of this is finding when a variable or function was first added.

>
> However, things become unclear if you consider a query with multiple
> words. Consider the simplest case of a linear history where commit n0
> adds word "vision" to file p1.tex (with respect to its single parent),
> there are some intermediate commits and then commit n7 adds word
> "feedback" to p1.tex. Then there's no commit whose diff with its
> single parent contains both words "vision" and "feedback". In the
> linear history case you could imagine trying to find the first commit
> which is a child of _all_ the commits under the "appearance diff"
> definition. However, that clearly doesn't "obviously" extend to
> general full DAG histories, and in any case it's probably not fully
> correct even in the linear case. So maybe a different definition would
> be better. So I'm just throwing the question out to the list in case
> anyone has any better ideas for what a full-text index on an evolving
> set of files ought to be.
>
> (One question is "why do you want to build a table rather than
> actively search the full git repo for each query (ie, combination of
> words) as you make it?" My primary motivation is that I might in the
> future like to do queries on some sort of low processor power
> UMPC-type thing, having built the file containing a "full text index"
> data structure for the index on a quite beefy desktop. The other point
> is that searching natural language text based on a fallible memory
> you're more likely to try different combinations of search terms
> iteratively to try and hit the right one, so there might be some point
> in trying to build an index.)

I do admit that these indexes are used to make functions that can be
done with brute force faster. As computers get faster the need for
these decrease. Right now the size of the kernel repo is not growing
faster than the progress of hardware. If you went back are tried to do
these things on a 386 you'd be shouting for indexes tomorrow.

>
> Anyway, it's currently an idle speculation,
>
> --
> cheers, dave tweed__________________________
> david.tweed@gmail.com
> Rm 124, School of Systems Engineering, University of Reading.
> "we had no idea that when we added templates we were adding a Turing-
> complete compile-time language." -- C++ standardisation committee
>


-- 
Jon Smirl
jonsmirl@gmail.com
