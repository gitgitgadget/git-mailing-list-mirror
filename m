From: Jaime Soriano Pastor <jsorianopastor@gmail.com>
Subject: Re: [PATCH 2/2] Loop index increases monotonically when reading
 unmerged entries
Date: Sun, 24 Aug 2014 20:04:22 +0200
Message-ID: <CAPuZ2NEPcRm4S8m76kJ+8L7zR2RiVwu3Z6bNbZgfzAcVTYgOKA@mail.gmail.com>
References: <xmqq38cpsmli.fsf@gitster.dls.corp.google.com>
	<1408903047-8302-1-git-send-email-jsorianopastor@gmail.com>
	<1408903047-8302-2-git-send-email-jsorianopastor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jaime Soriano Pastor <jsorianopastor@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 24 20:04:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLc9Y-0007A7-KH
	for gcvg-git-2@plane.gmane.org; Sun, 24 Aug 2014 20:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752152AbaHXSEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2014 14:04:24 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:57684 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbaHXSEX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2014 14:04:23 -0400
Received: by mail-pd0-f170.google.com with SMTP id g10so18381078pdj.15
        for <git@vger.kernel.org>; Sun, 24 Aug 2014 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=e+R8nPUdkpaWzDyt0f7QRtQbN+C2nwsygXb9n4mOOLE=;
        b=ih/tBcYv8YmYdIoM1sxQ2MM7iFuplvJOHhHTpRUIxiQwBC4Zws+uvT7QOhvUSPN1ta
         OxnUi1tcbqplQT/iQxo8AST02MhtHEgCeawPRSFSZb4l/JVqEh98dJU57cmu9oUlB1xl
         0y/sQQdDDk/5rNStBH7psg85icb3/7G1WT4KVBPkdWBbjvS480DOdzDJvCXRBwXykipb
         MGf8LNQvk6NESn2LezP8syIJLMotUbNux6YkiYH4UPkQZzuwEXWbf0NdwJan9fmymNOk
         98lPiqN9dcwD4TEKMoBG+S9dCAKoZbZQ0IjKBakSwrZ7m4a7TRCnjZ2JGvsMUqEcQjcE
         Bupg==
X-Received: by 10.68.215.67 with SMTP id og3mr22361808pbc.30.1408903462754;
 Sun, 24 Aug 2014 11:04:22 -0700 (PDT)
Received: by 10.70.37.2 with HTTP; Sun, 24 Aug 2014 11:04:22 -0700 (PDT)
In-Reply-To: <1408903047-8302-2-git-send-email-jsorianopastor@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255809>

I think this line is dangerous, if add_cache_entry is not able to
remove higher-stages it will be looping forever, as happens in the
case of this thread.
I cannot see why it's even needed, and removing it doesn't break any test.

On Sun, Aug 24, 2014 at 7:57 PM, Jaime Soriano Pastor
<jsorianopastor@gmail.com> wrote:
> Signed-off-by: Jaime Soriano Pastor <jsorianopastor@gmail.com>
> ---
>  read-cache.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index c1a9619..3d70386 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1971,7 +1971,6 @@ int read_index_unmerged(struct index_state *istate)
>                 if (add_index_entry(istate, new_ce, 0))
>                         return error("%s: cannot drop to stage #0",
>                                      new_ce->name);
> -               i = index_name_pos(istate, new_ce->name, len);
>         }
>         return unmerged;
>  }
> --
> 2.0.4.1.g0b8a4f9.dirty
>
