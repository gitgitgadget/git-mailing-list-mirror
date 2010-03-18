From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Prompt for a username when an HTTP request 401s
Date: Thu, 18 Mar 2010 12:03:09 -0700
Message-ID: <20100318190309.GC10981@spearce.org>
References: <d411cc4a1003181157o79f1a1e1qcdea05322d76b812@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 20:03:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsL0F-0001NR-CN
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 20:03:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600Ab0CRTDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 15:03:17 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:51501 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524Ab0CRTDN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 15:03:13 -0400
Received: by pva4 with SMTP id 4so1303516pva.19
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 12:03:13 -0700 (PDT)
Received: by 10.114.250.39 with SMTP id x39mr2418067wah.179.1268938992876;
        Thu, 18 Mar 2010 12:03:12 -0700 (PDT)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm165750iwn.6.2010.03.18.12.03.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Mar 2010 12:03:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <d411cc4a1003181157o79f1a1e1qcdea05322d76b812@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142493>

Scott Chacon <schacon@gmail.com> wrote:
> When an HTTP request returns a 401, Git will currently fail with a
> confusing message saying that it got a 401.  This changes
> http_request to prompt for the username and password, then return
> HTTP_REAUTH so http_get_strbuf can try again.  If it gets a 401 even
> when a user/pass is supplied, http_request will now return HTTP_NOAUTH
> which remote_curl can then use to display a more intelligent error
> message that is less confusing.
> 
> Signed-off-by: Scott Chacon <schacon@gmail.com>
> ---
>  http.c        |   21 +++++++++++++++++++--
>  http.h        |    2 ++
>  remote-curl.c |    2 ++
>  3 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/http.c b/http.c
> index deab595..731783e 100644
> --- a/http.c
> +++ b/http.c
> @@ -199,6 +199,11 @@ static int http_options(const char *var, const
> char *value, void *cb)
>  	return git_default_config(var, value, cb);
>  }
> 
> +static void get_http_user_name()
> +{
> +	user_name = xstrdup(getpass("Username: "));

Why are we getting the username via a password prompt where echo
has been disabled?  Traditionally a username field is obtained as
echoed input.

Also, this method shouldn't be named get_*() if its returning void.
Sounds far to funny.  init_http_user_name()?  prompt_for_user_name()?

-- 
Shawn.
