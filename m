From: Sergio <sergio.callegari@gmail.com>
Subject: Re: Git repository mesh?
Date: Wed, 25 Nov 2009 08:42:37 +0000 (UTC)
Message-ID: <loom.20091125T092917-792@post.gmane.org>
References: <fcaeb9bf0911242007t1294bddej87b48691ea283e21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 09:43:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDDTF-00064w-TD
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 09:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498AbZKYInD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 03:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934248AbZKYInB
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 03:43:01 -0500
Received: from lo.gmane.org ([80.91.229.12]:50202 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934121AbZKYIm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 03:42:56 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NDDSm-0005u2-MM
	for git@vger.kernel.org; Wed, 25 Nov 2009 09:43:00 +0100
Received: from host44-54-dynamic.20-87-r.retail.telecomitalia.it ([87.20.54.44])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 09:43:00 +0100
Received: from sergio.callegari by host44-54-dynamic.20-87-r.retail.telecomitalia.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 09:43:00 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.20.54.44 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091109 Ubuntu/9.10 (karmic) Firefox/3.5.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133618>

Nguyen Thai Ngoc Duy <pclouds <at> gmail.com> writes:

> 
> Hi,
> 
> I work on a few machines so I have repositories on all of them. One
> repository can pull from or push to any other repositories (in case of
> push, it pushes on remote branches). I avoid a central repository
> because it's quite inconvenient when you just need to push some
> changes to a machine, you have to push it to the central repository
> then pull from that (and if the central repository is on WAN, double
> inconvenient). Maybe this model is just plain wrong, but it'd be fun
> to see if Git can work with this model.
> 
> The first thing that annoys me is remote repository management.
> Everytime I add a new repository to the mesh, I need to update .config
> of all repositories. 

If I remember correctly, there was in the past the idea of allowing some limited
shell variable substitution in the config file.

This would allow to have a single config for all the machines with remote
entries. Something like

[remote "host1"]
        url = ssh://host1/path
        fetch = +refs/heads/*:refs/remotes/host1/*
        push = +refs/heads/*:refs/remotes/$hostname/*
[remote "host2"]
        url = ssh://host2/path
        fetch = +refs/heads/*:refs/remotes/host2/*
        push = +refs/heads/*:refs/remotes/$hostname/*
...

In other terms, admitting that all the candidate machines are known at the very
start, you could start a repo on any of the host, placing in the config file all
the possible hosts.  Moreover, not needing to have a different config for each
host may make it easier to manage (propagate by simple scp) or even to version
control.

To the best of my knowledge the idea was not implemented in the end, but I think
that a patch for variable substitution in the config file might still be found
on the ML.

Sergio
