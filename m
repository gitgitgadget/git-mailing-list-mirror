From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetool--lib: add support for p4merge
Date: Wed, 28 Oct 2009 02:36:56 -0700
Message-ID: <20091028093655.GC90780@gmail.com>
References: <1256721087-72534-1-git-send-email-jaysoffian@gmail.com>
 <76718490910280221u4e1d3e78me7f9b0b45f590e56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O . Pearce" <spearce@spearce.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 10:37:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N34xp-0008KK-TD
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 10:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082AbZJ1Jg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 05:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754051AbZJ1Jg4
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 05:36:56 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:60018 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754040AbZJ1Jgz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 05:36:55 -0400
Received: by yxe17 with SMTP id 17so474758yxe.33
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 02:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=rNskZYL8gYxbwrZcqHevMdC8j6RpuRnoaPwiaxcz6UI=;
        b=FXO45+mmxU9RGSKBoP0w9tC0V7idXxEWNM/s7QvPriiXvh6T9x3tLlZ+usvVwnHNZc
         BLGZtOrBix1jWijfb3q1VP5rc5kUc0H9t+Aelf/24MwYbZRZHKjob2JSsK+4BdfFrXf/
         ++N8nYhv7x3JNepYcQBP8Dk3kICQubayrhNcI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XtOrm30tsUJzr4v7ZsCEmyiB1OuVyXk5/4/RI5F21hPiZVjJTdYMkgvYmvmntLMz0c
         vIR4JAW0VYn3TgBXtYk14v64a5xXrMMF07PzgUYtLvNcboA4HgnMHbVf7EFQruykLUI0
         YAjl0FfKv9i3rPtljNWHqIn1I/fxRoAkxkMfU=
Received: by 10.90.37.37 with SMTP id k37mr3369600agk.64.1256722620277;
        Wed, 28 Oct 2009 02:37:00 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 4sm365700yxd.16.2009.10.28.02.36.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 02:36:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <76718490910280221u4e1d3e78me7f9b0b45f590e56@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131441>

On Wed, Oct 28, 2009 at 02:21:46AM -0700, Jay Soffian wrote:
> 
> But, in my testing, for things to work properly I needed to use
> launchp4merge per:
> 
> http://kb.perforce.com/AllPerforceApplications/StandAloneClients/P4merge/CommandLineP..rgeOnMacOsX
> 
> And I also found things didn't work properly unless I provided an absolute path.
> 
> (Aside, the "right" way to launch p4merge, at least on 10.6 would be:
> 
> /usr/bin/open -b com.perforce.p4merge -W -n --args <args to p4merge...>


:(

I tested on 10.5, so there's definitely some difference in
behavior since difftool.p4merge.path is all that was needed here
(with an absolute path as I mentioned).


> This way OS X's launch services would find p4merge.app wherever it is
> on the user's system. But, I think some of these options to open are
> 10.6 specific and in practice looking in /Applications and
> $HOME/Applications I think is a sane enough default.)

We've stayed away from hard-coding any platform-specific paths
in mergetool--lib in the past.  It's a practicality thing --
trying to guess all of the possible installation locations is
simply untenable.

Here's an old thread where we talked about this in the context
of ecmerge:

http://thread.gmane.org/gmane.comp.version-control.git/118125/focus=118182


Let me know what you think.

-- 
		David
