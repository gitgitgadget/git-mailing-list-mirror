From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/13] Add skeleton dump editor
Date: Wed, 7 Jul 2010 13:16:19 -0500
Message-ID: <20100707181619.GA2617@burratino>
References: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
 <1278461693-3828-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>, dev@subversion.apache.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 07 20:17:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWZBI-000527-Ji
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 20:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756625Ab0GGSRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 14:17:06 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33125 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754926Ab0GGSRD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 14:17:03 -0400
Received: by iwn7 with SMTP id 7so8097039iwn.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 11:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=kxhnTe9WoDqwnG2dHPCukAW4y+7Za7Q1lo4IGDorhrs=;
        b=B+r+V0hxLPiiTr+KI22xwDW7/vWQeyfMW54Jh1SgwiVB1jlVoZvW+/26zN5Q621cXz
         ibL0n8BnLeV45BQECm8DDi/rOm+bpwPm3QrnL4NX4dZzamCIeW02RTeMJx7GY/d6IKcP
         cQvFUXms3/joK89IgZOijmK5lF7rmAJJ9L4tg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=r9G26k9Yff/sQFHd2KPi2Gy7Vy/BeoErQ6wth5KfmKZtvlKcAADnuRD/eJJpBQSyMP
         EoifvZlhPOYh5vq5u938aI5ZLdk1h87t0wy51/1tRcDvxZXwp0suaUyYRsGSzuB5w0kr
         bb5QOsgR2dXxQ9ZuJHSs+9PDj5hY2D3sRU1QM=
Received: by 10.231.193.11 with SMTP id ds11mr6542299ibb.192.1278526622188;
        Wed, 07 Jul 2010 11:17:02 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 34sm29836214ibi.12.2010.07.07.11.17.00
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 07 Jul 2010 11:17:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1278461693-3828-5-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150491>

Ramkumar Ramachandra wrote:

> Add a dump editor and write out skeleton callback functions according
> to the API documentation of svn_delta_editor_t. Also expose
> get_dump_editor through a header.

This commit message tells me nothing... Maybe:

	Add a no-op svn_editor.  The function to retrieve it is called
	get_dump_editor because it is planned to tweak it to write a
	dumpfile.  But for now it is more useful when used with the
	debug_editor, to get a list of editor operations printed to
	stderr.

It could make sense to squash this with patch 5 as a demo.

> --- /dev/null
> +++ b/dump_editor.c
> @@ -0,0 +1,143 @@
> +/* Licensed under a two-clause BSD-style license.
> + * See LICENSE for details.
> + */
> +
> +#include "svn_pools.h"
> +#include "svn_error.h"
> +#include "svn_iter.h"
> +#include "svn_repos.h"
> +#include "svn_string.h"
> +#include "svn_dirent_uri.h"
> +#include "svn_path.h"
> +#include "svn_time.h"
> +#include "svn_checksum.h"
> +#include "svn_props.h"

Are these all needed?

[...]
> +svn_error_t *open_root(void *edit_baton,
> +                       svn_revnum_t base_revision,
> +                       apr_pool_t *pool,
> +                       void **root_baton)
> +{
> +	return SVN_NO_ERROR;
> +}

Might make sense to use

	*root_baton = NULL;

for easier debugging.

[...]
> +svn_error_t *add_directory(const char *path,
[...]
> +svn_error_t *open_directory(const char *path,
[...]
> +svn_error_t *add_file(const char *path,
[...]
> +svn_error_t *open_file(const char *path,
[...]
> +svn_error_t *apply_textdelta(void *file_baton, const char *base_checksum,

Likewise.

[...]
> +++ b/dumpr_util.h
> @@ -0,0 +1,29 @@
> +#ifndef DUMPR_UTIL_H_
> +#define DUMPR_UTIL_H_
> +
> +struct edit_baton {

A more specific name might be nice (or might not, depending on the
prevailing style in svn; I ought to check but I am too lazy).

> +	/* The stream to dump to: stdout */
> +	svn_stream_t *stream;
> +
> +	/* pool is for per-edit-session allocations */
> +	apr_pool_t *pool;

Unused; probably should delay adding these until there is a user to
explain them.

> +
> +	svn_revnum_t current_rev;

Used.

> +	
> +	/* Store the properties that changed */
> +	apr_hash_t *properties;
> +	apr_hash_t *del_properties; /* Value is always 0x1 */
> +	svn_stringbuf_t *propstring;
> +
> +	/* Path of changed file */
> +	const char *changed_path;
> +
> +	/* Was a copy command issued? */
> +	svn_boolean_t is_copy;
> +
> +	/* Temporary file to write delta to along with its checksum */
> +	char *temp_filepath;
> +	svn_checksum_t *checksum;

All unused.

> +};
