From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [WIP PATCH 1/7] Add skeleton RA svnclient
Date: Thu, 24 Jun 2010 19:14:27 -0500
Message-ID: <20100625001427.GA4683@burratino>
References: <1277310140-16891-1-git-send-email-artagnon@gmail.com>
 <1277310140-16891-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <daniel@shahaf.name>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 25 02:15:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORwZe-0000x9-0Z
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 02:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219Ab0FYAOl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 20:14:41 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37049 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312Ab0FYAOk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 20:14:40 -0400
Received: by iwn41 with SMTP id 41so1383277iwn.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 17:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=m7nrcyVWKwjUL8BkLWlOJVKsXj+kOAa2W4UrltlZ0DQ=;
        b=jF6LXQ5J5WBoD2N48AbEJqCb8tjYrd/+IXBP6AhW6i5QXFohMjTgvf1TnJt025KEeP
         +BHllArBjycO5gLt/U/x5Cbun/J+t/nXrpW/roYaNZAitLXVPpqNJ8aAfpGR0wTXs+Mh
         ywmtDMAybLG8HGkh2UZvL/JuwnSSZttjDcn44=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=LGeDcFmb3IOCgmFN/Loo2iuxOC5hQRiN+/qwiqvS5UyWdOC1tywg8KSpD0/4Def0b0
         s6kGnA8ClCyTrodFQ0/++rEh4S/G+rtJi30hwKZ1gfsf0K041Z07bQOicEHNuOcUXuMd
         OtawJuqHkytACJ/QR+QZqzhSM0qkHhlleo/hE=
Received: by 10.231.59.75 with SMTP id k11mr11277100ibh.100.1277424879786;
        Thu, 24 Jun 2010 17:14:39 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r12sm20027242ibi.14.2010.06.24.17.14.38
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 17:14:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1277310140-16891-2-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149659>

Ramkumar Ramachandra wrote:

> In future, it will dump the data in every revision
> to stdout in dumpfile format (hopefully) without resorting to the FS
> API.

=46or now, just some na=C3=AFve questions.  Warning: I know nothing abo=
ut
svn internals.

I assume this corresponds to the ra-svn branch of
<http://github.com/artagnon/svn-dump-fast-export.git>.  Has the
relevant code changed much since you sent it?

> --- /dev/null
> +++ b/debug_editor.c
> @@ -0,0 +1,413 @@
> +#include "svn_pools.h"
> +#include "svn_cmdline.h"
> +#include "svn_client.h"
> +#include "svn_ra.h"
> +
> +struct edit_baton

What is a baton?

[...]
> +  void *wrapped_edit_baton;
[...]
> +  void *edit_baton;
> +  void *wrapped_dir_baton;
[...]
> +  void *edit_baton;
> +  void *wrapped_file_baton;

Are these opaque types necessary?

> +
> +static svn_error_t *
> +write_indent(struct edit_baton *eb, apr_pool_t *pool)
> +{
> +  int i;
> +
> +  for (i =3D 0; i < eb->indent_level; ++i)
> +    SVN_ERR(svn_stream_printf(eb->out, pool, " "));
> +
> +  return SVN_NO_ERROR;
> +}

What does this do?  Is SVN_ERR for debugging?  Where does the output go=
?

> +static svn_error_t *
> +set_target_revision(void *edit_baton,
> +                    svn_revnum_t target_revision,
> +                    apr_pool_t *pool)
[...]
> +static svn_error_t *
> +open_root(void *edit_baton,
[...]
> +static svn_error_t *
> +close_edit(void *edit_baton,
[...]

I take it these are callbacks?  Is there overview documentation for
them somewhere?

> +svn_error_t *
> +svn_delta__get_debug_editor(const svn_delta_editor_t **editor,
> +                            void **edit_baton,
> +                            const svn_delta_editor_t *wrapped_editor=
,
> +                            void *wrapped_edit_baton,
> +                            apr_pool_t *pool)
> +{
> +  svn_delta_editor_t *tree_editor =3D svn_delta_default_editor(pool)=
;
> +  struct edit_baton *eb =3D apr_palloc(pool, sizeof(*eb));
> +  apr_file_t *errfp;
> +  svn_stream_t *out;
> +
> +  apr_status_t apr_err =3D apr_file_open_stderr(&errfp, pool);
> +  if (apr_err)
> +    return svn_error_wrap_apr(apr_err, "Problem opening stderr");
> +
> +  out =3D svn_stream_from_aprfile2(errfp, TRUE, pool);
> +
> +  tree_editor->set_target_revision =3D set_target_revision;
> +  tree_editor->open_root =3D open_root;
> +  tree_editor->delete_entry =3D delete_entry;
> +  tree_editor->add_directory =3D add_directory;
> +  tree_editor->open_directory =3D open_directory;
> +  tree_editor->change_dir_prop =3D change_dir_prop;
> +  tree_editor->close_directory =3D close_directory;
> +  tree_editor->absent_directory =3D absent_directory;
> +  tree_editor->add_file =3D add_file;
> +  tree_editor->open_file =3D open_file;
> +  tree_editor->apply_textdelta =3D apply_textdelta;
> +  tree_editor->change_file_prop =3D change_file_prop;
> +  tree_editor->close_file =3D close_file;
> +  tree_editor->absent_file =3D absent_file;
> +  tree_editor->close_edit =3D close_edit;

I take it that the fields of svn_delta_editor_t do not have a
well-defined order?  Ugh.

In any case, I suspect this would be easier to read rearranged a little=
:

 1. declarations for callbacks
 2. get_debug_editor implementation
 3. definitions of types not needed in get_debug_editor()
 4. implementations of callbacks

That way, a person reading straight through can figure out what=E2=80=99=
s
going on a little earlier.

> --- /dev/null
> +++ b/svnclient_ra.c
[...]
> +int main()
> +{
> +	const char url[] =3D "http://svn.apache.org/repos/asf";
> +	svn_revnum_t start_revision =3D 1, end_revision =3D 5;
> +	if (svn_cmdline_init ("svnclient_ra", stderr) !=3D EXIT_SUCCESS)
> +		return 1;
> +	pool =3D svn_pool_create(NULL);
> +
> +	SVN_INT_ERR(open_connection(url));
> +	SVN_INT_ERR(replay_range(start_revision, end_revision));
> +
> +	close_connection();
> +	return 0;
> +}

What is svn_cmdline_init?  Is this code destined for inclusion in svn
upstream, and if so, where can one find the surrounding code this
should fit in with?

Jonathan
