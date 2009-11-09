From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Git drawbacks?
Date: Mon, 9 Nov 2009 18:48:16 +0300
Message-ID: <20091109154816.GH27126@dpotapov.dyndns.org>
References: <loom.20091106T160709-387@post.gmane.org> <32541b130911060849s2d8f13f5sb9b8390f075f8d15@mail.gmail.com> <loom.20091106T180313-750@post.gmane.org> <32541b130911060951q3358ce9ahe28fb0cf902853f2@mail.gmail.com> <alpine.DEB.2.00.0911061051540.3216@asgard.lang.hm> <loom.20091109T084539-720@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dmitry Smirnov <divis1969@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 16:48:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7WTj-0002Un-Bw
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 16:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756160AbZKIPsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 10:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755571AbZKIPsO
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 10:48:14 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:34336 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbZKIPsN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 10:48:13 -0500
Received: by fg-out-1718.google.com with SMTP id e12so1265388fga.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 07:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=C7nifg7rw1FxgKDWHR2FOj0RrRK36OfehuYTSdmkDSo=;
        b=oK0E8mKP3ZpTCdOwzyE6PCoXJOCpceiSeR+pBPxZ0I61HxdsNAWvzGlHUHeRIWjAOX
         Db7NXIQJmJUe+hvqqpKsGzHs0fcKRDlgB8n5tHlEFzd/RniE369flPe/ktGvSVJk/Vaj
         u29qFE0hQ/bvfCf7j9S+FFwR/asMN6NuNn9lI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VM3J22i+pshpg3zLLAd8g1mRluQJ0+KL+W8VyStJLVKBUujW7iHUC88ea5PE03r0la
         BoEheSb+GQMhE90ugDva82PjE10qdOtLK4GBcM0ewoVPbA5wyd7WrW9rgEG/GpCBBcZN
         j+rK8AKtL9TKsgfV97Nz2TOK4QTlA6Cy4uT90=
Received: by 10.86.181.6 with SMTP id d6mr8305969fgf.29.1257781697787;
        Mon, 09 Nov 2009 07:48:17 -0800 (PST)
Received: from localhost ([91.78.51.65])
        by mx.google.com with ESMTPS id l12sm7101883fgb.2.2009.11.09.07.48.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 07:48:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <loom.20091109T084539-720@post.gmane.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132488>

On Mon, Nov 09, 2009 at 07:53:24AM +0000, Dmitry Smirnov wrote:
>  <david <at> lang.hm> writes:
> 
> > going back to the initial poster's comments. if the android repo is 1G, 
> > eliminating the history will probably have significantly less impact than 
> > you expect it to. 
> 
> Do you have 2 or more copies of the same repository at the same time?
> If yes, can I skip cloning new copy from network? 
> Or even skip cloning it at all? 
> Is it possible with Git to chekout into two (few) working trees?

Jacob has already mentioned git-new-workdir from Git contrib, but
there are other ways to do the same or almost the same....

First of all, you can always copy your directory and thus creating
another clone. It is very simple and straightforward solution, but
it takes extra space due an extra copy of the repository. Usually,
it is not a big issue in practice, because your working tree tends
to be larger than the repository itself...

However, if you want to save disk space, you can use local clone. When
you clone your (like: git clone old_dir new_dir), git tries to use hard
links if it is possible. So, it may save disk space. However, if you
repack your original repo then a new pack will be created, and saving
from using the hard link will be lost.  To prevent that from happening,
you can tell to the garbage collector to keep the main existing pack by
create a file that has the same name as the pack file plus the .keep
suffix:

   touch .git/objects/pack-<SHA-1>.keep

then all changes will be put into a separate pack.

There is one more way to save disk space is to use git clone --shared.
It does not require hard links, but it has some caveats. If you want to
use it, then read the documentation carefully and make sure you understand
all implications.


Actually, in most use cases, there is no reason to have more than one
working tree. Git is designed to work well with plenty branches and one
working tree. So, switching between two branches and recompiling a few
changed files is much faster then going to another directory and try to
work there, because when you go to another directory, you may hit cold
cache and disk is *slow*... Another thing is that you can do a lot of
things without checking out some branch. You can grep any revision in
your repository, you can insect any file from it, etc and you do not
have to checkout this revision in your working tree.


Dmitry
