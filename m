From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/3] Different views on a repository
Date: Wed, 24 Feb 2010 09:42:35 -0800
Message-ID: <20100224174235.GA20567@spearce.org>
References: <cover.1267029680.git.agruen@suse.de> <f409d0cde7939a833708ed92f86605dbbdd64a49.1267029680.git.agruen@suse.de> <92fea2335b73265b04d64fcc217055e1170f5e16.1267029680.git.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Wed Feb 24 18:42:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkLG1-0004KE-E3
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 18:42:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757355Ab0BXRmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 12:42:40 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51284 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756385Ab0BXRmk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 12:42:40 -0500
Received: by gwj16 with SMTP id 16so1235991gwj.19
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 09:42:39 -0800 (PST)
Received: by 10.150.117.10 with SMTP id p10mr517072ybc.121.1267033359298;
        Wed, 24 Feb 2010 09:42:39 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 5sm827913yxd.53.2010.02.24.09.42.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 09:42:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <92fea2335b73265b04d64fcc217055e1170f5e16.1267029680.git.agruen@suse.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140961>

Andreas Gruenbacher <agruen@suse.de> wrote:
> Add --view options in upload-pack and receive-pack so that a repository
> on the server side can be made to look like several independent
> repositories on the client side.

Before saying this is good... I'd like to know how a repository owner
is supposed to set these options on the user started invocations
of other remote side program.

Right now, I don't see how this is too different from just
doing the following on a client:

  git init
  git remote add origin URL
  git config remote.origin.fetch refs/heads/one/*:refs/remotes/origin/*

and therefore shouldn't just be handled on the *client* side of the
connection, as part of the remote setup and push matching refs rules.

(Of course, the push matching ref logic is messy too... adding yet
more into that pile might also be ugly.)

> +const char *view_to_ref(const char *refname, const char *view)
> +{
> +	static char *buffer;
...
> +	buffer = xrealloc(buffer, prefix_len + view_len + suffix_len + 1);
> +	sprintf(buffer, "%.*s%s%s", prefix_len, refname, view, suffix);
> +	return buffer;

I'd rather not use a static buffer like this.  Why not alloc and let
the caller free?  Or have the caller pass in a strbuf you populate
for them?

-- 
Shawn.
