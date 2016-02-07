From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 05/12] ref-filter: introduce parsing functions for each
 valid atom
Date: Sun, 7 Feb 2016 04:12:16 -0500
Message-ID: <CAPig+cSvjd6hX3B1SEXW176Nr3Hz9wSLfkNubA6O6d47zbYSEg@mail.gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
	<1454262176-6594-6-git-send-email-Karthik.188@gmail.com>
	<CAOLa=ZQxbCYd_bpf4PSpRVvejOgi=farNPtHgP_mZZypOf6cnQ@mail.gmail.com>
	<CAPig+cSt9Dub88ywP8mc8dPq6pXFvn4OTSJmEWbAiTeirRB7xA@mail.gmail.com>
	<CAOLa=ZTFVLxiP5PXszwmS3xueitQJd3FhJ968hf58yvWX=qmGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 10:12:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSLOP-0004nq-3Q
	for gcvg-git-2@plane.gmane.org; Sun, 07 Feb 2016 10:12:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551AbcBGJMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2016 04:12:23 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:36257 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbcBGJMR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2016 04:12:17 -0500
Received: by mail-vk0-f68.google.com with SMTP id k196so760123vka.3
        for <git@vger.kernel.org>; Sun, 07 Feb 2016 01:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=YqK4qtl2d+6EvR37+szzNvON0GI24PU9O4mGOCwbbxo=;
        b=tQqvJr/y5oMb7tnEYHik6otHLTbfiS7VwLifTxyfEWSCC6xLQB2eZ2MvnC1LKDj1fY
         NNMbgfzcqs6OgtPZjf5OUr8qbDpAFo2fLzJ1xfDJXVzMRMVPFt49xMwacNeBVesBkf9X
         8P1TlebsLUONJqyT+42mkKp85jDe+blTesBUsqUiYpnC1ksI/q1FntRdaMpGEP6o4NdT
         1Vrrhu3Rv0OxV0rsKkfQq+/26vSNsE6q/1v7wl3FM9Tfra7fb3MqjKboVYB6gmm2PQty
         /NgHb2+gE0j2aN31IFDvFySg74xAWUpIN64j0c3ipT7puqQsF2IhJImN13OQXUP02x2M
         0LvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=YqK4qtl2d+6EvR37+szzNvON0GI24PU9O4mGOCwbbxo=;
        b=S9meiy9iIQk2Hi/v+GT9v6tr18xz/SJOCIEsptp5BD0I1oiiBdmW6vqV23RJFiltM0
         DdL2vggviVMy4hRHoK3amU4MS+64vFzINGNUvggrvWOcsfA4e6/yU6pr9B9VQd+SY4lp
         D//GWzwbjCNp8cG21fkZFHGwBoCN5xkCaCU+UV5byfBa0g862eL0Iy2Be4Ta58CzkPT0
         A4DxmOvGrUj74sa66EMn0nUVKipEgKAZtyv4OU7OgHBkcmOcCsF8r/bXD5PSJDzrgMos
         NRJkLobkPHnoe7TLbJPyD3gGiQ1RLS8UxtY8RRwmo/5CXVvCrepYO88ZYylzMb54rrXr
         GxSw==
X-Gm-Message-State: AG10YOSlv/vSVXJlPUGpTr0T4rJIJF2bu8r7FLc3sanKizV21yNpl0H9VQaQExjw8fDyHqt/HHdWOQAgE3PRiA==
X-Received: by 10.31.164.78 with SMTP id n75mr15918905vke.14.1454836336445;
 Sun, 07 Feb 2016 01:12:16 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 7 Feb 2016 01:12:16 -0800 (PST)
In-Reply-To: <CAOLa=ZTFVLxiP5PXszwmS3xueitQJd3FhJ968hf58yvWX=qmGA@mail.gmail.com>
X-Google-Sender-Auth: XcistL9x8pUWTiPSYmspPuE9n2c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285725>

On Sun, Feb 7, 2016 at 4:01 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Sun, Feb 7, 2016 at 12:03 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sat, Feb 6, 2016 at 10:15 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>> I think the code needs to be changed to:
>>>
>>> -               if ((!arg || len == arg - sp) &&
>>> +               if ((arg || len == ep - sp) &&
>>> +                   (!arg || len == arg - sp) &&
>>
>> For completeness, for people reading the mailing list archive, a
>> couple alternate fixes were presented elsewhere[1], with a personal
>> bias toward:
>>
>>     arg = memchr(...);
>>     if (!arg)
>>         arg = ep;
>
> There is a slight issue with this solution though, as you see 'arg'
> gets modified
> here, hence 'arg' passed to parser functions will never will null.
> [...]
> Else we could avoid this assignment and re-assignment by letting 'arg'
> hold the value it gets from memcmp(...) and use the solution provided
> by me or Ramsay (preferably)
>
> Ramsay's solution being
>
>                 arg = memchr(sp, ':', ep - sp);
> -               if ((!arg || len == arg - sp) &&
> +               if ((( arg && len == arg - sp)  ||
> +                    (!arg && len == ep - sp )) &&
>                     !memcmp(valid_atom[i].name, sp, len))
>                         break;

Yep, Ramsey's fix is preferable.
