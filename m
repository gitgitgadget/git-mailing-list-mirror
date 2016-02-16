From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 20/21] refs: add LMDB refs storage backend
Date: Tue, 16 Feb 2016 17:01:21 -0500
Organization: Twitter
Message-ID: <1455660081.7528.8.camel@twopensource.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
	 <1454701462-3817-21-git-send-email-dturner@twopensource.com>
	 <CACsJy8CWS9E0Jb4omm4k0=kZ73w9UoHmofLFCFHUhHu53zfgYw@mail.gmail.com>
	 <CACsJy8AkWpVERj8=ABaQ89xe=6-DRLV5KBz9_sxW8TE4LUzcQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 23:01:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVngZ-00038N-2G
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 23:01:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756176AbcBPWBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 17:01:25 -0500
Received: from mail-qg0-f44.google.com ([209.85.192.44]:35016 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756010AbcBPWBY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 17:01:24 -0500
Received: by mail-qg0-f44.google.com with SMTP id y89so144929052qge.2
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 14:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=9wl6zFFogXewp01vYkHp7+MGyo4/d27t8A6WK+jjr5k=;
        b=xwgwMsgs/i0vRETIRlY75GBFyMnLyhTxjz5yqkqU786Px1VSnEOlqjUovYhSAPl424
         FzQpQqm2p/Cb/prqakKJrsYjcuDZZ0yy60EIxA0dOTVyn5ikKYG7+W+oYc6Q/tiRdVBd
         11aD63SIaDHqfaHo/Kzvhc9V0B8XTAu/jHKSlIzoOehAG9BcOX7rphrkDphA2zCYBxuM
         YrTuGbiUs8Zo4zZvudt9GEU0Oao+bfLQIufd40wAN6UsCHumtmVbDrfxKvKepjuVoOpS
         5YCrIBaGo41hc30IE3kK6c/Yc5dfkoBRJ5FV2A6KT5UL/LSIq/Q+pAwTVjc81MkEwj+Z
         v5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=9wl6zFFogXewp01vYkHp7+MGyo4/d27t8A6WK+jjr5k=;
        b=CV2GMy0RzEs+10Cd28CYBzLDjLO3fNoiUzhjHU9nu7+lajb9PQOWtP9uqACf3AmAi9
         bGVHdBFIJ5GGly69/oiIwNIMTls8uzj3BGO9VnsqzkmOjLDuFu7Z6NKjuj48Oucqs/e2
         fCWFeLYzSSci42qF6mlG5nlkVyej0fXAEHkWMZt3Ca7jCt/+QPyfkHbdlj3thxq2s4cH
         g9Omo25DEO2AF4O1uzyoDuF1+Zrm1jf7f1Fgb7n+kRBCcNFVOaxdt6Uj5JGLRn8SKxtL
         lL051CA2Poip6otk+MJw+wPufy0Jz3Ki33yVTOzAU2YDbRhUDX+Elh9fKg07Rrfz+76J
         +XAQ==
X-Gm-Message-State: AG10YOQ0ZzoeUpaCmU6xRlHHpuPNP6U59rEueICuDsAGmXl6ZIpD/rReeaWB7n0mIGs52Q==
X-Received: by 10.140.19.43 with SMTP id 40mr30585276qgg.72.1455660083530;
        Tue, 16 Feb 2016 14:01:23 -0800 (PST)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id b34sm14022606qgb.31.2016.02.16.14.01.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 16 Feb 2016 14:01:22 -0800 (PST)
In-Reply-To: <CACsJy8AkWpVERj8=ABaQ89xe=6-DRLV5KBz9_sxW8TE4LUzcQw@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286439>

On Mon, 2016-02-15 at 16:57 +0700, Duy Nguyen wrote:
> On Sun, Feb 14, 2016 at 7:04 PM, Duy Nguyen <pclouds@gmail.com>
> wrote:
> > On Sat, Feb 6, 2016 at 2:44 AM, David Turner <
> > dturner@twopensource.com> wrote:
> > > +static char *get_refdb_path(const char *base)
> > > +{
> > > +       static struct strbuf path_buf = STRBUF_INIT;
> > > +       strbuf_reset(&path_buf);
> > > +       strbuf_addf(&path_buf, "%s/refdb", base);
> > > +       return path_buf.buf;
> > > +}
> > ...
> > > +static int lmdb_init_db(struct strbuf *err, int shared)
> > > +{
> > > +       /*
> > > +        * To create a db, all we need to do is make a directory
> > > for
> > > +        * it to live in; lmdb will do the rest.
> > > +        */
> > > +
> > > +       if (!db_path)
> > > +               db_path =
> > > xstrdup(real_path(get_refdb_path(get_git_common_dir())));
> > 
> > This works for multiple worktrees. But scripts may have harder time
> > getting the path. The recommended way is "git rev-parse --git-path
> > refdb" but because "refdb" is not registered in
> > path.c:common_list[],
> > that command becomes git_path("refdb") instead of
> > get_refdb(get_git_... like here. And I will need to know that
> > .git/refdb is _not_ per-worktree when I migrate/convert main
> > worktree
> > (it's very likely I have to go that route to solve .git/config
> > issue
> > in multi worktree).
> > 
> > The solution is register refdb to common_list[] and you can do
> > git_path("refdb") here. But then what happens when another backend
> > is
> > added? Will the new backend use the same path "refdb", or say
> > "refdb.sqlite"? If all backends share the name "refdb", why can't
> > we
> > just reuse "refs" instead because the default filesystem-based
> > backend
> > is technically just another backend?
> 
> To answer myself: I forgot that there were per-worktree refs (e.g.
> refs/bisect). It makes me wonder if we should put per-worktree refs
> to
> lmdb as well (maybe one per worktree if we don't want to put all in
> one db). One of the advantages of moving away from fs-based backend
> is
> the ability to deal with case sensitivity, "nested" refs (e.g. a/b
> and
> a/b/c are both refs).

I don't think case-sensitivity is a huge problem here: per-worktree
refs are now HEAD or refs/bisect/*, and refs/bisect is controlled
entirely by the bisection machinery (that is, it won't have user
-defined refs with case conflicts).

>  With this split, I think some refs are still
> left behind.. Sorry if this was discussed before, I haven't followed
> this closely.

Previous discussion:
http://comments.gmane.org/gmane.comp.version-control.git/275097
