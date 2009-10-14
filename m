From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Efficient cloning from svn (with multiple branches/tags subdirs)
Date: Wed, 14 Oct 2009 14:26:16 -0400
Message-ID: <32541b130910141126u4df7f439i3d2926c2e1db9497@mail.gmail.com>
References: <hb2fvu$8qi$1@ger.gmane.org> <20091014060307.GA17178@dcvr.yhbt.net> 
	<32541b130910140928jdac0187x754423e8d5c64e53@mail.gmail.com> 
	<20091014180013.GA24741@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bruno Harbulot <Bruno.Harbulot@manchester.ac.uk>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Oct 14 20:32:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My8dk-0008HS-0X
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 20:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756369AbZJNS1N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Oct 2009 14:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756353AbZJNS1N
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 14:27:13 -0400
Received: from mail-yw0-f176.google.com ([209.85.211.176]:36419 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756323AbZJNS1M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Oct 2009 14:27:12 -0400
Received: by ywh6 with SMTP id 6so61658ywh.4
        for <git@vger.kernel.org>; Wed, 14 Oct 2009 11:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Q3qwaFVVBmVdbBHrdxHOURKLsoiN9Wursp69D7TGXq4=;
        b=OBVbS0YivSK6y9aNo6TdmFJzF6wB+MZ8Icyv3fDkZEr3PteOlVdJKMUOmbN51j/W8s
         +99Mp6yjRY+gs7B2H3uzMqTc1omloJLSBIGfNSNkJGjaP500SooP7d9Fk+D9HaJZuFbs
         i3d9ZWdujx+gW5atkO7a7XRjQVgGfUnzp9Cgs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Y78Elh9aq9ZHbNn0iMW1nvuKIRhF66biuUzWAsfzpCNDclwU7kgrgcOzpWrSxhdRXk
         d01WHpRdfI+EgzMn2KsIjkO9R0r3Uqqpee2EIyuaEb9YJI/w9ADf1ke/1z8DI8MlduLH
         hy9w+5mTxxEDqPjnPBkO1Djr/Io/t7F7EnaTA=
Received: by 10.150.213.18 with SMTP id l18mr15406513ybg.183.1255544796185; 
	Wed, 14 Oct 2009 11:26:36 -0700 (PDT)
In-Reply-To: <20091014180013.GA24741@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130314>

On Wed, Oct 14, 2009 at 2:00 PM, Eric Wong <normalperson@yhbt.net> wrot=
e:
> Avery Pennarun <apenwarr@gmail.com> wrote:
>> I've been thinking about this myself for some time. =A0One option th=
at
>> might be "interesting" would be to just grab the *entire* svn tree
>> (from the root), and then use git-subtree[1] to slice and dice it in=
to
>> branches using your local copy of git (which is fast and uses no
>> bandwidth) instead of during the svn fetch (which is slow and uses
>> lots of bandwidth). =A0I think it would also simplify the git-svn co=
de
>> quite a lot, at least for fetching, since there would always be a
>> global view of the tree and SVN things like "copy branch A to tag B"
>> would just be exactly that.
>
> This was actually the original use case of git svn back when I starte=
d.
>
> =A0git svn clone SVNREPO_ROOT =A0 (without --stdlayout)
>
> It's still an option if you have the disk space for the working copie=
s,
> but I had to create the branches/tags support since the working copie=
s
> would be become prohibitively large. =A0If git-subtree could be
> taught to work on a bare repo (git svn has a --no-checkout option)
> it might be an option, too.

I've never tested git-subtree without a working tree, however, it
doesn't *use* the working tree for anything when splitting, so at
worst, there might be a minor bug or two.  Thus, there ought never be
a need to check out the whole huge tree (which I agree would be both
slow and huge).

dcommit might be a little weirder.  Though I guess if we fixed the
git-svn-id tags in the split branches, you could just commit directly
into a branch, then fetch the new commit back from the root, then
rebase the branch, as dcommit already does.

You know, maybe this is actually easier than I thought... I was
thinking committing back to svn would be complicated since it requires
a working tree, but if we let you commit straight from one of the
branches, it shouldn't actually be too bad at all.  Hmm.

Have fun,

Avery
