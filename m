X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: sf <sf-gmane@stephan-feder.de>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 02 Dec 2006 00:34:31 +0100
Message-ID: <4570BC07.4080203@stephan-feder.de>
References: <20061201110032.GL18810@admingilde.org> <45701B8D.1030508@b-i-t.de> <20061201121234.GQ18810@admingilde.org> <4570289D.9050802@b-i-t.de> <20061201133558.GU18810@admingilde.org> <45703375.4050500@b-i-t.de> <20061201145817.GY18810@admingilde.org> <45704EA3.40203@b-i-t.de> <20061201165418.GD18810@admingilde.org> <45706758.2020907@b-i-t.de> <20061201184801.GG18810@admingilde.org>
Reply-To: sf-gmane@stephan-feder.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 23:37:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.4 (X11/20060606)
In-Reply-To: <20061201184801.GG18810@admingilde.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32988>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqHw7-00066g-14 for gcvg-git@gmane.org; Sat, 02 Dec
 2006 00:36:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162243AbWLAXf4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 18:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162254AbWLAXfM
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 18:35:12 -0500
Received: from mail.medianet-world.de ([213.157.0.167]:49541 "HELO
 mail.medianet-world.de") by vger.kernel.org with SMTP id S1162379AbWLAXee
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 18:34:34 -0500
Received: (qmail 12015 invoked by uid 1011); 1 Dec 2006 23:34:33 -0000
Received: from sf-gmane@stephan-feder.de by mail1 by uid 1003 with
 qmail-scanner-1.22  (ExcuBAtor: 1.0.2. 
 Clear:RC:1(213.157.24.137):SA:0(0.6/5.0):.  Processed in 0.623868 secs); 01
 Dec 2006 23:34:33 -0000
Received: from unknown (HELO mx.stephan-feder.de) (213.157.24.137) by
 mail.medianet-world.de with SMTP; 1 Dec 2006 23:34:32 -0000
Received: from [192.168.3.69] (unknown [192.168.0.2]) by mx.stephan-feder.de
 (Postfix) with ESMTP id 1334588B01; Sat,  2 Dec 2006 00:34:32 +0100 (CET)
To: Martin Waitz <tali@admingilde.org>
Sender: git-owner@vger.kernel.org

Martin Waitz wrote:
> On Fri, Dec 01, 2006 at 06:33:12PM +0100, Stephan Feder wrote:
>> We are in agreement about two fundamental parts of the implementation 
>> and their meaning:
>>
>> 1. A submodule is stored as a commit id in a tree object.
>>
>> 2. Every object that is reachable from the submodule's commit are 
>> reachable from the supermodule's repository.
> 
> Correct.

Good. For me that is the main point. As I said before the user interface
is not so important because it can be changed anytime, but to change the
object database later is close to impossible.

...
> Let's see if I understand you correctly:
> 
> You don't want to create an additional .git directory for the submodule
> and just handle everything with one toplevel .git repository for the
> whole project.

Yes.

> Without the .git directory, you of course do not have refs/heads inside
> the submodule.

Correct..

> So this is a different user-interface approach to submodules when
> compared to my approach.  But the basis is the same and both could
> inter-operate.

Big YES.

> Now your submodule is no longer seen as an independent git repository
> and I think this would cause problems when you want to push/pull between
> the submodule and its upstream repository.

You can always pick a single commit or several commits out of a larger
repository and have a complete git repository.

And I already explained how to push and pull even from within superprojects.

> No technical problems, but UI-problems because now your submodule is
> handled completly different to a "normal" repository.

Yes and no. You can always have branches that are only concerned with
submodules' code, say, in refs/heads/submodules/<submodule>/.
"submodules" here is simply an example and has not deeper meaning. You
could call it foo or whatever you like. Or you could use
refs/heads/<submodule>/ if it suits you.

But if you mean the submodule as seen from the supermodule, then there
is a difference. Naturally, because the concept of submodules is new to git.

>>> Yes, but if it would have been integrated as a submodule it obviously
>>> would have been committed to the xdiff submodule inside the git
>>> repository.
>> No. The xdiff submodule would only exist as part of the git repository. 
> 
> But you could still call the "xdiff" part of the git repository a
> submodule.  And then changes to the xdiff directory result in a new
> submodule commit, even when there is no direct reference to it.
> So you'd still "commit to the xdiff submodule".

Let's make certain that we understand each other. I see a clear
distinction between the submodule code in a supermodule branch (commits
in the supermodule's tree and nothing else) and submodule branches which
are independent of the superproject. Supermodule branches and submodule
branches do not interact, only if I want them to.

> 
>> You could, f.e., access the xdiff commit in git HEAD as HEAD:xdiff// 
>> (again my proposed syntax). HEAD:xdiff//~2:xemit.c would give you the 
>> grandparent of xemit.c in the xdiff submodule.
> 
> git-cat-file commit HEAD:xdiff already works out of the box (even
> cat-file tree to get the submodule tree).  But up to now revision
> parsing follows the file name only once.
> 
> What about just separating things with "/"?
> 
> commit HEAD
> tree   HEAD/
> blob   HEAD/Makefile
> commit HEAD/xdiff
> tree   HEAD/xdiff/
> blob   HEAD/xdiff~2/xemit.c
> 
> this may add some confusion when used with hierarchical branches, but
> it's still unique:
> 
> 	refs/heads/master/xdiff/xemit.c
> 
> Just use as many path components until a matching reference is found,
> then start peeling.
> Or just use / between super and submodule:
> 
> 	refs/heads/master:xdiff/xemit.c
> 
> I think this is easier to read then
> 
> 	refs/heads/master:xdiff//:xemit.c

The double slashes is the only way I can think of that clearly indicates
that I do not mean the contents named by the path, but the commit that
you find there. Once you have named a commit in that way, you can
continue to apply other revision naming suffixes, paths, and so on.

Let's try. What does git cat-file -p
master:dir/sub//^^^:sub/dir/sub//^:dir/file mean?

Explanation: Take branch master and go to path dir/sub. There you will
find a commit. Take its grand-grandparent and go to path sub/dir/sub
(the first sub is a subproject as well but we do not care). There you
will, again, find a commit. Take its parent and go to path dir/file
which happens to be a blob the contents of which you want to cat.

In reality you will never see these kinds of complex paths. Have you
ever seen something like git cat-file -p
bd2c39f58f915af532b488c5bda753314f0db603~12^{commit}^2^5~8^2~308:README ?

>> If you mean the submodule repository created by init-module I 
>> understand. But why create this "helper repository at all"?
> 
> Because it helps "normal" git operations ;-)


Let's see. I still have to try.

Regards

