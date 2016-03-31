From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/4] submodule--helper clone: simplify path check
Date: Thu, 31 Mar 2016 10:17:46 -0700
Message-ID: <CAGZ79kYbX5dggD7cs1PRHpkUS2gRTp1fAmt3mg1n1Og3ZB3fRw@mail.gmail.com>
References: <1459383457-6848-1-git-send-email-sbeller@google.com>
	<1459383457-6848-3-git-send-email-sbeller@google.com>
	<CAPig+cTz3fTyXFM4oPNO3Tv6dP0hN152jf9_JZOrsAZad1+O6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Norio Nomura <norio.nomura@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 19:17:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1algEC-0005yn-ER
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 19:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756715AbcCaRRs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 13:17:48 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:37417 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbcCaRRr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 13:17:47 -0400
Received: by mail-ig0-f171.google.com with SMTP id l20so72796716igf.0
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 10:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=N3/+gicRVYeFyFn0xd78qq40wo++/KAV8SI23EoMI3I=;
        b=a7+HLJVxPnvON1mJKPwE5JZoJdVoE0z3lDff4FAqI2CZSA2xOYtm0EqC+GZfDwr/aT
         9K1eOVna9dEQLzwbukyTzTwIk+ZdtJ4kGI/WlfjI33mWduFOHsKuFHbJSRevfl2rT6sk
         jsydzxsTQZtGWee1bd1EcstnBoHie6QU23eFGo14rTX9oPeM/5LxfsJ6QEi1n8PKY3SG
         Jr49a4qd38MM998Hkk6y9E5y7ixz/xXD7ndEkZFdCbHKN5uOfMAjmY2xswTVC/p3QoGK
         Bg1Lp79W5wIC6UhzRrnQokJ0EHM+KNbbO4AMP0NgVqyFp1txJ1Piz74+onhBfy/5F9FC
         sc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=N3/+gicRVYeFyFn0xd78qq40wo++/KAV8SI23EoMI3I=;
        b=F2qqNcYMiynOPffS3TJW019HWHiseyqaklphr2Ux2EYK0KXgz/fkcDDAdXTXPpE8qe
         y/C2yE8suSzqL64+l4yLMt06eKhAKvNwai1SSoh/kNLGhDtkSyDueBFBSFuvgAZmmZ9b
         oIRDlrz8O/IxYeRobb8glN+Et6DAu4LrIZf/nTL01FcxTfwz7OXPW3f4EOKuunZiJwIU
         mn6blWLb41GbdmMQkD+ZEZQEA/IDem/4CZy3KMe/opAuXDC/8W7XtvuabbbvL27BTxkh
         B+YTmHqst3SfuW9miy+5RUxYrEJGyVY2Z/hWWQkCZH5mwR+UR418ULbO5EveN+30qEoP
         DN3Q==
X-Gm-Message-State: AD7BkJKvWL6lCmO3MSySdCnEA82A/CYfAust2x+MOWNqcB8N87aqu/Lnw0e9qlbAorYcP47BjLlvW6XcDJLAqpqh
X-Received: by 10.50.57.50 with SMTP id f18mr801435igq.93.1459444666686; Thu,
 31 Mar 2016 10:17:46 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Thu, 31 Mar 2016 10:17:46 -0700 (PDT)
In-Reply-To: <CAPig+cTz3fTyXFM4oPNO3Tv6dP0hN152jf9_JZOrsAZad1+O6Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290423>

On Thu, Mar 31, 2016 at 12:31 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Mar 30, 2016 at 8:17 PM, Stefan Beller <sbeller@google.com> wrote:
>> The calling shell code makes sure that `path` is non null and non empty.
>> (side note: it cannot be null as just three lines before it is passed
>> to safe_create_leading_directories_const which would crash as you feed
>> it null).
>
> I'm confused by this. So, you're saying that it's okay (and desirable)
> for git-submodule--helper to segfault when the user does this:
>
>     % git submodule--helper clone
>     Segmentation fault: 11
>
> rather than, say, printing a useful error message, such as:
>
>     submodule--helper: missing or empty --path

I think I was rather saying,
* that you see the segfault behavior not at all when channeling
   the command through the proper frontend command
* that it already crashes (we access *path before this check,
  so this check is pointless)


> While one can argue that this is an
> internal command only invoked in a controlled fashion, it's not hard
> to imagine someone running it manually to understand its behavior or
> to debug some problem.

(additionally:)
And later we may want to reuse this code when replacing the
frontend command to be written in C completely.

>    if (!path || !*path)
>        die(_("submodule--helper: unspecified or empty --path"));

That sounds good to me. I'll pick it up.
