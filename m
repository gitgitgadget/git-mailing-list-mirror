From: Junio C Hamano <gitster@pobox.com>
Subject: Re: setting up tracking on push
Date: Sun, 15 Mar 2009 11:33:58 -0700
Message-ID: <7v1vsy8wkp.fsf@gitster.siamese.dyndns.org>
References: <buofxhr2vta.fsf@dhlpc061.dev.necel.com>
 <gp9jp7$uc3$1@ger.gmane.org>
 <76718490903111758l4e4bd29et379e975deb8e99bd@mail.gmail.com>
 <76718490903111814t1ab90a39h9252d0ccf8af05c4@mail.gmail.com>
 <4845-91917@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "John M. Dlugosz" <ngnr63q02@sneakemail.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 19:38:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LivE7-0002n7-5L
	for gcvg-git-2@gmane.org; Sun, 15 Mar 2009 19:38:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753441AbZCOSeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2009 14:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbZCOSeI
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Mar 2009 14:34:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39393 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbZCOSeG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2009 14:34:06 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5340CA2581;
	Sun, 15 Mar 2009 14:34:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3094CA257E; Sun,
 15 Mar 2009 14:33:59 -0400 (EDT)
In-Reply-To: <4845-91917@sneakemail.com> (John M. Dlugosz's message of "Sat,
 14 Mar 2009 22:28:36 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DBCA9DA4-118F-11DE-BED5-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113292>

"John M. Dlugosz" <ngnr63q02@sneakemail.com> writes:

> Jay Soffian jaysoffian-at-gmail.com |git| wrote:
>> - The branches under refs/remotes (those shown by "git branch -r") are
>> remote tracking branches. So that tells git fetch where to fetch
>> from, which remote branches to
>> fetch, and where to store those branches locally. In this case, each
>> branch under refs/heads/ on git://git.kernel.org/pub/scm/git/git.git
>> will be fetched and stored locally as refs/remotes/origin/. Locally
>> the branches are called "remote tracking branches".
>
> Things under refs/remotes are remote tracking branches, and local
> branches (under refs/heads) that automatically updated based on a
> fetch ("store locally" means merge or rebase, right?) are also called
> remote tracking branches.
>
> I think that's why some of us are confused.

True; the latter wording invites confusion.

What fetch updates directly from remote site are called "remote tracking
branches".  The local branches you intend to keep up to date with respect
to one remote tracking branch is sometimes said to "track" the remote
tracking branch, but because I find it confusing to use the same verb for
this other purpose, I tend to say that local branch (that "tracks" the
other one)

 (1) _forked_ from; or
 (2) _builds_ on

the remote tracking branch, in order to avoid confusion.

Historically, refs/remotes/ hierarchy did not exist, and "git clone"
created these refspecs after cloning from a two branch project:

    refs/heads/master:refs/heads/origin
    refs/heads/maint:refs/heads/maint

and created a local master starting at 'origin'.

The expectation was that everybody would work on 'master', occasionally
referring to 'maint', and because 'master' is always checked out, avoid 
'fetch' from disturbing it by using a separate local branch 'origin' to
keep track of the advance of the other side, while updating 'maint' that
is not checked out directly.

This was the layout used in the good old times, and worked well *only* in
the most simplistic case.  In reality, people used far more branches and
worked on branches other than master.

To fix that, refs/remotes/ hierarchy was introduced, and we started
treating the tracking part of master the same way as other branches, i.e.

    refs/heads/*:refs/remotes/origin/*

The local 'maint' in the old layout was called a remote tracking branch,
too, even though it was local.  These days, if you use the default layout
"git clone" gives you, you can say refs under refs/remotes/ hierarchy are
all remote tracking branches, and you do not have any remote tracking
branches that are local.
