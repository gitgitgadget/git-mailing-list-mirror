From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git xinet service setup questions
Date: Thu, 03 Jan 2008 12:35:57 -0800
Message-ID: <7vk5mqpryq.fsf@gitster.siamese.dyndns.org>
References: <827742.53287.qm@web56014.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@linux-foundation.org
To: Scott L Baker <freecycler23@yahoo.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 21:36:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAWnu-0000vZ-Db
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 21:36:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122AbYACUgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2008 15:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752120AbYACUgG
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 15:36:06 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46997 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024AbYACUgF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 15:36:05 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E2C811672;
	Thu,  3 Jan 2008 15:36:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 362AF2D3E;
	Thu,  3 Jan 2008 15:35:59 -0500 (EST)
In-Reply-To: <827742.53287.qm@web56014.mail.re3.yahoo.com> (free cycle's
	message of "Wed, 2 Jan 2008 14:27:37 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69532>

Scott L Baker <freecycler23@yahoo.com> writes:

> This is probably a simple mistake on my part.. so apologies in advance..
>
> I am trying to setup a git server and I have a few questions.
> My sys-admin (I do not have root access) setup an xinet service, e.g.

Addressing individuals for this kind of help requests is an
inefficient way to resolve problems.  I've tried to spawn
git-daemon from inetd just as a test to make sure it works in
the past, but I personally never have run xinetd.

You would have better luck finding somebody who have used xinetd
to run git-daemon if you asked git@vger.kernel.org mailing list,
which you can send mails to without subscribing yourself.

Having said that...

>>> cat /etc/xinetd.d/git-daemon
>
> # default: off
> # description: The git server offers access to git repositories service git
> service git
> {
>         disable = no
>         type            = UNLISTED
>         port            = 9418
>         socket_type    = stream
>         wait            = no
>         user            = nobody
>         server          = /usr/intel/bin/git-daemon
>         server_args    = --inetd --syslog --export-all --base-path=/git
>         log_on_failure  += USERID
> }
>
> I then created a repo in /git/myrepo and tried to clone it..
>
>>> git clone git://plxc1214.pdx/git/myrepo
>
> Initialized empty Git repository in /users/myuser/junk/myrepo/.git/
> fatal: The remote end hung up unexpectedly
> fetch-pack from 'git://plxc1214.pdx/git/myrepo' failed.
>
> Is the xinet service setup correctly?
> What is the correct syntax for cloning from the local xinet service?
>
> Thanks,
> Scott L Baker

The first thing you would want to try is to see if it is xinetd
or git-daemon that is misconfigured.  Try running the daemon
without xinetd involved and see if you can access the
repository.  I think there is something in Documentation/howto/*
on running the daemon.

The --base-path is used to hide the (often unsightly) leading
prefix from the general public.  If you are trying to fetch from
git://plxc1214.pdx/git/myrepo, the --base-path I see in your
configuration would mean the repository is at /git/git/myrepo
directory on the filesystem.  Is it the case?  Does it help to
try cloning from git://plxc1214.pdx/myrepo instead?
