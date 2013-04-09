From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] clone: Allow repo using gitfile as a reference
Date: Mon, 8 Apr 2013 17:24:56 -0700
Message-ID: <20130409002456.GW30308@google.com>
References: <20130408185957.GM27178@pug.qqx.org>
 <1365461200-13509-1-git-send-email-aaron@schrab.com>
 <1365461200-13509-3-git-send-email-aaron@schrab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Aaron Schrab <aaron@schrab.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 02:25:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPMN3-00034u-83
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 02:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925Ab3DIAZD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 20:25:03 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:39070 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935717Ab3DIAZC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 20:25:02 -0400
Received: by mail-oa0-f48.google.com with SMTP id j1so6848728oag.21
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 17:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=B1kNqorfN9+VtOZyiMJyPuegeV7s36xo5xDqLD/0zg8=;
        b=RBE8YTuoXcdF6pwnawC8/im1+t+qIhNrDWWGgb5hnX2NzgJCKvAHNt4MxuQyvgO4IA
         Xto8oD4tFkLsIo2/9+geaxcwEKI8QmuISDbEblPolhyS9oOotB6bgikqqO3j8fvV1DWV
         GNbD1CNayCQ3qETqoxbQkqm7OBAU63Xg79VxhdEvA1SqJAUsO9WFCyuNFOgCxtSVsbYP
         Xh+dcMoHLsJ9oppEaDM6aDH7DrtNcQbpzBFb3I6GtmXwpMeJQUHbH1RXv72ARoTYAM1e
         UwnQ3/tNJqhx5S/jRR0zTUCcqsaPNDJSoiTw2mnVW6r7L7QciD8s2Zm57JYJEt3I28z0
         eqTw==
X-Received: by 10.182.33.102 with SMTP id q6mr16945323obi.39.1365467101107;
        Mon, 08 Apr 2013 17:25:01 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id xz9sm28016180oeb.5.2013.04.08.17.24.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 17:24:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1365461200-13509-3-git-send-email-aaron@schrab.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220543>

Aaron Schrab wrote:

> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -232,11 +232,19 @@ static void strip_trailing_slashes(char *dir)
>  static int add_one_reference(struct string_list_item *item, void *cb_data)
>  {
>  	char *ref_git;
> +	const char *repo;
>  	struct strbuf alternate = STRBUF_INIT;
>  
> -	/* Beware: real_path() and mkpath() return static buffer */
> +	/* Beware: read_gitfile(), real_path() and mkpath() return static buffer */
>  	ref_git = xstrdup(real_path(item->string));
> -	if (is_directory(mkpath("%s/.git/objects", ref_git))) {
> +
> +	repo = read_gitfile(mkpath("%s/.git", ref_git));
[...]
> +++ b/t/t5700-clone-reference.sh
> @@ -185,4 +185,11 @@ test_expect_success 'fetch with incomplete alternates' '
>  	! grep " want $tag_object" "$U.K"
>  '
>  
> +test_expect_success 'clone using repo with gitfile as a reference' '
> +	git clone --separate-git-dir=L A M &&
> +	git clone --reference=M A N &&

What should happen if I pass --reference=M/.git?

> +	echo "$base_dir/L/objects" > expected &&

The usual style in tests is to include no space after >redirection
operators.

With those two changes,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
