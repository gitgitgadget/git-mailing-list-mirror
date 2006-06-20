From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: packs and trees
Date: Tue, 20 Jun 2006 10:35:49 -0400
Message-ID: <9e4733910606200735u5741a9adr83264ae7d51dd37@mail.gmail.com>
References: <9e4733910606192257y1516e966t848a3b1e29e5667f@mail.gmail.com>
	 <46a038f90606192313l16b16132r1523f5e05ae1566a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 20 16:36:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FshKb-0008RO-VU
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 16:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWFTOfv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 10:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWFTOfu
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 10:35:50 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:58945 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751057AbWFTOfu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jun 2006 10:35:50 -0400
Received: by nz-out-0102.google.com with SMTP id s18so2032834nze
        for <git@vger.kernel.org>; Tue, 20 Jun 2006 07:35:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lpQ6t8VGBRCcuhWg8JoMJ+oqNixBrXhInBILUfpw0NsynT8mDQVdPbQ0EDcwTHq2lHKmqy3/om/7fecSYbP0GYdZBMSKwtyDkf5uiBEWQIoMZQzH19ewlVbmLbH51U60RzcQWCHhGbF1H9KWo7DAEjDivKnQNDd/SazvgMXLzoE=
Received: by 10.36.224.17 with SMTP id w17mr2334619nzg;
        Tue, 20 Jun 2006 07:35:49 -0700 (PDT)
Received: by 10.36.37.5 with HTTP; Tue, 20 Jun 2006 07:35:49 -0700 (PDT)
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90606192313l16b16132r1523f5e05ae1566a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22203>

On 6/20/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On 6/20/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> > The plan is to modify rcs2git from parsecvs to create all of the git
> > objects for the tree.
>
> Sounds like a good plan. Have you seen recent discussions about it
> being impossible to repack usefully when you don't have trees (and
> resulting performance problems on ext3).

No, I will look back in the archives.  If needed we can do a repack
after each file is added. I would hope that git can handle a repack
when the new stuff is 100% deltas from a single file.

If I can't pack the exploded deltas need about 35GB disk space. That
is an awful lot to feed to pack all at once, but it will have trees,

>
> > cvs2svn seems to do a good job at generating the trees.
>
> No doubt. Gut the last stage, and use all the data in the intermediate
> DBs to run a git import. It's a great plan, and if you can understand
> that Python code... all yours ;-)

How hard would it be to adjust cvsps to use cvs2svn's algorithm for
grouping the changesets? I'd rather do this in a C app but I haven't
figured out the guts of parsecvs or cvsps well enough to change the
algorithms. There is no requirement to use external databases, sorting
everything in RAM is fine.

If you are interested in changing the cvsps grouping algorithm I can
look at moding it to write out the revisions as are they are parsed.
Then you only need to save the git sha1 in memory instead of the
file:rev when sorting.

> > exactly sure how the changeset detection algorithms in the three apps
> > compare, but cvs2svn is not having any trouble building changesets for
> > Mozilla. The other two apps have some issues, cvsps throws away some
> > of the branches and parsecvs can't complete the analysis.
>
> Have you tried a recent parsecvs from Keith's tree? There's been quite
> a bit of activity there too. And Keith's interested in sorting out
> incremental imports too, which you need for a reasonable Moz
> transition plan as well.

Keith's parsecvs run ended up in a loop and mine hit a parsecvs error
and then had memory corruption after about eight hours. That was last
week,  I just checked the logs and I don't see any comments about
fixing it.

Even after spending eight hours building the changeset info iit is
still going to take it a couple of days to retrieve the versions one
at a time and write them to git. Reparsing 50MB delta files n^2/2
times is a major bottleneck for all three programs.

-- 
Jon Smirl
jonsmirl@gmail.com
