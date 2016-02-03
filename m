From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 4/8] submodule-config: introduce parse_generic_submodule_config
Date: Wed, 3 Feb 2016 15:26:51 -0800
Message-ID: <CAGZ79kZwGPNHeZFcu7-60U8cTZhC8t6TZ5=4ZzBbP+4MrLqRZQ@mail.gmail.com>
References: <1454435497-26429-1-git-send-email-sbeller@google.com>
	<1454435497-26429-5-git-send-email-sbeller@google.com>
	<xmqqd1sdl7bx.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 00:27:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aR6po-00055k-83
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 00:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932840AbcBCX0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 18:26:54 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37973 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753574AbcBCX0w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 18:26:52 -0500
Received: by mail-ig0-f181.google.com with SMTP id mw1so47713968igb.1
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 15:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yT2I6P9hxxpidNiCZHewpLHdWMU7C0H6IK7cMQasWM4=;
        b=CTj2ryzuhRuFFaW9lqKVJubEG4keKL6kEwFROD3/VXxE+5ko0WxVTR238GWMUzbquR
         KmDn8uBLwEfFYTqhtrPgWFbxBe4rLscrr1QgGWkdoKgYUHEg699mB1SBZ0lBVc22gWLj
         76minVRiPgBgcBUkaabwaJ6D+79JG1f+qhHPLl0Gs8aYw2fe0SnAz4VxjAAxiFrTdmq/
         MAXPa7YMl7JXyzdtUQpjb6n4Nv1dB0jI2EQG2G1TZqCrQLbqQXTTWQwtK6OgyC6NK1eX
         L3ixhvsta1+01B6cBMCcv1SqaAQSnh6Lwjjf7nYh9nHECLRWBm76sK3Vi7kFKzGzb/h1
         zWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=yT2I6P9hxxpidNiCZHewpLHdWMU7C0H6IK7cMQasWM4=;
        b=FMvOCHacJpNEz05R10Q2Fo16MsqRGZy/FYHXXvV2CGvqdRWNKgzFiCS3uF09W8Qn9A
         G/HRkI7EVWuVPYbdKTiWrUO5mGkfIvnIMLp2PXZdKvyzcMkn6g37i7sjL7VpREDu4pCN
         KnBM9Ev2iVMhxRbvRJTBys6WrrZZR+XYmsaVJTy0ElndaAaC7h3sS57O3M8CTyMGYfpa
         qcVxIT5W00eljjMMmDHcqRdQi2OgR/r463HsrG3pc67h4OWVTMVURIlio88V5ozTBz+K
         9wnPF4hqhDX/Uq88g9bM51NrVCl11GtR/B2zUqaW4/E3mjcdPIZOspbs1vvdCimzVall
         dvcQ==
X-Gm-Message-State: AG10YOQViiI5dxEuJzsClBAbA2zr4eL3eJ+ZzEsM5LiFMWH5I9gKDs2Lm1HdO2FZW1cRVGHr6Igzm/FXiqLYFmW8
X-Received: by 10.50.43.168 with SMTP id x8mr6257193igl.93.1454542011980; Wed,
 03 Feb 2016 15:26:51 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Wed, 3 Feb 2016 15:26:51 -0800 (PST)
In-Reply-To: <xmqqd1sdl7bx.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285383>

On Wed, Feb 3, 2016 at 3:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This rewrites parse_config to distinguish between configs specific to
>> one submodule and configs which apply generically to all submodules.
>> We do not have generic submodule configs yet, but the next patch will
>> introduce "submodule.fetchJobs".
>
> OK.
>
>> +static int parse_config(const char *var, const char *value, void *data)
>> +{
>> +     struct parse_config_parameter *me = data;
>> +     int subsection_len;
>> +     const char *subsection, *key;
>> +
>> +     if (parse_config_key(var, "submodule", &subsection,
>> +                          &subsection_len, &key) < 0)
>> +             return 0;
>> +
>> +     if (!subsection_len)
>> +             return parse_generic_submodule_config(key, var, value, me);
>
> The same comment as in the footnote for the review on [3/8] applies
> here.

Ok, so we want to have

    [section ""]

and

    [section]

be different, such that we could have a submodule with an "" name,
but still be able to differentiate to the common section which should be
applied to all submodules?

It sounds like a corner case to me, but if we want to guarantee such a behavior,
let me see if test cases for that need some special love in this series.

Thanks,
Stefan
