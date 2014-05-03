From: David Turner <dturner@twopensource.com>
Subject: Re: Watchman support for git
Date: Sat, 03 May 2014 00:39:46 -0400
Organization: Twitter
Message-ID: <1399091986.5310.20.camel@stross>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
	 <CACsJy8C72QQZd4v+p4bkFFKHnN2Uj1zD-BELwGtYB7sx1P6q6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 03 06:40:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgRjw-0007EC-J6
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 06:39:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbaECEjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 00:39:51 -0400
Received: from mail-qc0-f180.google.com ([209.85.216.180]:62033 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbaECEjv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 00:39:51 -0400
Received: by mail-qc0-f180.google.com with SMTP id i17so5037819qcy.11
        for <git@vger.kernel.org>; Fri, 02 May 2014 21:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=x5ZQs1+3oLdM/jcNnVyvUFxlI0RsV4plIPXo2oJ+yxw=;
        b=aspuWJY0l5mLpfSEO6TixMSBKz9v3ebaK65yN/fGZI4+aVAZaGq8BVPqeoqen2iYfo
         /7EH5S1CoeYlyTo/2Tz4pDvRlJMqE+Adr+iRivXTjP8QSjiqDr7khMm1yN+Vueb1gDJ4
         7gVxxoDTBn9vJFsm7PtEMeHH6ANct0Me0k7aMBj4+oEn9psp4gfmYeRV3afuuRMXtO49
         Z3QnBEEFpxVFzJeJGKllqmfeQIU+NQ6aLN74anQyZyOYCaxJBx57ayg6r+PkS7bu0BmW
         uQSlKSQdBUupNnE+TZJuLg0J5QUtJd88D7dZrE0C/gEfjrISSs8nKd+GjMKk2eVSapjb
         sViw==
X-Gm-Message-State: ALoCoQnd0tKe6C1piWJ2yD8opM4o5QtV6tvOKFIxkkxEQskCpGwPwFYwypgQgo7UVT1BfC/zaoyh
X-Received: by 10.140.30.161 with SMTP id d30mr25866881qgd.62.1399091990330;
        Fri, 02 May 2014 21:39:50 -0700 (PDT)
Received: from [172.18.25.156] ([8.25.196.25])
        by mx.google.com with ESMTPSA id k9sm2280739qat.18.2014.05.02.21.39.48
        for <git@vger.kernel.org>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Fri, 02 May 2014 21:39:49 -0700 (PDT)
In-Reply-To: <CACsJy8C72QQZd4v+p4bkFFKHnN2Uj1zD-BELwGtYB7sx1P6q6g@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248017>

On Sat, 2014-05-03 at 07:52 +0700, Duy Nguyen wrote:
> On Sat, May 3, 2014 at 6:14 AM,  <dturner@twopensource.com> wrote:
> > The index format change might be less important with the split index;
> > I haven't investigated that since at the time I wrote these patches,
> > it didn't exist.
> 
> This is the worst case scenario of "git status" on webkit.git (182k
> files, path name 74 byte long on average), hot cache, no SSD
> 
>    366.379ms gitmodules_config:199 if (read_cache() < 0) die("index file
>      0.004ms cmd_status:1294 read_cache_preload(&s.pathspec);
>    488.433ms cmd_status:1295 refresh_index(&the_index, REFRESH_QUIE
>    456.495ms cmd_status:1299 update_index_if_able(&the_index, &inde
>     13.088ms wt_status_collect:616 wt_status_collect_changes_worktree(s)
>    706.926ms wt_status_collect:621 wt_status_collect_changes_index(s)
>    100.495ms lazy_init_name_hash:136 { int nr; if (istate->name_hash_initia
>    921.185ms wt_status_collect:622 wt_status_collect_untracked(s)
> 
> real    0m2.969s
> user    0m1.943s
> sys     0m1.021s

For me, those times are:
0m0.581s (no watchman, index v4)
0m0.465s (watchman, index v4)
0m0.445s (watchman, index v5)

That's not huge win on its own, but (a) it's better than nothing and (b)
it lays the groundwork for other improvements.

A fair amount (~12%) of the time seems to be spent in zlib; this varies
based on how the data is packed IIRC. 

> Index v4 and split index (and the following read-cache daemon,
> hopefully) 

Looking at some of the archives for read-cache daemon, it seems to be
somewhat similar to watchman, right?  But I only saw inotify code; what
about Mac OS?  Or am I misunderstanding what it is?

> should help reduce numbers of the 1st and 4th lines, I
> expect to less than 50ms each line. lazy_init_name_hash could be taken
> away with read-cache daemon also.
> 
> core.preloadindex can cut the total number of 2nd and 3rd lines by
> half. Watchman should help in these two lines, but it should do better
> than core.preloadindex.
> 
> wt_status_collect_changes_index() depends on how damaged cache-tree is
> (in this case, totally scraped). watchman does not help this either.
> We need to try to "heal" cache-tree as much as possible to reduce the
> number.
> 
> The last line could be a competition between watchman and my coming
> "untracked cache" series. I expect to cut the number in that line at
> least in half without external dependency.

I hadn't seen the "untracked cached" work (I actually finished these
patches a month or so ago but have been waiting for some internal
reviews before sending them out).  Looks interesting.  It seems we use a
similar strategy for handling ignores.

> Patch 2/3 did not seem to make it to the list by the way.. 

Thanks for your comments.  I just tried again to send patch 2/3.  I do
actually see the CC of it in my @twitter.com mailbox, but I don't see it
in the archives on the web.  Do you know if there is a reason the
mailing list would reject it?  At any rate, the contents may be found
at 
https://github.com/dturner-tw/git/commit/cf587d54fc72d82a23267348afa2c4b60f14ce51.diff

> initial
> reaction is storing the list of all paths seems too much, but I'll
> need to play with it a bit to understand it.

I wonder if it would make sense to use the untracked cache as the
storage strategy, but use watchman as the update strategy.
