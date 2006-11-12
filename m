X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: when is a remote a branch?
Date: Sun, 12 Nov 2006 18:31:18 +0100
Message-ID: <200611121831.18851.jnareb@gmail.com>
References: <ej7fra$8ca$2@sea.gmane.org> <ej7h1n$ed8$1@sea.gmane.org> <20061112163624.GE7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 12 Nov 2006 17:31:01 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=l40/67NeFTyoDBfvpAG/MHJRDah0GbXQqnJwz/MDNA0Flrq6M2BUybZ9zhIU6AZ4RW8QwhwBGLLJMLiNPMwOB1GktspCWPrIBR/btCe7aMquljYAdxJ78sg795ENILI3GrblTRZ7QP/5eIgAwJr7Wl+UlaIVNih1uSdKLQjECM8=
User-Agent: KMail/1.9.3
In-Reply-To: <20061112163624.GE7201@pasky.or.cz>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31267>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjJA4-00054B-UV for gcvg-git@gmane.org; Sun, 12 Nov
 2006 18:30:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933028AbWKLRa0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 12 Nov 2006
 12:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933030AbWKLRaZ
 (ORCPT <rfc822;git-outgoing>); Sun, 12 Nov 2006 12:30:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:28204 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S933028AbWKLRaZ
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2006 12:30:25 -0500
Received: by ug-out-1314.google.com with SMTP id m3so891240ugc for
 <git@vger.kernel.org>; Sun, 12 Nov 2006 09:30:23 -0800 (PST)
Received: by 10.66.242.5 with SMTP id p5mr6744955ugh.1163352623154; Sun, 12
 Nov 2006 09:30:23 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id 72sm4616204ugb.2006.11.12.09.30.22; Sun, 12 Nov
 2006 09:30:22 -0800 (PST)
To: Petr Baudis <pasky@suse.cz>, Anand Kumria <wildfire@progsoc.org>
Sender: git-owner@vger.kernel.org

Petr "Pasky" Baudis wrote:
> On Sun, Nov 12, 2006 at 05:11:41PM CET, Jakub Narebski wrote:
>> Read Documentation/repository-layout.txt (ot it's HTML version, either
>> locally ot at www.kernel.org).
>> 
>>  branches::
>>          A slightly deprecated way to store shorthands to be used
>>          to specify URL to `git fetch`, `git pull` and `git push`
>>          commands is to store a file in `branches/'name'` and
>>          give 'name' to these commands in place of 'repository'
>>          argument.
>> 
>> You can store only one branch to fetch per shorthand. I'm not sure about
>> where it is stored which branch to download, and how to name this branch 
>> locally.
> 
> I think the above is quite confusing description. This really is not
> about any "shorthands" at all, but just about branches (how the name
> implies, after all).

Well, it is a shorthand in a way that you can just use "git fetch"
or "cg fetch" to fetch correct branch without need for URL.

But I agree that the description (although of deprecated feature)
could be better.

> Git and Cogito share the same models of branches. These branches are
> 'heads' with commit pointers stored in refs/heads/, etc. 

Not exactly. "Live" branches (i.e. branches you can commit to) are head
refs stored in refs/heads/. But in repository cloned with git-clone
--use-separate-remotes tracking heads (tracking branches) would be at
refs/remotes/<remotename>/. You can fetch to such a ref, but you can't
checkout it, nor commit to it.

> The branches/ 
> directory says that some branches do not correspond to local development
> (and should never be used for that) but instead they correspond to a
Does that _should_ is enforced in Cogito? Is it enforced in Git?

> particular branch in some remote repository. Such branches are called
> "REMOTE BRANCHES".

I'd rather call them "tracking branches", at least in git. So if there
is branch 'localbranch' in refs/heads/ (?), and there is corresponding
branches file branches/localbranch, which contains a single URL
  git://host.domain/path/to/repository#remotebranch
it is AFAICU equivalent to having some remotes file, named e.g. 'repo',
with the following contents:
  URL: git://host.domain/path/to/repository
  Pull: remotebranch:localbranch
  Push: remotebranch:localbranch
or equivalent entry in git config.

> So it's "if branch X has corresponding .git/branch/X file, it's not a
> local branch but instead a REMOTE BRANCH corresponding to the URL stored
> in that file". That simple. The URL is address of the repository plus
> optionally a '#branchname' if the branch name in the remote repository
> should not default to remote HEAD or master.

The whole concept of branches file (and marking some branches as "remote"
branches) is IMHO from the times where there were most common to have one
live branch per repository, and we fetched and pushed single branches.
This simple picture changed with more widespread use of multiple heads,
and with the introduction of tags (I think).
 
> In addition, Git (not Cogito at this point) supports a completely
> different and unrelated abstraction called REMOTES. They don't have
> anything to do with branches. Instead, a REMOTE represents a repository
> URL and a set of local/remote branch pairs to handle on pulls and
> pushes; it has no other obvious mapping to branches and branches can be
> even shared between various REMOTES etc. (this is changing lately with
> the refs/remotes/ hierarchy, but I think that's still not in wide use).

Remote is usually a repository. It is single URL (although it would be
nice to be able to specify alternate URLs for the same repository, or
for different mirrors of the same repository) representing repository
to fetch from/to push to, together with branches we want to fetch (which
parts of DAG we want to fetch), and local names of those branches,
following fetched contents.

By the way, with introduction of branches and remotes in config file,
you can say:
 [branch "localbranch"]
	remote = someremote

 [remote "someremote"]
	fetch = remotebranch:localbranch
	push  = remotebranch:localbranch

and that would be equivalent to example branches file from the beginning
of this email.
-- 
Jakub Narebski
