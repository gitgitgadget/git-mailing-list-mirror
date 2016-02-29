From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v6 4/7] submodule: fix submodule--helper clone usage
Date: Mon, 29 Feb 2016 15:15:06 -0800
Message-ID: <CAGZ79kaTSyqYWumBPn6fSQdyiEsyXTBxcH4DjTRo6vyhZ+d-mg@mail.gmail.com>
References: <1456786715-24256-1-git-send-email-jacob.e.keller@intel.com>
	<1456786715-24256-5-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 00:15:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaX22-0005rE-1x
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 00:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482AbcB2XPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 18:15:08 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:33235 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbcB2XPH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 18:15:07 -0500
Received: by mail-ig0-f178.google.com with SMTP id y8so7554558igp.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 15:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=mwaRqekpS7JQ28UiTnJZAz8jjc+4PyOPx/ME9m5zINM=;
        b=RlaUwr1KoM1uGfaug1C5n8Zlq0hSBhvr4/C/7j3myJa0SCvIuv8hXF7VEzZJ9ADtyw
         uu4BeMU3UlWn+3V8qkSjguJiYcNVAfTkaartkp4km/8iGnDfVXscYT8qGgJVrqedB49q
         x1PrMJxbVenU/BMQW+4bTG9A/uritdsKoo2PEzckiom02u8SgmFY47aThKbaD3xxylL2
         i0vjq5IgpkD5cWwDUEPbuAvvY0v8xnNsg0T2sqtXkVTrk/8wiXdEnesVYUOOHRhZu3R+
         C1MImwSQLT+s6oR6FVxefsW9cIOP4LlTiOAVfFwl6EKi6ERQxNEXf0UD6GfDJx8kTaoy
         hX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=mwaRqekpS7JQ28UiTnJZAz8jjc+4PyOPx/ME9m5zINM=;
        b=NxaV477FRFHtqJPnE1uoEIweuxXFpz5pPA4qLOf+X/84UnO+9WyxPCF7hwvHibNtvQ
         o5R8iuSOhH+unOydYj28oLfHOj8rn7wu5CTOM0VTPs2MrZyA2bZdCdZ5ZMd8X1u1KlSx
         ajIsofsVvEK/6BXk1EsodsDnh8fMb4r4R8p3lX7viQyW6GGZVVFkmbTX5q8ZbUQiX2Qb
         m8tUaI6nhkFbeRz3ltuQkyHJt21TYOzkIqehcEJCYEvThQF6fF2TBn0Y+2FGX7svcjFb
         kBXt09njov/7nCEuJ0F/Ns1tKLjihu6J5TiFcAeSYTVlyyKIbW60Jw2lrZwllR8tb2TP
         R+yg==
X-Gm-Message-State: AD7BkJL6Psx6+kHyagYnHbdJDHdJ8G0ePyAGUL4+Xu3e2BqTlWkwzjoCaHINrFxh8ROhkM0C+TLYVxNER+nUGane
X-Received: by 10.50.180.35 with SMTP id dl3mr501635igc.94.1456787706656; Mon,
 29 Feb 2016 15:15:06 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Mon, 29 Feb 2016 15:15:06 -0800 (PST)
In-Reply-To: <1456786715-24256-5-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287936>

On Mon, Feb 29, 2016 at 2:58 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> git submodule--helper clone usage stated that paths were added after the
> [--] argument. The actual implementation required use of --path argument
> and only supports one path at a time. Update the usage string to match
> the current implementation.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>

Reviewed-by: Stefan Beller <sbeller@google.com>
