From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 20/23] reflog_expire(): new function in the reference API
Date: Mon, 8 Dec 2014 15:32:17 -0800
Message-ID: <20141208233217.GL25562@google.com>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
 <1417734515-11812-21-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Dec 09 00:32:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy7my-0005D0-Ew
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 00:32:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540AbaLHXcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 18:32:19 -0500
Received: from mail-yh0-f73.google.com ([209.85.213.73]:48668 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbaLHXcT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 18:32:19 -0500
Received: by mail-yh0-f73.google.com with SMTP id f10so320822yha.0
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 15:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=QfLJGEUJq0AWZ4EtmNylCogBdQwviN2qpC5+kHyKMpc=;
        b=OwTMkxJeNSAJRG+k3MzqtRCfWuPQWYRVe5FNSWSuDUqgpSN6wQOkcuXI0202K16DsW
         0jFuN4uLZDebiSf7kX4PxNzNCcAfivHbN2eqRx+ShBxISqUa4VYMC3VKrYhUCE4j5Li/
         j6SKAfi0VOn0/LKjgY3v2Q7x6B93owvQwUKzDWnuwJqbx70IDhpkr65NA0A75abhheZ0
         HsSv7/EN05x4GHRFuTu8heeX+DA6VBRDj1ZbzTT9CdlVJj4RjmeaNh1fgpM71kLG6wgk
         fPBTrqLdRjH9t5CCleoeF1QuYrI8hksdw8uR6+7ydkI9ABZqbiGkJrYDaH1NWDua7+XU
         dKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=QfLJGEUJq0AWZ4EtmNylCogBdQwviN2qpC5+kHyKMpc=;
        b=iadZnuys97fGQGPa6R9dVGT6gUaNtO5rQ3rjU9kewCVfJ6Gu4aJiMMq/H3B0YdttNE
         /V9FCrCeMr8nfqriErUIlRSjmtFNKryjzbT8UO1GySomYFjVKkQbevWxMcT5VLVUZiKm
         DBI1xyeE8n6Z5aenqnvCg0tItbyJsD7zMPXrGiwaeVopx7hu+53YCUV38AxD/bg8w3VF
         7FcF0zcjBz+TIscvAAJJiLtbI/BBsKHxfoyqET9Dg8X0pTg8rCXC0HrTZXnkb0FfdCvE
         KooAOBnhbMqF1n6aPZqs50wk9MCQU7qSpI9/MvOWv6NRxKMZ30rCQyYgB524HpWf70QX
         3UCA==
X-Gm-Message-State: ALoCoQkqBAFlAjmsvVn8Rw7MJaOw0iCBobAc+TVlCfeQ8UdgGeTA2imgvHtYrC5II0tZ4v4hFy/J
X-Received: by 10.236.63.6 with SMTP id z6mr30412510yhc.47.1418081538370;
        Mon, 08 Dec 2014 15:32:18 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id r6si1700750yhg.1.2014.12.08.15.32.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Dec 2014 15:32:18 -0800 (PST)
Received: from sbeller.mtv.corp.google.com ([172.27.69.125])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id kTBwlvL7.1; Mon, 08 Dec 2014 15:32:18 -0800
Received: by sbeller.mtv.corp.google.com (Postfix, from userid 279346)
	id 6BBA6140BBD; Mon,  8 Dec 2014 15:32:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1417734515-11812-21-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261097>

On Fri, Dec 05, 2014 at 12:08:32AM +0100, Michael Haggerty wrote:
> Move expire_reflog() into refs.c and rename it to reflog_expire().
> Turn the three policy functions into function pointers that are passed
> into reflog_expire(). Add function prototypes and documentation to
> refs.h.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

With or without the nits fixed
Reviewed-by: Stefan Beller <sbeller@google.com>
as the nits are not degrading functionality.

> ---
>  builtin/reflog.c | 133 +++++++------------------------------------------------
>  refs.c           | 114 +++++++++++++++++++++++++++++++++++++++++++++++
>  refs.h           |  45 +++++++++++++++++++
>  3 files changed, 174 insertions(+), 118 deletions(-)
> 



> +static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
> +		const char *email, unsigned long timestamp, int tz,
> +		const char *message, void *cb_data)

Nit: According to our Codingguidelines we want to indent it further, so it aligns with
the arguments from the first line.

+static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
+                             const char *email, unsigned long timestamp, int tz,
+                             const char *message, void *cb_data)

> +	}
> +	return 0;

Why do we need the return value for expire_reflog_ent?
The "return 0:" at the very end of the function is the only return I see here.

> +enum expire_reflog_flags {
> +	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
> +	EXPIRE_REFLOGS_UPDATE_REF = 1 << 1,
> +	EXPIRE_REFLOGS_VERBOSE = 1 << 2,
> +	EXPIRE_REFLOGS_REWRITE = 1 << 3
> +};

Sometimes we align the assigned numbers and sometimes we don't in git, so an alternative would be

enum expire_reflog_flags {
     EXPIRE_REFLOGS_DRY_RUN    = 1 << 0,
     EXPIRE_REFLOGS_UPDATE_REF = 1 << 1,
     EXPIRE_REFLOGS_VERBOSE    = 1 << 2,
     EXPIRE_REFLOGS_REWRITE    = 1 << 3
}

Do we have a preference in the coding style on this one?




> + *
> + * reflog_expiry_select_fn -- Called once for each entry in the
> + *     existing reflog. It should return true iff that entry should be
> + *     pruned.

Also I know how we got here, I wonder if we should inverse the logic here
(in a later patch). "select" sounds to me as if the line is selected to keep it.
However the opposite is true. To actually select (keep) the line we need to return
0. Would it make sense to rename this to reflog_expiry_should_prune_fn ?
