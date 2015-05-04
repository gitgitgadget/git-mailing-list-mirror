From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Fixed a translation error
Date: Mon, 4 May 2015 14:18:39 -0700
Message-ID: <20150504211839.GX5467@google.com>
References: <554766e9.b30db50a.72e3.ffff8bbe@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alangi Derick <alangiderick@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 04 23:18:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpNlH-0006PV-Mi
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 23:18:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045AbbEDVSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 17:18:44 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34311 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbbEDVSm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 17:18:42 -0400
Received: by iget9 with SMTP id t9so74424374ige.1
        for <git@vger.kernel.org>; Mon, 04 May 2015 14:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=sOnwNn7ZipJK81k/cPmVkivzHq2dGP5fvuKHstGRxq8=;
        b=V6SrX39pzRXdP0b82/gU8s68xojJsuoe6oBQL0FQrQ9CBFxVKsSveHQlqff2046HTd
         UCTwlTHm1y6eRokS0oDVRFBBwDWVx+W0v5o3+cZlixiIQygqsPyzM3HvvEBc/cNj66gc
         fMkswU44zjOlYS5hOEtmtBzNznEnT71WawxvztnpmZMlN0+NP4VW6HR8UaeQxnwdMRlO
         utrpzl8GECE4MK9/zcE21kgkrbyneTNVRbclOQLRgTsS6NBGtNs/73UVqZ7vueXRYP9h
         d+1i6LOniM1Aj3fcEWBXgnmDBjSZ17Deu8Lkrsqhpsb+igHg94n1LiJfU+uzJMlJT2Bi
         OZeg==
X-Received: by 10.50.112.73 with SMTP id io9mr760892igb.18.1430774321813;
        Mon, 04 May 2015 14:18:41 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:a584:986e:73c0:2278])
        by mx.google.com with ESMTPSA id l3sm5950343ige.21.2015.05.04.14.18.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 04 May 2015 14:18:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <554766e9.b30db50a.72e3.ffff8bbe@mx.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268355>

Hi,

Alangi Derick wrote:

> [To: unlisted-recipients: no To-header on input <;]

Please don't do that.

What mailer do you use to send patches?  Others on the list using the
same mailer might be able to help with configuration tips.

> [Subject: [PATCH] Fixed a translation error]

The above commit description is vague and confusing: in fact, this
patch doesn't fix a translation error.  Instead, the commit
description should explain the purpose of the change in such a way as
to make it clear why a person might want to apply it.

More details are in Documentation/SubmittingPatches.

> Signed-off-by: Alangi Derick <alangiderick@gmail.com>

Thanks.

[...]
> +++ b/builtin/config.c

Yes, this is an okay command to start with.  Some messages are already
translated in this file, so it's a good example of a command that
currently presents an inconsistent interface in some languages.

[...]
> @@ -412,7 +412,7 @@ static int get_urlmatch(const char *var, const char *url)
>  	config.cb = &values;
>  
>  	if (!url_normalize(url, &config.url))
> -		die("%s", config.url.err);
> +		die(_("%s"), config.url.err);

This change is subtle.  It lets a translator replace the format "%s"
with something else --- that wouldn't be useful in any language, so
this string should not be marked for translation.

The underlying message in config.url.err is from urlmatch.c and is
already translated.

There are two more strings that need to be marked for translation in
this file: "Invalid key pattern: %s" and "Invalid pattern: %s".
Here's a preparatory patch to make that output more consistent.

One more piece of advice: when working on many similar patches like
this, a good strategy is to just send out one and get review for it.
When it has been reviewed and is in good shape, you can move on to
preparing and polishing the next patch.  The first few reviewed
patches can be used a template for the rest.

In other words, only once it's very clear that all the patches are
likely to be in good shape is it time to prepare and send out all of
them.  By working through only one patch at a time in a collection of
similar, unfinished patches, you avoid wasting time re-writing all the
patches in response to feedback and avoid overwhelming reviewers by
asking them to keep track of many reviews at once.  Most comments on
one patch will also apply to all the rest and the conversation only
has to happen once.

Thanks,
Jonathan

-- >8 --
Subject: config: use error() instead of fprintf(stderr, ...)

The die() / error() / warning() helpers put a fatal: / error: /
warning: prefix in front of the error message they print describing
the message's severity, which users are likely to be accustomed to
seeing these days.

This change will also be useful when marking the message for
translation: the argument to error() includes no newline at the end,
so it is less fussy for translators to translate without lines running
together in the translated output.

While we're here, start the error messages with a lowercase letter to
match the usual typography of error messages.

A quick web search and a code search at codesearch.debian.net finds no
scripts trying to parse these error messages, so this change should be
safe.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index d32c532..89f3208 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -193,7 +193,7 @@ static int get_value(const char *key_, const char *regex_)
 
 		key_regexp = (regex_t*)xmalloc(sizeof(regex_t));
 		if (regcomp(key_regexp, key, REG_EXTENDED)) {
-			fprintf(stderr, "Invalid key pattern: %s\n", key_);
+			error("invalid key pattern: %s", key_);
 			free(key_regexp);
 			key_regexp = NULL;
 			ret = CONFIG_INVALID_PATTERN;
@@ -214,7 +214,7 @@ static int get_value(const char *key_, const char *regex_)
 
 		regexp = (regex_t*)xmalloc(sizeof(regex_t));
 		if (regcomp(regexp, regex_, REG_EXTENDED)) {
-			fprintf(stderr, "Invalid pattern: %s\n", regex_);
+			error("invalid pattern: %s", regex_);
 			free(regexp);
 			regexp = NULL;
 			ret = CONFIG_INVALID_PATTERN;
-- 
