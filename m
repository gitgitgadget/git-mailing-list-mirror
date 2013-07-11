From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH 1/4] builtin: add git-check-mailmap command
Date: Thu, 11 Jul 2013 01:50:46 -0400
Message-ID: <CAPig+cRxuqOvRZQ5WZmUWruvEQytYM+RduYdkkN4_f8UdcuQnQ@mail.gmail.com>
References: <1373483041-27901-1-git-send-email-sunshine@sunshineco.com>
	<1373483041-27901-2-git-send-email-sunshine@sunshineco.com>
	<CACsJy8C6_ycum9RfxgfB0Xa2U7Fk02NyED5VvH6o1pExkcV6vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Marius Storm-Olsen <marius@trolltech.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 07:50:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ux9mH-0002qN-1u
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 07:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520Ab3GKFus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 01:50:48 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:53278 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841Ab3GKFus (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 01:50:48 -0400
Received: by mail-lb0-f181.google.com with SMTP id w10so6296200lbi.26
        for <git@vger.kernel.org>; Wed, 10 Jul 2013 22:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=AMTsPr45hTSpp8WNiQi0JmNnGCmgSlXi4Bh31OCkZ/c=;
        b=DJaTB/ewacKBZ6sIiLVN81+1sjOrziyxXw99KJmPXhiBoAPmMrLcwmTmsQPmu90kxc
         K1ImeR+EINFoBFY4gRXQNpKSaieShFVYPtxg4GWc+IBbqSvfq+t+DQ8H0CQSbYGOpXae
         m2B0KiDxquAGr04g8g4mRfZoyvxWxXwINuRWEajj61nJ6iVuPGHlZGLHLY3CUlVK504x
         twp/yyZv/KfdkPpg2ivcCFQNLpUFcDfZQaw/owXs/t1YCNCK8usoWxc54w6/lG96hEEZ
         zZCeNUI2NNQmh3HcnZoq/fkPlz1qd3hErVNxun3r9lZjE7wJDwQzUb/PfBukSB1dOaHm
         rfgA==
X-Received: by 10.152.87.172 with SMTP id az12mr16806184lab.24.1373521846480;
 Wed, 10 Jul 2013 22:50:46 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Wed, 10 Jul 2013 22:50:46 -0700 (PDT)
In-Reply-To: <CACsJy8C6_ycum9RfxgfB0Xa2U7Fk02NyED5VvH6o1pExkcV6vA@mail.gmail.com>
X-Google-Sender-Auth: pe93g0JT-YMCgCHQiCBI6wN3u4c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230076>

On Wed, Jul 10, 2013 at 10:31 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Jul 11, 2013 at 2:03 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> +static const struct option check_mailmap_options[] = {
>> +       OPT_BOOLEAN(0, "stdin", &use_stdin,
>> +                   N_("also read contacts from stdin")),
>> +       OPT_BOOLEAN('z', NULL, &null_out,
>> +                   N_("null-terminate output lines")),
>
> I think OPT_BOOLEAN is deprecated in favor of OPT_BOOL (or OPT_COUNTUP
> if you really want -z -z -z to mean differently than -z)

Thanks, I knew this and intended to change it to OPT_BOOL but forgot.
(The OPT_BOOLEAN was inherited from check-attr.c and check-ignore.c
which I used as templates for check-mailmap.c.)

>> +       maybe_flush_or_die(stdout, "contact to stdout");
>
> On error this function will print
>
> write failure on 'contact to stdout'
>
> maybe maybe_flush_or_die(stdout, "write contact to stdout") or
> something? From i18n point of view, maybe_flush_or_die should not
> compose a sentence this way. Let the second argument be a complete
> sentence so that translators have more freedom. But that's a different
> issue.

Indeed, it's not ideal. I chose "contact to stdout" for consistency
with other callers, not because of a fondness for it.

  % git grep maybe_flush_or_die
  builtin/blame.c: maybe_flush_or_die(stdout, "stdout");
  builtin/check-attr.c: maybe_flush_or_die(stdout, "attribute to stdout");
  builtin/check-attr.c: maybe_flush_or_die(stdout, "attribute to stdout");
  builtin/check-ignore.c: maybe_flush_or_die(stdout, "check-ignore to stdout");
  builtin/check-ignore.c: maybe_flush_or_die(stdout, "ignore to stdout");
  builtin/hash-object.c: maybe_flush_or_die(stdout, "hash to stdout");
  builtin/rev-list.c: maybe_flush_or_die(stdout, "stdout");
  log-tree.c: maybe_flush_or_die(stdout, "stdout");

They seem pretty evenly split between just "stdout" and "foo to
stdout". (I actually prefer plain "stdout" and will happily change it
to that.)

-- ES
