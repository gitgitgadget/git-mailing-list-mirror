From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] checkout: Say =?utf-8?B?4oCc?=
 =?utf-8?B?aXTigJ0gaW5zdGVhZCBvZiDigJx0aGVt4oCd?= for one commit
Date: Wed, 1 Apr 2015 12:43:11 -0700
Message-ID: <20150401194310.GH22844@google.com>
References: <1427909880-9846-1-git-send-email-thosch97@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Schneider <thosch97@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 21:43:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdOXo-0006ca-2m
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 21:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225AbbDATnP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Apr 2015 15:43:15 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34893 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086AbbDATnO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2015 15:43:14 -0400
Received: by ierf6 with SMTP id f6so52230700ier.2
        for <git@vger.kernel.org>; Wed, 01 Apr 2015 12:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=E6We6EV8RyAt04zvIUnaI4L5GWmmSICIjbscgzL9PuE=;
        b=DthPUNZvAPtDQk66sKt7K2yN+wA4ORKbUjfim/9x6lvwB9iIsC7g7PA7YXF2RmMyWy
         lH9e8hGf/XjATlw+/aPLJViW1qLBsrENIXoMKSJAdnbM4uVb7Z5Dy5FISMQ6+kKmCs9h
         XRw/1+aYqkankf4UHZQepOHlv6Nec8kC0Acd4wwjb1W/9C/wqcDHs/S+HqM8kXxedqvz
         8zNTfw8KeBebG+dgWeVv1MMHpUQLWYWG5dPHQDX1uitMRL3mS1Ka6BYIO0Wpcu5r/iNw
         JFCJf7onCVmUqjIZR+xqzHFK76dPnQ7Dmcw8Gwz43VTGujsN7btcC06zj5CHePusYnlv
         hpcw==
X-Received: by 10.42.41.200 with SMTP id q8mr71428466ice.61.1427917393611;
        Wed, 01 Apr 2015 12:43:13 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:1935:bf91:6c0f:6c54])
        by mx.google.com with ESMTPSA id e3sm12744281igg.16.2015.04.01.12.43.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Apr 2015 12:43:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1427909880-9846-1-git-send-email-thosch97@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266617>

Hi,

Thomas Schneider wrote:

> When detached and checking out a branch again, git checkout warns abo=
ut
> commit(s) that might get lost.  It used to say =E2=80=9CIf you want t=
o keep them
> [=E2=80=A6]=E2=80=9D even for only one commit.
>
> Signed-off-by: Thomas Schneider <thosch97@gmail.com>

Makes sense.

[...]
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -743,10 +743,17 @@ static void suggest_reattach(struct commit *com=
mit, struct rev_info *revs)
> =20
>  	if (advice_detached_head)
>  		fprintf(stderr,
> -			_(
> +			Q_(
> +			/* The singular version */
> +			"If you want to keep it by creating a new branch, "
> +			"this may be a good time\nto do so with:\n\n"
> +			" git branch <new-branch-name> %s\n\n",
> +			/* The plural version */
>  			"If you want to keep them by creating a new branch, "
>  			"this may be a good time\nto do so with:\n\n"
> -			" git branch <new-branch-name> %s\n\n"),
> +			" git branch <new-branch-name> %s\n\n",
> +			/* Give ngettext() the count */
> +			lost),
>  			find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV));

The comments for /* singular */, /* plural */, and /* count */ seem
redundant and distracting to me, but since we have the same comments a
few lines before, keeping it consistent is the right thing to do.

=46or what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
