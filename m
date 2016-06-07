From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 12/13] dir_iterator: new API for iterating over a
 directory tree
Date: Tue, 7 Jun 2016 01:13:29 -0400
Message-ID: <CAPig+cRKa2QF9fp0in7wbPBzyY3UQbvNrioFWjxPjQQsoY=F9A@mail.gmail.com>
References: <cover.1464957077.git.mhagger@alum.mit.edu> <38124bd892ac1f4683b7debe721fc69424a347be.1464957077.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 07 07:13:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA9Ka-0005M6-3T
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 07:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbcFGFNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 01:13:31 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34741 "EHLO
	mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723AbcFGFNa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 01:13:30 -0400
Received: by mail-it0-f66.google.com with SMTP id r205so5383536itd.1
        for <git@vger.kernel.org>; Mon, 06 Jun 2016 22:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZAioO+Gx4HOEMzBWi1AiCEQdMK/9fBG2N0GuGU/EyRY=;
        b=s1nUWX2XDaNWLIxTPAAMiA3nvGcfvywIUsMiDm3pQxgkwGvbFj4FgVBfk0pDVVeQvQ
         Xcu7cSuk+vKcBiMDin0n1m9SPJnn4OW+c0ZQD70Ek3qXQimdxuhCDtDytHLkkOtinbk2
         n0kFgUFfqeGbfajPr1cKMfjv52zKQxRKOD/ZiNxgo1cLKmIbyDJ3uY9Sndi8r0n9a5o+
         XfWOSV681EBwpZi2hHSW7Mc0zbs14VwpU/+fUrASEig9fjAA7sQV2nmJuPZak3K0XbH1
         EgzRvery74lMLNi1sJN7S9+WLGbUeb1WA7qprmFzzRzt6HbcWXJKJTNpT8xuatv9L1T8
         nO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ZAioO+Gx4HOEMzBWi1AiCEQdMK/9fBG2N0GuGU/EyRY=;
        b=NNfUXQcDvngW6zVVd8Oj8/WuUtwHGl7vz51xTU8DIXgKfBEul8MIrny8H68EI4OWlv
         MdEvW611CCdO2lDTagGvDe9MROApH63a9ckUg5b/S2MqS0iO7RSR5O+nrpDGnbwdHOoo
         A3oJli6gndGfAhoS/pa5Euaryc5ZW5xJ/ZMWkc0jrXzQHwXThe1+owQD3u43+UujRzGc
         bs8y6EP1ulaY9vVr2lzEO3bUvKaSaQk5a0Z9Wew849ko4yNAH8Uqw03M9jIkAcIkGKjj
         Kvl8P21xDFCvN7NPUxB52HO3Vr42wEoJvciOF4PixykrUJv+ehDgBHp0L+2VTU2oEp+o
         A7ag==
X-Gm-Message-State: ALyK8tI/zfrhtvZWUOM5WOYMBYY/ZCQVjymZ1ooWHSQKhEn8LaMY6dZPKit65twLntE/nPCcq/5qdoASsakhMw==
X-Received: by 10.107.47.41 with SMTP id j41mr23449904ioo.168.1465276409501;
 Mon, 06 Jun 2016 22:13:29 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Mon, 6 Jun 2016 22:13:29 -0700 (PDT)
In-Reply-To: <38124bd892ac1f4683b7debe721fc69424a347be.1464957077.git.mhagger@alum.mit.edu>
X-Google-Sender-Auth: OQTL6nDYsTyuwCS6nGTrr4ko7-4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296594>

On Fri, Jun 3, 2016 at 8:33 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> The iterator interface is modeled on that for references, though no
> vtable is necessary because there is (so far?) only one type of
> dir_iterator.
> [...]

Some minor comments below, though probably nothing demanding a re-roll...

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> diff --git a/dir-iterator.c b/dir-iterator.c
> @@ -0,0 +1,185 @@
> +int dir_iterator_advance(struct dir_iterator *dir_iterator)
> +{
> +       struct dir_iterator_int *iter =
> +               (struct dir_iterator_int *)dir_iterator;
> +
> +       while (1) {
> +               struct dir_iterator_level *level =
> +                       &iter->levels[iter->levels_nr - 1];
> +               struct dirent *de;
> +
> +               if (!level->initialized) {
> +                       if (!is_dir_sep(iter->base.path.buf[iter->base.path.len - 1]))

I realize that dir_iterator_begin() ensures that we never get this far
if path has zero length, but that check is so (textually and perhaps
mentally) distant from this chunk of code that it's still a little bit
scary to see this *potential* access of base.path.buf[-1]. Perhaps an
assert(iter->base.path.len) just before this line would document that
this condition was taken into consideration?

> +                               strbuf_addch(&iter->base.path, '/');
> +                       level->prefix_len = iter->base.path.len;
> +
> +                       /* opendir() errors are handled below */
> +                       level->dir = opendir(iter->base.path.buf);
> +[...]
> +               if (!level->dir) {
> +                       /*
> +                        * This level is exhausted (or wasn't opened
> +                        * successfully); pop up a level.
> +                        */
> +                       if (--iter->levels_nr == 0) {
> +                               return dir_iterator_abort(dir_iterator);
> +                       }

Style: unnecessary braces

> +                       continue;
> +               }
> +
> +               /*
> +                * Loop until we find an entry that we can give back
> +                * to the caller:
> +                */
> +               while (1) {
> +[...]
> +                       strbuf_addstr(&iter->base.path, de->d_name);
> +                       if (lstat(iter->base.path.buf, &iter->base.st) < 0) {
> +                               if (errno != ENOENT)
> +                                       warning("error reading path '%s': %s",
> +                                               iter->base.path.buf,
> +                                               strerror(errno));

Duy's warning_errno() series is already in 'master'...

> +                               continue;
> +                       }
> +
> +                       /*
> +                        * We have to set these each time because
> +                        * the path strbuf might have been realloc()ed.
> +                        */
> +

Maybe drop the blank line between the comment and the code to which it applies.

> +                       iter->base.relative_path =
> +                               iter->base.path.buf + iter->levels[0].prefix_len;
> +                       iter->base.basename =
> +                               iter->base.path.buf + level->prefix_len;
> +                       level->dir_state = DIR_STATE_ITER;
> +
> +                       return ITER_OK;
> +               }
> +       }
> +}
> +
> +int dir_iterator_abort(struct dir_iterator *dir_iterator)
> +{
> +       struct dir_iterator_int *iter = (struct dir_iterator_int *)dir_iterator;
> +
> +       while (iter->levels_nr) {
> +               struct dir_iterator_level *level =
> +                       &iter->levels[--iter->levels_nr];

It's a bit difficult to locate the loop control embedded within this
(textually) noisy expression. I wonder if it would be easier to read
as a plain for-loop instead:

    for (; iter->levels_nr; iter->levels_nr--) {

> +               if (level->dir)
> +                       closedir(level->dir);

The documentation talks about this function returning ITER_ERROR upon
abort failure. This implementation doesn't care about closedir()
errors, thus never returns ITER_ERROR, which I guess agrees with
dir_iterator_advance() which also doesn't worry about opendir() or
closedir() errors. Do opendir() and closedir() errors at least deserve
a warning, as lstat() failure does? (Genuine question; I haven't
thought too hard about it.)

> +       }
> +
> +       free(iter->levels);
> +       strbuf_release(&iter->base.path);
> +       free(iter);
> +       return ITER_DONE;
> +}
> diff --git a/dir-iterator.h b/dir-iterator.h
> @@ -0,0 +1,86 @@
> +/*
> + * Advance the iterator to the first or next item and return ITER_OK.
> + * If the iteration is exhausted, free the resources associated with
> + * the iterator and return ITER_DONE. On error, return ITER_ERROR. It
> + * is a bug to use iterator or call this function again after it has
> + * returned false.
> + */
> +int dir_iterator_advance(struct dir_iterator *iterator);

The documentation makes it clear that the iterator is freed upon
ITER_OK, but I'm having trouble determining if it is freed for
ITER_ERROR, as well. The documentation for ref_iterator_advance(), on
the other hand, makes it clear that the iterator is freed in all
cases.

> +/*
> + * End the iteration before it has been exhausted. Free the directory
> + * iterator and any associated resources and return ITER_DONE. Return
> + * ITER_ERROR on error.
> + */
> +int dir_iterator_abort(struct dir_iterator *iterator);
