From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv13 5/7] git submodule update: have a dedicated helper for cloning
Date: Fri, 19 Feb 2016 12:20:48 -0500
Message-ID: <CAPig+cR6SKwM7x=n6fdZDscm2GLTNQq-ZNvB-ELqAk6dk1jGFw@mail.gmail.com>
References: <1455838398-12379-1-git-send-email-sbeller@google.com>
	<1455838398-12379-6-git-send-email-sbeller@google.com>
	<20160219120310.GB10204@sigill.intra.peff.net>
	<CAGZ79kbp+A1J4isLGftMiA2UZM16NO6nUycraj4U==2Zv6kHVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 18:21:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWojy-0002FT-G5
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 18:21:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030379AbcBSRVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 12:21:06 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:34164 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947508AbcBSRUt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 12:20:49 -0500
Received: by mail-vk0-f51.google.com with SMTP id e185so80202878vkb.1
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 09:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=rERzyl6swzrn+GTNyKfzUCujcruz53a/QzV7fuLnFaA=;
        b=YM3KWrAJl3Mq2wlT/pgKy4NxRO3E+a3gvd+4M1O/4RfdxIZIbMydfZ4jSxjDpzsh+2
         n0iex5tVZQP1O4X76Irzn9xQ1orZU+Ava4ebeRBR5GWAV3+sJxWfSdVKSAKuQYvDnz4/
         92K6b6wYafue2jlZVedO1jMDM0ZtA59okmB0sShlsLElEhZuLvxD4ZyDQ8/zqxbNfHWa
         wniK4W0ERNtW4QyN0BK1oCAqKgdbvNFmoXxogBdsYNybT9ZS0XG4KjGXaXpc+jmAl/Qr
         ME4S+S1A4WiZGqEWdJn3RRBwhjZ3F6DXqPyFWzgliK/XdkGqX9+PvTYSJHPUMXx6qgYk
         pJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=rERzyl6swzrn+GTNyKfzUCujcruz53a/QzV7fuLnFaA=;
        b=VV5hou8Rpx4XX8hG3g17C1EvhocME/rS8ZHRffECrCTPJJXyWolc7Efx708MPoT28l
         VlyxL9PTILc7DO6BeSaRiissVHZK89CDSdh8dRYYml41lsWMaYoQFUwJD/hLo/l9LZU4
         KgKW2TGMJJneV9c2++nhruVMlrxAet4UYTAS7sTIJNh+kiUj5tTHfBIlvUQfSgF/v5pJ
         /bynGEPYCLnbKhgVABzQbFEtKU5r/dlD8vYc65z1zexE8hg/fjs8T5Kr3hCGGqDqzyZP
         TZqniwMEPthos+iwB+mfO8iYh9cOZ48XfedlfeVe1OlqiJ7oKGOXs9FS9oT7uRA9gUvY
         O9QA==
X-Gm-Message-State: AG10YOTac2iduV7i4iT8f8XKRYW6bAcDHkHer9CjFRjr5wpyCCTmwfO65WHwJfOXRc8H4p4cz1+i/ajczrbZJQ==
X-Received: by 10.31.164.78 with SMTP id n75mr12271599vke.14.1455902448764;
 Fri, 19 Feb 2016 09:20:48 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Fri, 19 Feb 2016 09:20:48 -0800 (PST)
In-Reply-To: <CAGZ79kbp+A1J4isLGftMiA2UZM16NO6nUycraj4U==2Zv6kHVQ@mail.gmail.com>
X-Google-Sender-Auth: tzZSx9GQ7BvJ02wfBQTLPDH6Ses
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286719>

On Fri, Feb 19, 2016 at 11:47 AM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Feb 19, 2016 at 4:03 AM, Jeff King <peff@peff.net> wrote:
>> On Thu, Feb 18, 2016 at 03:33:16PM -0800, Stefan Beller wrote:
>>
>>> +     if (needs_cloning) {
>>> +             cp->git_cmd = 1;
>>> +             cp->no_stdin = 1;
>>> +             cp->stdout_to_stderr = 1;
>>> +             cp->err = -1;
>>> +             argv_array_push(&cp->args, "submodule--helper");
>>> +             argv_array_push(&cp->args, "clone");
>>> +             if (pp->quiet)
>>> +                     argv_array_push(&cp->args, "--quiet");
>>> +
>>> +             if (pp->prefix)
>>> +                     argv_array_pushl(&cp->args, "--prefix", pp->prefix, NULL);
>>> +
>>> +             argv_array_pushl(&cp->args, "--path", sub->path, NULL);
>>> +             argv_array_pushl(&cp->args, "--name", sub->name, NULL);
>>> +             argv_array_pushl(&cp->args, "--url", strdup(url), NULL);
>>
>> No need to strdup() here; argv_array handles its own memory, so this
>> just leaks (and if we were keeping it, it should be xstrdup(), of
>> course).
>
> We cannot remove the strdup as the url is a local variable we read in from
> git_config_get_string and the local variable is going out of scope before the
> child process ends?
>
> I'll change it to xstrdup then.

When Peff said "argv_array handles its own memory", he meant that it
does xstrdup() itself, so there's no need for you to do so a second
time manually (leaking a string as a consequence).
