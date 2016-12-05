Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E24A1FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 20:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751672AbcLEUVq (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 15:21:46 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34067 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751639AbcLEUVq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 15:21:46 -0500
Received: by mail-pf0-f179.google.com with SMTP id c4so65354643pfb.1
        for <git@vger.kernel.org>; Mon, 05 Dec 2016 12:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=71cJSREhIsiARitbDo6kc6DVJ2l7PeHpGENNkkZGt+0=;
        b=CUdORlA161dXvDRvozK/yQDD5PK/BEAtThEa2B6ZJJUP1rFtJf8Tw4P4aRww39QgXN
         +Hkqg3aKkSJ/JZnzPuZ9tlzPQGI0Z4667jKFZNZBnZ3NzjML0xJwddX1V7oSXxLvY+rP
         j1XTOqIgMsvMUIizTkXM8IAwAC1ejIJW/ozBO6541vuv1kll5NFFIifI8ZqbMJahHq2A
         xgm/rOetlZn8gJHnFXEOPkv1EySRIe2zkL+6tp23j61K8KOgSc9LH45e2VwRXWdytuUj
         pSzvC8fDFxd4Zt2kUOBnSjapuyx0CZ+B/iTg157HhA8VUzsNK3pNTY6AYUfwCOsFUdbw
         BNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=71cJSREhIsiARitbDo6kc6DVJ2l7PeHpGENNkkZGt+0=;
        b=U4LwfptPEKhjBPqqyjH3wBFOkkEi4B/KckSzVDSq5G7tlBPDER/J+pRCpSj5jEYZGd
         k53dhGToG4tCXSliwDc5EteWKaGpT+bx484oijYCYh5X8EErULDnTnhDLe696HiBUmyL
         Dn0hgT88zeeuZC22hd7uYBRvtV2RDswqidTWI1JWwaXi7tcykyjgU6EYIN/iOZHWFv0O
         mbnuibqCN5LcF0ew6ycomAEZczpsZwh2WDogDCl1zmhiIgNjrUg8S97Wjta7HxAFsVwT
         EUEGU5t1uuVM5apYyk1vXnxQCCKdfzWHUJG7PYReBetwTcdKYvoYCjCR2+vVsCqELOfZ
         l0uA==
X-Gm-Message-State: AKaTC01Bpr1kQPabp5ZDOk2nDmsfhJvc7R6vNXfp0wDRcACcvqmoKHXGDZ2KhOlTo+SoMQxl
X-Received: by 10.99.232.21 with SMTP id s21mr106193273pgh.19.1480968759466;
        Mon, 05 Dec 2016 12:12:39 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:20ca:c78:1a67:9579])
        by smtp.gmail.com with ESMTPSA id t193sm29595760pgb.4.2016.12.05.12.12.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 05 Dec 2016 12:12:38 -0800 (PST)
Date:   Mon, 5 Dec 2016 12:12:37 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] real_path: make real_path thread-safe
Message-ID: <20161205201237.GD68588@google.com>
References: <1480964316-99305-1-git-send-email-bmwill@google.com>
 <1480964316-99305-2-git-send-email-bmwill@google.com>
 <CAGZ79kauPdE1uiFSvBALkNiwXbnV6d6xhwLdWNQwRir_8rTG6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kauPdE1uiFSvBALkNiwXbnV6d6xhwLdWNQwRir_8rTG6Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/05, Stefan Beller wrote:
> > +/* removes the last path component from 'path' except if 'path' is root */
> > +static void strip_last_component(struct strbuf *path)
> > +{
> > +       if (path->len > 1) {
> > +               char *last_slash = find_last_dir_sep(path->buf);
> 
> What happens when there is no dir_sep?

There should always be a dir_sep since that only gets run if the passed
in path at least contains root '/'

> 
> > +/* gets the next component in 'remaining' and places it in 'next' */
> > +static void get_next_component(struct strbuf *next, struct strbuf *remaining)
> > +{
> 
> It's more than just getting it, it also chops it off of 'remaining' ?

True, I can update the comment to reflect that.

> > +       } else {
> > +               /* relative path; can use CWD as the initial resolved path */
> > +               if (strbuf_getcwd(&resolved)) {
> > +                       if (die_on_error)
> > +                               die_errno("Could not get current working directory");
> 
> I am looking at xgetcwd, which words it slightly differently.
> 
>     if (strbuf_getcwd(&sb))
>         die_errno(_("unable to get current working directory"));
> 
> Not sure if aligning them would be a good idea?
> 
> Going by "git grep die_errno" as well as our Coding guidelines,
> we don't want to see capitalized error messages.

K I can use the other msg.

> >
> > -               if (sb.len) {
> > -                       if (!cwd.len && strbuf_getcwd(&cwd)) {
> > +               /* append the next component and resolve resultant path */
> 
> "resultant" indicates you have a math background. :)
> But I had to look it up, I guess it is fine that way,
> though "resulting" may cause less mental friction
> for non native speakers.
> 
> 
> > +                       if (!(errno == ENOENT && !remaining.len)) {
> >                                 if (die_on_error)
> > -                                       die_errno("Could not get current working directory");
> > +                                       die_errno("Invalid path '%s'",
> > +                                                 resolved.buf);
> >                                 else
> >                                         goto error_out;
> >                         }
> > +               } else if (S_ISLNK(st.st_mode)) {
> 
> As far as I can tell, we could keep the symlink strbuf
> at a smaller scope here? (I was surprised how many strbufs
> are declared at the beginning of the function)

Yeah I can push it down in scope.  There will be a bit more allocation
churn with the smaller scope but multiple symlinks should be rare?
Alternatively the 'next' buffer can be reused...I decided against that
initially due to readability.  And yes, lots of string manipulation
requires lots of strbufs :)

> > +       //strbuf_release(&resolved);
> 
> This is why the cover letter toned down expectations ?
> (no // as comment, maybe remove that line?)

yep.  It will be added back in though once the callers to real_path take
ownership of the memory.

-- 
Brandon Williams
