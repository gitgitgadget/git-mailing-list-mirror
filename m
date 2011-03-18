From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question about "branch.<name>.merge"
Date: Fri, 18 Mar 2011 14:13:09 -0700
Message-ID: <7vei64w2sa.fsf@alter.siamese.dyndns.org>
References: <AANLkTin-96TK_8MjAM7MB4CCyZ0ZSvD=ZanaYWLiXsvC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Josh Ralburton <josh.ralburton@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 22:13:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0gzA-0007Ej-Be
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 22:13:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757463Ab1CRVNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 17:13:24 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59283 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757368Ab1CRVNW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 17:13:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2FB1342F4;
	Fri, 18 Mar 2011 17:14:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rei/AJ3wHHxvh1NNRkcObGLskoQ=; b=rZRpTT
	+ugtR5eh/sxIbDDtndKX+xhP3Oz9uNm96vTNZWkDkVGOIv9BVX/ZZ2t6zq0Ipq7C
	IUgELAufaCgyrSU2LJZWCqYL1ASKtxmwUYRzf3WPwjl3Kd3ohnlpw/L1fjIedhzJ
	0BXMCpvTyfverK6rZVXirmF8pfb0QIR38r/b4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NgLwl5VNpWkfmo7sVMLSAC5/LFPuuOSZ
	VyyZs7l5lKiUj+9z8MfqjyunNq6yR9masKvPQIcYx//mU08hV5ojQH0BWZl74SNc
	x18iOwgB7j3zdQI4R8K5p+yVG1kV9t787uSkRBYhqnQUy6bpkFkl1MmqGPD9Pql1
	fct7tc9cYwE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0CF0B42DC;
	Fri, 18 Mar 2011 17:14:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2544C42DB; Fri, 18 Mar 2011
 17:14:44 -0400 (EDT)
In-Reply-To: <AANLkTin-96TK_8MjAM7MB4CCyZ0ZSvD=ZanaYWLiXsvC@mail.gmail.com>
 (Josh Ralburton's message of "Fri, 18 Mar 2011 12:35:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C13D8F30-51A4-11E0-AFA4-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169360>

Josh Ralburton <josh.ralburton@gmail.com> writes:

> This is a typical section from a .git config file:
>
> [remote "origin"]
>     fetch = +refs/heads/*:refs/remotes/origin/*
>     url = git://git.kernel.org/pub/scm/git/git.git
> [branch "master"]
>     remote = origin
>     merge = refs/heads/master
>
> I am curious why "branch.master.merge=refs/heads/master"  was
> implemented to refer to the remote branch (refs/heads/master) rather
> than the local branch (refs/remotes/origin/master).

Because conceptually you are merging with the refs/heads/master branch
that exists at the "origin" repository, not merging with a remote tracking
branch that the "origin" repository may have to track its upstream.

It is immaterial that you happen to have a copy of it at your own remote
tracking branch (i.e. refs/remotes/origin/master).  If you don't need
tracking branches, you can even do something like this:

	[remote "origin"]
                url = git://...there
        [branch "master"]
		remote = origin
                merge = refs/heads/master

Notice that you are telling git not to create any remote tracking branches
with this configuration.
