From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 19/20] refs: add LMDB refs backend
Date: Tue, 19 Jan 2016 13:55:33 -0500
Organization: Twitter
Message-ID: <1453229733.16226.33.camel@twopensource.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
	 <1452788777-24954-20-git-send-email-dturner@twopensource.com>
	 <20160115133317.GJ10612@hank>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 19:55:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLbRN-0006bZ-4x
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 19:55:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757162AbcASSzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 13:55:37 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:35247 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755507AbcASSzf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 13:55:35 -0500
Received: by mail-qg0-f47.google.com with SMTP id o11so586999316qge.2
        for <git@vger.kernel.org>; Tue, 19 Jan 2016 10:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=85BsnnB0BtT6uP316IFegEa0GKsIUO/9E3xB/upB4yo=;
        b=BSTgVXqC2q3XH94c4uocWqqDi1vEOZHUWT4fCGVrEnfWpUzBBvtGZN0tuTWcJbFs7n
         EEy9SnnI9JmQSXT8VP/rqXzjcBOemimW0IEIgN+q4nPdEUw7DQ7w0pZ66T0lzhLoUCq0
         E27JxpX5yEgw3QkRsiYk1TVLKe+OVMZNWCI1lFkJ6KAOXyesMQXBMttdRHCDRHbP+h9H
         gEymcqdYavGZK3ZciKwC4M1GV4oy8EBQhGdVInfKjCbPTcB6qY5i+CfmEO6wWJAXKIK4
         LYfwybbsjLnVpmrwH7tehrDzIii8BgqTi4AkrGC76oN3cXTtGtXfXnVB2Y2fUO8W7w1S
         IgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=85BsnnB0BtT6uP316IFegEa0GKsIUO/9E3xB/upB4yo=;
        b=nM5sgWtICa6+r8pRuPYVQaIULFyVsPXYosKJDbPw/mwbkbljGq8/gfCzLZ8oVtVj/6
         eU0+6l3/CHqw55OKuVABI5k6XsHygmNxS1klM713wwklcNAkPT6cIUsJP2b/JcJE3MeK
         zpaocU03TAN/3faK9LugtT6iE9CyMjbqcRVYUK78fdS9TN2oFkwcAzGrjRRuv0PKxyVN
         4mvfxWyV5rJys2OwsrqSfETTg8n4ItNWWyHq/qtKZfw6KmhCdN7q3k12pQdlicUlJfg3
         s7AzFRf7W8ivS5xOnHDcur7RptK2vQ8SXUWO/SjIk+tEK6YQF38HzBZW2caj5Wo8bYfY
         kFaA==
X-Gm-Message-State: ALoCoQlh5iHpH/UxHGcYd4sy8MT8JGrtzIutcENvnd2AFFXyUnAFH5YfZXhud3HBK1pMcLYCE9KLXlJPtMRKMoPe00K4iLaDqA==
X-Received: by 10.140.132.212 with SMTP id 203mr41075453qhe.102.1453229734946;
        Tue, 19 Jan 2016 10:55:34 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id l139sm12670594qhc.24.2016.01.19.10.55.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Jan 2016 10:55:34 -0800 (PST)
In-Reply-To: <20160115133317.GJ10612@hank>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284371>

On Fri, 2016-01-15 at 14:33 +0100, Thomas Gummerer wrote:
> [I don't know too much about the refs code, but was still interested
> in this patch series, so below are the few things that I noticed
> while
> reading through it.]

Thanks for taking a look.

> On 01/14, David Turner wrote:

> > +exists.  The header has the same format as an ordinary reflog, but
> > with
> > +a timeztamp of all zeros and an empty value.
> 
> s/timeztamp/timestamp/

Fixed, thanks.

> > +test "$(git config extensions.refstorage)" = "lmdb" && die "git
> > -new-workdir is incompatible with the refs lmdb storage"
> > +
> 
> Is it expected that other potential ref backends are compatible with
> git-new-workdir?  Otherwise I think it would make more sense to
> whitelist the files backend here instead of blacklisting the lmdb
> backend, so we don't risk forgetting about this when adding another
> backend.

I no longer remember what the exact issue was, but we can be safe and
restrict git-new-workdir to the files backend (since it looks likely
that worktrees will replace it anyway).

> >  case "$git_dir" in
> >  .git)
> >  	git_dir="$orig_git/.git"
> 
> [...]
> 
> > +static int lmdb_init_db(struct strbuf *err, int shared)
> > +{
> > +	/*
> > +	 * To create a db, all we need to do is make a directory
> > for
> > +	 * it to live in; lmdb will do the rest.
> > +	 */
> > +
> > +	if (!db_path)
> > +		db_path =
> > xstrdup(real_path(get_refdb_path(get_git_common_dir())));
> 
> I think we're leaking some memory from get_refdb_path() here.
> get_refdb_path() uses strbuf_detach(), which according to its
> docstring
> makes its caller take care of the memory of the returned string.
> real_path() then uses strbuf_addstr() to add the string to its
> internal strbuf, but leaves the string we get from get_refdb_path()
> alone, so it leaks.

That only happens once per run, since db_path is set afterwards, but
I'll change get_refdb_path() to return a pointer to a statically
allocated string (as many similar funcs do).  That will be easier to
read.
