From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 5/7] i18n: am: mark more strings for translation
Date: Tue, 24 Jul 2012 23:26:33 -0500
Message-ID: <20120725042633.GB3055@burratino>
References: <cover.1343188013.git.worldhello.net@gmail.com>
 <1493bd09efd0ba6e1d56500305d989047da245ec.1343188013.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 06:26:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SttBN-0001qv-R7
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 06:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826Ab2GYE0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 00:26:40 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60234 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765Ab2GYE0j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 00:26:39 -0400
Received: by yenl2 with SMTP id l2so298319yen.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 21:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=q2Zkup0oCGeekLxOwwOfyXmIvCxBz7+gtoKsNEciu1Q=;
        b=kc8mE3iGbALFRBvIudtoXxl3pzGyFGb1VqgaDORvWYm71jTAQgLLHoBa6jKOxB2y2F
         I7CKihp2ZPz3s8GIfJr7DuLiwOQfjXNFfxFVwqiJGLrxMIsWB1wK/MB+D2nfT6y6rB3a
         6S5HtFxOYP5aMqUiMNVaoLEs4WkC+XQpbOkssKCsPVqtTscujx4Xn4XMc49xYq+fEDlZ
         qZM4yzMFB4QPOhME/H5ZH6YZJ37AFam1Uez9awLKviuEAido15ci65tKDAF+aSdHS7fD
         V1JAjhUz+X6WPM1+RprjC0ZbBUaL4AN/QlGQ8FiEPEQdY8emiZGNwGZN06MHGYo6tq5A
         vJ9Q==
Received: by 10.42.146.6 with SMTP id h6mr20997595icv.53.1343190398970;
        Tue, 24 Jul 2012 21:26:38 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id k5sm313323igq.12.2012.07.24.21.26.36
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 21:26:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1493bd09efd0ba6e1d56500305d989047da245ec.1343188013.git.worldhello.net@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202118>

Jiang Xin wrote:

> Mark strings in 'git-am.sh' for translation. In the last chunk, I
> changed '$1' to '-b/--binary' for this reason:
>
>  * First, if there is a variable in the l10n message, we could not use
>    gettext. Because the variable will be expanded (evaluated) and will
>    never match the entry in the po file.
>
>  * Second, if there is a positional parameter ($1, $2,...) in the
>    message, we could not use eval_gettext either. Because
>    eval_gettext may be a wapper for gettext, and the positional
>    parameter would loose it's original context.

Yes, I think it's a good change.

> --- a/git-am.sh
> +++ b/git-am.sh
[...]
> @@ -387,8 +386,8 @@ do
>  	-i|--interactive)
>  		interactive=t ;;
>  	-b|--binary)
> -		echo >&2 "The $1 option has been a no-op for long time, and"
> -		echo >&2 "it will be removed. Please do not use it anymore."
> +		echo >&2 $(gettext "The -b/--binary option has been a no-op for long time, and
> +it will be removed. Please do not use it anymore.")

Could this be simplified to

		gettextln >&2 'The -b/--binary option...
... any more.'

or

		gettextln 'The -b/--binary option ...
... any more.' >&2

or would that confuse xgettext?  That would be more comforting than "echo"
because if the translated string includes backslashes then the behavior of
echo can be unpredictable.

Sorry I missed that last time.

The rest is indeed
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
