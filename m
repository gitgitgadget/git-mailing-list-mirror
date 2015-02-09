From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 08/11] ref_transaction_create(): check that new_sha1 is valid
Date: Mon, 9 Feb 2015 10:35:58 -0800
Message-ID: <CAGZ79kbC-HB7nFcLUBGddkXKT__gYdigSHs=bg8CQW9SieUPWg@mail.gmail.com>
References: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
	<1423412045-15616-9-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 09 19:36:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKtBl-0002zV-ES
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 19:36:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933724AbbBISgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 13:36:00 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:41280 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933629AbbBISf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 13:35:59 -0500
Received: by iecrd18 with SMTP id rd18so6639629iec.8
        for <git@vger.kernel.org>; Mon, 09 Feb 2015 10:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ciZq6TGNGPE6X6T/YiH32IjQH+ZY/iGQmpV8m9FDOMc=;
        b=pNXRvvprF94SZnU5qREpt3A9iM6RhMvDC5UznE9shGVSmVdF8WNTsf5/LDkZMq8vRn
         fcQeZ9Xwl31eC3gSo3PLbbkn6chqBKQtyurh8uOBh+FVcZv5Y4jZSRn23JiK1paHNPpJ
         DsEPu/8GZfrpr7yCEJXu+xmAgJ/bwhpoKmxdX98ZXDccnxkD3y/dGUpHZ+xn0/osAQxi
         v/BAox1d0VV49O+8m6wLx+aSeAtgXexpkGWlz2kt5O/XPcg1tPBM00CgRnR7SoVDxtYq
         OSYiP1aZVe6i1ZNnSce+BDeE2n/cWh51yAG3g+nr6PqONKfkzhyKqAh8KMRvVjO0OKEx
         2SBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ciZq6TGNGPE6X6T/YiH32IjQH+ZY/iGQmpV8m9FDOMc=;
        b=EzG1TGCdFYJR1FH6UoSZKjLqHC39vHJ76aWqWmYDhgzH/oJDSes/u2VdUOryDIpay+
         EXHIYWLRNEX0WwCPN5dqGl5XqJ5z/LDA+NH6SNMxzn1z2uSUniR0vThrx9Ap4unLGJDj
         Rn1B7etgFXE4fNpGDr6CYemm3JteMwmts7dZlXdlFwRtdMIPZBrNCDsE7Z7WIlaEpck+
         fS6M2qpeSatPsobrtvyGF4xlpSI3TabmcQw4y6DpShFvd6LYwNU4aNDQGy/1J/asqdZv
         5MxhkxJh713x1PBqOuVI9w4Vveq119NmwlphemJAXfLI2C7yl+R6zTNWoF9hFx8Mgal5
         QaVg==
X-Gm-Message-State: ALoCoQlQu+IFtcdmqqWxcnkYHUI4/QcahZItRpmy2aNns1q5FXM70UW4XaYeByHSB0XhbhvSq2G0
X-Received: by 10.107.137.17 with SMTP id l17mr7320573iod.33.1423506958918;
 Mon, 09 Feb 2015 10:35:58 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Mon, 9 Feb 2015 10:35:58 -0800 (PST)
In-Reply-To: <1423412045-15616-9-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263576>

On Sun, Feb 8, 2015 at 8:14 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Creating a reference requires a new_sha1 that is not NULL and not
> null_sha1.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Reviewed-by: Stefan Beller <sbeller@google.com>
