From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git rescue mission
Date: Fri, 9 Feb 2007 01:03:04 +0100
Message-ID: <200702090103.05510.jnareb@gmail.com>
References: <17866.27739.701406.722074@lisa.zopyra.com> <20070208233324.GA1556@spearce.org> <17867.46325.433406.974582@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Fri Feb 09 01:01:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFJCp-0000yv-4o
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 01:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422710AbXBIABa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 19:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933329AbXBIABa
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 19:01:30 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:51249 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933225AbXBIABa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 19:01:30 -0500
Received: by ug-out-1314.google.com with SMTP id 44so624528uga
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 16:01:28 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uPamA1ZC+dnTh56d9bKUWC67j85wClkCm+0sedLN7O/fcAZZwLH3zAmD8UUgjy5OjotCttrOmdQZ88An8hRewNCPbwb7A9gt6UeBkZkmqhGaTuwMi5TArZ04Gn60gAygPqdjb1DjvHAYNJWFx+29iSjQQapu7USkXh9LOvUWVUM=
Received: by 10.78.157.8 with SMTP id f8mr4679911hue.1170979288237;
        Thu, 08 Feb 2007 16:01:28 -0800 (PST)
Received: from host-81-190-29-4.torun.mm.pl ( [81.190.29.4])
        by mx.google.com with ESMTP id 32sm3958630ugf.2007.02.08.16.01.27;
        Thu, 08 Feb 2007 16:01:28 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <17867.46325.433406.974582@lisa.zopyra.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39134>

Bill Lear wrote:
> On Thursday, February 8, 2007 at 18:33:24 (-0500) Shawn O. Pearce writes:
>> Bill Lear <rael@zopyra.com> wrote:
>>>
>>> With regard to the new version and old repos, am I correct in assuming
>>> that we can upgrade our old repo (a bare one) to the new git by first
>>> installing the new git, and then doing this:
>>> 
>>> % cd /repos/git
>>> % mv project project.old_git
>>> % git --bare clone project.old_git project
>>> 
>>> or is there something else we must do?
>>
>> In the case of a bare repo, there isn't anything to do.
> 
> So, I assume I need to tell our developers that once we have installed
> the new git, they will need to set aside their old repos and just
> clone again from our company repo?

Nope.


1. New git works with old repositories, and would continue to work.
Nevertheless you need new layout and new configuration to make use
of some new features.


2. They need to clone _their own_ repositories. It's the simplest
way, but


3. You can simply

 a) convert remotes configuration from .git/remotes/origin file
    to .git/config using remotes2config.sh script in contrib area
    of git, or http://repo.or.cz/w/git.git?a=blob_plain;f=contrib/remotes2config.sh

 b) hand edit remotes configuration to use globbing for refspec,
    and per branch configuration

If old repository was _not_ cloned with --use-separate-remote (using
separate remote layout), you would also have to:

 c) move branches from old layout to new layout using "git branch -m"
    command: 'refs/heads/origin' branch to 'refs/remotes/origin/master',
    all branches except 'master' (refs/heads/master) from 
    'refs/heads/<branch>' to 'refs/remotes/origin/<branch>'.

That's all. You have new layout and new configuration without re-cloning.

-- 
Jakub Narebski
Poland
