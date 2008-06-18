From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 03/14] Write to a stack log when stack is modified
Date: Wed, 18 Jun 2008 14:03:51 +0100
Message-ID: <b0943d9e0806180603h59187f7epc5014f36d070cec7@mail.gmail.com>
References: <20080612052913.23549.69687.stgit@yoghurt>
	 <20080612053424.23549.64457.stgit@yoghurt>
	 <b0943d9e0806170324j12605a55m41b582ad09925cce@mail.gmail.com>
	 <20080617123138.GA6932@diana.vm.bytemark.co.uk>
	 <b0943d9e0806170711w6da8e841p3ac83a59a81f6577@mail.gmail.com>
	 <20080617153247.GA12520@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 15:04:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8xLD-0003ge-Sh
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 15:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759AbYFRNDw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Jun 2008 09:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753843AbYFRNDw
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 09:03:52 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:63470 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753629AbYFRNDv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2008 09:03:51 -0400
Received: by rv-out-0506.google.com with SMTP id k40so4578304rvb.1
        for <git@vger.kernel.org>; Wed, 18 Jun 2008 06:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=cW6ZOh9rJLFc/b2hKyst0jNMWvgZF+I+o2yzMLyzYwI=;
        b=wlewoQfwwiThwvYDsA9HNxZ/+tdbADR4Q1/h3a3Lf0OHpjOzUSRr9EZ7Nf7dmvq3kY
         JyqxkgtNUYGrSUQ6/JQDcTiXkwocoV1yKU83zBJTYrVlzbEyxakHuZy0F9rBYyZy0zCa
         bsTvzBVZzibT/uhN/h+M4kXbLuVC2mzeXkQkk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=CiDHwy11yyTg/P5dX5MIdCHx61g+ijBtIkrRCLdHQcCC05G814/kDLdSGvqQyWc5+D
         ndGXOzqwgNWLWDGB2JgN6FjQ3uXjuYjIKkYdvWU7gx5U2hIsAKcooz8wjl+axfTotjbm
         yYPBsKRKnzhprvCPUk6bV2G/hxd64NmE7wfRI=
Received: by 10.114.24.1 with SMTP id 1mr681409wax.74.1213794231191;
        Wed, 18 Jun 2008 06:03:51 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Wed, 18 Jun 2008 06:03:51 -0700 (PDT)
In-Reply-To: <20080617153247.GA12520@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85378>

2008/6/17 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-06-17 15:11:42 +0100, Catalin Marinas wrote:
>
>> 2008/6/17 Karl Hasselstr=F6m <kha@treskal.com>:
>>
>> > On 2008-06-17 11:24:53 +0100, Catalin Marinas wrote:
>> > > The main question. Is this history preserved after a git-gc?
>> >
>> > Yes. It's stored in a regular git branch. (The design is such that=
 it
>> > should even be possible to pull a stack log from another repositor=
y
>> > and _still_ get everything you need.)
>>
>> But how are the patches recreated when undoing (the
>> refs/patches/<branch>/* files)? Using the Bottom/Top tree ids that a
>> patch had in the past? Are these trees still present after a git-gc?
>
> The log actually _contains_ those trees, so there is no problem.

OK, I begin to understand. It is a generic solution for storing
metadata but IMHO it is too overweight when we only need a list of
applied and unapplied files (we can remove hidden) that could be
easily stored in a commit log. It would be useful to run a quick
benchmark with many (hundreds) of patches and compare it with no
logging variant (or the current patch logging, which isn't as
advanced).

Could we not make this (much) simpler? I.e. <branch>.stgit is a commit
object whose tree is <branch>^{tree} and the message contains the
command followed by list of patches in the form "<commit> <patch>"?
This commit can have two parents - the previous <branch>.stgit and
current <branch> head. All the patches are referred via the <branch>
head or the previous <branch> heads if unapplied (assuming that when a
patch is created it is first applied and then popped, maybe this needs
a bit of thinking). This way, a diff between subsequent <branch>.stgit
commits would show the tree changes. The 'stg log' command could be
made to show differences in the commit messages.

>> > It shows you diffs between subsequent revisions of the simplified
>> > log. I'm sure it's far from perfect, but I think it's actually
>> > quite useful.
>>
>> It is useful, though it might take a bit of time to get used to it.
>
> Yes, much like diffs take some time to get used to if you haven't see=
n
> them before.
>
> If you have ideas for a better way to visualize this, I'm all ears.

The diff of diffs is generally useful but for 'refresh' logs, you can
show the diff between the old top tree and the new one (the current
patch log implementation does something like this but it doesn't show
anything for commands like 'push' where a diff of diffs would be more
appropriate).

--=20
Catalin
