From: Stefan Monnier <monnier@iro.umontreal.ca>
Subject: Re: Post-receive hook for "git pull"
Date: Fri, 12 Feb 2016 08:39:09 -0500
Message-ID: <jwvlh6qt5i6.fsf-monnier+gmane.comp.version-control.git@gnu.org>
References: <jwv4mful6nu.fsf-monnier+gmane.comp.version-control.git@gnu.org>
	<xmqqio4am3uk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 14:39:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUDwQ-0003Q2-8Y
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 14:39:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbcBLNjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 08:39:18 -0500
Received: from plane.gmane.org ([80.91.229.3]:34948 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752426AbcBLNjR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 08:39:17 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aUDwJ-0003M6-4g
	for git@vger.kernel.org; Fri, 12 Feb 2016 14:39:15 +0100
Received: from 45.72.140.225 ([45.72.140.225])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Feb 2016 14:39:15 +0100
Received: from monnier by 45.72.140.225 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Feb 2016 14:39:15 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 45.72.140.225
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.50 (gnu/linux)
Cancel-Lock: sha1:EiTJm3yVJMuiD+8+QMgQMbUf6sM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286048>

>> I have a system here where it can be quite common to have thousands of
>> branches in the remote repository, and where I'd like to update some
>> local state according to the appearance of new branches (or updates of
>> pre-existing ones).
>> Currently, I use a "git for-each-ref" after pulling and then check (for
>> each one of those refs) if an update is warranted, but this can get slow
>> with that many branches.  Is there some way to get something like the
>> post-receive hook to be run for "git pull", so that the script gets told
>> directly which (remote tracking) branches have been modified/created?

> I do not think there is.  But you could easily script along the
> lines of...

>     #!/bin/sh
>     git for-each-ref | sort >prestate
>     git pull "$@"
>     git for-each-ref | sort >poststate
>     comm -12 prestate poststate

Right, it kinda works, but it can break down in case of
concurrent operations.

I really wish there was a way to get something like the post-receive
hook to be called everytime new commits are added, regardless if it's
due to a push, a pull, a commit, a fast-import, ...


        Stefan
