From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 03/14] Write to a stack log when stack is modified
Date: Fri, 20 Jun 2008 10:14:29 +0100
Message-ID: <b0943d9e0806200214j77aef272sc5cfb98b002cae22@mail.gmail.com>
References: <20080612053424.23549.64457.stgit@yoghurt>
	 <20080617123138.GA6932@diana.vm.bytemark.co.uk>
	 <b0943d9e0806170711w6da8e841p3ac83a59a81f6577@mail.gmail.com>
	 <20080617153247.GA12520@diana.vm.bytemark.co.uk>
	 <b0943d9e0806180603h59187f7epc5014f36d070cec7@mail.gmail.com>
	 <20080618143633.GB30540@diana.vm.bytemark.co.uk>
	 <b0943d9e0806180916m4af3970ck347408661e95663@mail.gmail.com>
	 <20080618173246.GA1155@diana.vm.bytemark.co.uk>
	 <b0943d9e0806190224v1b6434fesd3a54443422edaeb@mail.gmail.com>
	 <20080619100722.GB14415@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 11:15:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9ciN-0007gU-LI
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 11:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbYFTJOb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Jun 2008 05:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbYFTJOb
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 05:14:31 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:12151 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbYFTJO3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jun 2008 05:14:29 -0400
Received: by wa-out-1112.google.com with SMTP id j37so863149waf.23
        for <git@vger.kernel.org>; Fri, 20 Jun 2008 02:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=tRWg6E0JrniVUkPYZYTUWw/qSrpMMmxBDq6dIuYiXz8=;
        b=qxDabC5x8O9fItlH2D4s8oh8JdGpmVatJu8Ih8imhAtA+BtBLLw/HC/F5mf+25L831
         fD65Nj+WynwsxcASkZsUxo19nySq+EsGdo2geZUqcZ3vOAJR57DP1K7bPZhl1lep+dUX
         vxM7m9/Mwk7S32AdVoaDq5muGrkgBAdlp/wh4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ZOYbIufX6yG76mgYRJOSZ4Hwk1gsZQ9XtDrHSLIzHR1BokjaNK5Px0ZTfpqi9oNoVa
         KfJY8nS04YaLRrAhm3lzmYs//1woIVVIFDTmBdDD4yU7N/2JKGYRuv44ewyc0v//opdg
         bNQydK9Oj27sIr64mse7lQ6e2Pr6MCG2Q1XcE=
Received: by 10.114.147.7 with SMTP id u7mr3955197wad.188.1213953269114;
        Fri, 20 Jun 2008 02:14:29 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Fri, 20 Jun 2008 02:14:29 -0700 (PDT)
In-Reply-To: <20080619100722.GB14415@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85609>

2008/6/19 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-06-19 10:24:28 +0100, Catalin Marinas wrote:
>
>> 2008/6/18 Karl Hasselstr=F6m <kha@treskal.com>:
>>
>> > On 2008-06-18 17:16:10 +0100, Catalin Marinas wrote:
>> > > Making the first log entry special gets difficult with log
>> > > pruning (unless you prune the whole log rather than entries
>> > > older than a chosen time or number) since you might have to
>> > > re-create all the chained log entries as the first log's sha1
>> > > will probably change.
>> >
>> > You have to re-create all the commits anyway, since they all are
>> > immutable, and all have a back pointer.
>>
>> Ah, OK. So, at least initially, we should only support the full log
>> pruning.
>
> How do you imagine we'd do anything except a "full" pruning? There ar=
e
> grafts and shallow clones, I guess, but both of them have drawbacks.

Recreate the log but we I wouldn't spend time on this.

>> > > The applied patches are chained automatically via HEAD. For
>> > > unapplied patches, we could add the correponding commits as
>> > > parents of the logging commit (starting with the third parent as
>> > > the first two are used for log chaining and applied patches). Do
>> > > we hit any OS limit with the number of arguments?
>> >
>> > Not until long after we hit git limits to the number of parents of
>> > a commit. I believe the octopus merge refuses to create merges
>> > with more than about 25 parents, and we probably shouldn't do more
>> > than that either. We'll have to do a tree of octopuses.
>>
>> For the first log only, we could chain the unapplied patches using
>> commits with 2 parents. We just need to warn people not to stare at
>> the <branch>.stgit directly :-)
>
> We could make chains (or trees) of 16-parent commits -- that'd speed
> it up by a factor of 15. :-)

Yes, good idea.

>> >  * Parents: the previous log entry; branch head; something that
>> >    (recusively) points to all unapplied commits, if necessary.
>>
>> As you pointed below, "branch head" should probably be the "stack
>> top". We don't need to track the "branch head" if different, just
>> need to fix up the error and add the patches to the stack. And,
>> anyway, if one modifies the HEAD using git directly, the log will
>> still point to the top of the stack.
>
> If we ever want to be able to undo "stg repair", we have to be able t=
o
> represent an inconsistent state where head !=3D top.

I wouldn't bother with this feature. Why would one want to break the
stack again after repairing? If they merge patches and git commits,
they either repair the stack or commit all the patches and continue
with using Git only.

>> The third head would only be needed for the first log entry or when
>> we use pick --unapplied (in the latter, it only points to the
>> unapplied commit).
>
> Actually, except for the previous log entry, all the parents are just
> there for gc's benefit. So we could just put all of them in the same
> bucket -- branch head, stack top, and unapplied patches.
>
> ( By "bucket" I mean something like: if there are just a few of them,
>  have them as direct parents of the log commit; otherwise, refer to
>  them using a tree of octopuses. But in any case, just treat them as
>  a set of sha1s that we need to have as ancestors but don't otherwise
>  care about. )

Yes.

>> >  * I'm pretty sure we want the kind of "simplified" log I have in
>> >    my proposal. The full log in your proposal is going to look
>> >    every bit as ugly as the one in mine.
>>
>> I agree it will look ugly but the simplified log adds an extra
>> overhead on any stgit action. If we don't use stg log -g, a text
>> only log command could show the diff. We can add it afterwards
>> though if it is fast enough.
>
> I'd actually say the opposite: until we have a good visualizer that
> doesn't need the simplified log, we need to have the simplified log.
> If I actually have to look at the diffs in the log, I find gitk
> indispensible.

And what would the simplified log contain if we decide to go with a
new scheme? In your proposal, it points to the tree of main log and
you get the diff of diffs (which also means that the diffs must be
generated for every modification of a patch). Would this be the same?
Again, I worry a bit about the overhead to generate the patch diff for
every push (with refresh I'm OK). It can be optimised as in the stable
branch where we try git-apply followed by a three-way merge (which,
BTW, I'd like added before 0.15). If git-apply succeeds, there is no
need to re-generate the diff.

--=20
Catalin
