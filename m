From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 0/6] Fix checkout-dash to work with rebase
Date: Tue, 18 Jun 2013 16:06:03 +0530
Message-ID: <CALkWK0n2AvL49DNp1t7ty0Dneprd7r_V2p=brS0qMKz=wdZz6A@mail.gmail.com>
References: <1371372316-16059-1-git-send-email-artagnon@gmail.com>
 <7v1u81ibjp.fsf@alter.siamese.dyndns.org> <7vk3lsei4i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 12:36:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UotHM-0005Og-To
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 12:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755999Ab3FRKgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 06:36:45 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:64617 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754539Ab3FRKgo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 06:36:44 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar20so9612932iec.21
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 03:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MVpPgl+J3Y6YpfvagE+ut+FymilhWo9+4e0XL9ffCt0=;
        b=zaEH34ZCDku+6qP04GDrV3MsI8DHHgvMYc8JKuEtJnBA9lPDcqHXzrhv5BmO2Q4+8M
         DBwc28T9ZgkX+zOErUBLKQvpz4mrdRewR1NBcYUvVn04y7NXRHNNiQ8vklbLeFUWvu29
         rXfktrxy5mqimeowE3HdzZgunuGZj0bf7X0uHh2KyA9YqqGGQF+tDi3163EQ8T150blv
         YsppJvEVNYPT6qoRcmeUDe16FOvGXqyiF2rlxL3SlVQUZk3NA8gfSHTlyZiZXJyzsTXJ
         fiN1UuBwsUyOqSdVbgSr+tDMwJf/g0WcYQ2XnyD7mJ6OFfv7kz+CTGMzxkwdLwzxR+st
         mEcQ==
X-Received: by 10.50.25.194 with SMTP id e2mr7191543igg.111.1371551804055;
 Tue, 18 Jun 2013 03:36:44 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 18 Jun 2013 03:36:03 -0700 (PDT)
In-Reply-To: <7vk3lsei4i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228190>

Junio C Hamano wrote:
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index a58406d..c175ef1 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -934,6 +934,21 @@ test_expect_success 'rebase --edit-todo can be used to modify todo' '
>         test L = $(git cat-file commit HEAD | sed -ne \$p)
>  '
>
> +test_expect_success 'rebase -i produces readable reflog' '

I don't know if this test is a good idea at all.  We never directly
check the messages written by a command to the reflog, and I suspect
that there is a good reason for this: the format of .git/logs is not
guaranteed to be stable, and the messages written by various commands
are not guaranteed to be stable either; the only machine-parsing of
reflogs we do is very minimal: interpret_nth_prior_checkout() and
grab_1st_switch().

A quick

  $ git grep .git/logs -- t

shows that I'm mostly right about this.

Why make an exception in the case of rebase -i?  In the worst case,
the patch atleast needs to be discussed as an independent patch: it's
certainly not obvious enough to sneak into this series.  I'll submit a
re-roll without this hunk.
