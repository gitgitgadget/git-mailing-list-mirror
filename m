From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 5/6] tag: use pgp_verify_function in tag -v call
Date: Mon, 4 Apr 2016 21:39:29 -0400
Message-ID: <CAPig+cQkqaYd2Vpgpd5jB8ZUD41VvjryB8tYc9JNEydNaKrr=Q@mail.gmail.com>
References: <1459808535-8895-1-git-send-email-santiago@nyu.edu>
	<1459808535-8895-6-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Tue Apr 05 03:48:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anG6n-0002t9-FG
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 03:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757005AbcDEBkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 21:40:20 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33566 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756994AbcDEBkU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 21:40:20 -0400
Received: by mail-io0-f193.google.com with SMTP id g185so253870ioa.0
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 18:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=Ku3L0EF0XH0lQjbOWG4gWRn6WeWEXUReCLKR7cvxlm8=;
        b=Wo2DaNob+Cwz9GAjgcsn3gDtFv4VHvRWyWlV0sChXIoPROMdvntetbmsqZ8kH+Bk4t
         z4N9wVUGKiqhfKz/Jy1uO5IqYkYMlP8JBz/ehRIS8V9Ep35PuS9UgWLWeVcCxWP950uO
         l7j+gUIHsfVG6ewGTg9xbCqpb0rhaYnhd3nKo53wHaKOtTQ2iXYMTLiCWlY+EFzYy+/f
         yX+CYhtJCin3Q5GHou1PwZ3QHGTlJXW60rqB4fRypxnccISQqNn8ZSLlSem0SMz741d0
         SKd+IW5SWksV9Tgihv3WiunsuHix07FRaaoclmZYHwaqhvtOlW4QgQOlw5Yp3ZZJFkgf
         fOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Ku3L0EF0XH0lQjbOWG4gWRn6WeWEXUReCLKR7cvxlm8=;
        b=d8SzWD0UEPelyA04Ed5NWJJtkD/T483Zfb5c/PCymWeI/RK9L7v2/v1mtCBvphNPUc
         qFYsaiYr3Rc8kj2zUILTJjSO+BkiS7ublT+nRPylf5geEOnfN7blgIX6JyOcQ/AP+QX4
         HhiO4QKQLQl3LR7G6PQuz8ACLUVtUZ5m7tU1VoSfLvFejUNFX7d5wFjMJzUgpJdcO864
         inj4o4vSA+97EjcTrtCqAUoo3APDbsJRycClbNqtH88UzTxg+wW4jTtVkrC0/aLlBRby
         zu20mmwYOp20iurp2um15eUYT0lS5p5u0XS7afXAruDC8SNfbJkgG+8Abw0d8/Pq9UaX
         FBLw==
X-Gm-Message-State: AD7BkJLEThWmPqyUHDWKIqpB/btT+9eN56ins7XIIQGjLpPO8gd1D41BeG5d8LMJvzeRnx6cZoTVy9GI7GNrFQ==
X-Received: by 10.107.47.41 with SMTP id j41mr18511331ioo.168.1459820369190;
 Mon, 04 Apr 2016 18:39:29 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Mon, 4 Apr 2016 18:39:29 -0700 (PDT)
In-Reply-To: <1459808535-8895-6-git-send-email-santiago@nyu.edu>
X-Google-Sender-Auth: U-nAuNqGHEde97wqZkOeaehhfB0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290748>

On Mon, Apr 4, 2016 at 6:22 PM,  <santiago@nyu.edu> wrote:
> Instead of running the verify-tag plumbing command, we use the
> pgp_verify_tag(). This avoids the usage of an extra fork call. To do
> this, we extend the number of parameters that tag.c takes, and
> verify-tag passes. Redundant calls done in the pgp_verify_tag function
> are removed.

I'm confused about everything following "an extra fork call" since
those subsequent sentences don't seem to pertain to this patch. Is
that leftover gunk from the previous version of this series?

> Signed-off-by: Santiago Torres <santiago@nyu.edu>
> ---
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 1705c94..f4450f8 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -104,13 +104,7 @@ static int delete_tag(const char *name, const char *ref,
>  static int verify_tag(const char *name, const char *ref,
>                                 const unsigned char *sha1)
>  {
> -       const char *argv_verify_tag[] = {"verify-tag",
> -                                       "-v", "SHA1_HEX", NULL};
> -       argv_verify_tag[2] = sha1_to_hex(sha1);
> -
> -       if (run_command_v_opt(argv_verify_tag, RUN_GIT_CMD))
> -               return error(_("could not verify the tag '%s'"), name);
> -       return 0;
> +       return gpg_verify_tag(name, GPG_VERIFY_VERBOSE);
>  }
>
>  static int do_sign(struct strbuf *buffer)
> --
