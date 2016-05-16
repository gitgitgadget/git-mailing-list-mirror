From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 54/94] builtin/apply: make parse_chunk() return a
 negative integer on error
Date: Mon, 16 May 2016 20:19:11 +0200
Message-ID: <CAP8UFD1Qwyi6uO4YTNB_RqR9QiCkuc9DbRb2JHTsiv9KrEjpeQ@mail.gmail.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<20160511131745.2914-55-chriscool@tuxfamily.org>
	<CAPig+cQkKijp_Mg0Ho0wAFSxmLin0EPA_a5PwV9DaHkHLJKNMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon May 16 20:19:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2N77-00034s-JL
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 20:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753274AbcEPSTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 14:19:30 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34829 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbcEPST3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 14:19:29 -0400
Received: by mail-wm0-f67.google.com with SMTP id e201so19906199wme.2
        for <git@vger.kernel.org>; Mon, 16 May 2016 11:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=JCR8vt4eExt/WeK7Iv+/twK0u3lrY9C53AAG2kkaz/k=;
        b=venlCcK+6yCKHKkBE16odUpJyKFGtHk/TyH8GjDupV5mmuAPLa+8suQ1htSbdvt9gt
         +c5YGtO/MWZq/LnPhMyaMoXdUlgTvbDFsB2jsQWwzohtExaSVubo97PsRsmDSPy40rPy
         rt72MQ5wYKZF8qGjzKfArOG2nRkQy50+cYIGygvlikgbTRV6HA9MzAhJGpxFZ5Pa06o3
         0V+J4fr/9tEEQ9g3dqtJ1XCXcVn7sfBQHHgKSalJngxvu3pkCy5jouy56g6R6y2WamRC
         bwYner2xtaLCuXjUUL5iL5lkEGJP2Ik1Yvr7v7hypbVHnXC19XLLaOxYMhzrY6keTQXh
         oHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=JCR8vt4eExt/WeK7Iv+/twK0u3lrY9C53AAG2kkaz/k=;
        b=MvIlLsMWQJqd00eJbBN14AU7p2gJDOaFU/AN5IfJoaR+x6v0dhnPPGmrRW1r8MEwRu
         6TCrlnglCPbeIQpCTtTD2lMRcRw1r3em68SJCTXjEirVnCHnna0fJzFtaBcGjRPyeROP
         IAFrupmFAZcQd93wn3wi4fXmAwQ9V+y/JJnuMOLg4k0Vs6oNUlD5ihXGhiRTKhoZTexu
         3JqCrWLOqcVo/SIjyoK4RQ+tqPN7YUE7VvTtDbPazfEE2a3uWRxDYAv4C8iGB2QLeGWh
         Nqo09Gw3+SJq31EVv6faVyvT4CuPU2GEw35TXqnaZJ9hMOO4AoHOgwOU6Lb9GmXUgNoQ
         nk+g==
X-Gm-Message-State: AOPr4FXt9JyBxZcI6ReKskG6xtjyFHmVP5b1pgcaaBjrqw/ssUApnkhHLIBvKcAns/uiVa1YO/8cHNZFcgl7TA==
X-Received: by 10.28.151.133 with SMTP id z127mr18381447wmd.79.1463422751572;
 Mon, 16 May 2016 11:19:11 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Mon, 16 May 2016 11:19:11 -0700 (PDT)
In-Reply-To: <CAPig+cQkKijp_Mg0Ho0wAFSxmLin0EPA_a5PwV9DaHkHLJKNMA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294774>

On Mon, May 16, 2016 at 5:04 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, May 11, 2016 at 9:17 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> To libify `git apply` functionality we have to signal errors to the
>> caller instead of die()ing or exit()ing.
>>
>> To do that in a compatible manner with the rest of the error handling
>> in builtin/apply.c, find_header() should return -1 instead of calling
>> die() or exit().
>
> Why is this talking about making find_header() return -1? Didn't that
> happen in the previous patch?
>
>> As parse_chunk() is called only by apply_patch() which already
>> returns -1 when an error happened, let's make apply_patch() return -1
>> when parse_chunk() returns -1.
>>
>> If find_header() returns -2 because no patch header has been found, it
>> is ok for parse_chunk() to also return -2. If find_header() returns -1
>> because an error happened, it is ok for parse_chunk() to do the same.
>>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>> diff --git a/builtin/apply.c b/builtin/apply.c
>> @@ -2176,8 +2176,9 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
>>                  * empty to us here.
>>                  */
>>                 if ((state->apply || state->check) &&
>> -                   (!patch->is_binary && !metadata_changes(patch)))
>> -                       die(_("patch with only garbage at line %d"), state->linenr);
>> +                   (!patch->is_binary && !metadata_changes(patch))) {
>> +                       return error(_("patch with only garbage at line %d"), state->linenr);
>> +               }
>
> Unnecessary braces.

Ok, will remove.
