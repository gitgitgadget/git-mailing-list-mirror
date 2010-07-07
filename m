From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 02/13] Add skeleton SVN client and Makefile
Date: Wed, 7 Jul 2010 11:25:16 -0500
Message-ID: <20100707162516.GA1529@burratino>
References: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
 <1278461693-3828-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, avarb@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>, dev@subversion.apache.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 07 18:26:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWXRs-0004zK-Q7
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 18:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757393Ab0GGQ0F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Jul 2010 12:26:05 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43203 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757344Ab0GGQ0D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 12:26:03 -0400
Received: by iwn7 with SMTP id 7so8006238iwn.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 09:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ZVOzBUI12KpN//XeKx0sD0zeqHGfY7XTEBYHNbfA3lQ=;
        b=IdnVEvufx5Z5cB754YBc+2nCn4T2xb0T3C/LrefTz2+68sHYk3pIVGeWy0As7xiLoy
         yQ9KIKC0OAsbh0vctcOQ+RboYZ0sv/zX5rMS+X2oPGvnTFUPwT3uWmuww2QFS2c3EHj7
         Zq35+gmXyh6ABNdGalxQjJGCkt/9Vo4Fak3Og=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=cEPha7XQM5imW1hQvLsdetjYPm/d+g9c0TRPrc+nGVsxkUFEmUuZwbH4Cy+zKh1dH9
         M3fJ+CVPOpzfUQxoN40Q0RNHYX5TVMimu8Yn4hOhbbPeBkiD5fNMawzqd3hJAMUSjFWt
         k79nQk1xJMnKuTuW422f1ySEioZtlCM2seXKw=
Received: by 10.231.79.4 with SMTP id n4mr7008739ibk.16.1278519959053;
        Wed, 07 Jul 2010 09:25:59 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id e8sm27096505ibb.14.2010.07.07.09.25.56
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 07 Jul 2010 09:25:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1278461693-3828-3-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150480>

Ramkumar Ramachandra wrote:

> Add a basic SVN command-line client along with a Makefile that does
> just enough to establish a connection with the ASF subversion server;

Thanks for splitting this out.

Let=E2=80=99s see what=E2=80=99s needed to set up a connection:

> +++ b/Makefile
> @@ -0,0 +1,8 @@
> +svndumpr: *.c *.h
> +	$(CC) -Wall -Werror -DAPR_POOL_DEBUG -ggdb3 -O0 -o $@ svndumpr.c -l=
svn_client-1 -I. -I/usr/include/subversion-1 -I/usr/include/apr-1.0

Links against libsvnclient-1.  Good.

I assume the details of the Makefile are not important, since it is
probably going to be revamped in the style of the svn build system
anyway.

> +++ b/svndumpr.c
> @@ -0,0 +1,68 @@
[...]
> +svn_error_t *populate_context()
[...]
> +svn_error_t *open_connection(const char *url)
[...]
> +svn_error_t *replay_range(svn_revnum_t start_revision, svn_revnum_t =
end_revision)

Why not static?

> +svn_error_t *populate_context()
> +{
> +	const char *http_library;
> +=09
> +	SVN_ERR(svn_config_get_config(&(ctx->config), NULL, pool));
> +=09
> +	http_library =3D getenv("SVN_HTTP_LIBRARY");
> +	if (http_library)
> +		svn_config_set(apr_hash_get(ctx->config, "servers", APR_HASH_KEY_S=
TRING),
> +		               "global", "http-library", http_library);

I tried googling for this SVN_HTTP_LIBRARY setting, but no
useful hints.  I take it that this overrides the [global] http-library
setting from ~/.subversion/servers?  Do other commands honor this
environment variable or just svndumpr?

[...]
> +svn_error_t *open_connection(const char *url)
> +{
> +	SVN_ERR(svn_config_ensure (NULL, pool));
> +	SVN_ERR(svn_client_create_context (&ctx, pool));
> +	SVN_ERR(svn_ra_initialize(pool));
> +
> +#if defined(WIN32) || defined(__CYGWIN__)
> +	if (getenv("SVN_ASP_DOT_NET_HACK"))
> +		SVN_ERR(svn_wc_set_adm_dir("_svn", pool));
> +#endif

I guess it=E2=80=99s water under the bridge now (from 5 years ago), but=
 why do
clients have to do this themselves?  It would not be so difficult for
libsvnclient to automatically set the admin dir according to whether
SVN_ASP_DOT_NET_HACK is set or not, or at least to provide a single
function to call and do so.

But that is not the topic for the moment.  I am tempted to suggest
checking SVN_ASP_DOT_NET_HACK unconditionally (i.e., on Unix, too),
just so the function is easier to scan.  Or there could be a separate
set_appropriate_adm_dir function in svndumpr.c:

	#if defined(WIN32) || ...
	static svn_error_t *set_appropriate_adm_dir(...)
	{
		if (getenv...
		...
	}
	#else
	static svn_error_t *set_appropriate_adm_dir(...
	{
		return SVN_NO_ERROR;
	}
	#endif

=46eel free to ignore me here. :)

> +
> +	SVN_ERR(populate_context());
> +	SVN_ERR(svn_cmdline_create_auth_baton(&(ctx->auth_baton), TRUE,
> +					      NULL, NULL, NULL, FALSE,
> +					      FALSE, NULL, NULL, NULL,
> +					      pool));

Maybe comments would help, for the boolean arguments.

> +	SVN_ERR(svn_client_open_ra_session(&session, url, ctx, pool));
> +	return SVN_NO_ERROR;
> +}
> +
> +svn_error_t *replay_range(svn_revnum_t start_revision, svn_revnum_t =
end_revision)
> +{
> +	return SVN_NO_ERROR;
> +}

Might be more self-explanatory without this function, but that
is just nitpicking.

> +
> +int main()
> +{
> +	const char url[] =3D "http://svn.apache.org/repos/asf";
> +	svn_revnum_t start_revision =3D 1, end_revision =3D 500;
> +	if (svn_cmdline_init ("svndumpr", stderr) !=3D EXIT_SUCCESS)
> +		return 1;
> +
> +	pool =3D svn_pool_create(NULL);
> +
> +	SVN_INT_ERR(open_connection(url));
> +	SVN_INT_ERR(replay_range(start_revision, end_revision));
> +
> +	svn_pool_destroy(pool);
> +=09
> +	return 0;
> +}

So: this is an expensive no-op.

Thanks for the pleasant reading.

Jonathan
