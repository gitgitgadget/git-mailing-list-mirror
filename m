From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 45/83] builtin/apply: move 'state' init into init_apply_state()
Date: Wed, 27 Apr 2016 14:00:33 +0200
Message-ID: <CAP8UFD03d7DVnKDmzv0JbAv1j7=nPv=qCJgkKqNOt5JPL5+hMg@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-46-git-send-email-chriscool@tuxfamily.org>
	<CAPig+cTx6jGwS12c8j_O+kT-f06o3E_yxrWZXmeU-XQ7fUY_9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 14:00:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avO92-0002q7-HI
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 14:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837AbcD0MAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 08:00:36 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35051 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbcD0MAf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 08:00:35 -0400
Received: by mail-wm0-f41.google.com with SMTP id e201so35407455wme.0
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 05:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=whE7s0dhDLFY8RWsucB9X2NSEEt26j2Rkox0ftjn+r0=;
        b=GJSQk8ABS9VkACTFGMWyXBjJxdKn+bza0DJbRf0ivpb2w11ATSplu0Dhyo9bOkt8kj
         5uI11jULpVs85K7QXmqlpq/FR26kJXquQE9ZGsGwO42urF103bcZ/iEgp7sTLyxw0wCv
         m0i3KpL9G1jJ15HS7dlE8pIXIk4DdU5vhauqaa4kU1GT815vbga7s3dDtMDtOHatsPez
         2rDFYW81iLj0exR575rdlmi5rJl7VxoNzXgr+CW7a9zfswIyZj/ASwzsrC5kzNduU6k/
         B84Vr+dPePlYwylr2ljiaNWeKYiGyv6a6TP5zdet0F5ZXSAeVSkSIIXCaeUptON5XrG0
         wsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=whE7s0dhDLFY8RWsucB9X2NSEEt26j2Rkox0ftjn+r0=;
        b=LrShqOUmSW4NJC2RPcm0w3sDQF/UnPWNfk/t8Hvv/eTOAjboA2aw4wtoN95M++PeMh
         W0QUzlW1QvyEcJYkVwOeb5P78YFSiZjXTrKTpw0UvxFRw2J8kZ4pGFWRw9cgfsneCCT3
         tT1EdwlSX663uekO9LuSXaAJ8YKY7HoNV8GbGASymegQ3Vah1kYGuUi7VwGaL6Jeuaty
         ZRuXry9IOtMqOBpnMdo8+HXyhD95WAGWZ52GF/JhB6waEMI4U4VjrUXPSWkMQk4lgx13
         0x1c/+zPwfaiKxmr2F8s5y2owIZvsXDeEDIQwqRy4QE+9Tj5dQx/q9rt/SQrunow2nfg
         E4zQ==
X-Gm-Message-State: AOPr4FV/ANpGF12psfYo4U/BDK6X1UwiNnJKvY3pIcGntB29NmkAYViK/8etnEAK9VdWU9PhOLS833x5AfSfnw==
X-Received: by 10.195.17.166 with SMTP id gf6mr8739989wjd.124.1461758433998;
 Wed, 27 Apr 2016 05:00:33 -0700 (PDT)
Received: by 10.194.95.129 with HTTP; Wed, 27 Apr 2016 05:00:33 -0700 (PDT)
In-Reply-To: <CAPig+cTx6jGwS12c8j_O+kT-f06o3E_yxrWZXmeU-XQ7fUY_9w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292719>

On Mon, Apr 25, 2016 at 9:32 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Apr 24, 2016 at 9:33 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>> diff --git a/builtin/apply.c b/builtin/apply.c
>> @@ -4670,6 +4670,28 @@ static int option_parse_directory(const struct option *opt,
>> +static void init_apply_state(struct apply_state *state, const char *prefix_)
>> +{
>> +       memset(state, 0, sizeof(*state));
>> +       state->prefix = prefix_;
>> +       state->prefix_length = state->prefix ? strlen(state->prefix) : 0;
>> +       state->apply = 1;
>> +       state->line_termination = '\n';
>> +       state->p_value = 1;
>> +       state->p_context = UINT_MAX;
>> +       state->squelch_whitespace_errors = 5;
>> +       state->ws_error_action = warn_on_ws_error;
>> +       state->ws_ignore_action = ignore_ws_none;
>> +       state->linenr = 1;
>> +       strbuf_init(&state->root, 0);
>> +
>> +       git_apply_config();
>> +       if (apply_default_whitespace)
>> +               parse_whitespace_option(state, apply_default_whitespace);
>> +       if (apply_default_ignorewhitespace)
>> +               parse_ignorewhitespace_option(state, apply_default_ignorewhitespace);
>> +}
>
> Minor:
>
> If factoring out this code from cmd_apply() into init_apply_state()
> was done as a preparatory patch before introduction of 'apply_state',
> then each new 'state->foo=...' line would already be at its final
> location when added by its respective patch.

Yeah I agree. So I did something like that.
And by the way while doing it I saw that Junio also suggested a similar change.

The little difference with what you and Junio suggest is that the
patch that creates init_apply_state() is just after the patch that
introduces 'struct apply_state'. I think it is a bit cleaner this way,
as if I create init_apply_state() first, then I would have to change
its arguments in the next patch that introduces 'struct apply_state'.

> Doing so would also provide an obvious opportunity to name the
> 'prefix' argument to init_apply_state() "prefix" rather than the odd
> "prefix_".

Yeah, I did that too.

Thanks,
Christian.
