From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] Preserve the protection mode for the Git config files
Date: Mon, 27 Jul 2009 19:18:53 +0100
Organization: ARM Ltd
Message-ID: <1248718733.12375.65.camel@pc1117.cambridge.arm.com>
References: <20090721152435.16642.47207.stgit@pc1117.cambridge.arm.com>
	 <7vab2wlh4y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 20:19:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVUnG-0001fe-So
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 20:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753975AbZG0SS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 14:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753893AbZG0SS6
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 14:18:58 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:58112 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752587AbZG0SS5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jul 2009 14:18:57 -0400
Received: from cam-owa1.Emea.Arm.com (cam-owa1.emea.arm.com [10.1.255.62])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id n6RIIsZm025198;
	Mon, 27 Jul 2009 19:18:54 +0100 (BST)
Received: from [10.1.68.81] ([10.1.255.212]) by cam-owa1.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Mon, 27 Jul 2009 19:18:53 +0100
In-Reply-To: <7vab2wlh4y.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.22.3.1 
X-OriginalArrivalTime: 27 Jul 2009 18:18:53.0884 (UTC) FILETIME=[B2D1C7C0:01CA0EE6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124179>

Hi Junio,

On Wed, 2009-07-22 at 11:14 -0700, Junio C Hamano wrote:
> Catalin Marinas <catalin.marinas@arm.com> writes:
> > Every time an option is set, the config file protection mode is changed
> > to 0666 & ~umask even if it was different before. This patch is useful
> > if people store passwords (SMTP server in the StGit case) and do not
> > want others to read the .gitconfig file.
[...]
> Your log message talks about .git/config and nothing else, but I think
> this codepath affects everything that is created under the lock, such as
> the index and refs.

I haven't checked all the places where this function is called. For my
use-case, I store the SMTP password in the .git/config file (or
~/.gitconfig) and every time I update this file (with git or via stgit),
the permission gets changed.

> The patch description must defend itself a bit better, perhaps by saying
> something like this at the end.
> 
> 	This patch touches the codepath that affects not just .git/config
> 	but other files like the index and the loose refs, so they also
> 	inherit the original protection bits.  In a private repository,
> 	this is not an issue exactly because the repository is private,
> 
> 	In a shared repository, a later call made in this function to
> 	adjust_shared_perm() widens the permission bits as configured.
> 	Because adjust_shared_perm() is designed to do so from any mode
> 	limited by user's umask, even though this patch changes the
> 	behaviour in the strict sense, it should not affect the outcome in
> 	a negative way and what is explicitly marked as allowed in the
> 	configuration will still be allowed.

Thanks for the explanation. Would you like me to repost with your
description?

Thanks.

-- 
Catalin
