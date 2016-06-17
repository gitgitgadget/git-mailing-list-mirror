Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DB611FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 23:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753357AbcFQXbK (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 19:31:10 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:32778 "EHLO
	mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbcFQXbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 19:31:09 -0400
Received: by mail-it0-f67.google.com with SMTP id y82so697927itf.0
        for <git@vger.kernel.org>; Fri, 17 Jun 2016 16:31:08 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=rUXeaTk9AEDB+QjXW764RblT1Phk7xdjrrvp0n2vvxI=;
        b=cRprchACljzZ6DppdI+xEwhAQz2VS35EkglAEfTJ3cQw3bsCj4PDTbTC6snpCsr7UZ
         wz4Uuz2GrUmfMn4tEoFHpSkYwG6TGztkcCB9Y7aUB7pPSVRNyeKG3M5lJNX33KsbIlw3
         V0F6uarG+oE6t6J7yWU5DUuy7J+XWaq9okp63NHn9Ov6lROPiKHNUw5k8NmXi58TNTcn
         wz2UE8oLy+xlV2w92KTu6jfHPFPfidSMIAXaPiV++HVkK4e5tRG7PocMKMAStgOp2bJP
         5yYSa7F3xWTDeiBJfErJ7pELAl49Nu7YRpJxk34YIVVtRTRe/ET9gOjFrwXlBUwZ8f33
         5jGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=rUXeaTk9AEDB+QjXW764RblT1Phk7xdjrrvp0n2vvxI=;
        b=ED6IoiXMpExqxIrShG8/vA7p9POM/PJc++PF76IsrfsCAZqZIjjF2sF8Xo0ztlt0A/
         emHfyXZbnMBStRPJVtBAP8N7uiYLxqGoFXEXbZ8eqBrawPXZnj2jok5ME/hi81zA7ZHC
         ajSkPcz9k9dWySEk90iu73egakQVbUR1rYIVLfSrjr0hR+W4+5xqCcN+8y60IqQRI5q9
         RIobZrmtXvkrKvsInlWgMC+tMZBeub4SG6Oso97knZnz/v/aAQOV9DBFFUTfN3lIrLmf
         H0Ou0XZ/ABhpZPeV7tZo1GTYziuUmiZY6h4Jo+oJvE4tOYXh61lqM6uExxVF9Ofk3iq5
         LJvw==
X-Gm-Message-State: ALyK8tIIGau3wna849LFO/bUFPyJeplgM/maCS7yRr6j47UXigmFeJdUk1epaFtTEyhwckLwe2v2RvDW6T35AQ==
X-Received: by 10.36.55.138 with SMTP id r132mr1457339itr.73.1466206268171;
 Fri, 17 Jun 2016 16:31:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.0.30 with HTTP; Fri, 17 Jun 2016 16:31:07 -0700 (PDT)
In-Reply-To: <20160617232857.GA26564@sigill.intra.peff.net>
References: <20160616093248.GA15130@sigill.intra.peff.net> <20160616093745.GD15851@sigill.intra.peff.net>
 <CAPig+cR-Z+dpKN0dG_BG7JWRBZeo4Xtpa1HQAU1Tt3WRunsrXg@mail.gmail.com> <20160617232857.GA26564@sigill.intra.peff.net>
From:	Eric Sunshine <sunshine@sunshineco.com>
Date:	Fri, 17 Jun 2016 19:31:07 -0400
X-Google-Sender-Auth: CeT6CM5r_bVXWOutw-aI3K-MA24
Message-ID: <CAPig+cQkFSDNHLXBPzycm98AROcBQYCwgffSC0ditrqXpd1NEA@mail.gmail.com>
Subject: Re: [PATCH 4/7] run-command: add pipe_command helper
To:	Jeff King <peff@peff.net>
Cc:	Git List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jun 17, 2016 at 7:28 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jun 17, 2016 at 04:03:18PM -0400, Eric Sunshine wrote:
>> > diff --git a/run-command.h b/run-command.h
>> > @@ -79,17 +79,34 @@ int run_command_v_opt(const char **argv, int opt);
>> >  /**
>> > - * Execute the given command, capturing its stdout in the given strbuf.
>> > + * Execute the given command, sending "in" to its stdin, and capturing its
>> > + * stdout and stderr in the "out" and "err" strbufs. Any of the three may
>> > + * be NULL to skip processing.
>> > + *
>> >   * Returns -1 if starting the command fails or reading fails, and otherwise
>> > - * returns the exit code of the command. The output collected in the
>> > - * buffer is kept even if the command returns a non-zero exit. The hint field
>> > - * gives a starting size for the strbuf allocation.
>> > + * returns the exit code of the command. Any output collected in the
>>
>> Did you mean s/returns/Returns/ ?
>
> I don't think so. This is a continuatino of "...and otherwise" from the
> context line above.

Indeed. I somehow imagined a leading '-' on the line containing
"...and otherwise".
