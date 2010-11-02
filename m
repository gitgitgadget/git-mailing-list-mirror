From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Remove restriction on notes ref base
Date: Tue, 2 Nov 2010 01:52:08 -0500
Message-ID: <20101102065208.GA4280@burratino>
References: <1288657003-17802-1-git-send-email-kroot@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Thomas Rast <trast@student.ethz.ch>
To: Kenny Root <kroot@google.com>
X-From: git-owner@vger.kernel.org Tue Nov 02 07:53:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDAju-0000zt-MV
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 07:53:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932799Ab0KBGw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 02:52:28 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43412 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755878Ab0KBGwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 02:52:25 -0400
Received: by ywc21 with SMTP id 21so1419546ywc.19
        for <git@vger.kernel.org>; Mon, 01 Nov 2010 23:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=D6KjtFjVp6Y6BC9jUW8kPJj4vjk4ft6UkYgK8wwr7Ko=;
        b=dtRmOiYaoys7iFU+6oRDO7jtgsM6QXqBI3004OfOpAkoGBpUtMYAA5d6/LjccVO6+/
         elnwUERbcXuTWKtpwVZ4gi8ofDK1hANJOM4lE6GSq/CcVOAlVG8TBjaOpad4kGxFGeXr
         qhfghxGHOEGFGBn/zMo+1zUX2043QbE++Hcus=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EwQhHuhFbbrRCmVdllsJSAOspkZL+JkrXAZrOu1P1XlbfcYdl0GnjSK0qqUtZ29j+G
         YnqbSGQnT/ltYCpD37se7v6qYQIT2C9fwm2G4x1Tc4A7xKBwJqWNxmxhzJPqUPX9KZMg
         qgJoeNwgFB9UnQXSSz02Ab2YyxcC7t+zQVrJ8=
Received: by 10.101.163.5 with SMTP id q5mr499717ano.262.1288680744756;
        Mon, 01 Nov 2010 23:52:24 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id d15sm3652193ana.20.2010.11.01.23.52.22
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 01 Nov 2010 23:52:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1288657003-17802-1-git-send-email-kroot@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160505>

(+cc: Johan, Thomas)

Kenny Root wrote:

> Git notes were restricted to refs/notes/* in the command line utilities,
> but setting things like GIT_NOTES_REF to something outside of that
> structure would work.
> 
> This removes the restrictions on the git notes command line interface.

Could you explain what those restrictions are (perhaps through an
example in the form of a patch to the t/ subdirectory)?

Cc-ing some people more knowledgeable about notes than I am; maybe
they can give more information about what this notes.rewriteref
protection and other check are about.

Jonathan

[patch follows for their convenience.]
> Signed-off-by: Kenny Root <kroot@google.com>
> ---
>  builtin/notes.c |   11 ++---------
>  1 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 6d07aac..9acce7b 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -343,11 +343,7 @@ static int notes_rewrite_config(const char *k, const char *v, void *cb)
>  	} else if (!c->refs_from_env && !strcmp(k, "notes.rewriteref")) {
>  		/* note that a refs/ prefix is implied in the
>  		 * underlying for_each_glob_ref */
> -		if (!prefixcmp(v, "refs/notes/"))
> -			string_list_add_refs_by_glob(c->refs, v);
> -		else
> -			warning("Refusing to rewrite notes in %s"
> -				" (outside of refs/notes/)", v);
> +		string_list_add_refs_by_glob(c->refs, v);
>  		return 0;
>  	}
>  
> @@ -473,9 +469,6 @@ static struct notes_tree *init_notes_check(const char *subcommand)
>  	init_notes(NULL, NULL, NULL, 0);
>  	t = &default_notes_tree;
>  
> -	if (prefixcmp(t->ref, "refs/notes/"))
> -		die("Refusing to %s notes in %s (outside of refs/notes/)",
> -		    subcommand, t->ref);
>  	return t;
>  }
>  
> @@ -844,7 +837,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
>  
>  	if (override_notes_ref) {
>  		struct strbuf sb = STRBUF_INIT;
> -		if (!prefixcmp(override_notes_ref, "refs/notes/"))
> +		if (!prefixcmp(override_notes_ref, "refs/"))
>  			/* we're happy */;
>  		else if (!prefixcmp(override_notes_ref, "notes/"))
>  			strbuf_addstr(&sb, "refs/");
> -- 
