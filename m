From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: setting up tracking on push
Date: Sun, 15 Mar 2009 08:36:31 -0400
Message-ID: <76718490903150536r2d3e687ckbcc4e1bdb2d2194d@mail.gmail.com>
References: <buofxhr2vta.fsf@dhlpc061.dev.necel.com>
	 <gp9jp7$uc3$1@ger.gmane.org>
	 <76718490903111758l4e4bd29et379e975deb8e99bd@mail.gmail.com>
	 <76718490903111814t1ab90a39h9252d0ccf8af05c4@mail.gmail.com>
	 <4845-91917@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "John M. Dlugosz" <ngnr63q02@sneakemail.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 13:38:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LipbS-0008IX-Cq
	for gcvg-git-2@gmane.org; Sun, 15 Mar 2009 13:38:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754373AbZCOMge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2009 08:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754267AbZCOMgd
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Mar 2009 08:36:33 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:60477 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933AbZCOMgd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2009 08:36:33 -0400
Received: by rv-out-0506.google.com with SMTP id g37so1140468rvb.1
        for <git@vger.kernel.org>; Sun, 15 Mar 2009 05:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=v+5e4XI2ZfBG4JHws6waWk8KQEDTTDGO2RGtp3JWXJc=;
        b=f3L7kXij1nrxwh8VrZUUKv55Y8ZyPvAubJaAXjXcjTV73QPaGJxaja/SGaUBLy22YD
         vqBSv3vnzoud7RNmRA8J3f0978MNAtQA7LnwChe9Lb/ebTDYoAtMUSKQ5yBs1MNaS1Sl
         /tTJgxcIIY38aUegUqK71WRPdY13+aqHKkPrg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=u7ONSn3s9RST9AE2vsPuhiEHB1fW16ufuiE5TxgIoKj+Ft63lBuzrmAxUvU+hEacBg
         jJBcLSkL/YcU7BPnJaapJorJQf9UI2mdABGQ7a7qcnOnNFRJEUzyXNnnqq84ljOeMIDS
         NsE/9bWYAs4jJz651Mb/p5xnuGRsMi0awVcqM=
Received: by 10.141.142.15 with SMTP id u15mr1646248rvn.16.1237120591410; Sun, 
	15 Mar 2009 05:36:31 -0700 (PDT)
In-Reply-To: <4845-91917@sneakemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113286>

On Sat, Mar 14, 2009 at 11:28 PM, John M. Dlugosz
<ngnr63q02@sneakemail.com> wrote:

> Things under refs/remotes are remote tracking branches

Yes.

> and local branches
> (under refs/heads) that automatically updated based on a fetch ("store
> locally" means merge or rebase, right?) are also called remote tracking
> branches.

No. The branches under refs/heads are *not* [1] updated by fetch.

- Anything under refs/remotes is a remote tracking branch.
- Anything under refs/heads is a local branch.

Now, often local branches are based on remote tracking branches, in the
sense that you created the local branch _from_ the remote tracking
branch. So periodically, you will want to update the local branch in
order to incorporate your local changes with whatever changes have been
made in the remote tracking branch. Doing this is a two-step process:

1) You update your remote tracking branches using fetch.
2) You integrate the changes from the remote tracking branches into your
   local branches using either merge or rebase.

> I think that's why some of us are confused.

I remember being just as confused, but oddly it seems so clear to me
now. I think there is an inflection point where git goes from
"confusing" to "ah hah, it's ingenious!" :-)

Let me try to draw a little ascii art:

Local Repo                                  Remote Repo (origin)
----------                                  --------------------
refs/remotes/origin/master  <-- fetch ---   refs/heads/master
        |
(merge or rebase)
        |
        v
refs/heads/master

As changes are made to refs/heads/master on the remote repo, the
corresponding remote tracking branch on the local repo
(refs/remotes/origin/master) will fall behind. Performing a fetch in the
local repo updates its refs/remotes/origin/master to match the remote's
refs/heads/master. Then either merge or rebase in the local repo, while
refs/heads/master is checked out, integrates those changes.

If no changes have been made locally to refs/heads/master, then the
merge operation is a so-called "fast forward".

The confusing part is that there is a switch to "git checkout" and "git
branch" named "--track". A better name would have probably been
"--follow". Regardless, this switch [2], configures branch.<name>.remote
and branch.<name>.merge in the local repo's .git/config. And I mentioned
in a previous message the reason for having these. [3]

[1] You could of course configure fetch to do whatever you like, but it
    would be rather unusual to update refs/heads via fetch.
[2] Which is the default in current git when a local branch is created
    from a remote tracking branch.
[3] Namely, 1) branch -v, status, and checkout tell you how far
    ahead/behind the local branch is from the remote tracking branch;
    2) pull can be run w/o having to explicitly tell it what to fetch
    and what to merge.

j.
