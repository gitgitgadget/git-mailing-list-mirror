From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v5 3/5] pseudorefs: create and use pseudoref update and
 delete functions
Date: Fri, 31 Jul 2015 16:40:16 -0700
Message-ID: <CAGZ79kZ-e-GU5FfKWDAUxQPUnyrmGjSvHGnjWn=pwpDAj37umQ@mail.gmail.com>
References: <1438322781-21181-1-git-send-email-dturner@twopensource.com>
	<1438322781-21181-3-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 01:40:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLJub-0002Kg-9J
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 01:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754010AbbGaXkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 19:40:19 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:34704 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbbGaXkS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 19:40:18 -0400
Received: by ykax123 with SMTP id x123so71581275yka.1
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 16:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9t/cbsvc8t0xnnO+HAND9/BKjWX8gPWz1A9fjEfJWQs=;
        b=TD2vSNKlMYaVhSd8weQvGyItZWPdhZ5nkK1pbSbq8aGV7CP3eKfdRYVx4082tfsR5I
         Bn/VfI3QRA7Y45DfxyDohNVrmm9VvZmjNYbNjMlYQIsQ16+KXRAxrZJZbpXjSk0NSDpZ
         +BIuJxEySr82gBxGX0JdvS3oMsrl9ELHTv+HaqAOoxCM8FPqt8jxGOVNEda7sIkjw1ka
         L99a8Ik490tZ9GdkDyE31q7DI4+Ltp1MJ3YJlwVdkcp+aWLJ+TTyl0X4NuIU3YvdoXyu
         OyT6mVkP6+HhR3k3rCjaCy5tdMiUCtTWHv6SYG8ram0z1lrJXD0PtWp84jhsVcbkVaEl
         iHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=9t/cbsvc8t0xnnO+HAND9/BKjWX8gPWz1A9fjEfJWQs=;
        b=E39NFVmW3ooDvpcWVFZoh97jizCggcNmj6/D+9TIONAqctHqg/KJst6f1gw8FI9xj6
         GPAyODBBi58MThev8p7Bh71MIe7ASndVG31HXqnz0skwxAeLvAu56Cc646otmGNZz9PV
         0m94SJ0evmHjSiTkEiHbExlQJhYHCBt+6NOhyGDX4/g3e3VD1dJe2KL0l4w7hvGBh9oJ
         2KVguUyQMrJ2aJedG5ksQHcb+dU4VgSFK0B1cIvPOFA1xuSsU5zm2ivkeWUfEVA4fZBl
         9cA05WaHysGib79/x6OVjDHZnW5e2SXfvUpmQDBQvvY33lfVxJdQnuMtjTQBVQkVMcJM
         h+Eg==
X-Gm-Message-State: ALoCoQkMSF5XepTzRQC9Zm2898sH6Tb7L7zEO5NJDRGEcSLmo3oU2yLAT20mmMu4jqnr26ggbRyA
X-Received: by 10.170.36.197 with SMTP id 188mr6492836yke.10.1438386016999;
 Fri, 31 Jul 2015 16:40:16 -0700 (PDT)
Received: by 10.37.21.129 with HTTP; Fri, 31 Jul 2015 16:40:16 -0700 (PDT)
In-Reply-To: <1438322781-21181-3-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275094>

I am sorry for being late to the review, I looked into coverity today as Duy
bugged me to fix the memory allocation stuff[1]

[1] $gmane/275046

On Thu, Jul 30, 2015 at 11:06 PM, David Turner <dturner@twopensource.com> wrote:

> +
> +       if (old_sha1) {
> +               unsigned char actual_old_sha1[20];
> +               read_ref(pseudoref, actual_old_sha1);

What about the return value of read_ref?
In most cases of the code base (19/21) we check the return of that.
So maybe

    if (read_ref(pseudoref, actual_old_sha1) <0)
        die("Could not read ref %s", pseudoref);


> +               if (fd < 0)
> +                       die_errno(_("Could not open '%s' for writing"), filename);
> +               read_ref(pseudoref, actual_old_sha1);

same here.
