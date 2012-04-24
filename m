From: Christopher Tiwald <christiwald@gmail.com>
Subject: Re: [PATCH] Give better 'pull' advice when pushing non-ff updates to
 current branch
Date: Tue, 24 Apr 2012 00:58:44 -0400
Message-ID: <20120424045844.GA41274@gmail.com>
References: <1335221121-36664-1-git-send-email-christiwald@gmail.com>
 <xmqqvckpho0a.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 06:58:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMXq4-0008G1-O2
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 06:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506Ab2DXE6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 00:58:51 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:52131 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889Ab2DXE6u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 00:58:50 -0400
Received: by vbbff1 with SMTP id ff1so222739vbb.19
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 21:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=sS5TUjZ6wVhMGKPafKbtCkkfLGpZFSE9hdI5DQ7Gd4k=;
        b=Pfmt/pALfG9ObPxjn+PVgLGSXOuRYfDOLSvm2fi1abVqPAAwFXbH4OxaCfrpU4B9yE
         gzODfd7sAhmTRrNnFFXoUfUNoojKoQBR9I7Zzsgw5Gz7hwPsVs2Uep94ZBZhCmoM6Dyq
         pYAeYZPGDB7gHK7gaTmKuNnqf8wubD6Mrg6MZhBhG66fSc5CvmFo+3dGj3Nm7zmNRIrd
         q02gd8XOnLaxcmB0Ka+TKvyH0v24ddGsoh8M4ABNupf7YrwNnnQKhN7FIwJG2i/Ky9l0
         dEkciQuKWHjxWsxKwFE2Lu8Wc5SyfwwpddWFzQQ2P8zvYVxUuPQn/bDiT7miUu5cSKsd
         TlyQ==
Received: by 10.52.178.98 with SMTP id cx2mr15614815vdc.112.1335243529685;
        Mon, 23 Apr 2012 21:58:49 -0700 (PDT)
Received: from gmail.com (cpe-74-66-248-47.nyc.res.rr.com. [74.66.248.47])
        by mx.google.com with ESMTPS id iz3sm29541094vdb.11.2012.04.23.21.58.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 Apr 2012 21:58:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqvckpho0a.fsf@junio.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196185>

On Mon, Apr 23, 2012 at 07:17:25PM -0700, Junio C Hamano wrote:
> So what makes it dangerous is the use of "--rebase", if anything, isn't
> it?  It does not seem to have much to do with how the local branches are
> named.

After thinking about this argument, there might be a deeper problem with
my reasoning. Take the workflow you describe. In the "devel tracks to origin
master" workflow, this patch would advise 'git pull <repository> <refspec>'.
The advice misses the point of setting the upstream branch. Worse, the
advice is broken if the user issues 'git pull origin devel' and no 'devel'
branch exists on origin or the 'devel' branch is simply out of date (as
might occur if the user pushes between a personal remote clone of a
shared repo and the shared repo itself with different frequency).

Maybe the solution here is to ditch the $dest_ref and $dest_remote
matching entirely and just touch the one case I _know_ the advice could
do better: git should advise 'git pull <repo> <refspec>' or something
like "consider setting an upstream branch and pulling before pushing
again" when branch->merge doesn't exist at all. I like the former
because it's simpler as an end user and doesn't require enforcing a
setting he or she may not understand.

I think that might be the way to go. I approached this from a specific
workflow assumption. In retrospect, I can't divine the motivation of
merge configurations well enough to avoid bad advice.

--
Christopher Tiwald
