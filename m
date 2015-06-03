From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] ewah/bitmap: silence warning about MASK macro redefinition
Date: Wed, 3 Jun 2015 02:46:17 -0400
Message-ID: <CAPig+cRC7M2T7OMW=GDs6S68MFo_R5guMWdhkxT+pkpYKinDdQ@mail.gmail.com>
References: <20150603063812.GA21319@peff.net>
	<20150603063917.GA29008@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 03 08:46:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z02RS-0001gL-U8
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 08:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773AbbFCGqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 02:46:19 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:36638 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbbFCGqS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 02:46:18 -0400
Received: by ieclw1 with SMTP id lw1so6540675iec.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 23:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=kL2IQZS0KMD2ZzZIBIEf9ieJND0HerMFQ871WRZ5QiM=;
        b=GQ9MD8V9kiBadx62+ew5Kl354zd8/MCmCRmOQiBnibd4OMaopMT5bdNjdmniI63cpT
         YyWbgipPpspEb2q0IOxX8EFQkYhBlNGZREAtaVQEQoCZibaToqY6OHpqN2LEaLG7Qo8t
         +ShdooUyCmnAYytpq6AcOctgPG6AoJCWbqKUGVTlZ6AYtZYp8RAHL4mSkEyIHfnqTU7V
         Tlm3J0UdJPziYy8sxWOzzfRDZKM9UeSH1jbsu1k5B9XWQ3k9uctF7AufNUPC0m2BlQc3
         ByWZ7gzoAaCekMz3LsjY1VgZiEieg9Evp8n0JoJ7Xx/XPZjvR34Z1FPJWBhluLkEFVj/
         C6VA==
X-Received: by 10.50.66.234 with SMTP id i10mr3277961igt.22.1433313977312;
 Tue, 02 Jun 2015 23:46:17 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Tue, 2 Jun 2015 23:46:17 -0700 (PDT)
In-Reply-To: <20150603063917.GA29008@peff.net>
X-Google-Sender-Auth: sYyEub3emWC4uGyNJGfe_nCn7P8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270636>

On Wed, Jun 3, 2015 at 2:39 AM, Jeff King <peff@peff.net> wrote:
> From: Eric Sunshine <sunshine@sunshineco.com>
>
> On PowerPC Mac OS X (10.5.8 "Leopard" with Xcode 3.1),
> system header /usr/include/ppc/param.h[1] pollutes the
> preprocessor namespace with a macro generically named MASK.
> This conflicts with the same-named macro in ewah/bitmap.c.
> We can avoid this conflict by using a more specific name.
>
> [1]: Included indirectly via:
>      git-compat-util.h ->
>      sys/sysctl.h ->
>      sys/ucred.h ->
>      sys/param.h ->
>      machine/param.h ->
>      ppc/param.h
>
> Signed-off-by: Jeff King <peff@peff.net>

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>

> ---
>  ewah/bitmap.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/ewah/bitmap.c b/ewah/bitmap.c
> index 710e58c..2af94f6 100644
> --- a/ewah/bitmap.c
> +++ b/ewah/bitmap.c
> @@ -20,8 +20,8 @@
>  #include "git-compat-util.h"
>  #include "ewok.h"
>
> -#define MASK(x) ((eword_t)1 << (x % BITS_IN_WORD))
> -#define BLOCK(x) (x / BITS_IN_WORD)
> +#define EWAH_MASK(x) ((eword_t)1 << (x % BITS_IN_WORD))
> +#define EWAH_BLOCK(x) (x / BITS_IN_WORD)
>
>  struct bitmap *bitmap_new(void)
>  {
> @@ -33,7 +33,7 @@ struct bitmap *bitmap_new(void)
>
>  void bitmap_set(struct bitmap *self, size_t pos)
>  {
> -       size_t block = BLOCK(pos);
> +       size_t block = EWAH_BLOCK(pos);
>
>         if (block >= self->word_alloc) {
>                 size_t old_size = self->word_alloc;
> @@ -45,22 +45,22 @@ void bitmap_set(struct bitmap *self, size_t pos)
>                         (self->word_alloc - old_size) * sizeof(eword_t));
>         }
>
> -       self->words[block] |= MASK(pos);
> +       self->words[block] |= EWAH_MASK(pos);
>  }
>
>  void bitmap_clear(struct bitmap *self, size_t pos)
>  {
> -       size_t block = BLOCK(pos);
> +       size_t block = EWAH_BLOCK(pos);
>
>         if (block < self->word_alloc)
> -               self->words[block] &= ~MASK(pos);
> +               self->words[block] &= ~EWAH_MASK(pos);
>  }
>
>  int bitmap_get(struct bitmap *self, size_t pos)
>  {
> -       size_t block = BLOCK(pos);
> +       size_t block = EWAH_BLOCK(pos);
>         return block < self->word_alloc &&
> -               (self->words[block] & MASK(pos)) != 0;
> +               (self->words[block] & EWAH_MASK(pos)) != 0;
>  }
>
>  struct ewah_bitmap *bitmap_to_ewah(struct bitmap *bitmap)
> --
> 2.4.2.745.g0aa058d
