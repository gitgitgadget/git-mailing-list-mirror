From: Dave Borowitz <dborowitz@google.com>
Subject: Re: Bug: send-pack does not respect http.signingkey
Date: Thu, 16 Jul 2015 13:08:40 -0700
Message-ID: <CAD0k6qS_uQk5KZVJYA7BVZ9sRPRj=cZ3rbYRfJ3vhgSh2drEMA@mail.gmail.com>
References: <CAD0k6qQ=ovEBZn_wje-exBhvW8brRbTgULDr68rmeiw-ZdsozQ@mail.gmail.com>
 <xmqqlhef50kz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 22:09:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFpSt-0003UM-Mf
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 22:09:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbbGPUJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 16:09:00 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35699 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbbGPUJA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 16:09:00 -0400
Received: by igcqs7 with SMTP id qs7so22618052igc.0
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 13:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TTR94AuT8sb2khmm1Dt6xn4deS8NOeCG1OAFz7CiHj4=;
        b=T5GhHM6cgXiVVdyi7X6JqQEk5DG6keQoEQZsDUcdP4wRKg66frf4pBFYYz0EZrGmD3
         JsQW4HUv+wOP7Yay5TV1ccl5pREXGHLBJrI4jGPt8l7fYBR66nO8u5jicNGOtQKRMfWA
         tdFsd6p8NOlNuyqfmLes57DV16PySKtMMyDDocMlGScEDsPwkEzwR11H0YW3hp7RoWir
         VHyUEvaul/9jkAEnjz/rDygVwINvkfBuJyTfIzOHWN/ytTwDdeS6Ler8GExLug7zZaPk
         IA57/chdhQJghrV6GRtqijZzoQCxGzlVb9IlQL+AFxaD5V8Sw4FrntZyKuOMMQoxnyGx
         WlWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=TTR94AuT8sb2khmm1Dt6xn4deS8NOeCG1OAFz7CiHj4=;
        b=NhKIvfgYmahnGnuoPjLhsD1wIex18Y46ulhe8FZ4qq2HG9kzCBO8e0QIv6FH6Fef/1
         K2tDk3hI6v8vzVEGKygZ2jAhIDIXBELoXNe5lQ0h1YHAozrENrM85f3r7AEff0cU64ME
         HOPqfm8AAlcCvYuWfB2AZAGJv+tQkA2bBYHi6Sb0xjygfVgL3eSk5xeWr+/20cKsrCzw
         Wf6bWLmje+24gc+WmWVIMhY8TgkIMgZ8uKbb/kGvVbFELuMiTPsR98clKU8loyprFj3d
         12ROV8lDn4b7GsMhbYW8vUTK4jNe/8L85N+iggUB0NFvBuytZMa+6xl0RdEw9b9rgw/o
         swqQ==
X-Gm-Message-State: ALoCoQkcsFT9gCihclwNMCUYttdBrha28warSFsB4gH8mQefnSViH3R6GbIbpfPCIUqTqHg0nvnI
X-Received: by 10.107.132.7 with SMTP id g7mr14018462iod.9.1437077339576; Thu,
 16 Jul 2015 13:08:59 -0700 (PDT)
Received: by 10.107.4.201 with HTTP; Thu, 16 Jul 2015 13:08:40 -0700 (PDT)
In-Reply-To: <xmqqlhef50kz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274040>

On Thu, Jul 16, 2015 at 1:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Dave Borowitz <dborowitz@google.com> writes:
>
>> When git-send-pack is exec'ed, as is done by git-remote-http, it does
>> not reread the config, so it does not respect the configured
>> http.signingkey, either from the config file or -c on the command
>> line. Thus it is currently impossible to specify a signing key over
>> HTTP, other than the default one matching the "Name <email>" format in
>> the keyring.
>>
>> This is not an issue for git:// as send-pack is executed directly in
>> the same process that reads the config.
>
> Interesting.  I agree that it would be a problem not to be able to
> specify which signing key to use.
>
> Perhaps something like this?

Seems like it should work.

Jonathan had suggested there might be some principled reason why
send-pack does not respect config options, and suggested passing it in
as a flag. But that would be more work, certainly, as it would also
have to get passed through git-remote-http somehow.

> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index b564a77..57c3a9c 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -11,6 +11,7 @@
>  #include "transport.h"
>  #include "version.h"
>  #include "sha1-array.h"
> +#include "gpg-interface.h"
>
>  static const char send_pack_usage[] =
>  "git send-pack [--all | --mirror] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
> @@ -113,6 +114,8 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
>         int from_stdin = 0;
>         struct push_cas_option cas = {0};
>
> +       git_config(git_gpg_config, NULL);
> +
>         argv++;
>         for (i = 1; i < argc; i++, argv++) {
>                 const char *arg = *argv;
