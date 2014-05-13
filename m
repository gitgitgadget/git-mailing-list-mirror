From: David Turner <dturner@twopensource.com>
Subject: Re: Watchman support for git
Date: Tue, 13 May 2014 18:38:27 -0400
Organization: Twitter
Message-ID: <1400020707.14179.13.camel@stross>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
	 <CACsJy8B6AVOHH7HhreqvusQN=UFZzj1mkjqekrOb62Lmq_8VQw@mail.gmail.com>
	 <1399747109.11843.137.camel@stross>
	 <CACsJy8Cazm+6ixw3r8WYfdFYeD01Lmf0PSF0sdsh7PGy_6WDTQ@mail.gmail.com>
	 <1399848982.11843.161.camel@stross>
	 <CACsJy8C_j2bKVwqOQtOqGFkc_-_AmY=bQXquRfL-aqk=z9YKdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 00:38:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkLLH-0003zW-RV
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 00:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754499AbaEMWic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 18:38:32 -0400
Received: from mail-qc0-f172.google.com ([209.85.216.172]:54157 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870AbaEMWib (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 18:38:31 -0400
Received: by mail-qc0-f172.google.com with SMTP id l6so1482927qcy.3
        for <git@vger.kernel.org>; Tue, 13 May 2014 15:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=DopAjDl/K0m62lkBcg5XplCgk7+PLNykfzUksGwOZkQ=;
        b=UnCAZShp1WeeL4XI8NJkeyar76X2LSTc8Olao/lQxmQufHcG29Npk8Be7OX4FOPShT
         hyH5cJ0HdkDe9soaTAOC1WbHFRwI7UvkaNwU8kvby62Oh/qlG6LXkiuCoyDP1WyjTcip
         Q3uGBmIVz/qo8LbOjQqvLR4UUYIVXB8kBLaHdGpbd5tvJjjn0RTh3mu1T3o7AiD++oXS
         9gtTtHLd/uGYtFf8Hb0qZlEc2My6jWzp8iCFD1LyETyxy1kC/NZ5aEd5avYK/ua7PVXf
         R1NigE4NoaR+fqNMeC+9ARKf7cyd9NWPtA5HXepUB/5ECywD7QlNvNcdr2VNa0TYW0vG
         9I5A==
X-Gm-Message-State: ALoCoQk1sWkMZTvBhRaaWyOfwFuefGBBQhQjbGgvij1TPi39RPEUYOlVWLJkoJy3cADPIMzCI0Ru
X-Received: by 10.140.51.74 with SMTP id t68mr49667827qga.50.1400020710187;
        Tue, 13 May 2014 15:38:30 -0700 (PDT)
Received: from [172.17.2.145] ([38.104.173.198])
        by mx.google.com with ESMTPSA id l46sm12808465qga.21.2014.05.13.15.38.28
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Tue, 13 May 2014 15:38:29 -0700 (PDT)
In-Reply-To: <CACsJy8C_j2bKVwqOQtOqGFkc_-_AmY=bQXquRfL-aqk=z9YKdw@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248876>

On Mon, 2014-05-12 at 17:45 +0700, Duy Nguyen wrote:
> This is your quote from above, moved down a bit:
> 
> > update_fs_cache should only have to update based on what it has learned
> > from watchman.  So if no .gitignore has been changed, it should not have
> > to do very much work.
> >
> > I could take the fe_excluded check and move it above the
> > last_exclude_matching check in fs_cache_is_excluded; it causes t7300 to
> > fail when run under watchman but presumably that's fixable
> 
> So you exclude files early and make the real read_directory() pass do
> pretty much nothing. This is probably not a good idea. Assume that I
> touch $TOP/.gitignore then do something other than "git status" (or
> "git add") then I have to pay read_directory() cost.

I'm not sure I understand this. read_directory does something: it checks
the fs_cache (instead of the filesystem) for untracked files.

> Back to the open vs fs_cache_open and the number of .gitignore files
> above. I touch $TOP/.gitignore then do "git status" to make it read
> all .gitignore files (6k of them) and change between open and
> fs_cache_open. I think the numbers still  do not make any visible
> difference (~1620-1630ms).

Yes, I would expect no win in that case.  fs_cache_open will only save
time in the common case where there is no .gitignore file, because it
saves an open() call.  If every possible .gitignore file exists, of
course it makes no difference.  But also, your processor may be
sufficiently slow that the context-switch penalty for open() is less
than the hash table lookup.  

For me, the win from fs_cache_open is about 7%.  
