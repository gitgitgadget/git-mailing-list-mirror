From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: git replace: should it check for object type, and can it replace merges?
Date: Mon, 5 Aug 2013 17:07:37 +0100
Organization: OPDS
Message-ID: <2A84813A5DBF494391F94A840C228278@PhilipOakley>
References: <24928554D0C34B4696DAD74F569E2E17@PhilipOakley> <CAP8UFD3yHMKfBdjHc6CxeAXSdQ=ua1MddAb5rRXV3TU0ZW7g6w@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Christian Couder" <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 18:07:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6NJf-0004T3-1C
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 18:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754125Ab3HEQHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 12:07:19 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:29164 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753699Ab3HEQHQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Aug 2013 12:07:16 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AlQLAMPM/1FOl3kA/2dsb2JhbABbgwY1gneGJ7YeBAEDAYEhFnSCHwUBAQQBCAEBHREfASEFBgIDBQIBAw0HAQMJJRQBBAgSDRcGEwgCAQIDAYdtAwkKCKxBDYhejSeBVQIDGQh3gyB0A4hyhg6GdgGDE4UehWCFJ4MYOw
X-IPAS-Result: AlQLAMPM/1FOl3kA/2dsb2JhbABbgwY1gneGJ7YeBAEDAYEhFnSCHwUBAQQBCAEBHREfASEFBgIDBQIBAw0HAQMJJRQBBAgSDRcGEwgCAQIDAYdtAwkKCKxBDYhejSeBVQIDGQh3gyB0A4hyhg6GdgGDE4UehWCFJ4MYOw
X-IronPort-AV: E=Sophos;i="4.89,819,1367967600"; 
   d="scan'208";a="433070879"
Received: from unknown (HELO PhilipOakley) ([78.151.121.0])
  by out1.ip03ir2.opaltelecom.net with SMTP; 05 Aug 2013 17:07:14 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231668>

From: "Christian Couder" <christian.couder@gmail.com>
> Hi,
> On Sat, Aug 3, 2013 at 5:13 PM, Philip Oakley <philipoakley@iee.org> 
> wrote:
>> A recent comment http://stackoverflow.com/a/18027030/717355 on a 
>> question I
>> asked two years ago about 'grafts' and 'replace' indicates that users 
>> think
>> that 'git replace' can't replace a merge commit. The documentation 
>> doesn't
>> have any examples and gives the naive impression that one should only
>> replace a simple commit with another simple commit.
>
> I am sorry if the documentation gives this impression.
> I'd like to fix it, but I am not sure what should be changed.
> Should adding an example be enough? Or do you want it to state that 
> explicitely?
>
I did a quick markup which is shown below (an export of the commit from 
the gitk viewer)

>> Having looked at the code, I realised that anything can be replaced 
>> with
>> anything, which is perhaps not what was intended.
>
> The documentation says in the "BUGS" section:
>
> "And of course things may break if an object of one type is replaced
> by an object of another type (for example a blob replaced by a
> commit)."

I hadn't seen that part, being 'hidden' at the end of the paragraph 
(that is, it's easy to miss;-). If my update was acceptable then that 
sentence could probably be deleted (though it may require the checks to 
actually be in the code, and not just a "must" imperative in my 
documentation update).

>
> So yes it is a know bug.
>
>> A simple thought is that
>> the replace should be like-for-like with regard to object type, 
>> though that
>> would not include replacing a sub-module for a tree (and vice versa).
>>
>> Should 'git replace' check the object types to ensure they are 
>> sensible?
>
> It would probably be a good idea to do that, yeah.
> But I don't know much about submodules, so I can't say if replacing a
> sub-module for a tree (and vice versa) should be allowed.
> Or if there should be a --force-different-objects option for these
> kinds of special cases.

An extra bit of thought made me realise that while a sub-module is 
represented as a special symbolic commit, it is still just an element of 
a tree object, so would still be a tree <-> tree replacement, so doesn't 
break the rule.

>
>> Would it be reasonable to add examples to indicate the range of
>> replacements, and how to prepare alternative merge commits, or is 
>> that a
>> hostage to fortune?
>
> Yeah, adding examples would be a good idea. I don't understand what do
> you mean with "range of replacements", though.

There were in two parts: 1) creating a replacement merge commit, and 2) 
creating a replacement tree,  possibly with a sub-module in it.

>
> I am not sure preparing alternative commits or merge commits should be
> an important part of the examples.
>
> There are many cases that could be interesting to different users:
>
> - replacing a non merge commit with a merge commit (if someone forgot
> to use --no-ff when merging for example)
> - replacing a merge commit with a non merge commit (if a rebase should
> have been done)
> - and of course replacing a non merge commit with a non merge commit,
> or a merge commit with a merge commit
>
> So I think explaining how another commit can be created from existing
> commits belongs to some other parts of the git documentation.

Yes, I just haven't looked yet. I think there are some examples in the 
plumbing command man pages. They'd just need referencing.

> Perhaps there could be such examples in the git hash-object and git
> filter-branch documentation and we could just point to them.
>
> Best,
> Christian.
> --

My quick markup, based on a local branch.
---8<---
commit c12c03462f8c65a593e702896b461f1c63d67ec5
Author: Philip Oakley <philipoakley@iee.org>
Date:   Sat Aug 3 20:20:05 2013 +0100

    Doc: 'replace' the same object type, and mention merge commits

    Signed-off-by: Philip Oakley <philipoakley@iee.org>

diff --git a/Documentation/git-replace.txt 
b/Documentation/git-replace.txt
index e0b4057..2ab451c 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -20,6 +20,10 @@ The name of the 'replace' reference is the SHA-1 of 
the object that is
 replaced. The content of the 'replace' reference is the SHA-1 of the
 replacement object.

+The type of the replacement object must be the same as that of the
+object it replaces. Merge commits can be replaced by non-merge commits
+and vice versa.
+
 Unless `-f` is given, the 'replace' reference must not yet exist.

 Replacement references will be used by default by all Git commands
--->8---

Philip 
