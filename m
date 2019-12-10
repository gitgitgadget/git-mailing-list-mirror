Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADCEC43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 22:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290C720836
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 22:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W3u4Za5u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbfLJWfG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:35:06 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34934 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfLJWfE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 17:35:04 -0500
Received: by mail-pj1-f68.google.com with SMTP id w23so7990113pjd.2
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 14:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bDqzFhUq8AbLKLxt5BEd7HIV9I7d4Wtn11hiBINxd4I=;
        b=W3u4Za5uUEIL3ss9Y/ZC6VjF8EIRcm7haVmST2v6Z9EUYShVdrgrtbnk+oJBy/PM2U
         /1MaylLgYDzSwD93d2UCs0lx3uH88HAdmLkdwaYd38Y+hmryGsqvRPlqKttZxEv/8T9z
         JNJLINXKmPBIlas0TqKwByTxqkEixv9RdFghsIybU+H4AXP2sxMICPptLqvh/grrGDjw
         5YezoaFCdAfcUW+QSiRwc1IrV02X7M4d7n+V7INJIK9Afj155RZF5USqS11M1exp3Aya
         IOp+EX8b7Z+Ac9Xdu594JOwiL37ARs5mxMCYpQ1LwXz5gwPSKEkHOBmoOYqjN4u85Ts9
         MLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bDqzFhUq8AbLKLxt5BEd7HIV9I7d4Wtn11hiBINxd4I=;
        b=YQNOu4cGU2Yck6wxyJciiBseZc6yX+2vBVnTpbG+6CGJBKtNNGLjSgDAA5T0imRrbT
         la1PzcpFqMwtABA9CQkyG06R3jzYq/FS+PP92E3J0gJYsKiol4DzjTMGV4zJjXVBNqAy
         CcSFI+6hT1Cg96gP/QS6U/lMvMv/Vu6EmcMWcsr43cq0nYQq64euFOdBugs9KySMl78H
         rj5KxTSX+R0AAF5kgasCuxNfvpaHTAAbicL+3QU36u41bzP9GiHLdxzW7d5NOQqF4zWb
         qfXIr9OBwIFPQUpyLBFB1uQ7UcQGGLO9Tbt9zXYhVGfqiNRHnSKkJelIomIM37ibEOqh
         ZK8w==
X-Gm-Message-State: APjAAAWJi9TGLajY6//Zp5iJ7XOq/g11U1m1Aevblp8W48Dk32hLEZiM
        l3uJEL4JHazqz4sFbmXRGb2CMFXUmYA=
X-Google-Smtp-Source: APXvYqwSBZyUmRr0TvWvgtLOX6KZUEaaLTOiB+bPYyughhSB853A9cuAeMNftVjMG0eW8kCQiY0a3w==
X-Received: by 2002:a17:902:6b4b:: with SMTP id g11mr37819464plt.196.1576017303681;
        Tue, 10 Dec 2019 14:35:03 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id z4sm65395pfn.42.2019.12.10.14.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 14:35:02 -0800 (PST)
Date:   Tue, 10 Dec 2019 14:34:57 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 6/9] bugreport: count loose objects
Message-ID: <20191210223457.GA107889@google.com>
References: <20191025025129.250049-1-emilyshaffer@google.com>
 <20191025025129.250049-7-emilyshaffer@google.com>
 <nycvar.QRO.7.76.6.1910281540550.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910281540550.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 28, 2019 at 04:07:40PM +0100, Johannes Schindelin wrote:
> Hi Emily,
> 
> On Thu, 24 Oct 2019, Emily Shaffer wrote:
> 
> > The number of unpacked objects in a user's repository may help us
> > understand the root of the problem they're seeing, especially if a
> > command is running unusually slowly.
> >
> > Rather than directly invoking 'git-count-objects', which may sometimes
> > fail unexpectedly on Git for Windows, manually count the contents of
> > .git/objects. Additionally, since we may wish to inspect other
> > directories' contents for bugreport in the future, put the directory
> > listing into a helper function.
> 
> Thank you, much appreciated!
> 
> I guess the next step is to count the number of packs, and the number of
> submodules ;-)
> 
> >
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> >  bugreport.c         | 72 +++++++++++++++++++++++++++++++++++++++++++++
> >  bugreport.h         |  6 ++++
> >  builtin/bugreport.c |  4 +++
> >  3 files changed, 82 insertions(+)
> >
> > diff --git a/bugreport.c b/bugreport.c
> > index 9d7f44ff28..54e1d47103 100644
> > --- a/bugreport.c
> > +++ b/bugreport.c
> > @@ -5,8 +5,11 @@
> >  #include "exec-cmd.h"
> >  #include "help.h"
> >  #include "run-command.h"
> > +#include "strbuf.h"
> 
> Why not append this to the end of the `#include` list, as is common in
> Git's commit history?
> 
> >  #include "version.h"
> >
> > +#include "dirent.h"
> 
> This header (although with pointy brackets instead of double quotes) is
> already included in `git-compat-util.h`
> 
> > +
> >  /**
> >   * A sorted list of config options which we will add to the bugreport. Managed
> >   * by 'gather_whitelist(...)'.
> > @@ -147,3 +150,72 @@ void get_populated_hooks(struct strbuf *hook_info)
> >  		}
> >  	}
> >  }
> > +
> > +/**
> > + * Fill 'contents' with the contents of the dir at 'dirpath'.
> 
> Since you start this comment in JavaDoc style, there should be an almost
> empty line after this one ("almost" because it still contains the
> asterisk, of course).
> 
> > + * If 'filter' is nonzero, the contents are filtered on d_type as 'type' - see
> > + * 'man readdir'. opendir() doesn't take string length as an arg, so don't
> > + * bother passing it in.
> > + */
> > +void list_contents_of_dir(struct string_list *contents, struct strbuf *dirpath,
> 
> Shouldn't this be `static`?
> 
> > +			  int filter, unsigned char type)
> > +{
> > +	struct dirent *dir = NULL;
> > +	DIR *dh = NULL;
> > +
> > +	dh = opendir(dirpath->buf);
> > +	while (dh && (dir = readdir(dh))) {
> > +		if (!filter || type == dir->d_type) {
> > +			string_list_append(contents, dir->d_name);
> > +		}
> > +	}
> > +}
> > +
> > +
> > +void get_object_counts(struct strbuf *obj_info)
> 
> Oops. This function is no longer used.
> 
> > +{
> > +	struct child_process cp = CHILD_PROCESS_INIT;
> > +	struct strbuf std_out = STRBUF_INIT;
> > +
> > +	argv_array_push(&cp.args, "count-objects");
> > +	argv_array_push(&cp.args, "-vH");
> > +	cp.git_cmd = 1;
> > +	capture_command(&cp, &std_out, 0);
> > +
> > +	strbuf_reset(obj_info);
> > +	strbuf_addstr(obj_info, "git-count-objects -vH:\n");
> > +	strbuf_addbuf(obj_info, &std_out);
> > +}
> > +
> > +void get_loose_object_summary(struct strbuf *obj_info)
> > +{
> > +	struct strbuf dirpath = STRBUF_INIT;
> > +	struct string_list subdirs = STRING_LIST_INIT_DUP;
> > +	struct string_list_item *subdir;
> > +
> > +	strbuf_reset(obj_info);
> > +
> > +	strbuf_addstr(&dirpath, get_object_directory());
> > +	strbuf_complete(&dirpath, '/');
> > +
> > +	list_contents_of_dir(&subdirs, &dirpath, 1, DT_DIR);
> > +
> > +	for_each_string_list_item(subdir, &subdirs)
> > +	{
> > +		struct strbuf subdir_buf = STRBUF_INIT;
> > +		struct string_list objects = STRING_LIST_INIT_DUP;
> > +
> > +		/*
> > +		 * Only interested in loose objects - so dirs named with the
> > +		 * first byte of the object ID
> > +		 */
> > +		if (strlen(subdir->string) != 2 || !strcmp(subdir->string, ".."))
> > +			continue;
> > +
> > +		strbuf_addbuf(&subdir_buf, &dirpath);
> > +		strbuf_addstr(&subdir_buf, subdir->string);
> > +		list_contents_of_dir(&objects, &subdir_buf, 0, 0);
> > +		strbuf_addf(obj_info, "%s: %d objects\n", subdir->string,
> > +			    objects.nr);
> 
> Hmm. Not only does this leak `objects`, it also throws away the contents
> that we so painfully constructed.
> 
> Wouldn't it make more sense to do something like this instead?
> 
> static int is_hex(const char *string, size_t count)
> {
> 	for (; count; string++, count--)
> 		if (hexval(*string) < 0)
> 			return 0;
> 	return 1;
> }

True if the string matches [0-9a-fA-F]*, false otherwise.

> 
> static ssize_t count_loose_objects(struct strbuf *objects_path)
> {
> 	ssize_t ret = 0;
> 	size_t len;
> 	struct dirent *d;
> 	DIR *dir, *subdir;
> 
> 	dir = opendir(objects_path->buf);
> 	if (!dir)
> 		return -1;
> 
> 	strbuf_complete(objects_path, '/');

starting with .git/objects/...

> 	len = objects_path->len;
> 	while ((d = readdir(dir))) {
For all contents of dir...
> 		if (d->d_type != DT_DIR)
> 			continue;
..which are directories...
> 		strbuf_setlen(objects_path, len);
> 		strbuf_addstr(objects_path, d->d_name);
> 		subdir = opendir(objects_path->buf);
show all the contents of that subdirectory.
> 		if (!subdir)
> 			continue;
> 		while ((d = readdir(subdir)))
for each regular file there,
> 			if (d->dt_type == DT_REG &&
if it's a regular file,
> 			    is_hex(dir->d_name, the_repository->hash_algo->hexsz))
and the directory is named like an object prefix,
> 				ret++;
increase the total count of numbers of loose objects.
> 		closedir(subdir);
> 	}
> 	closedir(dir);
> 	strbuf_reset(objects_path, len);
> 	return ret;
> }

The foremost difference here is that the loose object count previously
was not given in total - instead, it was divided up by object prefix. I
can't speak to whether that's actually very important to know about, but
the original request from stolee was to have the summary by dirname.
That's certainly still possible with a light modification to this code.

(Suggestion from Stolee, some months ago earlier in this thread:)

  As mentioned before, I've sometimes found it helpful to know the data shape for the object
  store. Having a few extra steps such as the following could be nice:
  
          echo "[Loose Objects]"
          for objdir in $(find "$GIT_DIR/objects/??" -type d)
          do
                  echo "$objdir: $(ls $objdir | wc -l)"
          done
          echo
  ...

Checking that the directory we're about to inspect is hexval rather than
that it's only two characters long is also an interesting point. I'd
probably rather do both, though, since I think we both missed
futureproofing by a little bit.

Dropping the many string_list is fine by me - call it object-oriented
habits dying hard.

I worry somewhat on delving into every directory and only afterwards
checking whether the directory is one we care about, but that's an easy
modification too to your basic suggestion ("don't use a string list for
that, silly").

Thanks. I'll make the changes with the modifications I mentioned and add
your Helped-by line on this commit.

 - Emily

> 
> Ciao,
> Dscho
> 
> > +	}
> > +}
> > diff --git a/bugreport.h b/bugreport.h
> > index 942a5436e3..09ad0c2599 100644
> > --- a/bugreport.h
> > +++ b/bugreport.h
> > @@ -18,3 +18,9 @@ void get_whitelisted_config(struct strbuf *sys_info);
> >   * contents of hook_info will be discarded.
> >   */
> >  void get_populated_hooks(struct strbuf *hook_info);
> > +
> > +/**
> > + * Adds the output of `git count-object -vH`. The previous contents of hook_info
> > + * will be discarded.
> > + */
> > +void get_loose_object_summary(struct strbuf *obj_info);
> > diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> > index a0eefba498..b2ab194207 100644
> > --- a/builtin/bugreport.c
> > +++ b/builtin/bugreport.c
> > @@ -64,6 +64,10 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
> >  	get_populated_hooks(&buffer);
> >  	strbuf_write(&buffer, report);
> >
> > +	add_header(report, "Object Counts");
> > +	get_loose_object_summary(&buffer);
> > +	strbuf_write(&buffer, report);
> > +
> >  	fclose(report);
> >
> >  	launch_editor(report_path.buf, NULL, NULL);
> > --
> > 2.24.0.rc0.303.g954a862665-goog
> >
> >
