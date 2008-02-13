From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: new stacked git feature
Date: Wed, 13 Feb 2008 22:29:34 +0000
Message-ID: <b0943d9e0802131429p76f0981cm6e54a6a07042f229@mail.gmail.com>
References: <20080111194946.GA7504@redhat.com>
	 <1202834567.14175.68.camel@pc1117.cambridge.arm.com>
	 <20080213000806.GB25839@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jason Baron" <jbaron@redhat.com>,
	"=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>,
	"Yann Dirson" <ydirson@altern.org>, git <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 23:30:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPQ7a-0007I1-Oq
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 23:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758970AbYBMW3i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Feb 2008 17:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758467AbYBMW3i
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 17:29:38 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:23124 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755845AbYBMW3g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Feb 2008 17:29:36 -0500
Received: by rv-out-0910.google.com with SMTP id k20so105419rvb.1
        for <git@vger.kernel.org>; Wed, 13 Feb 2008 14:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=NLKi37t/gRPnrvLIofBgKdLov+co0+9DOvB4AirSdeg=;
        b=bEO1fLvA7m0CUbmUq0FpJ8lABTbqnxLOCeNFSCZzKkJouvNzJ5D5uILLXE+oeHk/Dij5FQhXxtIE4vzeuG/s01HdYdgEj9dJf5SQIc4sFd/m8faZDPVfsx0PMU9whfUmczZWRSf7UgDe2P6q1eIltCxxQw/+IPf3GHNJjUsO2hU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FhiHnVYo8w2k0lmjOhXy0/Xd03MleunXgVGUcNRKIDfZ1zUm7zT3KFi6tsxxcqTbaMXxojDR+TV9kDKdee/gavQjKTT1DgU9M1lFsT1yWyC6AxTDMQNO9arrpsZWkd6L/4iUE11Eb/BgIBRebLY9wCiQtdDaiVVvDlCdirw8YWQ=
Received: by 10.141.87.13 with SMTP id p13mr371245rvl.163.1202941774995;
        Wed, 13 Feb 2008 14:29:34 -0800 (PST)
Received: by 10.140.193.5 with HTTP; Wed, 13 Feb 2008 14:29:34 -0800 (PST)
In-Reply-To: <20080213000806.GB25839@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73822>

On 13/02/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2008-02-12 16:42:46 +0000, Catalin Marinas wrote:
> > The background of this discussion is to have two or more StGIT
> > repositories and keep them in sync. An idea is to share the exporte=
d
> > patches directory and automatically synchronise them between variou=
s
> > repositories (we already have a 'stg sync' command which I use for
> > this kind of things but it's not automated).
> >
> > Yet another idea is to add some metadata to each commit log,
> > something like a unique id so that one can recreate the stack with
> > only a GIT revision id, without knowing the base.
>
> I've been trying to come up with a good way to represent undo
> information, and my current plan is this:
>
>   * Every time the patch stack is modified (that is, any time an StGi=
t
>     command modifies anything at all), a new commit is made to a log
>     branch. Each StGit branch has one such log branch.

We already have another commit for the patch history. If we add this,
we end up with 3 commit for each patch command. People already
complained that StGIT is slow, I wouldn't go this route. I even think
we should drop the patch history log and maybe use some git features
like reflog.

=46or undo, can we not keep the HEAD of the old stacks in a simple text
file? Or maybe use reflogs and only allow as many undos as information
available in reflog.

> I wasn't planning to try to build patch stack merging until later, bu=
t
> here's how I imagine it would work:
>
>   1. All patches are popped, and set to a special "conflicting" state
>      with three or more "a" trees: a.ours, a.theirs, a.base0, a.base1=
,
>      a.base2, .... Similarly for the "b" tree and the commit details.
>      (Of course, trivial conflicts could be sorted out automatically
>      at this point.)
>
>   2. The merged stack base is created with a normal recursive merge.

A recursive merge with the HEAD of another stack containing similar
patches? If yes, when pushing it is likely that the patches already in
the base will be emptied during a three-way merge.

>   3. When a conflicting patch is pushed, we do the following:
>
>        1. For each of .ours, .theirs, .base0, ..., create a new "b"
>           tree just like we do when we normally push a patch. If ther=
e
>           are conflicts, autoresolve them like merge-recursive does
>           internally.
>
>        2. Create the single new "b" tree by making a recursive merge
>           of all these updated "b" trees. Represent any conflicts lik=
e
>           we usually do when pushing patches.

My idea is to merge each patch with the corresponding commit in the
other branch and leave the base unchanged (like "stg sync"). The
difficulty is in identifying which commit from the other branch has to
be used. We could try guessing by the number of changes or just using
the subject line, assuming that it won't change (or an extra id field
in the commit text).

I find this workflow pretty difficult to implement since the StGIT
patches are pretty volatile. It might be better to use topic branches
instead.

--=20
Catalin
