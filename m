From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/6] remote.c: simplify a bit of code using
 git_config_string()
Date: Wed, 20 Mar 2013 11:07:07 -0700
Message-ID: <20130320180707.GH3655@google.com>
References: <1363783501-27981-1-git-send-email-artagnon@gmail.com>
 <1363783501-27981-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 19:07:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UINQR-0004xM-Bk
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 19:07:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756888Ab3CTSHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 14:07:16 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:59047 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756864Ab3CTSHM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 14:07:12 -0400
Received: by mail-pb0-f45.google.com with SMTP id ro8so1567016pbb.4
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 11:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=zCioSbYT6RNgXYzMxgNdV26YyHvWm3j3bkNgPWOC9Fc=;
        b=r+YH7aZUAbcWoMWLZOnBrNq/KVhui6AfAFHbtLSvvXXsJlnH6AUR+MTp02LfkLwyjn
         9QNROqStg9xdQZHXGRjr8xyqDA8wsX8xSmuETOy1yOOCI1tASYeQwGWp47iGWngAhUm6
         NkwAZIpe188di/IIo2GshevbwhtYbEubppx6kbpOnU91uIbxhpVnNshcDkx5CMKynOwD
         7WJ0RXBPnmaxOZ2O0J2sz9uckHXIkaX395xNlLymm5Dl0dnz2yQG747TfE0Zx+u3AzsL
         AoYTldl3J5i4xYbBn2tDWXHOg6/LhTBwTHjDRRKyHfMSXyFCoFFPJJRZ/wuGTV4C6GFy
         OFng==
X-Received: by 10.66.176.73 with SMTP id cg9mr10652906pac.37.1363802832052;
        Wed, 20 Mar 2013 11:07:12 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id in5sm2899375pbc.20.2013.03.20.11.07.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 11:07:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1363783501-27981-2-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218634>

Ramkumar Ramachandra wrote:

> --- a/remote.c
> +++ b/remote.c
> @@ -356,9 +356,7 @@ static int handle_config(const char *key, const char *value, void *cb)
>  			return 0;
>  		branch = make_branch(name, subkey - name);
>  		if (!strcmp(subkey, ".remote")) {
> -			if (!value)
> -				return config_error_nonbool(key);
> -			branch->remote_name = xstrdup(value);
> +			git_config_string(&branch->remote_name, key, value);

Shouldn't this say

			if (git_config_string(&branch->remote_name, key, value))
				return -1;

or something?

Thanks,
Jonathan
