From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Add .git/version
Date: Thu, 17 Nov 2005 16:44:47 +0100
Message-ID: <200511171644.48438.Josef.Weidendorfer@gmx.de>
References: <11322339372137-git-send-email-matlads@dsmagic.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Martin Atukunda <matlads@dsmagic.com>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Nov 17 16:54:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EclwX-0003IB-AN
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 16:44:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbVKQPoy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 10:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbVKQPoy
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 10:44:54 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:42166 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1751349AbVKQPoy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 10:44:54 -0500
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id B64482669;
	Thu, 17 Nov 2005 16:44:50 +0100 (MET)
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <11322339372137-git-send-email-matlads@dsmagic.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12121>

On Thursday 17 November 2005 14:25, Martin Atukunda wrote:
> This patch series attempts to add .git/version support to init-db.c. THis
> is an overview of the patches.

As .git/version is part of the repository, it should contain the version
of the repository format used. Do you really want to link the version
of the repository format with the version of git which created the
repository? It think it is better to detach a repository version from
version of git.

Why? Ideally, the git commands first should check if they can handle the
repository format. If they can not handle the version, they should bail
out with an error [*]
Now suppose we want to release Git 2 without change the repository
format at all. Thus, even if Git 1 tool *would* work with repositories
created by Git 2, they will fail in the version check!

If this is meant to be used in scripts (as your commit comment mentions):
a script should never touch any files in the repository directly, but go
via commands supplied with git. So these scripts should actually check
against the version of installed git. Thus, such a version string should go
into git-var or better simply use the existing "git --version"?

Josef

[*] Junio: This should be done before Git 1.0 - it is needed to be able
to change the repository format in the future without taking the risk
that old git commands possibly corrupt a repo in the new format. This
has nothing to do with backwards compatibility. Without a version, we
are forced to be forwards compatible ;-)
Needed in init-db.c is a "echo 1 >.git/version"; and the mentioned check
in the tools against this version.
