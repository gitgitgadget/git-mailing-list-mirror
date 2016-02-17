From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 20/21] refs: add LMDB refs storage backend
Date: Wed, 17 Feb 2016 15:32:19 -0500
Organization: Twitter
Message-ID: <1455741139.7528.14.camel@twopensource.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
	 <1454701462-3817-21-git-send-email-dturner@twopensource.com>
	 <CACsJy8CWS9E0Jb4omm4k0=kZ73w9UoHmofLFCFHUhHu53zfgYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 21:32:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW8lz-0002c0-9v
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 21:32:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965452AbcBQUc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 15:32:26 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35425 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422775AbcBQUcW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 15:32:22 -0500
Received: by mail-qk0-f182.google.com with SMTP id o6so10767898qkc.2
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 12:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=HKvvx0s93S0MRL5q9VuUQTY+fRHo8xkES/aPvlU2caQ=;
        b=kIwKoKaVv2P0YKwDM9sYvYEuvDNiO6s1dKVfoxrZJDdxoBRTQTqqVTMC1Tuugz+jbC
         JkFqgLpBs8iJ3qhB+E51P6i9gnx2SiU0QFwc1L+lTECUJ58vTmFyx0GdRIDjGo7ieEWS
         sIdNLAGf+ZC5X9UsQT4Ui0piv8L1F4j93WXW6aOLvS8Oh1+z/AF+X59KtONp77wDv/Nx
         h8ee7Wp++NlbEf65S6EJ1A2l1uTOpCB0StmR8rlrwZuHsnp50IYNa3HtHzQdk6PcgX+E
         O+A+fOyKhyEAns3oLPbvS+42xXVjxGMLIrW9/BjTUJXoEM+ZnyBYhJ7qOevEIDQEykR0
         E6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=HKvvx0s93S0MRL5q9VuUQTY+fRHo8xkES/aPvlU2caQ=;
        b=GcqAdTgfU0vPfclBLMzAOxH91pj8kNHDQ4cCb/nO0AN84Be6gwOXK8u1rJt0uPSu8G
         gIyef/0XWhFsespVwBbXLsCuQZkW1wYKr6jjMgnzVOjymiJGxUvYFWWLSVIuGMYJcGi2
         nHu2JlVlfuvyTnnScfZI4yOS0a/Wte0OQ+IBkKw7HE73SO2mpK+GrNc06R1Mvp91sv5I
         cc5Mbhek5VTTFipaQhYXOJmrxurGFuG6b1wXour9/MZe2Z+yRVq8NNEE9TboQ7r+pc6A
         MVL7Ocgk96FTp0plHbZ4HgjHl1Hxds6X9SOn8DfdyAxrkKy/4618bDpR+2IUip14gYuo
         AQEw==
X-Gm-Message-State: AG10YOTvr248Slv4l3bVCs72sTTWRIrvfLHX15pSvvfpFENtn+1eJdFEefbCl1TxwR12Eg==
X-Received: by 10.55.75.131 with SMTP id y125mr4417904qka.61.1455741141597;
        Wed, 17 Feb 2016 12:32:21 -0800 (PST)
Received: from ubuntu ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id b6sm1226789qkh.12.2016.02.17.12.32.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Feb 2016 12:32:20 -0800 (PST)
In-Reply-To: <CACsJy8CWS9E0Jb4omm4k0=kZ73w9UoHmofLFCFHUhHu53zfgYw@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286544>

On Sun, 2016-02-14 at 19:04 +0700, Duy Nguyen wrote:
> On Sat, Feb 6, 2016 at 2:44 AM, David Turner <
> dturner@twopensource.com> wrote:
> > +static char *get_refdb_path(const char *base)
> > +{
> > +       static struct strbuf path_buf = STRBUF_INIT;
> > +       strbuf_reset(&path_buf);
> > +       strbuf_addf(&path_buf, "%s/refdb", base);
> > +       return path_buf.buf;
> > +}
> ...
> > +static int lmdb_init_db(struct strbuf *err, int shared)
> > +{
> > +       /*
> > +        * To create a db, all we need to do is make a directory
> > for
> > +        * it to live in; lmdb will do the rest.
> > +        */
> > +
> > +       if (!db_path)
> > +               db_path =
> > xstrdup(real_path(get_refdb_path(get_git_common_dir())));
> 
> This works for multiple worktrees. But scripts may have harder time
> getting the path. The recommended way is "git rev-parse --git-path
> refdb" but because "refdb" is not registered in path.c:common_list[],
> that command becomes git_path("refdb") instead of
> get_refdb(get_git_... like here. And I will need to know that
> .git/refdb is _not_ per-worktree when I migrate/convert main worktree
> (it's very likely I have to go that route to solve .git/config issue
> in multi worktree).

I'll fix common_list.  

> The solution is register refdb to common_list[] and you can do
> git_path("refdb") here. But then what happens when another backend is
> added? Will the new backend use the same path "refdb", or say
> "refdb.sqlite"? If all backends share the name "refdb", why can't we
> just reuse "refs" instead because the default filesystem-based 
> backend is technically just another backend?

I'll change it to "refs.lmdb".

I don't want to use "refs" because it makes it hard for software to
distinguish the format (in some cases, like sqlite, it won't even be a
directory).
