From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v3 1/4] config.c: Add git_config_bool_or_int to handle bool/int variable
Date: Sun, 13 Apr 2008 15:28:20 +0800
Message-ID: <46dff0320804130028l76c69b55jb8d6be79125b6041@mail.gmail.com>
References: <1208012733-18211-1-git-send-email-pkufranky@gmail.com>
	 <1208012733-18211-2-git-send-email-pkufranky@gmail.com>
	 <7vmynye0cz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junio@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 13 09:29:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkweJ-00042M-Af
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 09:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbYDMH2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2008 03:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbYDMH2W
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 03:28:22 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:12194 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbYDMH2V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 03:28:21 -0400
Received: by an-out-0708.google.com with SMTP id d31so285487and.103
        for <git@vger.kernel.org>; Sun, 13 Apr 2008 00:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=6ijQ9Y8fgP1nVU+Qwh0m5dOixyudph3/Wu/fzeV1O1I=;
        b=v6GezdEW64VuJG+YezdxqE/qsFwrqnHcfO8UZuHMJhVP5qcr+tT7awLU37jyxM0HPPzy6Ogg4Mf9mafWWKJjDm0u4R5Y5kvxS8/+G3J5FgjMTWIuuChj/TUu3k69sdyfgIRAKN5g58AHSalsBZJUam9k/pPMLbi2H8MfJazuD00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mBDZwH9hgnDM7jc7Hwl5sJvJ27ftoWy2Q4ky+Y3Au/sde9gk6aX3kAkAIwCsO/HO8al6Sr1K52wzu/cvlz/JDIscXKrBr5ipIobp/yTky+lhDCS8Fi/rwRDDasHA+Xc7xeRnqBWwLd5cS9aw7dqALTZ3ozR0eoHzjRqsEXqPXX0=
Received: by 10.100.214.19 with SMTP id m19mr9400749ang.1.1208071700665;
        Sun, 13 Apr 2008 00:28:20 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Sun, 13 Apr 2008 00:28:20 -0700 (PDT)
In-Reply-To: <7vmynye0cz.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79395>

On Sun, Apr 13, 2008 at 2:26 PM, Junio C Hamano <junio@pobox.com> wrote:
> Ping Yin <pkufranky@gmail.com> writes:
>
>  > With git_config_bool_or_int, the caller can differentiate boolean true
>  > and integer 1 etc.
>  >
>  > Signed-off-by: Ping Yin <pkufranky@gmail.com>
>  > ---
>  >  config.c |   15 +++++++++++++++
>  >  1 files changed, 15 insertions(+), 0 deletions(-)
>  >
>  > diff --git a/config.c b/config.c
>  > index 0624494..e614456 100644
>  > --- a/config.c
>  > +++ b/config.c
>  > @@ -316,6 +316,21 @@ int git_config_bool(const char *name, const char *value)
>  >       return git_config_int(name, value) != 0;
>  >  }
>  >
>  > +int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
>  > +{
>  > +     *is_bool = 1;
>  > +     if (!value)
>  > +             return 1;
>  > +     if (!*value)
>  > +             return 0;
>  > +     if (!strcasecmp(value, "true") || !strcasecmp(value, "yes"))
>  > +             return 1;
>  > +     if (!strcasecmp(value, "false") || !strcasecmp(value, "no"))
>  > +             return 0;
>  > +     *is_bool = 0;
>  > +     return git_config_int(name, value);
>  > +}
>  > +
>
>  I expected git_config_bool() to be implemented in terms of this new
>  function to avoid code duplication if we were actually going to do this.
>
>  You also need an external declaration in a header file for its users.
>
>  ---
>   cache.h  |    1 +
>   config.c |   10 +++++++++-
>   2 files changed, 10 insertions(+), 1 deletions(-)
>
>  diff --git a/cache.h b/cache.h
>  index 2a1e7ec..50b28fa 100644
>  --- a/cache.h
>  +++ b/cache.h
>  @@ -692,6 +692,7 @@ extern int git_parse_long(const char *, long *);
>   extern int git_parse_ulong(const char *, unsigned long *);
>   extern int git_config_int(const char *, const char *);
>   extern unsigned long git_config_ulong(const char *, const char *);
>  +extern int git_config_bool_or_int(const char *, const char *, int *);
>   extern int git_config_bool(const char *, const char *);
>   extern int git_config_string(const char **, const char *, const char *);
>   extern int git_config_set(const char *, const char *);
>
> diff --git a/config.c b/config.c
>  index 0624494..5ea18ef 100644
>
> --- a/config.c
>  +++ b/config.c
>  @@ -303,8 +303,9 @@ unsigned long git_config_ulong(const char *name, const char *value)
>         return ret;
>   }
>
>  -int git_config_bool(const char *name, const char *value)
>
> +int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
>   {
>  +       *is_bool = 1;
>         if (!value)
>                 return 1;
>         if (!*value)
>  @@ -313,9 +314,16 @@ int git_config_bool(const char *name, const char *value)
>
>                 return 1;
>         if (!strcasecmp(value, "false") || !strcasecmp(value, "no"))
>                 return 0;
>  +       *is_bool = 0;
>
>         return git_config_int(name, value) != 0;
>   }
>
>  +int git_config_bool(const char *name, const char *value)
>  +{
>  +       int discard;
>  +       return git_config_bool_or_int(name, value, &discard);

Is it better to use
+       return git_config_bool_or_int(name, value, &discard) != 0;

since git_config_bool_or_int(name, value, &discard) may return an
interger neither 0 nor 1


-- 
Ping Yin
