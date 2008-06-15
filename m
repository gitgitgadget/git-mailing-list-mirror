From: Luke Lu <git@vicaya.com>
Subject: Re: RFC: rebase without pain
Date: Sun, 15 Jun 2008 12:36:34 -0700
Message-ID: <C8DA824B-97D6-46FB-8CD4-F66458FBC7B2@vicaya.com>
References: <5B4BD573-8C89-4E27-8ADB-F870EA503D00@vicaya.com> <20080614111758.GB5737@dpotapov.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 15 21:38:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7y3E-000815-UE
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 21:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbYFOTgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 15:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbYFOTgl
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 15:36:41 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:8891 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbYFOTgk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 15:36:40 -0400
Received: by wr-out-0506.google.com with SMTP id 69so2844915wri.5
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 12:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer:sender;
        bh=xn4Hrur20CXRMdqhd/VKMVIhGf+9UKbIiesBun+efZU=;
        b=GlZjBrIOlutyTt11nBl01Q1rGdsjUNZsk6UozR9ivlf4NLgB5Y/JeZNo/5IrOl98u9
         rQSRDGjOScumPnxWaY92F+Frueyy+ajvk1oITHM5QRsAD1LqZ1tUkzdc8obwaI6+frrj
         vLF+Xhp1KdAxXrRMPOwj5uWLXWzX3tlXVoQj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer:sender;
        b=Pvte0jDUmFhF5h8mxxrUBdJuurhB2ET5xrCgFOQpGbe69QyJyP+em4YOSZY8YjbSng
         PXNyjRa6gg4o2sr9fAT/4Ub6yabaw1JrUybg93P5+i/wgc3jz9fbU463mstg275mnKCH
         D4wAyF5uUNMKio/p/7yxN2HFz3L3Wf3R3hm/I=
Received: by 10.90.87.7 with SMTP id k7mr2449200agb.47.1213558598271;
        Sun, 15 Jun 2008 12:36:38 -0700 (PDT)
Received: from ?192.168.7.9? ( [71.198.200.243])
        by mx.google.com with ESMTPS id 5sm8340944ywd.2.2008.06.15.12.36.35
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 15 Jun 2008 12:36:37 -0700 (PDT)
In-Reply-To: <20080614111758.GB5737@dpotapov.dyndns.org>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85109>

On Jun 14, 2008, at 4:17 AM, Dmitry Potapov wrote:
> On Fri, Jun 13, 2008 at 06:38:44PM -0700, Luke Lu wrote:
>> This may have been discussed before, but I could not find it. If  
>> so, I
>> apologize for the noise and hope somebody is working on the issue.
>
> I think we have had a somewhat similar discussion not so long ago.
> It was called "inexplicable failure to merge recursively across
> cherry-picks". I think you can find it here:
> http://kerneltrap.org/mailarchive/git/2007/10/9/333729
>
> Please, read carefully this Linus' posts:
> http://kerneltrap.org/mailarchive/git/2007/10/10/334129
> http://kerneltrap.org/mailarchive/git/2007/10/11/335451

Thanks for the pointers, Dmitry. They are indeed illuminating. I  
actually agree with Linus on all accounts here.

>> Based on my observation, rebase is the single most interesting and
>> misunderstood feature in git compared with other VCS. Once I
>> discovered rebase -i, I can't stop using it, because I'd like to keep
>> my history clean for readability and maintenance purpose.
>
> The downside of rebase is that you are *re-writing* branch history.

I think the word "history" is too overloaded in VCS world. Sometimes  
it really means the actually chronological steps developer performed  
to solve a problem. Sometimes it just means a portion of commit/patch  
DAG, that is, a series of transformations (or functions if you prefer)  
that given an input (e.g., a parent of a tree) will produce a  
deterministic outcome. The two semantics are actually orthogonal,  
despite the fact they're often identical in reality. I think it's a  
misuse of the word "history" here, when you actually mean a set of  
patches. You can never rewrite history by definition of the original  
meaning of history because you can't turn back time. The real history  
of git is kept in the reflog.

Rebasing is rewriting a set of patches. It's a form of  
(meta)programing to compose and decompose features. The problem of  
rebasing (in addition to merge) is that we don't have proper tools to  
track rebase itself. Even though the history is in the reflog, the  
information is only kept temporarily and not propagated and used  
through fetch/merge.

> It
> is okay when you do that in your private branch, but when you publish
> something there is no way back. It is like when you prepare on some
> article, you can make a lot of drafts but when you publish it then
> it is published. Any attempt to falsify history will cause a lot of
> confusion.

I think the confusion mainly comes from the conflation of meanings of  
the word "history" and merge conflicts that result from lack of tool  
support.

> Also, please, notice that even if a branch was rebased
> without a single conflict, it does not mean that it will work.

The same applies to usual merges as well. The advantage of merge is  
that it maintains the original ancestry of the commits, so it's  
relatively easy to visualize and debug merge problems.

> So, you can break things just by rebasing

So can you by just straight merging.

> and it will be impossible to
> find later who caused the breakage.

Yes, that's the real problem. But it's mainly caused by lack of tools  
to track rebase. I think we should probably put a 'rebase' node in the  
commit just like merge. The rebase commit will contain enough  
information to track the rebase. git log can display who did the  
rebase and gitk can even visualize the graph transformation.

> Sometimes, even if the final state after rebase is working, the  
> intermediate commits may not work
> or even not compile.

Yes, that's another problem, but with rebase -i, we can hopefully fix  
them :)

> So, I don't think that rebasing published history is a good idea.

Yes, rewriting published patch set (again you can't rewrite history,  
public or not) without proper tool to track them is definitely not a  
good idea. But don't you think we need to develop tools to track  
rebase properly?

One common use case would be maintaining a patch set against a release  
point. It's already a common practice with or without VCS support:  
People release some software version n, then release a giant patch to  
cover several bugs; later on, they realize that they need to split the  
patch for each bug and vice versa. That's rebase right there. But  
people are not really confused because they know they need to reapply  
the patch set against an official release.

You can't do that easily with git by simply pulling from upstream, yet.

__Luke
