From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/5] fast-export: Introduce --inline-blobs
Date: Tue, 29 Mar 2011 15:44:12 -0500
Message-ID: <20110329204412.GA13812@elie>
References: <1301422392-21177-1-git-send-email-artagnon@gmail.com>
 <1301422392-21177-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Peter Baumann <waste.manager@gmx.de>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 22:44:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4fmE-0005wl-6W
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 22:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754111Ab1C2Uo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 16:44:28 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:62741 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238Ab1C2Uo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 16:44:28 -0400
Received: by vxi39 with SMTP id 39so512619vxi.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 13:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=xXMmJe3e2suhbDYwlA0Wf54D7VNg41lzesO2JiOI6Lk=;
        b=uQNUlEPd6iWL1FHm5hJVvyEPPzvTgLTNK/EiWEPUtt+mMrDeYnqT9xCG1dZIhXHr92
         elA7bSuJVEnCWhBjXnSb+Yigev64oZwKNs8ZGQZWdm7XxiiRHLGaNZBHJDOOex57awsp
         UoDPQEAL0AZQpovOiyMuE56oWALJ6eTeQuHS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UCdEfZ/iIAwyDEseR+1+BYpl37D7F4WJ6mpS2B2afEUBM+Kur/YoY3vFZQhxGE+nkQ
         Go2FsOKuxzLUOBumEILy9wQdB0HlWxaMvNh6W2qtsLGGl62o4z9S919QRitESwqKyAcP
         C6uU4RlnxV+SOqwhUjlQj581/FUC5r84U+m7o=
Received: by 10.52.97.165 with SMTP id eb5mr326576vdb.298.1301431467148;
        Tue, 29 Mar 2011 13:44:27 -0700 (PDT)
Received: from elie (adsl-76-206-232-54.dsl.chcgil.sbcglobal.net [76.206.232.54])
        by mx.google.com with ESMTPS id n32sm2962276vba.10.2011.03.29.13.44.24
        (version=SSLv3 cipher=OTHER);
        Tue, 29 Mar 2011 13:44:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1301422392-21177-3-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170318>

Hi,

Ramkumar Ramachandra wrote:

> Introduce a new command-line option --inline-blobs that always inlines
> blobs instead of referring to them via marks or their original SHA-1
> hash.

Could you expand on this?  What does it mean to inline a blob (is it the
same thing as the reference manual describes as using the inline data
format with the filemodify command)?  Why do we want to always do
that?  How would a person or script choose whether to use this option?
Are there any downsides?

I ask because I would be happy to use something like this. ;-)  Thanks
for working on it.

> --- a/Documentation/git-fast-export.txt
> +++ b/Documentation/git-fast-export.txt
> @@ -90,6 +90,11 @@ marks the same across runs.
>  	resulting stream can only be used by a repository which
>  	already contains the necessary objects.
>  
> +--inline-blobs::
> +	Inline all blobs, instead of referring to them via marks or
> +	their original SHA-1 hash.  This is useful to parsers, as they
> +	don't need to persist blobs.

This explanation leaves something out, I think.  If it is useful to
parsers, that means it simplifies the syntax, so a natural conclusion
would be that parsers do not need to learn about the non-inline
syntax.  But I think the last time[1] this came up, we decided that
one should not encourage that, because it moves away from a world in
which "git fast-export", "hg fast-export", and svn-fe use one standard
format and can be used interchangeably.

[1] http://thread.gmane.org/gmane.comp.version-control.git/165237/focus=165289

Perhaps it would be better to say something to the effect that "This
can decrease the memory footprint and complexity of the work some
fast-import backends have to do"?  In other words, it's just an
optimization.

To that end, if the same blob keeps on coming up again and again, I'd
be tempted to allow making a mark for it in the future, even when
--inline-blobs is specified.  In other words, I'd prefer (unless
real-world considerations prevent it) for --inline-blobs to be a hint
or a permission instead of something binding.

> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
[...]
> @@ -118,7 +119,7 @@ static void handle_object(const unsigned char *sha1)
>  	char *buf;
>  	struct object *object;
>  
> -	if (no_data)
> +	if (no_data || inline_blobs)
>  		return;

Maybe inline_blobs should imply no_data internally?

>  
>  	if (is_null_sha1(sha1))
> @@ -218,7 +219,23 @@ static void show_filemodify(struct diff_queue_struct *q,
>  			if (no_data || S_ISGITLINK(spec->mode))
>  				printf("M %06o %s %s\n", spec->mode,
>  				       sha1_to_hex(spec->sha1), spec->path);
> -			else {
> +			else if (inline_blobs) {

If so, this could be something like

	int inline_me = inline_blobs && !S_ISGITLINK(spec->mode);
	...

	if (no_data || S_ISGITLINK(spec->mode)) {
		const char *dataref =
			inline_me ? "inline" : sha1_to_hex(spec->sha1);
		printf("M %06o %s %s\n", spec->mode, dataref, spec->path);
	} else {
		struct object *object = lookup_object(spec->sha1);
		printf("M %06o :%d %s\n", spec->mode,
		       get_object_mark(object), spec->path);
	}

	if (inline_blob && export_data(spec->data, spec->size))
		die_errno("Could not write blob '%s'",
				sha1_to_hex(spec->sha1));

> --- a/contrib/svn-fe/.gitignore
> +++ b/contrib/svn-fe/.gitignore
[...]
> --- a/contrib/svn-fe/Makefile
> +++ b/contrib/svn-fe/Makefile
[...]
> --- /dev/null
> +++ b/contrib/svn-fe/svn-fi.c
[...]
> --- /dev/null
> +++ b/contrib/svn-fe/svn-fi.txt

Snuck in from another patch?

Hope that helps,
Jonathan
