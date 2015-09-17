From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 07/10] git submodule update: pass --prefix only with a non
 empty prefix
Date: Thu, 17 Sep 2015 16:33:24 -0400
Message-ID: <CAPig+cQtrL1jN+iePU8BBqQSrbDC78y_bPrb-MwnrqEHysmiGA@mail.gmail.com>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
	<1442453948-9885-8-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, vlovich@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 22:33:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zcfs2-0006OP-E4
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 22:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbbIQUd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 16:33:26 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:32885 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbbIQUdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 16:33:25 -0400
Received: by vkgd64 with SMTP id d64so18375901vkg.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 13:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=8ymlnE1CUxF8KPo3fXnyIKVtxpMwEOE37ejaf3HqdvQ=;
        b=VVjxE4Lusa4bVdlmSOD3iiFp8bn1S92GyewF04xVVNybKnIo9eZkj6W6lJasDqX66t
         6T9I4dwxqvVD5IF6Xf+bpGCXp3rjH+eUfUi/YfZf/obyooIseKfeojE0ne6Zcfg+uSr5
         WcFLQZ/YCmoVnaTry1cfF+wXpp65tZQ+GCRzno8xIdzFyoZ/sDxLuB5qQGhGF0n1QSRi
         piTEQw5V0bY36j/1iSHgBhSzr+6TMaQo19nuAcWrjfO/KY3H/vF9dhNdBDotMVq363LK
         CIF15IaCnUFypdQB93szgtAonVwL0CAjJYpozObhwFdMYGAnIvjvP2EJR4u9iq9GZXmD
         ofAQ==
X-Received: by 10.31.8.80 with SMTP id 77mr1215127vki.45.1442522004767; Thu,
 17 Sep 2015 13:33:24 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Thu, 17 Sep 2015 13:33:24 -0700 (PDT)
In-Reply-To: <1442453948-9885-8-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: 2_9UC6cgfulpJ0_BKyaHi2a8AaM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278165>

On Wed, Sep 16, 2015 at 9:39 PM, Stefan Beller <sbeller@google.com> wrote:
> We should not pass --prefix NULL into the helper. Although the helper
> can deal with it, it's just messy.

Perhaps the commit message can explain under what conditions $prefix
will be null...

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 7ef3247..3ccb0b6 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -700,7 +700,7 @@ Maybe you want to use 'update --init'?")"
>
>                 if ! test -d "$sm_path"/.git && ! test -f "$sm_path"/.git
>                 then
> -                       git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$prefix" --path "$sm_path" --name "$name" --url "$url" "$reference" "$depth" || exit
> +                       git submodule--helper clone ${GIT_QUIET:+--quiet} ${prefix:+--prefix "$prefix"} --path "$sm_path" --name "$name" --url "$url" "$reference" "$depth" || exit
>                         cloned_modules="$cloned_modules;$name"
>                         subsha1=
>                 else
> --
> 2.6.0.rc0.131.gf624c3d
