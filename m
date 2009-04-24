From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git send-email: How to modify subject prefix?
Date: Fri, 24 Apr 2009 08:22:27 -0700
Message-ID: <20090424152227.GY23604@spearce.org>
References: <85647ef50904240818s41fffc2eh798083a24ab53750@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 17:24:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxNG4-0001ba-A3
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 17:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757182AbZDXPWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 11:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756784AbZDXPW3
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 11:22:29 -0400
Received: from george.spearce.org ([209.20.77.23]:59425 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759307AbZDXPW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 11:22:28 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id BE81138211; Fri, 24 Apr 2009 15:22:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <85647ef50904240818s41fffc2eh798083a24ab53750@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117453>

Constantine Plotnikov <constantine.plotnikov@gmail.com> wrote:
> I'm interested how to modify subject prefix when sending patches using
> git send-email. I want it to prefix the subject with [JGIT PATCH]
> instead of [PATCH] and I have not found any option that allows it.

Here's how I send email, the trick is to set the subject on
format-patch not on send-email:

_sop/dump.sh
--8<--
base="${1:-master}" &&
if [ $(git rev-list ^$base HEAD | wc -l) -gt 1 ]
then
	n="--numbered --cover-letter"
fi &&
git format-patch \
	--output-directory _sop/OUT \
	--subject-prefix='JGIT PATCH' \
	-M \
	$n \
	$base || exit
----

_sop/send.sh
--8<--
git send-email \
	--to 'Robin Rosenberg <robin.rosenberg@dewire.com>' \
	--cc 'git@vger.kernel.org' \
	--chain-reply-to \
	--suppress-cc self \
	--smtp-server localhost \
	--smtp-server-port 8025 \
	_sop/OUT
----

-- 
Shawn.
