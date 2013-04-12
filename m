From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] i18n: make the translation of -u advise in one go
Date: Thu, 11 Apr 2013 19:55:02 -0700
Message-ID: <20130412025501.GB3266@elie.Belkin>
References: <4003e29bb04b122897cefe2a8057266e2428dce5.1365734618.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.co>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 04:55:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQU8v-0003ek-MO
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 04:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947Ab3DLCzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 22:55:08 -0400
Received: from mail-da0-f54.google.com ([209.85.210.54]:49088 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736Ab3DLCzG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 22:55:06 -0400
Received: by mail-da0-f54.google.com with SMTP id p1so937246dad.27
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 19:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=fGRy0tNhuYvGRgqXT04qt+MDQPDMQ2lXYUEc4y8t21U=;
        b=d8eTJlL/E0gMpLEg7OoJ6NzlQPIFuXmcV8hDDe1WI7oiy7CJsC6C7ZhujBX4nkZDcU
         G/8IVrcYa6GCssjhpTPoj8ScssYtG3e3Qil/hMUr+IbLg3Q3HNl6ZiV2bhnB+dKz+9so
         S2qz16qXBHNEGdZZCI7ISb4Wv7tT7kpTTuNIzn0TBRPEEfueeg8MrQibI3jVyAgnmnJZ
         69oo584OVMgBTZueOEBCw4YMkp42yQPrpqsuoKTEXLhX3WolXZ3bgpzyYZ3+iZALjkbz
         5IiKjNWTug/NpFXO0jtyZ7ozX+CAixYDrmrBgDXifFgRsGyyNSl/puAHNnScL/vJi95v
         aNmA==
X-Received: by 10.66.240.70 with SMTP id vy6mr13258486pac.70.1365735306314;
        Thu, 11 Apr 2013 19:55:06 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id be10sm6489993pbd.30.2013.04.11.19.55.04
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 19:55:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4003e29bb04b122897cefe2a8057266e2428dce5.1365734618.git.worldhello.net@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220947>

Hi,

Jiang Xin wrote:

> Since status_vprintf() called by status_printf_ln() can handle eol in
> buffer, we could simply join these lines into one paragraph.

Good idea.

[...]
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1223,16 +1223,12 @@ void wt_status_print(struct wt_status *s)
>  		if (s->show_ignored_files)
>  			wt_status_print_other(s, &s->ignored, _("Ignored files"), "add -f");
>  		if (advice_status_u_option && 2000 < s->untracked_in_ms) {
> -			status_printf_ln(s, GIT_COLOR_NORMAL, "");

Tiny nit: I'd suggest keeping the above line, making it:

			status_printf_ln(s, GIT_COLOR_NORMAL, "");
			status_printf_ln(s, GIT_COLOR_NORMAL,
					_("It took ..."
					  "... status')."),
					s->untracked_in_ms / 1000.0);

That way, the message to be translated doesn't start with a newline,
so translators don't have to worry about preserving it (or removing
it if the layout ever changes in the future, etc).

With that change,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
