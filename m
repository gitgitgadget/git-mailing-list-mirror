From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 10/11] ref_transaction_verify(): new function to check a
 reference's value
Date: Mon, 9 Feb 2015 10:50:47 -0800
Message-ID: <CAGZ79kZqsCmhzw9mW4Bxyzd-+XRuzh5aYFnp5GLZwjGj9SW_LQ@mail.gmail.com>
References: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
	<1423412045-15616-11-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 09 19:50:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKtQ4-0000rn-Sr
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 19:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760562AbbBISus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 13:50:48 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:45339 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753833AbbBISur (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 13:50:47 -0500
Received: by mail-ig0-f179.google.com with SMTP id l13so18436993iga.0
        for <git@vger.kernel.org>; Mon, 09 Feb 2015 10:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EmvUM3ngIIfhhrfPXxb5umujsWNgcKC3Vl2qe/+I2UM=;
        b=WQdShmpP9x2IvyNGujLm7ExJ8nEkNzV69tq2lZZgmEMAYPEuxoAH/Fa6IS1NBcmh/O
         Ge64QBbuHCRLmWDOipGI0M2gGScAONdxubqFktSRbLdunpbZBxhHx09Lx+SSQbGO32cH
         6KQs0WCcUYPzQmSkAMVbYFSYsPgPPT9VpPTABqtd/IcT1UprmhEavoRV3d+LSUmfgobI
         F4fdV1XjP6wqjiONn1y7m1Bhiz2gwX33HaayXkRdlv1lAdZ9w7eBA8qkNUoG5FI+JK9P
         t7tlFlNvBfh0CpayST8VqHUF1zjvIPau3K5KZD03y5pDQZHP3UE0OpP7S6QUcaSaSloi
         7A9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=EmvUM3ngIIfhhrfPXxb5umujsWNgcKC3Vl2qe/+I2UM=;
        b=C6cvbP6IZ4mA74YZBzKRVk+gKiBlfIuopY57Bqb5yliWK92uwTRn4JAD0Fprk57iaT
         pvcWwBiv0vxqm4LuzSBRfPzOmBi8ogQx+LoTOKlH49V6Y7LmqwKTk2pQK+tUJpV8ELy6
         dBAr3C4zgGJXlQiyZIrUNNSr9Ors+q12dljWRc7+zG/5DYP4LOATRMH1hYcrZ3mtPATG
         6q5cStd6D9xwLs4i0HuoNsoIZ6hGkUANb0znlZMdDqhDfYPgM94yAUpknxLQNuftSSsi
         d46xTSW2JB6vXHVlQqIgMBAE0ODM9MCIZ2+E4iWGxjUxp9d6j9iwviIYWSh0lBIZXylN
         dFIg==
X-Gm-Message-State: ALoCoQktI2jz2vjqzpeu7iCeQblapJATo5vEESo+wzdQtvx0o2N0VQHII58Ds/ttdt9slG6Y+GnP
X-Received: by 10.107.18.148 with SMTP id 20mr116050ios.34.1423507847052; Mon,
 09 Feb 2015 10:50:47 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Mon, 9 Feb 2015 10:50:47 -0800 (PST)
In-Reply-To: <1423412045-15616-11-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263581>

On Sun, Feb 8, 2015 at 8:14 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>  /*
> - * Add a reference update to transaction.  new_sha1 is the value that
> - * the reference should have after the update, or null_sha1 if it should
> - * be deleted.  If old_sha1 is non-NULL, then it the value
> - * that the reference should have had before the update, or null_sha1 if
> - * it must not have existed beforehand.
> - * Function returns 0 on success and non-zero on failure. A failure to update
> - * means that the transaction as a whole has failed and will need to be
> - * rolled back.
> + * Add a reference update to transaction. new_sha1 is the value that
> + * the reference should have after the update, or null_sha1 if it
> + * should be deleted. If new_sha1 is NULL, then the reference is not
> + * changed at all. old_sha1 is the value that the reference must have
> + * before the update, or null_sha1 if it must not have existed
> + * beforehand. The old value is checked after the lock is taken to
> + * prevent races. If the old value doesn't agree with old_sha1, the
> + * whole transaction fails. If old_sha1 is NULL, then the previous
> + * value is not checked.
> + *
> + * Return 0 on success and non-zero on failure. Any failure in the
> + * transaction means that the transaction as a whole has failed and
> + * will need to be rolled back.

Do we need to be explicit about having to rollback everything in each
ref_transaction_* function documentation?

I like the new wording (first paragraph) of this function documentation.
