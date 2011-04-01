From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] builtin/show: do not prune by pathspec
Date: Fri, 01 Apr 2011 15:59:16 -0700
Message-ID: <7v7hbdefy3.fsf@alter.siamese.dyndns.org>
References: <7vwrjfjdqr.fsf@alter.siamese.dyndns.org>
 <cover.1301649372.git.git@drmicha.warpmail.net>
 <6509d23c538dfabd4fac8870d29a69b1dd11a516.1301649372.git.git@drmicha.warpmail.net> <7vwrjdej42.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	=?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
	<pclouds@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Apr 02 00:59:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5nJZ-0007UA-FS
	for gcvg-git-2@lo.gmane.org; Sat, 02 Apr 2011 00:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624Ab1DAW7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 18:59:32 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51543 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207Ab1DAW7b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 18:59:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9FBD14C6B;
	Fri,  1 Apr 2011 19:01:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DpG6i29iZ7RSDzZ8v2DOzL2Oa2I=; b=xaGyUi
	mVwMII8ScNMybI3Ct3/msIfniseAoSDuuJEY2c0rABGf0Ru9ziIxUxBkPPKp9xIG
	zFnxV1wuo8cHq0rq2krjH/ELcTUpgMbo1MCZcdWyCScbxu8MEWfogS0LHTGbHw8Y
	d7z1OVlFKhgTfzNdnh3KId/bqke6IYJAS9nrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zfq7cqSOUrXSpLINi90JtnvGwASf9A/8
	BfACtnL+0xhSKrAatXnrGd88mXzbHTHhLsI2+fIPp+ivhGC7HPxeYCjAFYuSqY7j
	xyNTQGhBvhCSpomst7/VMqKCiuOyBvt0WI5YNI0d4ZWwdumG/pJkn6orwDth6Cdq
	VDMeZ54djMQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5BDEC4C66;
	Fri,  1 Apr 2011 19:01:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F327B4C63; Fri,  1 Apr 2011
 19:01:08 -0400 (EDT)
In-Reply-To: <7vwrjdej42.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 01 Apr 2011 14:50:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1929C56-5CB3-11E0-A0E5-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170634>

I attempted to rewrite the log message in a bit more objective voice like
this:

    builtin/show: do not prune by pathspec
    
    "git show $commit -- $path" does not show anything for a commit that does
    not change the $path.  While this may be technically correct, it is somewhat
    unexpected from the end user's point of view.
    
    Unless "show" is used as "log -p", e.g. "git show HEAD~5..", it makes more
    sense to show at least the log message for commits, even they are
    uninteresting with respect to $path.
    
    Turn off commit pruning (but keep diff limiting of course) so that the
    command shows the log message and the diff that the commit introduces to
    the path.  The diff part may be empty for a given commit that does not
    touch the path.
    
    As an intended side effect, users mistaking "git show commit -- path"
    for "git show commit:path" are automatically reminded that they asked
    git to show a commit, not a blob.
    
    Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

which made me realize that this change does regress for no-walk case.

What if you (or your homegrown tool or alias) are feeding a list of
candidate commits that may have touched the path, without walking, and are
expecting them to be filtered?

    $ git show A B C D -- path

We used to get a nice output of "git show C -- path" in such a case but
now the output will be cluttered with the log message from a commit that
is totally uninteresting with respect to the given path.

I really wanted to like this patch, because I _very much_ liked the
"intended" ;-) side effect.

I am torn.
