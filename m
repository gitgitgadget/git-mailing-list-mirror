From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2 00/16] port branch.c to use ref-filter's printing options
Date: Tue, 15 Mar 2016 15:00:41 -0700
Message-ID: <CA+P7+xoHy0oBGdYqhCmA3h=fv-YhDSyZV=kJyizwNnNcm37jBA@mail.gmail.com>
References: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 23:01:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afx1W-0002XB-Vv
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 23:01:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbcCOWBC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 18:01:02 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37686 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932195AbcCOWBB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 18:01:01 -0400
Received: by mail-ig0-f181.google.com with SMTP id mh10so27059032igb.0
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 15:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rkrwFR5BDQmG4I5VQWGoQ0BpvF3muCSLHL3jhktzGWw=;
        b=E6/MfU65IFNUphFHmXoOIcfiX+xWqpISfVG3sgxAvplgvKPzS7g/CzwZiX2zwVrsZX
         JCXBTCXhAsnh/SFnNXVMnRgx00K1YTXAnkB/4gcW6b1Wek4EFnIwfIg4iEgc2gKd+dWl
         e3JRHe5naMVQtosBCtUd+PY86w171E3jzROT808XcYcX7Yylp0nUBozkI1TiRcgFEUkx
         S6Bz2rd/u654lISL/8bqxtI9NHNs+6JGjzPR3HRpirZEg6wr4BAr6OnaAcPmEu50sAlZ
         mT9Up1SRbym4yCt+dlOzD6EqbBd4NZ01e9+xPFZxJDpf7L1SO5BpBddP3prulkR5nmW7
         KAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rkrwFR5BDQmG4I5VQWGoQ0BpvF3muCSLHL3jhktzGWw=;
        b=LiWniGbskL4XWVH+XI1PCc/LKKMw+SCTXBk0wkGYbdGgQmePZ9f4HzALVL6DNwv73b
         DbFhK/zQncScPIIkWB/kqpSwtxL3Axlt1Tswc+OQ90/M889dle0oGjSGt1sK6sVw85A7
         I8TG6g4tbtujH/3MCYn1bVvv1IAJthFSmF9lEwRXPrIiB2UyjZdU6gtj8u6o0MMVHKoB
         pF6xNKwPUS63x9jr6rqMCJBLvN4Rxqn+heTrhcLVXPqq7VbxELk+ZTsNmw9xpKFsO4jl
         TKKLO+Am+EeESRxIO0Kl6N8wB2GYMwpoRPxMif4+avsMrMcaI0Bf/BcLCPYwRdfwE/hk
         Cjaw==
X-Gm-Message-State: AD7BkJKNod7zuNZTKbkXI2IWsxr51U6CFhqywHy8qnW8GcsHUwm5P40bejKZSxvBYULHu2P72RtqCq9zOnscmw==
X-Received: by 10.50.137.35 with SMTP id qf3mr1066757igb.92.1458079260389;
 Tue, 15 Mar 2016 15:01:00 -0700 (PDT)
Received: by 10.107.10.202 with HTTP; Tue, 15 Mar 2016 15:00:41 -0700 (PDT)
In-Reply-To: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288924>

On Tue, Mar 15, 2016 at 9:47 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 193e99e..578bbd1 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -116,10 +116,12 @@ upstream::
>         `refname` above.  Additionally respects `:track` to show
>         "[ahead N, behind M]" and `:trackshort` to show the terse
>         version: ">" (ahead), "<" (behind), "<>" (ahead and behind),
> -       or "=" (in sync).  Append `:track,nobracket` to show tracking
> -       information without brackets (i.e "ahead N, behind M").  Has
> -       no effect if the ref does not have tracking information
> -       associated with it.
> +       or "=" (in sync).  Has no effect if the ref does not have
> +       tracking information associated with it. `:track` also prints
> +       "[gone]" whenever unknown upstream ref is encountered. Append
> +       `:track,nobracket` to show tracking information without
> +       brackets (i.e "ahead N, behind M").  Has no effect if the ref
> +       does not have tracking information associated with it.
>

It looks like you duplicated "Has no effect if the ref does not have
tracking information associated with it"
