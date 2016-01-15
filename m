From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule: Port resolve_relative_url from shell to C
Date: Fri, 15 Jan 2016 14:58:47 -0800
Message-ID: <CAGZ79kaBLmwfeMocKP+tQmqNLy0BDYTU9dFtMY6rmiTqNSi_Dg@mail.gmail.com>
References: <1452708927-9401-1-git-send-email-sbeller@google.com>
	<xmqq4mehm92b.fsf@gitster.mtv.corp.google.com>
	<CAGZ79ka0rxYK7GRSjh13XOsg887EgqYtc5B60z9qU=tAoJGERQ@mail.gmail.com>
	<xmqqwpraiw15.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	Jens Lehmann <jens.lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 23:58:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKDKW-0001xJ-PE
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 23:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbcAOW6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 17:58:49 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37089 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbcAOW6s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 17:58:48 -0500
Received: by mail-ig0-f182.google.com with SMTP id h5so19319478igh.0
        for <git@vger.kernel.org>; Fri, 15 Jan 2016 14:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WOAmN2gTXQPUhwOhBn0HDjGwyO0neyP+QY+TGb4S+zM=;
        b=Uyf7oBq4ouX+SnlT2KTlx3PNs/w72k8SxR5wegzmpZ2NSj6BYSV1MQW0TuJjI+Qte+
         Ca7WL5aKiQY4exOKZg3U+YqaAG9rouo8nnO2W7szC8JCEqGz31vWk35urDVt2W7/LNps
         cZiuOewL+I7uPsD/CprYYoeYgHs0aHScfzWeq2huVOWZ4uFt57hq3RPCC3bMInLUr6+l
         Zr0XiE6JSAjkNDaiVgetyCoH3lxjYFG96Odao35IKu6BKPZ/w5iNHuQVxxOi9/YnGOTV
         SAXdZNUIFjfyRsaFtjfR1PfOMTmwOWb6Bl3xv7MWx6c/0XSvxP0e1e+daOC37O2e10sp
         Qm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=WOAmN2gTXQPUhwOhBn0HDjGwyO0neyP+QY+TGb4S+zM=;
        b=XEVokMSjYcrX5zkqMWCni64p7jGafsOe+3e2X6+NaFBLuTBfFmz3QaRYMAnea7diMG
         eo+71wrHpwKHVBw9qd7SNBTCYLt6TzcBeWjiZ4nWJQu0ekVS0uyi0bH//nmU4Eg6Pky+
         xV14SMV1PeQeMz/BP+i+Itu2+ByUi5U9GCoiJ9KbIC+A05VWxn0m3oXpgAz/wPM1h5LQ
         uWYb2YlwmfWXi6vhraYD5uD/jSYUTVjFQpKAP6X1n1AdE8l6WPMttSqUiEweK8v3jO6B
         fvlFQpd249oA4zMgPwyh2kOPq2H3c9pcAhDtoheW64OhCg3CgxvC7X4riu5dJXl8dxmM
         Rmmw==
X-Gm-Message-State: AG10YORnbojomasDf5fzjDXCsa+0k3FHKQewXdraD3w34XPJLJUTusMvM7kYCNhaeSKbj2ikvQB5svOHQ/OYZEdG
X-Received: by 10.50.28.51 with SMTP id y19mr934374igg.93.1452898727638; Fri,
 15 Jan 2016 14:58:47 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Fri, 15 Jan 2016 14:58:47 -0800 (PST)
In-Reply-To: <xmqqwpraiw15.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284227>

On Fri, Jan 15, 2016 at 9:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Wed, Jan 13, 2016 at 2:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Stefan Beller <sbeller@google.com> writes:
>>>> +     while (url) {
>>>> +             if (starts_with_dot_dot_slash(url)) {
>>>> +                     char *rfind;
>>>> +                     url += 3;
>>>> +
>>>> +                     rfind = last_dir_separator(remoteurl);
>>>> +                     if (rfind)
>>>> +                             *rfind = '\0';
>>>> +                     else {
>>>> +                             rfind = strrchr(remoteurl, ':');
>>>> +                             if (rfind) {
>>>> +                                     *rfind = '\0';
>>>> +                                     colonsep = 1;
>>>> +                             } else {
>>>> +                                     if (is_relative || !strcmp(".", remoteurl))
>>>> +                                             die(_("cannot strip one component off url '%s'"), remoteurl);
>>>> +                                     else
>>>> +                                             remoteurl = xstrdup(".");
>>>> +                             }
>>>> +                     }
>>>
>>> It is somewhat hard to see how this avoids stripping one (or both)
>>> slashes just after "http:" in remoteurl="http://site/path/", leaving
>>> just "http:/" (or "http:").
>>
>> it would leave just 'http:/' if url were to be ../../some/where/else,
>> such that the constructed url below would be http://some/where/else.
>
> Is that a good outcome, though?  Isn't it something we would want to
> catch as an error?

I would want to add theses checks later and for now
just port over the code from shell to C. (The same issue
is found in the shell code and nobody seems to bother so far)
