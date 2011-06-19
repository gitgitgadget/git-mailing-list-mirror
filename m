From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Undo last commit?
Date: Sat, 18 Jun 2011 19:37:18 -0500
Message-ID: <20110619003718.GA5628@elie>
References: <BANLkTinWujKYvx_fh2iBDOdMbywqzfgwUA@mail.gmail.com>
 <m31uyrutx7.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike <xandrani@gmail.com>, git@vger.kernel.org,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 19 02:41:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QY64Z-0005rR-Ag
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 02:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156Ab1FSAh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jun 2011 20:37:28 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62829 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918Ab1FSAh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2011 20:37:27 -0400
Received: by iwn6 with SMTP id 6so323730iwn.19
        for <git@vger.kernel.org>; Sat, 18 Jun 2011 17:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=wNt/ThhxGPPyly7CwPtwrhCPoMiIjJYN/wZ6MpdxjUY=;
        b=XNzL9JWu7Ax0JFpl0fdvlPVPacpmG4IKCFBdSdfizVFVE7SZMQMRnvtXqCUuHOcT3i
         XYJuKCecZEC760jA6qfOEcftVCPfj8k67hG5fqIPlD3nx+Rf+XM6GcPZdUZjC9oBHwd9
         C/HRYxrdDupyxwZll70p04aPRTzryUkhzJJAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hIsg+K/ocaGmcFWyqkt7JM+iRGb4jci8fi+g3RiDca/MrAM7ZD0wJ4OmVI+M9EGPqo
         r0ezjiccHiYd0FHO7SPBnsg3EPKmhQQQtgt/7JJLXcTk8dDOmlwAD3ZXKNCQiOlz7fod
         rUOrZjfOWIpBVkRHez/09qNITjoYJpM+1/018=
Received: by 10.231.120.68 with SMTP id c4mr1603220ibr.152.1308443846935;
        Sat, 18 Jun 2011 17:37:26 -0700 (PDT)
Received: from elie (adsl-69-209-65-244.dsl.chcgil.ameritech.net [69.209.65.244])
        by mx.google.com with ESMTPS id gb8sm2299254ibb.26.2011.06.18.17.37.24
        (version=SSLv3 cipher=OTHER);
        Sat, 18 Jun 2011 17:37:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m31uyrutx7.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175994>

Hi,

Jakub Narebski wrote:
> Mike <xandrani@gmail.com> writes:

>> % git reset --hard HEAD~1
>
> Errr... here you screwed up.  This reset state of you working area to
> the state at last commit, removing all your changes to tracked files.

Or rather, here we screwed up.  Jakub and others gave some useful
advice about how to recover, so let's consider how the UI or
documentation could be improved to prevent it from happening again.

* In this example if I understand correctly then the index contained
  some useful information, perhaps about a larger commit intended for
  later.  To preserve that, you could have used

	git reset --soft HEAD~1

  which would _just_ undo the effect of "git commit", leaving the index
  and worktree alone.

* Another situation that comes up from time to time is making a change
  that just turned out to be a bad idea.  After commiting it, you might
  want to discard the erroneous change, like so:

	git reset --keep HEAD~1

  The "--keep" option uses some safeguards to make sure that only the
  committed change gets discarded, instead of clobbering local changes
  at the same time.

* In the early days of git, the "--keep" option did not exist.  So a lot
  of old documentation recommends to do

	git reset --hard HEAD~1

  which is the same if you don't have any local changes.

It would be useful to fix such documentation by adding a few words
about local changes.  Recently Duy wrote a patch to improve "reset -h"
output in that vein, but discussion drifted off:

 http://thread.gmane.org/gmane.comp.version-control.git/170266

I also sent a couple of documentation patches and then dropped the
ball:

 http://thread.gmane.org/gmane.comp.version-control.git/165358
 http://thread.gmane.org/gmane.comp.version-control.git/160319

If someone wants to pick any of these up and run with it, I wouldn't
mind (hey, I'd be happy).

Thanks for a useful example.
Jonathan
