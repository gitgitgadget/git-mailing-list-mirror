From: Junio C Hamano <gitster@pobox.com>
Subject: Re: tracking repository
Date: Sat, 15 Mar 2008 19:42:23 -0700
Message-ID: <7vabkzmltc.fsf@gitster.siamese.dyndns.org>
References: <frh8dg$t9j$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: kenneth johansson <ken@kenjo.org>
X-From: git-owner@vger.kernel.org Sun Mar 16 03:43:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jaiqc-0004Yz-9e
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 03:43:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbYCPCme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 22:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbYCPCme
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 22:42:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57128 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbYCPCmd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2008 22:42:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2E0B71C74;
	Sat, 15 Mar 2008 22:42:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id DF8811C73; Sat, 15 Mar 2008 22:42:26 -0400 (EDT)
In-Reply-To: <frh8dg$t9j$1@ger.gmane.org> (kenneth johansson's message of
 "Sat, 15 Mar 2008 19:35:12 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77345>

kenneth johansson <ken@kenjo.org> writes:

> This works great and it will track all changes in the remote repositories 
> without me having to worry about it aborting due to merge issues with my 
> local branch or remote  doing rebase on some branch.
>
> The problem is that it is useless :( I can't find any way to use a 
> repository with only remotes in it. Is there a way to make a clone of a 
> remote branch in a repository ??

Usually a clone with a work tree ("git clone $elsewhere") is configured to
keep copies of branches at the remote in remotes/origin in order to track
them, and that is done by having this in its .git/config:

	[remote "origin"]
		url = $elsewhere
		fetch = +refs/heads/*:refs/remotes/origin/*
	[branch "master"]
        	remote = origin
                merge = refs/heads/master

This lets you to have your own work on your own "master", and have changes
on the other end merged when you "git pull" from there, while keeping
track of other branches on the other end in remotes/origin/ namespace.

You do not want to have any of your own work in this repository, however,
so there is no reason to separate the remote ones in remotes/origin/
namespace.  You would want "mirroring".

You can have in your $GIT_DIR/config something like this:

        [remote "origin"]
		url = $elsewhere
                fetch = +refs/heads/*:refs/heads/*

You can edit the configuration file yourself to read like above, and then
"git fetch" will keep a copy of remote "master" branch in your local
"master" (and similarly to all the branches over there).

Modern git allows this setup via "git remote add --mirror"; it is merely a
convenience wrapper and it is perfectly fine to edit the configuration
file yourself without using it.
