From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Not A BugReport] git tag -a / git show
Date: Fri, 24 Feb 2012 11:50:27 -0800
Message-ID: <7vsji0yprw.fsf@alter.siamese.dyndns.org>
References: <b05f03b381140ca57a7d03a934f605bd@rom1v.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: =?utf-8?Q?Romain_Vimont_=28=C2=AEom=29?= <rom@rom1v.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 20:50:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S11A3-0001Nz-OX
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 20:50:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757714Ab2BXTua convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Feb 2012 14:50:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51762 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754196Ab2BXTu3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2012 14:50:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68AF07ECD;
	Fri, 24 Feb 2012 14:50:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=aZRlz8snZEVU
	dnT4dR2wiBMXYFc=; b=nwojJq51ruAjuRHZL93XcdIrZvpuJw3kBknhCkc79eWD
	b6CKZwxD5TPym7yhmMFZ30WGKI4o3LEJdUvAMsqco3cz7/+9ronCu6TdHD3lXY9D
	pNChkBrZKr9Wrmd0e3i8PdWF2EGIkCXR31HK5H8tZH9q7vivfBxu4NH6tFBy414=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=EO8Bt/
	GiWaTeqxmBJq7OznpgnHK6AzprrZoIccxBv9s52Q0xi5FFMYpJDsmkJEk4cDjneg
	3kseFrKgBn7C3vg2Kaj4QPy7r6Y46DzQILkdTq82kUDNdWCqaws6HX4oWyJDVu2/
	e7ew3hQMAJcYEcbCmy70rGYzJaA4wKHPpgppM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FDCB7ECC;
	Fri, 24 Feb 2012 14:50:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E584A7EC9; Fri, 24 Feb 2012
 14:50:28 -0500 (EST)
In-Reply-To: <b05f03b381140ca57a7d03a934f605bd@rom1v.com> ("Romain Vimont
 =?utf-8?Q?=28=C2=AEom=29=22's?= message of "Fri, 24 Feb 2012 11:24:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CD859B22-5F20-11E1-BC54-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191451>

"Romain Vimont (=C2=AEom)" <rom@rom1v.com> writes:

> Now, I edit some files (for example in a config file
> "mock_data=3Dtrue"), then I want to tag without commiting this change=
=2E

Tag applies to an existing commit [*1*].  Your change in the working tr=
ee
is purely ephemeral until it is committed.

In other words, you don't "tag without committing".

> $ git tag -a v0.1 -m 'My v0.1 with mock data'

By omitting the [<head>] part from your command line for a command whos=
e
usage is:

  usage: git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname=
> [<head>]

you asked <head> to default to HEAD, the most recent commit, so the tag
points at your 0ef41513d0b6 (This is the last commit).  The tag message
should say "My v0.1" without anything else.

And show naturally shows the patch to bring its parent to that tagged
commit.

If you wanted to keep your mainline pristine without mock data, and wan=
t
to have a playpen that uses mock data, a way to do so is to use a separ=
ate
branch, e.g.

        $ git checkout -b playpen

Now, you are on your 'playpen' branch that was forked from the tip of
whatever branch you were on, perhaps 'master'.  Then commit that state
with whatever change that is specific to the playpen you want to keep o=
ut
of the mainline:

	$ edit config.txt ;# set mock_data=3Dtrue
        $ git commit -a -m 'With mock data'

You can optionally tag the resulting commit if you want to.  You are st=
ill
on the 'playpen' branch, so you probably would want to come back to the
previous branch after you are done.


[Footnote]

*1* technically, tag can apply to any type of object, but it is most
common to apply to a commit.
