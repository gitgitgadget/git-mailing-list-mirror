From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/6] push: change `simple` to accommodate triangular workflows
Date: Mon, 24 Jun 2013 13:16:47 +0530
Message-ID: <CALkWK0mAyDb3AjH0s3j2gRRDckx=a2nr9MR+O6gEtwX2MSJrtw@mail.gmail.com>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
 <1372048388-16742-4-git-send-email-gitster@pobox.com> <CALKQrgfAT9GhD-_tZHr9wRA6R6g7ttDWTsmUQXdWUhG-gwNBqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jun 24 09:47:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur1Uu-0007cU-Li
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 09:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759Ab3FXHr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 03:47:29 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:62088 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681Ab3FXHr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 03:47:27 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so24085466ied.14
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 00:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4HJjpxFEMArvO7ZscpfAakUGwL8M67r579dOA7Fteag=;
        b=i8BjO7DPo+oKaTAaMXFuHu5jgpV+v5UUQMrIDuVAmnvkm8x8FM8lo2GPYstvbrQDkT
         f9M3RXniwvsSXCBHeoKuoUO5UY1psuvRJecMDJrGIkFgOLs8GOZRbO6RVBhRKCoDIsM3
         8c4liO3MDIq6zfMtE0IUBsywkxTh7AeU9fi2+TdzHIUBckcWqjCMZ8C+GHbB767WtfII
         6oiLRPKHZPLj6u+ZYHDi67bBOwzjTH6NlaJcKelWogNtlnCBN+hcpUXH1DONhesRriyq
         tIb5Op6L2esFLKZ0r9XdBTdysRjezSLpcAqmF3cpUt+kwM91gRnvShxIfPhCqrFBOrLo
         IX1g==
X-Received: by 10.43.88.3 with SMTP id ay3mr7416936icc.61.1372060047154; Mon,
 24 Jun 2013 00:47:27 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Mon, 24 Jun 2013 00:46:47 -0700 (PDT)
In-Reply-To: <CALKQrgfAT9GhD-_tZHr9wRA6R6g7ttDWTsmUQXdWUhG-gwNBqQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228786>

Johan Herland wrote:
>> An earlier round of this change by mistake broke the safety for
>> "simple" mode we have had since day 1 of that mode to make sure that
>> the branch in the repository we update is set to be the one we fetch
>> and integrate with, but it has been fixed.
>
> Shouldn't there be an acompanying test to demonstrate this mistake being fixed?

Read "earlier iteration": it didn't get merged.

>> +static void setup_push_current(struct remote *remote, struct branch *branch)
>> +{
>> +       if (!branch)
>> +               die(_(message_detached_head_die), remote->name);
>> +       add_refspec(branch->name);
>
> Here (and above) we add a refspec to tell Git exactly what to push
> from the local end, and into what on the remote end.

Nope, we add the refspec "foo", without the :destination part.  The
remote end is unspecified (and defaults to "foo", but that is in the
transport layer).

> Is it possible to
> end up with multiple simultaneous refspecs matching the same local
> ref, but mapping to different remote refs? If so, which will win, and
> does that make sense?

It is impossible.  We either:

- Get an explicit refspec from the user and never run
setup_default_push_refspecs() to begin with.

- Run setup_push_refspecs() and add *one* refspec depending on the
push.default value.
