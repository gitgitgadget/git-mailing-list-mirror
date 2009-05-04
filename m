From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetool--lib: add support for araxis merge
Date: Sun, 3 May 2009 17:09:57 -0700
Message-ID: <20090504000956.GD50640@gmail.com>
References: <1241313481-17923-1-git-send-email-davvid@gmail.com> <200905030854.28059.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, snowcoder@gmail.com, spearce@spearce.org,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org,
	charles@hashpling.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Mon May 04 02:12:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0lnh-0007XL-38
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 02:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753686AbZEDAKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2009 20:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753476AbZEDAKD
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 20:10:03 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:30424 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420AbZEDAKB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2009 20:10:01 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1921106wah.21
        for <git@vger.kernel.org>; Sun, 03 May 2009 17:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=wgmokzb1XAk7rXy+5FNcAR0cOkqdZxBh60lk/aeoBOA=;
        b=P0wgitTVR7XFZAmv3dxpn52Pj6nm/25KrGg+IWJYZXuqZYcZgoUqy3dFLMnvWbRIGK
         ow9WRkL5BToXEPnaQYqvZIAzPyJp/WedOPeKCRQHivUi8ryYbZNd/d33uT/hmMiDN+4o
         v/Z6gVj9kJU2U4ntRgM3AIy29oYxFD9sH/irk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KFxu8kzhEhPgdK4TfNOG3R49Lw2g9uU+Tw+edfzPQGy1AgALGE06nj71qW2SQhhwuM
         F/0uuErQAenGkrQdU5j0qYpviwsj4BiwAYUAMG2ogMb4AsyorG/xvIsda3jo0H44MVXD
         P6tqFsMY7MyDjKovCPtI/bA7JVJe5zW2cBGr0=
Received: by 10.114.67.2 with SMTP id p2mr3745535waa.208.1241395801676;
        Sun, 03 May 2009 17:10:01 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id l28sm9017528waf.19.2009.05.03.17.09.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 May 2009 17:10:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200905030854.28059.markus.heidelberg@web.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118198>

Markus Heidelberg <markus.heidelberg@web.de> wrote:
> 
> Haven't you included the -title[1-3] command line switches because of
> the strange "'title'" format? The user on the msysgit list had commented
> it out in his patch, although he said it worked in this way. And looking
> at git-gui/lib/mergetool.tcl, it is done in the same way.
> 
> Markus

I looked into it.
Windows. :(

-title1:"nice stuff" works great everywhere except for windows.
-title1:"'nice stuff'" doesn't work there either.
That's probably why it was commented out in the original patch.

On windows we'd have to escape the spaces (wild guess) so the
original patch is probably the best option since I don't feel
like making the other platforms suffer for it.

Seeing .diff_XXXX as the filename is bad too (and that is a
form of suffering as well) but it's a compromise since there
is a possibility that we could fix that elsewhere to
everyone's benefit.

As far as difftool is concerned, the code that generates
the temp filename is prep_temp_blob() in diff.c.
It's used by several callers that naturally care nothing
about filenames.

It would be nice to specialize the ext-diff code to
generate a more intuitive filename.  Maybe something
like original_filename.XXXXX.ext instead of the current
.diff_XXXXX.  Right now the choice of filename breaks
syntax highlighting in some viewers and also makes
the usage of --title args necessary since the default
names tell us nothing about what we're viewing.

That's definitely not the kind of thing to be thinking
about during an -rc cycle ;), though I would be interested
in maybe working on that later if others agree that
it's not a bad idea.

It wouldn't be perfect, but it would be just a
little bit nicer for anyone that's using the tools
everyday.

-- 
		David
