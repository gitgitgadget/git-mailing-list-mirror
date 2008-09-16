From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Convert "sink" to the new infrastructure
Date: Tue, 16 Sep 2008 15:59:31 +0100
Message-ID: <b0943d9e0809160759w5c9be510t3b33d5d983bff5a7@mail.gmail.com>
References: <20080912215613.10270.20599.stgit@localhost.localdomain>
	 <20080914085118.GC30664@diana.vm.bytemark.co.uk>
	 <b0943d9e0809141419q6facb21at627e658805f1d223@mail.gmail.com>
	 <20080915075740.GB14452@diana.vm.bytemark.co.uk>
	 <b0943d9e0809150944o71acafe7ndeda500b1fba97df@mail.gmail.com>
	 <20080916074024.GA2454@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3057_25350726.1221577171531"
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 17:00:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfc2l-0005zy-Ho
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 17:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840AbYIPO7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 10:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753576AbYIPO7d
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 10:59:33 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:52826 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343AbYIPO7c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 10:59:32 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2719756rvb.1
        for <git@vger.kernel.org>; Tue, 16 Sep 2008 07:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type:references;
        bh=d2kvCBLA9xLU56TuQoAiQ/rZMSdTtjktG2ElxqtQugU=;
        b=pWB3DQeKS1phVhiYCWOqNHUyQ7SjzrQs/6bAgHgcmVwLbxd2jVyveD7O5TdyNWI5P7
         4u+CZ6OCakINLCGSmZUVrlRxBo8KWpv+bLaBPcphEQxRTXTG5+1zFLEbDrI7KVyERmwW
         M2Pg3Tj9R1+0HgXrq+Dg4ZbR4l+dAKx2OrFX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:references;
        b=svS0eVAxainYvCqkclqP8DgK5c5oRA2Ld9DLTwoU9MFilxK8ImRnuvMdW2mVALGne4
         6SvI+pDp5pn9j5fnOmy7XEPU7ezKZNhsEVMHBNjGMhwmjapB88CrX9NDHKzTKsZgc73r
         wuaWmXT1Dd9vO9VHVwhlNWNWCVIxe/9+qXGQQ=
Received: by 10.141.71.14 with SMTP id y14mr5719918rvk.253.1221577171528;
        Tue, 16 Sep 2008 07:59:31 -0700 (PDT)
Received: by 10.140.199.1 with HTTP; Tue, 16 Sep 2008 07:59:31 -0700 (PDT)
In-Reply-To: <20080916074024.GA2454@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96008>

------=_Part_3057_25350726.1221577171531
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

2008/9/16 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-09-15 17:44:38 +0100, Catalin Marinas wrote:
>
>> Since we are talking about this, the transactions documentation
>> doesn't explain when to use a iw and when to pass allow_conflicts. I
>> kind of figured out but I'm not convinced. At a first look, passing
>> allow_conflicts =3D True would seem that it may allow conflicts and not
>> revert the changes, however, this only works if I pass an "iw". But
>> passing it doesn't allow the default case where I want the changes
>> reverted.
>
> In my experimental branch, one of the patches adds the following piece
> of documentation:
>
> +        @param allow_conflicts: Whether to allow pre-existing conflicts
> +        @type allow_conflicts: bool or function of L{StackTransaction}""=
"
>
> That is, allow_conflicts decides whether to abort the transaction in
> case there already were conflicts -- undo and friends need to allow
> existing conflicts, but most other commands just want to abort in that
> case.

OK, it is clearer now.

> iw is the index+worktree object. The idea is that you provide one if
> your branch is checked out, and not if not. Operations that have no
> need of index+worktree, like pop, and push in case automatic merging
> succeeds, will just work anyway, while operations that need
> index+worktree, such as a conflicting push, will cause the whole
> transaction to abort.

Ah, that's the difference. I thought that even if iw isn't passed, it
uses the default one.

> ( Oh, and note that what I just said talks about the "patch stack
>  log", meaning that I'm talking about the code in kha/experimental.
>  The code in kha/safe doesn't look quite the same -- in particular,
>  there's no obvious place to place code that ignores the conflicting
>  push. Unless you really don't want your sink changes to depend on
>  the stack log stuff (e.g. because you doubt you'll be merging it
>  anytime soon), I suggest we do this: I'll prepare, and ask you to
>  pull, a "stacklog" branch, and once you've pulled it we won't rebase
>  it anymore. You can merge it directly to your master or publish it
>  as a separate development branch, whichever you feel is best. )

I think we could merge your experimental branch into master. I gave it
a try and seems OK. The only issue I had was that I had an older
version of Git and it failed in really weird ways (stg pop still
busy-looping after 4 minutes and in another case it failed with broken
pipe). Once I pulled the latest Git, it was fine but we should try to
be compatible at least with the Git version in the Debian testing
distribution. It might be the patch at the top with diff-ing several
trees at once but I haven't checked.

BTW, I ran some benchmarks on stable/master/kha-experimental branches
with 300 patches from the 2.6.27-rc5-mm1 kernel. See attached for the
results. Since performance was my worry with the stack log stuff, it
turns out that there isn't a big difference with real patches. I think
pushing can be made even faster by trying a git-apply first and taking
the diff from the saved blobs in the log.

>> I would rather add support for patch dependency tracking (which used
>> to be on the long term wish list). It might be useful for other
>> things as well like mailing a patch together with those on which it
>> depends (like darcs).
>
> Do you mean automatically detected dependencies, or dependencies that
> the user has told us about?

Automatic dependency - if two patches cannot be reorder with regards
to each-other, one of the depends on the other.

>> +    if options.conflict:
>> +        iw =3D stack.repository.default_iw
>> +    else:
>> +        iw =3D None
>
> As I said above, this doesn't (or at least isn't supposed to) work.

It should work since the trans.run() command without iw is equivalent
to trans.run(iw=3DNone).

> Have you seen the reorder_patches() function last in transaction.py?
> It seems you could save a lot of work here by using it.

No, I haven't. I'll have a look.

>> +    except transaction.TransactionHalted:
>> +        if not options.conflict:
>> +            raise
>
> Not catching TransactionHalted will have the effect of rolling back
> the whole transaction if it stops half-way through. But what you
> really wanted was the new flag I described above, I think.

OK, if you prepare the stack log, I'll merge it and have a look.

Thanks.

--=20
Catalin

------=_Part_3057_25350726.1221577171531
Content-Type: text/plain; name=stack-log-benchmarks.txt
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fl6nhgj70
Content-Disposition: attachment; filename=stack-log-benchmarks.txt

Q1BVOiBJbnRlbCBQZW50aXVtIDQgQCAyLjVHSHoKTWVtb3J5OiAxR0IKCjIuNi4yNy1yYzUtbW0x
IGtlcm5lbCwgMzAwIHBhdGNoZXMgdW5jb21taXR0ZWQKCnBvcC9wdXNoIHJhbiBhIGZldyB0aW1l
cyB0byBoZWF0IHRoZSBjYWNoZXMgYmVmb3JlIHJ1bm5pbmcgdGhlCmJlbmNobWFya3MuCgoKU3Rh
YmxlIHN0Z2l0ICh2MC4xNC4zICsgc29tZSBmaXhlcykKCiQgdGltZSBzdGcgcG9wIC1hCgpyZWFs
CTBtMS43NzVzCnVzZXIJMG0wLjk1NnMKc3lzCTBtMC43MjRzCgokIHRpbWUgc3RnIHB1c2ggLWEg
KGZhc3QtZm9yd2FyZCkKCnJlYWwJMG01LjAwMXMKdXNlcgkwbTEuODQ0cwpzeXMJMG0yLjg2MHMK
CiQgdGltZSBzdGcgcHVzaCAtYSAobm8gZmFzdC1mb3J3YXJkKQoKcmVhbAkxbTI3LjEzM3MKdXNl
cgkwbTM2Ljk5OHMKc3lzCTBtMzQuODk0cwoKCkN1cnJlbnQgc3RnaXQgbWFzdGVyIChubyBzdGFj
ayBsb2cpOgoKJCB0aW1lIHN0ZyBwb3AgLWEKCnJlYWwJMG0xLjYyMXMKdXNlcgkwbTAuODIwcwpz
eXMJMG0wLjY4OHMKCiQgdGltZSBzdGcgcHVzaCAtYSAoZmFzdC1mb3J3YXJkKQoKcmVhbAkwbTI3
LjIwNXMKdXNlcgkwbTguNzQxcwpzeXMJMG0xNi44NDlzCgokIHRpbWUgc3RnIHB1c2ggLWEgKG5v
IGZhc3QtZm9yd2FyZCkKCnJlYWwJMm04LjIwOXMKdXNlcgkwbTQ2LjAzMXMKc3lzCTBtNTcuMjYw
cwoKCmtoYS9leHBlcmltYW50YWwgc3RnaXQgKHdpdGggc3RhY2sgbG9nKToKCiQgdGltZSBzdGcg
cG9wIC1hCgpyZWFsCTBtMi40MTlzCnVzZXIJMG0xLjE0NHMKc3lzCTBtMS4xMzJzCgokIHRpbWUg
c3RnIHB1c2ggLWEgKGZhc3QtZm9yd2FyZCkKCnJlYWwJMG0yOS41OTRzCnVzZXIJMG05LjIxN3MK
c3lzCTBtMTcuMTQ1cwoKJCB0aW1lIHN0ZyBwdXNoIC1hIChubyBmYXN0LWZvcndhcmQpCgpyZWFs
CTJtMTAuMjcwcwp1c2VyCTBtNTAuOTE5cwpzeXMJMW0yLjA4OHMK
------=_Part_3057_25350726.1221577171531--
