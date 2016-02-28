From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 4/7] notes copy --stdin: split lines with string_list_split()
Date: Sun, 28 Feb 2016 01:56:51 -0500
Message-ID: <CAPig+cT2GQ7mr0i649JRkJA7xGzXLEmy0RD31u537==sU1mtqQ@mail.gmail.com>
References: <56D28092.9090209@moritzneeb.de>
	<56D28207.6080600@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Moritz Neeb <lists@moritzneeb.de>
X-From: git-owner@vger.kernel.org Sun Feb 28 07:56:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZvHl-0006pO-V8
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 07:56:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbcB1G4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 01:56:53 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:36295 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbcB1G4w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 01:56:52 -0500
Received: by mail-vk0-f66.google.com with SMTP id k196so7500977vka.3
        for <git@vger.kernel.org>; Sat, 27 Feb 2016 22:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=lMaGW1/MKrL+iEGa0jDvNiLa9xIIiAWbuo2aN3V5+1E=;
        b=rYGcGZgMPT1GOFbcMQp0qLrXKNpLLXCug6lD+arAt5KFiLcRSWYPl+ZsaidlthtGr2
         dWGIqaXDT5prZ/jolBHSwLGQq28Rsyro68A3R4ZDyPfTMsfpm7AaPUp3qNuIWh8sbTer
         INR1qWiGcHEfcZUiF0wNnPneEnSeAUl8FBOwqD11ndAUJCQTsuPD9Wk05h0vh8Je9TmU
         MyoLo5kLmHTHCNQdfqVuVNuw+Q/SfW4BWAdWefFDhjihwmc6bFSs6anpBRTcA3UwS9vK
         bMLuy/ot+FXbFeySuYw8lcRPfqy+arzL3mPWuLfXhNeg6t13Wn5WBzYnybtt2soO+SEY
         xUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=lMaGW1/MKrL+iEGa0jDvNiLa9xIIiAWbuo2aN3V5+1E=;
        b=Wdsh/ajCXfD/UgsRpNVGfM+D9TIVkxYnjtZ834WOUUTPUpxU/c4PYeG74pXE43Wnel
         YLtmlzHJofiLlCHcZ8CHvE/LPKRyAx7sTjJe/DTxRVhJfibQyHJ2aBQtCud93v0jbZ2N
         jWgsU4/tHo4wFMnN7sg+irMkKdwXe8hvEBE0AddN6TMMgvFmr6S4r5JVXBdkWnW1UMDs
         aC/sHA+T+g6qqXgDR3Ifu1xeD2nmqkFdt8mYv+Xbw1tUW4zYI3seshIPOX2kcCFeWsLH
         5PsrYKTncj4DFdM2zm7keW7VisLMhST7F+Rro+AJ5zqK+woqiC31zft84Bt+8LSPfdzK
         VBGQ==
X-Gm-Message-State: AD7BkJKaDLcYuVlsGq6PgKliGPFt0qGwp0kHocF90+/ECwiG9RWGggJKS1cId2/Sx1WjtCFoEf5PdpD6ChTA0w==
X-Received: by 10.31.141.2 with SMTP id p2mr7170347vkd.37.1456642611515; Sat,
 27 Feb 2016 22:56:51 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sat, 27 Feb 2016 22:56:51 -0800 (PST)
In-Reply-To: <56D28207.6080600@moritzneeb.de>
X-Google-Sender-Auth: lMZoiXx3M1iurQPaTlHjnckzeUs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287754>

On Sun, Feb 28, 2016 at 12:13 AM, Moritz Neeb <lists@moritzneeb.de> wrote:
> This patch changes, how the lines are split, when reading them from
> stdin to copy the notes. The advantage of string_list_split() over
> strbuf_split() is that it removes the terminator, making trimming
> of the left part unneccesary.

Here's an alternate commit message:

    strbuf_split() has the unfortunate behavior of leaving the
    separator character on the end of the split components, thus
    placing the burden of manually removing the separator on the
    caller. It's also heavyweight in that each split component is a
    full-on strbuf. We need neither feature of strbuf_split() so
    let's use string_list_split() instead since it removes the
    separator character and returns an array of simple NUL-terminated
    strings.

> The strbuf is now rtrimmed before splitting. This is still required
> to remove potential CRs. In the next step this will then be done
> implicitly by strbuf_readline(). Thus, this is a preparatory refactoring,
> towards a trim-free codepath.

I would actually swap patches 4 and 5 so that strbuf_getline() is done
first (without removing any of the rtrim's) and string_list_split()
second. That way, you don't have to add that extra rtrim in one patch
and immediately remove it in the next. And, as a bonus, you can drop
the above paragraph altogether.

The patch itself looks okay.

> Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
> ---
> diff --git a/builtin/notes.c b/builtin/notes.c
> @@ -292,18 +292,18 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
>
>         while (strbuf_getline_lf(&buf, stdin) != EOF) {
>                 unsigned char from_obj[20], to_obj[20];
> -               struct strbuf **split;
> +               struct string_list split = STRING_LIST_INIT_DUP;
>                 int err;
>
> -               split = strbuf_split(&buf, ' ');
> -               if (!split[0] || !split[1])
> +               strbuf_rtrim(&buf);
> +               string_list_split(&split, buf.buf, ' ', -1);
> +
> +               if (split.nr != 2)
>                         die(_("Malformed input line: '%s'."), buf.buf);
> -               strbuf_rtrim(split[0]);
> -               strbuf_rtrim(split[1]);
> -               if (get_sha1(split[0]->buf, from_obj))
> -                       die(_("Failed to resolve '%s' as a valid ref."), split[0]->buf);
> -               if (get_sha1(split[1]->buf, to_obj))
> -                       die(_("Failed to resolve '%s' as a valid ref."), split[1]->buf);
> +               if (get_sha1(split.items[0].string, from_obj))
> +                       die(_("Failed to resolve '%s' as a valid ref."), split.items[0].string);
> +               if (get_sha1(split.items[1].string, to_obj))
> +                       die(_("Failed to resolve '%s' as a valid ref."), split.items[1].string);
>
>                 if (rewrite_cmd)
>                         err = copy_note_for_rewrite(c, from_obj, to_obj);
> @@ -313,11 +313,11 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
>
>                 if (err) {
>                         error(_("Failed to copy notes from '%s' to '%s'"),
> -                             split[0]->buf, split[1]->buf);
> +                             split.items[0].string, split.items[1].string);
>                         ret = 1;
>                 }
>
> -               strbuf_list_free(split);
> +               string_list_clear(&split, 0);
>         }
>
>         if (!rewrite_cmd) {
> --
> 2.4.3
