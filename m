From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/WIP PATCH 05/11] transport: add infrastructure to support a
 protocol version number
Date: Wed, 27 May 2015 12:01:50 -0700
Message-ID: <CAGZ79kZosnaNv-FccG2pni2JkQdJ-QNtfHz82U+4FyYKrVACqQ@mail.gmail.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
	<1432677675-5118-6-git-send-email-sbeller@google.com>
	<20150527063925.GC885@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 27 21:12:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxgk9-0006DB-Au
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 21:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754465AbbE0TKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 15:10:53 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:35784 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753912AbbE0TBv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 15:01:51 -0400
Received: by qchk10 with SMTP id k10so8042857qch.2
        for <git@vger.kernel.org>; Wed, 27 May 2015 12:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+qU25JV9ewjxJ9DkaWm/KfAKz2uQh/nbQLQYMW7Hcf0=;
        b=Uhp5FQ4cpC8XBLtoMeBeOsGrDTWlC3ncwSnOzqmKidv46pBZAbxbTCZ/34Mj5rZvPq
         NpnbZXkgAp+uoDtluPdZ7+jZ0GN+brtLO4OW8kqTOWVcEGoPVBQLKDRkJjmplj/l5dOl
         cqqeQx1622Wmt3jTNwT3pibMJkl8lTesDzReK10EZZeFFNooy6aje/Azy2JcjqqBTkBi
         0qvcn/ZS8+jdfvy2GRAOfjrBk/Yhx8zP2bch8UoK6P0+HIjK+JyC9021AX8N2CS4F/bY
         EQ+ELjr4vX8pDHEaOhG6oReHq+v9O1wJZ+0G/h2ijz96Vk2nUwPBuQnObhZOXXac7WiL
         fq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=+qU25JV9ewjxJ9DkaWm/KfAKz2uQh/nbQLQYMW7Hcf0=;
        b=i0YoOQ4LH6IgV77D1Ih9G6bUaWE3JzZdZkmSj4AYQetHbHYb/W8IsCPPjyw9sCAxzP
         mlh89wqS0zBUJOZAK6g8R98nr1O3czpx3V7s/h7xOxfj7J6NOm9PcOu0fI5G4Re/W/Bs
         U/Q2UxGlWhIPDi2HgRcHdSSah43RaJIysdHd7Fvw6q09OtPdZef6n6QieYLzHpB11YJI
         e3DL36qFVPG4FC7l48qMbhbuxvaVkCIaah6nBpf1BAmRgpRUJ906+KRrJthCCAB9rdhq
         K42YYo1X32ncFvSB1QoxsUjrLilxZHUj0uKb4oBJv6WV47uY92dLGrKTGBKMlwno0yN3
         E6Qg==
X-Gm-Message-State: ALoCoQkQ1Y/CopER+JabBA1PF/bf854yHYuZjehg2I+Rtiq4k9RlulOTCs0dgoeaP2W6fbC8Y880
X-Received: by 10.140.96.202 with SMTP id k68mr41790658qge.102.1432753310532;
 Wed, 27 May 2015 12:01:50 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Wed, 27 May 2015 12:01:50 -0700 (PDT)
In-Reply-To: <20150527063925.GC885@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270067>

On Tue, May 26, 2015 at 11:39 PM, Jeff King <peff@peff.net> wrote:
> On Tue, May 26, 2015 at 03:01:09PM -0700, Stefan Beller wrote:
>
>> +     OPT_STRING('y', "transport-version", &transport_version,
>> +                N_("transport-version"),
>> +                N_("specify transport version to be used")),
>
> Interesting choice for the short option ("-v" would be nice, but
> obviously it is taken). Do we want to delay on claiming the
> short-and-sweet 'y' until we are sure this is something people will use
> a lot? In an ideal world, it is not (i.e., auto-upgrade and other tricks
> become good enough that nobody bothers to specify it manually).

I made the choice this way:
"Oh crap! -v is taken. so which letter is most likely not taken, so I
can move on?"

So if you have any other proposal with actual reasons I'd switch in a
heart beat.
I figured the -y is good to testing and debugging, but in an ideal
world we don't
want people messing with the transport option because of automatic upgrades
as you said.

Or do you rather hint on dropping the short option at all, and just having NULL
in the field?

>
> -Peff
