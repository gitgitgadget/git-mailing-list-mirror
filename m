Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D934FC433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 23:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359088AbhLCXH1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 18:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239271AbhLCXH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 18:07:27 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E25C061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 15:04:02 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id y16so5730046ioc.8
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 15:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fTxlS8A/Tf0IZah+VOXMKIJq0lxmHAGlwHtUP9EoD1Y=;
        b=YsEBxiYPt07h26yvHHOFdBgRzMbtWOhFdRYSJyCtrOOBS0GVuNwSZqK9g5rHxCWKSW
         JZeUlo4dn70F2Z6+YRxli9djcTz18eeazs4AMsOKnp0mfBkvCsFvGGcuXg6rgVVOKcch
         8FsvzHv8pUaGFNF1zZbIzilkTU11zaW+mqt3cufAyl9/7X8YY4Bl5+UWJG6FHHoQ6opS
         Ly291oGoWGxn0AIUHMp7OUYSDRPrf819P7sP23iuKOQlszwmqqkn8FqZTM4okQxBdiL/
         Z0ETcYtCB7zl9hGZfLCmzaZESq0i8iD/ii0IlgDl/+iX2YAz/XAFCsDxJqbROu6khRKU
         bPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fTxlS8A/Tf0IZah+VOXMKIJq0lxmHAGlwHtUP9EoD1Y=;
        b=CO8IxMoRryCSuwm/CVdv9Svj5IJTuE8BjGmVEjQw9B89sMzKLxChAufeEiOIjBf73C
         dbZ4MeLcmUIlancfBNHC0v2u7nv8g5ksjv4sNNF/E09N5bz1+RARb8DBigSEgwCnsC28
         buenpN3w9mrUi+Ksnv+4483C4d6POI3SQrBFHfDQnqvcDjpxf4BdIl4wuvDT5vga6lM8
         sJNFxvfbAH0wjVDjW2skbh4LXsubY6nHMuRoqFLAE+mASTPSfWdIc5sO49jMLX+dM+WW
         6Nd1n4LWxm/wDsqVxhh2w5Af6HknTP/ZvMzD8CNvI8Gazbv2yDI9RbCfdmPUbb+VBnU7
         qRUw==
X-Gm-Message-State: AOAM533xOKdQv0FLoGmohOLZdaSBu3sT+3fjIZgd0dgr+cxwkroMumM8
        LjKzYsivGbZT9V655/dHjEbkV3ecIOzJNg==
X-Google-Smtp-Source: ABdhPJwXj4D/cD7g7gjCTn9Jrjh/WrlBKMVCWseVueE2ckyjkbjDOUnouMgaFbz+ylmlaNeZKl/pJQ==
X-Received: by 2002:a05:6638:613:: with SMTP id g19mr26872462jar.77.1638572641725;
        Fri, 03 Dec 2021 15:04:01 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c19sm2406610ioa.30.2021.12.03.15.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 15:04:01 -0800 (PST)
Date:   Fri, 3 Dec 2021 18:04:00 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, larsxschneider@gmail.com,
        peff@peff.net, tytso@mit.edu
Subject: Re: [PATCH 05/17] pack-mtimes: support writing pack .mtimes files
Message-ID: <YaqiYGM48p5F9lS1@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <deece9eb70e9750bb8350946679b521e59139fe2.1638224692.git.me@ttaylorr.com>
 <2a26da15-8d4f-92b9-d727-debf8b969899@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2a26da15-8d4f-92b9-d727-debf8b969899@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 02, 2021 at 10:36:16AM -0500, Derrick Stolee wrote:
> On 11/29/2021 5:25 PM, Taylor Blau wrote:> @@ -168,6 +168,9 @@ struct packing_data {
> >  	/* delta islands */
> >  	unsigned int *tree_depth;
> >  	unsigned char *layer;
> > +
> > +	/* cruft packs */
> > +	uint32_t *cruft_mtime;
>
> This comment is a bit terse. Perhaps...
>
> 	/* Used when writing cruft packs. */

Sure; here I was imitating the terseness of the "delta islands" comment
a few lines above. But I don't mind changing it here.

> > +static inline uint32_t oe_cruft_mtime(struct packing_data *pack,
> > +				      struct object_entry *e)
> > +{
> > +	if (!pack->cruft_mtime)
> > +		return 0;
> > +	return pack->cruft_mtime[e - pack->objects];
> > +}
>
> When writing a pack, it appears that the cruft_mtime array
> maps to objects in pack-order, not idx-order, correct? That
> might be worth mentioning in the struct definition because
> it differs from the .mtimes file.

Great observation and suggestion, thank you! The comment that I
ultimately settled on is:

  /*
   * Used when writing cruft packs.
   *
   * Object mtimes  are stored in pack order when writing, but
   * written out in lexicographic (index) order.
   */
   uint32_t *cruft_mtime;

> > +static void write_mtimes_objects(struct hashfile *f,
> > +				 struct packing_data *to_pack,
> > +				 struct pack_idx_entry **objects,
> > +				 uint32_t nr_objects)
> > +{
> > +	uint32_t i;
> > +	for (i = 0; i < nr_objects; i++) {
> > +		struct object_entry *e = (struct object_entry*)objects[i];
> > +		hashwrite_be32(f, oe_cruft_mtime(to_pack, e));
> > +	}
>
> The name "objects" here confused me at first, thinking it
> corresponded to the objects member of 'struct packing_data', but
> that is being handled by the fact that 'objects' is actually a
> lex-sorted list of pack_idx_entry pointers (and they happen to
> also point to 'struct object_entry' values because the 'struct
> pack_idx_entry' is the first member.
>
> So this is (very densely) handling the translation from pack-order
> to lex-order through the double pointer 'objects'. I'm not sure if
> there is a way to make it more clear or if every reader will need
> to do the same mental gymnastics I had to do.

Exactly, and sorry that I didn't point this out more clearly. It's been
long enough since I wrote this code that I can sympathize with the
mental gymnastics required ;).

> > +}
> > +
> > +static void write_mtimes_trailer(struct hashfile *f, const unsigned char *hash)
> > +{
> > +	hashwrite(f, hash, the_hash_algo->rawsz);
> > +}
> > +
> > +static const char *write_mtimes_file(const char *mtimes_name,
> > +				     struct packing_data *to_pack,
> > +				     struct pack_idx_entry **objects,
> > +				     uint32_t nr_objects,
> > +				     const unsigned char *hash)
> > +{
> > +	struct hashfile *f;
> > +	int fd;
> > +
> > +	if (!to_pack)
> > +		BUG("cannot call write_mtimes_file with NULL packing_data");
> > +
> > +	if (!mtimes_name) {
> > +		struct strbuf tmp_file = STRBUF_INIT;
> > +		fd = odb_mkstemp(&tmp_file, "pack/tmp_mtimes_XXXXXX");
> > +		mtimes_name = strbuf_detach(&tmp_file, NULL);
> > +	} else {
> > +		unlink(mtimes_name);
> > +		fd = xopen(mtimes_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
> > +	}
> > +	f = hashfd(fd, mtimes_name);
> > +
> > +	write_mtimes_header(f);
> > +	write_mtimes_objects(f, to_pack, objects, nr_objects);
> > +	write_mtimes_trailer(f, hash);
> > +
> > +	if (mtimes_name && adjust_shared_perm(mtimes_name) < 0)
> > +		die(_("failed to make %s readable"), mtimes_name);
>
> What could cause 'mtimes_name' to be NULL here? It seems that it would
> be initialized in the "if (!mtimes_name)" block above.

You're right, it's impossible for it to be NULL here. I'll remove the
redundant side of the &&-expression here.

> > +
> > +	finalize_hashfile(f, NULL,
> > +			  CSUM_HASH_IN_STREAM | CSUM_CLOSE | CSUM_FSYNC);
> > +
> > +	return mtimes_name;
>
> Note that you return the name here...
>
> > +	if (pack_idx_opts->flags & WRITE_MTIMES) {
> > +		mtimes_tmp_name = write_mtimes_file(NULL, to_pack, written_list,
> > +						    nr_written,
> > +						    hash);
> > +		if (adjust_shared_perm(mtimes_tmp_name))
> > +			die_errno("unable to make temporary mtimes file readable");
>
> ...and then adjust the perms again. I think that this adjustment is
> redundant, because it already happened within the write_mtimes_file()
> method.

Yep, thanks. I'll clean it up here to just call adjust_shared_perm()
witin write_mtimes_file().

Thanks,
Taylor
