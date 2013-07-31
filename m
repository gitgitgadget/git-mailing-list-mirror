From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH v6 2/6] config: add helper to normalize and match URLs
Date: Wed, 31 Jul 2013 13:50:58 -0700
Message-ID: <AF82C57D-BE60-420C-AE62-13907D8115C7@gmail.com>
References: <1375298768-7740-1-git-send-email-gitster@pobox.com> <1375298768-7740-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 31 22:51:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4dMS-00015P-FQ
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 22:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760761Ab3GaUvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 16:51:03 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:41869 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759783Ab3GaUvC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 16:51:02 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq13so1300579pab.25
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 13:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mauler;
        bh=pOAXuPL9yTTG/P3QXU86rlQfOVl86q9HFKtt3DOasBs=;
        b=YOsDYRy7tDjyVpCvCvyThohm4/u6J4iQpiyUYNiP7GzCKgRyv1Bx/p6n33p0Upp+E9
         3AQArHu2lQxeGopJ3RdRLCqtW91USUINiWqeQiCSiEwfXZ3K6sCegsGbNasJCMqbDuW6
         vZLAHm2DpP/KxMeDWO2PhjTMJdt4lz6BR0K7Wl9sT1HDX3uqI3Gbp7+FR5ITtOM6paeb
         O3OLqnorrc3haD0FsaAb0EwpnB77t5of59/7Yd90PHvDkqlqDhOyNpXAgOIIlL41+6jW
         KdzMtGqnkAOJavprI5fAY2v99NVAb8rXJyGHL3/5R9/5aJGn+s1ZxUojY9/gGshTeOJn
         Nx0w==
X-Received: by 10.68.186.193 with SMTP id fm1mr81854771pbc.163.1375303861369;
        Wed, 31 Jul 2013 13:51:01 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id wr9sm87658pbc.7.2013.07.31.13.50.59
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 13:51:00 -0700 (PDT)
In-Reply-To: <1375298768-7740-3-git-send-email-gitster@pobox.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231456>

On Jul 31, 2013, at 12:26, Junio C Hamano wrote:

> From: "Kyle J. McKay" <mackyle@gmail.com>
>
> Some http.* configuration variables need to take values customized
> for the URL we are talking to.  We may want to set http.sslVerify to
> true in general but to false only for a certain site, for example,
> with a configuration file like this:
[...]
> urlmatch.c | 468 ++++++++++++++++++++++++++++++++++++++++++++++++++++ 
> +++++++++
> urlmatch.h |  36 +++++
> 2 files changed, 504 insertions(+)
> create mode 100644 urlmatch.c
> create mode 100644 urlmatch.h
>
> diff --git a/urlmatch.c b/urlmatch.c
> new file mode 100644
> index 0000000..e1b03ee
> --- /dev/null
> +++ b/urlmatch.c
[...]
> +
> +static size_t http_options_url_match_prefix(const char *url,
> +					    const char *url_prefix,
> +					    size_t url_prefix_len)
> +{
> +	/*
> +	 * url_prefix matches url if url_prefix is an exact match for url  
> or it
> +	 * is a prefix of url and the match ends on a path component  
> boundary.
> +	 * Both url and url_prefix are considered to have an implicit '/'  
> on the
> +	 * end for matching purposes if they do not already.

This function should probably be renamed to just url_match_prefix  
since it isn't part of nor does it depend on the http_options related  
files or functions anymore.

Otherwise looks good to me.
