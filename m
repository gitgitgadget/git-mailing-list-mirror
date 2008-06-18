From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 03/14] Write to a stack log when stack is modified
Date: Wed, 18 Jun 2008 17:16:10 +0100
Message-ID: <b0943d9e0806180916m4af3970ck347408661e95663@mail.gmail.com>
References: <20080612052913.23549.69687.stgit@yoghurt>
	 <20080612053424.23549.64457.stgit@yoghurt>
	 <b0943d9e0806170324j12605a55m41b582ad09925cce@mail.gmail.com>
	 <20080617123138.GA6932@diana.vm.bytemark.co.uk>
	 <b0943d9e0806170711w6da8e841p3ac83a59a81f6577@mail.gmail.com>
	 <20080617153247.GA12520@diana.vm.bytemark.co.uk>
	 <b0943d9e0806180603h59187f7epc5014f36d070cec7@mail.gmail.com>
	 <20080618143633.GB30540@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 18:17:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K90LL-0002Op-KR
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 18:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbYFRQQM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Jun 2008 12:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbYFRQQM
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 12:16:12 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:26917 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbYFRQQL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2008 12:16:11 -0400
Received: by wa-out-1112.google.com with SMTP id j37so245695waf.23
        for <git@vger.kernel.org>; Wed, 18 Jun 2008 09:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=SpBpX8Dx4aoEaYlNvBysRGhIIYjNxbSOilnoIV0qVvo=;
        b=kk2Rje+2mTFCVygOaFEge0fMslt3OMRudleI51H9WMqaEs+82mfuvyX2sgxyrhLeCn
         hUjw1wmRqCX0bgwuIpfOb6UP7rw05gq4W9KN0649ZqQt8iqeJEG1HqTJlmxmrIY/mMgz
         v+M6srL6267EjB0YH2IXm9hgeKxTjGObmk5ak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=SrAJdKs9jx+xgu5F2VYKh5aCe1QLTSHd2wxFr26lQWBsoEO5Q/lSRxr6NANmDJ01Td
         +gMQ4xLXSNeLJLBu1FELNDazS+CK77XHHuhcWSMT6zYgUlZ03h5qXlO1RCLo24hg+EFL
         yeDt26eGzrYWyU4BPG7m9/snK3YgH8keP45zk=
Received: by 10.114.39.16 with SMTP id m16mr1018922wam.98.1213805771013;
        Wed, 18 Jun 2008 09:16:11 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Wed, 18 Jun 2008 09:16:10 -0700 (PDT)
In-Reply-To: <20080618143633.GB30540@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85388>

2008/6/18 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-06-18 14:03:51 +0100, Catalin Marinas wrote:
>
>> 2008/6/17 Karl Hasselstr=F6m <kha@treskal.com>:
>>
>> > The log actually _contains_ those trees, so there is no problem.
>>
>> OK, I begin to understand. It is a generic solution for storing
>> metadata
>
> I don't know about "generic" -- it's made specifically for storing an
> StGit stack. You could certainly store just about anything in a git
> tree, but that's also true for a git commit message ...

By generic I meant that it is easily extensible to store other blobs
of whatever you need. As you say, a commit message could be extensible
as well.

>> but IMHO it is too overweight when we only need a list of applied
>> and unapplied files (we can remove hidden) that could be easily
>> stored in a commit log.
>
> Do you mean remove hidden patches from StGit altogether, or just not
> store them in the log?

Remove them altogether. Is there anyone using them apart from me? I
could create a "rotten" branch and pick those patches with
--unapplied.

>> It would be useful to run a quick benchmark with many (hundreds) of
>> patches and compare it with no logging variant (or the current patch
>> logging, which isn't as advanced).
>
> Will do, as soon as I've done some basic optimization. (A simple
> "dirty" flag on each patch will enable us to only write out the log
> for the patches that have actually changed, and reuse the rest from
> the previous log entry.)

It gets too complicated, really. A single commit with the proper
parents could do the job. We could also easily use the commit message
directly for metadata instead of .git/patches/<branch>/.

>> Could we not make this (much) simpler? I.e. <branch>.stgit is a
>> commit object whose tree is <branch>^{tree} and the message contains
>> the command followed by list of patches in the form "<commit>
>> <patch>"? This commit can have two parents - the previous
>> <branch>.stgit and current <branch> head. All the patches are
>> referred via the <branch> head or the previous <branch> heads if
>> unapplied (assuming that when a patch is created it is first applied
>> and then popped, maybe this needs a bit of thinking).
>
> I considered a scheme much like this, but besides the problem with
> (the very few) patches that are created unapplied, it fails badly in =
a
> very important corner case: when you start logging in a pre-existing
> stack. A similar failure will occur if we ever build some sort of log
> pruning (without which the log will grow without limit).
>
> I suppose it would be possible to special-case the very first log
> entry: let it have all patches as ancestors. But I don't really see
> this format as being simpler than the one I use now: all you've done,
> basically, is cram all the data into the commit message instead of
> storing it in the tree. (Benchmarking could certainly prove your
> design superior to mine, however.)

The time to create that tree and blobs worries me a bit, plus the (in
my view) complicated structure.

Making the first log entry special gets difficult with log pruning
(unless you prune the whole log rather than entries older than a
chosen time or number) since you might have to re-create all the
chained log entries as the first log's sha1 will probably change.

The applied patches are chained automatically via HEAD. For unapplied
patches, we could add the correponding commits as parents of the
logging commit (starting with the third parent as the first two are
used for log chaining and applied patches). Do we hit any OS limit
with the number of arguments?

Since we only need the unapplied commits tracking for gc and pull
reasons, we could only create that commit that references them when we
prune the stack log and link it from the top one (but it won't be used
by stgit).

--=20
Catalin
