From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Any chance for a Git v2.1.5 release?
Date: Thu, 26 Feb 2015 12:54:59 -0800
Message-ID: <xmqqvbiol7fg.fsf@gitster.dls.corp.google.com>
References: <C5211E53-8905-41C9-9D28-26D7BB51E76A@gmail.com>
	<xmqqk2z7qe8s.fsf@gitster.dls.corp.google.com>
	<2D3EB6D1-3029-4F60-AF29-E044E92DB036@gmail.com>
	<xmqq4mqapo9r.fsf@gitster.dls.corp.google.com>
	<DCB8EEAA-F6C3-4321-833E-39B80673C7E9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 21:55:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR5Si-0004Kt-5C
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 21:55:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089AbbBZUzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 15:55:05 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52265 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752169AbbBZUzE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 15:55:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B5D243C1FC;
	Thu, 26 Feb 2015 15:55:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cSW5pYZUuefNjAk6ED5+EVh3cec=; b=oVliM6
	mEWSRZin/4JmHm48Sssf8eyYRQjEbsfUDA4jHe+IxycJEqeyCIVDw6asBPdp3DrW
	aRzD6/Zu0ZsorRmR3+MqegBLwDQJseQtg11y62k+9uRWVRZmSchv3IJhPptYBMdI
	p6kamDMmRw+O70h4Es5OsZjqyN6qcBPSRf0WI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rvOj4J51FQDDw8iFgS0eUcmwVps1T3k8
	vjzzW1oy/ANfpraeWOOKZ4M4chI8s1Y9Eva5AQLlkEgdhZCxOc9dikOC76uQ2+mU
	6SZeQtdF6e2fDSCOZBoQbnp4/0u5ViGeEssZcpn9nYHrsAESeb1t3+j5Vt6RsdL8
	/zzWjPUNx9w=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ACBA63C1FB;
	Thu, 26 Feb 2015 15:55:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0EC4D3C1F9;
	Thu, 26 Feb 2015 15:55:01 -0500 (EST)
In-Reply-To: <DCB8EEAA-F6C3-4321-833E-39B80673C7E9@gmail.com> (Kyle J. McKay's
	message of "Wed, 25 Feb 2015 23:40:53 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BBB2A5C6-BDF9-11E4-B248-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264459>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> I would like to better understand how the various heads are
> maintained.  I've read MaintNotes and I've got the concepts, but I'm
> still a little fuzzy on some details.  It looks to me like all topics
> still only in pu after master has been updated are then rebased onto
> the new master and then pu is rebuilt.

Topics in 'pu' not yet in 'next' _can_ be rebased, but unless there
is a good reason to do so, I wouldn't spend extra cycles necessary
to do such thing.  I even try to keep the same base when replacing
the contents of a branch with a rerolled series.  For example, today
I have this:

    $ git config alias.lgf
    log --oneline --boundary --first-parent
    $ git lgf master..nd/slim-index-pack-memory-usage
    3538291 index-pack: kill union delta_base to save memory
    7b4ff41 FIXUP
    45b6b71 index-pack: reduce memory footprint a bit
    - 9874fca Git 2.3

and Duy has a newer iteration of it starting at $gmane/264429.  What
I would do, after saving these patches in a mbox +nd-index-pack,
would be to

    $ git checkout 9874fca
    $ git am -s3c ./+nd-index-pack
    $ git show-branch HEAD nd/slim-index-pack-memory-usage
    ... compare corresponding changes between the old and the new
    ... until I am satisified; otherwise I may tweak the new one
    $ git rebase -i 9874fca
    ... and then finally
    $ git branch -f nd/slim-index-pack-memory-usage HEAD

to update the topic.  Of course, it would be necessary to rebuild
'pu' by merging all the topics that are in it on top of 'master'.

https://github.com/gitster/git.git has these topic branches broken
out and you can observe how they change over time from your local
reflog for refs/remotes/<that repository>/<topic branches>.

> I vaguely recall you may have explained some of this in more detail in
> the context of explaining how you used the scripts in todo to put
> everything together when someone asked a question about it on the
> list.  But I can't seem to find that message anymore.  :(

There may be a copy in Documentaiton/howto/ somewhere.

> I think I mostly understand how master, next and pu are maintained.
> But MaintNotes says "Whenever a feature release is made, 'maint'
> branch is forked off from 'master' at that point."  What happens to
> the previous maint at that time?  Is it just renamed to maint-X.X?

After finishing 2.3.0 release, at some point while 'master' is still
at 2.3.0, something like this would happen:

    $ git branch -m maint maint-2.2
    $ git branch maint master

> Also, how do you handle a down merge to maint when you have this:
>
> * (master)
> * merge topic foo
> |\
> | * topic foo
> |/
> * c
> * b
> * a
> * (tag: vX.X.X, maint)
> *

I don't, and this is done by making sure I do not get into such a
situation in the first place.

A general rule of thumb when applying a set of patches that are
fixes eventually worth having in older maintenance tracks is to find
the oldest maintenance branch and apply them there.
