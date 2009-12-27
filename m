From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Does smart-http need git-daemon-export-ok?
Date: Sun, 27 Dec 2009 13:06:53 -0800
Message-ID: <20091227210653.GA609@spearce.org>
References: <905315640912260821k2fb149b3je69dbea5463afaa3@mail.gmail.com> <7vk4w963np.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tarmigan <tarmigan+git@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>, "J.H." <warthog9@kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 27 22:07:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NP0KM-00046o-J6
	for gcvg-git-2@lo.gmane.org; Sun, 27 Dec 2009 22:07:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbZL0VG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Dec 2009 16:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbZL0VG6
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Dec 2009 16:06:58 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:65058 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbZL0VG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Dec 2009 16:06:57 -0500
Received: by iwn1 with SMTP id 1so6968596iwn.33
        for <git@vger.kernel.org>; Sun, 27 Dec 2009 13:06:56 -0800 (PST)
Received: by 10.231.122.139 with SMTP id l11mr1634479ibr.53.1261948016610;
        Sun, 27 Dec 2009 13:06:56 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 22sm10409872iwn.4.2009.12.27.13.06.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 27 Dec 2009 13:06:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vk4w963np.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135713>

Junio C Hamano <gitster@pobox.com> wrote:
> Tarmigan <tarmigan+git@gmail.com> writes:
> > Should the git-http-backend check something like git-daemon-export-ok
> > before serving a repository?
> 
> I'd agree that it would make sense to have a way to mark individual
> repository for (or not for) export.

Just for some background... early drafts of git-http-backend actually
did check for, and require, this file before it exported a repository.

I took the check out because I was relying on the HTTP server's
document root translation to provide the mapping into the local
filesystem.  That meant the HTTP repository was already exported via
dumb-http, and the git-daemon-export-ok flag wasn't being checked.

Later in the series development we got the patch to allow a
different filesystem root via an environment variable, which means
its possible to hide repositories and make them available only
through git-http-backend.  In that configuration, checking the
git-daemon-export-ok flag makes sense again.
 
> In "native" case, the chain of events are: client talks to the daemon, the
> daemon checks and decides to (or not to) export, and it runs upload-pack.
> 
> In "smart http" case, http-backend is one half of what corresponds to the
> daemon (the other half being your http server configuration), and it is
> more flexible and git specific half, so I'd say it would make sense to
> implement the check that honors the same git-daemon-export-ok flag file in
> it.

Yea, I'd agree.

-- 
Shawn.
