From: Alexander Potashev <aspotashev@gmail.com>
Subject: Re: [PATCH 2/2] Use is_pseudo_dir_name everywhere
Date: Fri, 9 Jan 2009 13:24:07 +0300
Message-ID: <20090109102407.GA4089@myhost>
References: <1231457063-29186-1-git-send-email-aspotashev@gmail.com> <1231457063-29186-2-git-send-email-aspotashev@gmail.com> <1231457063-29186-3-git-send-email-aspotashev@gmail.com> <4966F6BB.90408@viscovery.net> <4966FB36.2030409@viscovery.net> <7vy6xk280e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 11:25:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLEYH-0003ug-Co
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 11:25:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612AbZAIKXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 05:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752844AbZAIKXy
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 05:23:54 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:52030 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbZAIKXx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 05:23:53 -0500
Received: by bwz14 with SMTP id 14so28689836bwz.13
        for <git@vger.kernel.org>; Fri, 09 Jan 2009 02:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=F5MMI71RGR7nSe6rZdI5s+V3viIkt0MGGZprmAliNxw=;
        b=YUmsUN6c1RNTBNn0+Gfc/6nP0sl7Sxs8ObsyeSFtPhhRC7XxaPLZjuS5DYqLohX1oy
         fYr7lTkLS+JdCV4aEDGnvKt+FU9GlkC4GbyLo19zMWkL1wB8tkLmntGbhTXPpngTYcPG
         TKh/WLGx/iezO9He7jlFZ5r7yTvoqeCx7tgac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=supgX+XKvM97PhqQXm7GH3RlHVGVzEL/Ykux8uwXpDHzBjB3atd3nwxEmaYgh750ZC
         CvatETnmqZPZ6Mv7te8P5IrlIpUxvSWa5RxqkYvZ3hAlsEEyCSsoo0M+b450Ej3eQgl9
         y/oaYInV/5c3wSdJZYnEz+HFG8lZpIhN7ge3c=
Received: by 10.223.110.144 with SMTP id n16mr18384619fap.55.1231496630707;
        Fri, 09 Jan 2009 02:23:50 -0800 (PST)
Received: from smtp.gmail.com (ppp91-77-12-84.pppoe.mtu-net.ru [91.77.12.84])
        by mx.google.com with ESMTPS id 21sm27741295fkx.20.2009.01.09.02.23.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Jan 2009 02:23:50 -0800 (PST)
Received: by smtp.gmail.com (sSMTP sendmail emulation); Fri, 09 Jan 2009 13:24:07 +0300
Content-Disposition: inline
In-Reply-To: <7vy6xk280e.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105001>

On 00:33 Fri 09 Jan     , Junio C Hamano wrote:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
> > Johannes Sixt schrieb:
> >> Alexander Potashev schrieb:
> >>> -		if ((ent->d_name[0] == '.') &&
> >>> -		    (ent->d_name[1] == 0 ||
> >>> -		     ((ent->d_name[1] == '.') && (ent->d_name[2] == 0))))
> >>> +		if (is_pseudo_dir_name(ent->d_name))
> >> 
> >> Nit-pick: When I read the resulting code, then I will have to look up that
> >>   is_pseudo_dir_name() indeed only checks for "." and "..". But if it were
> >> named is_dot_or_dotdot(), then I would have to do that.
> >
> > ... then I would *not* have to do that, of course.
> 
> I think the unstated motivation of this choice of the name is to keep the
> door open to include lost+found and friends to the repertoire, and perhaps
> to have an isolated place for customization for non-POSIX platforms and
> for local conventions.  It is more like is_uninteresting_dirent_name().

I didn't think over the support of 'lost+found'. But the name like
is_uninteresting_dirent_name is more flexible, indeed. I prefer a bit
shorter name, 'is_dummy_dirent_name'.

But if you're going to support 'lost+found's, remember that a Git
repository might have its own 'lost+found' directory. It's a bit crazy,
but it's possible:
	---
	 lost+found/file |    1 +
	 1 files changed, 1 insertions(+), 0 deletions(-)
	 create mode 100644 lost+found/file

	diff --git a/lost+found/file b/lost+found/file
	new file mode 100644
	index 0000000..190a180
	--- /dev/null
	+++ b/lost+found/file
	@@ -0,0 +1 @@
	+123
	-- 

Git shouldn't allow to clone at least repositories that have lost+found
directory into a directory with already existing lost+found (neither
it's a ordinary directory created using 'mkdir' nor it's an ext2's
property)

We should probably forbid cloning to a directory with lost+found,
because a 'lost+found' may appear after pulling from somebody and the
user won't be able to resolve this anyhow.

> 
> As long as this function is used only to detect and skip "uninteresting"
> dirent, I think that is not a bad direction.
> 
> On the other hand, I am a bit worried about is_empty_dir() abused outside
> its intended purpose to say "this directory does not have anything
> interesting".  E.g. "Oh, it's empty so we can nuke it":

I propose to rename it (if it's really necessary) to is_clean_dir, which
means "There's no old crap here, we can safely clone".

> 
> 	if (is_empty_dir(dir))
>         	rmdir(dir);
> 
> even though the current callers do not do something crazy like this (the
> usual order we do things is rmdir() and then check for errors).

I think, it's rather early to send [PATCHES v2] (with updated function
names), will wait for your comments.
