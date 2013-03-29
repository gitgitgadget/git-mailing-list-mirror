From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 4/6] dir.c::match_pathname(): pay attention to the length
 of string parameters
Date: Fri, 29 Mar 2013 15:45:35 +0700
Message-ID: <CACsJy8DisE8UNZzqmOFxPqw=bmFiHgE5-ao83ciGNUV9Sc9-gA@mail.gmail.com>
References: <20130328214358.GA10685@sigill.intra.peff.net> <20130328214821.GD10936@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	avila.jn@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 29 09:46:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULUxM-00024t-2n
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 09:46:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973Ab3C2IqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 04:46:08 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:58688 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724Ab3C2IqG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 04:46:06 -0400
Received: by mail-oa0-f50.google.com with SMTP id n1so260183oag.37
        for <git@vger.kernel.org>; Fri, 29 Mar 2013 01:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=xriRBK2gf/uF5chPrB/uWPNI+1uZB5qsdeeZaQI/1uw=;
        b=EpbICO3C9UC2WU2i8HVNt2OVQe4WPf9mGGwsaDmkzHcyLqBHeQx2OvoETHh4kg3Kzc
         8i5Jo5BzuAQCbyLQr8tPF1XNhGuupcpS38B3CvVafJYb78QcnahXMTL8/BNUrKnvh1F1
         W/G1OJZDDnzrfF5DhFti09Uv/mPBM+/VvA+Yg5dxURuYlJ2vDz6XN6qJr75aiSUn4T8Y
         k6+IbGARAUODyVYm2+3oRzL+dORhIXwV/XkjqyNWTFITdAi1PFBJhzf+hsUOUNgVI+N+
         qGVIhTj+8/AQmLDo8lgPcuX3p4fwjDHiJna1RyDTBJIki9EYQP1zx3BZ3eAPQrKAJe67
         JOlQ==
X-Received: by 10.182.116.70 with SMTP id ju6mr583554obb.48.1364546765518;
 Fri, 29 Mar 2013 01:46:05 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Fri, 29 Mar 2013 01:45:35 -0700 (PDT)
In-Reply-To: <20130328214821.GD10936@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219486>

On Fri, Mar 29, 2013 at 4:48 AM, Jeff King <peff@peff.net> wrote:
> -       return fnmatch_icase(pattern, name, FNM_PATHNAME) == 0;
> +       return fnmatch_icase_mem(pattern, patternlen,
> +                                name, namelen,
> +                                FNM_PATHNAME) == 0;
>  }

I think you (or Junio) should rebase this on maint. Since c41244e
(included in maint), this call is turned to wildmatch(WM_PATHNAME) and
WM_PATHNAME is _not_ the same as FNM_PATHNAME for patterns like
"foo/**/bar". A diff between next and pu shows me that WM_PATHNAME is
incorrectly converted to FNM_PATHNAME. I hope that is the cause of all
breakages Junio found out on pu.
-- 
Duy
