From: Junio C Hamano <gitster@pobox.com>
Subject: Re: who's on first? - following first parent and merge-management
Date: Tue, 06 Mar 2012 23:37:42 -0800
Message-ID: <7vwr6woo8p.fsf@alter.siamese.dyndns.org>
References: <jj6s47$m98$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 08:37:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5BRX-0001D7-Rl
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 08:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753159Ab2CGHhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 02:37:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39554 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753065Ab2CGHhp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 02:37:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 162DD4B41;
	Wed,  7 Mar 2012 02:37:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=70ERIqvGvp87dExANNgDsco2JSA=; b=g4EHTm
	cIt6d2A8EePzxqA539HmfrkEypcebSX1Q+TXkyyaWwp91b/UOICvTxEzluTlxaRC
	AiJx0dzQyEEOox/GJNFiXI/XyGzPQ8Ry18H2Drus2OgPVXSghNdROpS7E6JZ/+wm
	tYK/BPLuaQq9V2Q5WmiLsF30ZdkJCGTAy+4o4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rOif0shVpV9oStoznKkuk+fx74i+T+QX
	G1XoXRiWnpb9TKSXfWbtKzKvppHB6oBwjOG4FolC5UVyxPvO4/W6YOEP55A2Pjoz
	GRmINZTfM9Ee1N1CVxFyGwPSd4JU272yXqiHiDpQR1TkPd+lXQyO1/r9vB64/Tj3
	lokKst2tDYo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D9594B40;
	Wed,  7 Mar 2012 02:37:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 988D34B3F; Wed,  7 Mar 2012
 02:37:43 -0500 (EST)
In-Reply-To: <jj6s47$m98$1@dough.gmane.org> (Neal Kreitzinger's message of
 "Tue, 06 Mar 2012 23:36:06 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6D1BF1F8-6828-11E1-B514-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192430>

Neal Kreitzinger <nkreitzinger@gmail.com> writes:

> Please advise on "first parent" intent, best-practices, and pitfalls,
> or documentation that explains it.  (I haven't found documentation
> that directly explains "first parent theory and practice".  I've seen
> many references to "first parent" and its implied meaning that I'm
> supposed to "just know" or deduce).

A short conclusion: if you take "first parentness" very seriously,
neither of your two approaches are optimal, but that does not make
you a bad person. It is just that "log --first-parent" is not the
best way to get an overview of the history for your workflow.

The mechanical definition of "first parent" is that:

 - A merge is a commit with more than one parent.

 - When you run "merge", you are on one commit, HEAD, taking changes
   made by "other branches" you are merging into "your history"
   (whose definition is "the commit-dag leading to your HEAD
   commit"), and record the resulting tree as a new commit.

 - This new commit records all its parents, one of them being your
   old "HEAD" and the rest being "other branches" you merged into
   "your history".  They are recorded in that order in the resulting
   commit ("git cat-file commit HEAD" after a merge to see them).

Hence, the first parent of a merge is the HEAD the committer was at
when s/he ran "git merge".

It's late so I won't go into the details of what the implications of
this is in this message.  Perhaps tomorrow when/if I have time.
