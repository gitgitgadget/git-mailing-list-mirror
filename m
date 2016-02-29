From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 4/7] notes copy --stdin: read lines with strbuf_getline()
Date: Mon, 29 Feb 2016 13:19:08 -0500
Message-ID: <CAPig+cSptQr21QMOJmxT4RPVR3r3zkEQ2TkTU8RoaJfo7=KChw@mail.gmail.com>
References: <56D401C2.8020100@moritzneeb.de>
	<56D40314.7040608@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Moritz Neeb <lists@moritzneeb.de>
X-From: git-owner@vger.kernel.org Mon Feb 29 19:19:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaSPk-0000FE-Ag
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 19:19:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454AbcB2STU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 13:19:20 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:33339 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbcB2STT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 13:19:19 -0500
Received: by mail-vk0-f65.google.com with SMTP id c3so9946128vkb.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 10:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=FycVIAV+sD+J89c2VrZ4xjdWjYH92o6NUrRo2YE+KSM=;
        b=Ttix0zP/RuI5gTPwYghLU9pp1wmQzk5KnHH90bjmdJ9ceZPGMzqKjvgIPi4I02/ApK
         Od/I1CNJcmjN/oUptpJO5/rYmOoqSIoSkhkdRWGspwgwJ5e6rhkoWqVRM0YXY4Xpy4Vx
         wh3d52FlADVtOV96uGweYYsND9ifpP9KdvGgmD+tl7mClNdLNIZnTucEk0riMDCx/XuG
         vdcbQi6MJTSTDJIlfzq6qNZDd2Ta/IIy9Gf9qzi8GDT5VUzgnE+JLGYqQ2gZwZMV5vuh
         Iy3+AZ0prKTtp4H/ORFE/7tz6/fjZGj3CD20H8v/4RPb6/rHfJXsKopA+Vx0aINtxbbX
         XIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=FycVIAV+sD+J89c2VrZ4xjdWjYH92o6NUrRo2YE+KSM=;
        b=a9/RaesmjOZAMBlB7kUJayV6Ywi2Y2xEs6lkZ/SfyZ6vRoeNcP2L2cVDgjbddImq3z
         TqDnz6uaslwg9k6rC6kBFmR6A+MkS0i8eS6owgbCwlv/MUqGBPPlaKn3ZwWzzWPyA+W4
         LtlS3qUs9cjO7jJVqiqR7xsIbe5UIdn3A7KoN52J+HWrzPVRF9l29nTqpTcvrdwrJVpg
         VsRwfvHFRoy7BVISNevzEf+Oy3KLYKeOkcTMh23XFBsIk34zjXQ6GQW+QW1pw0KyBB+K
         GZCMqkyfDi5qM4VwFiFMrAI1eWOEC4q4rfhhAwYxvwhjEHRyLAc5D0dm+I8fvFaOv5y5
         wSSw==
X-Gm-Message-State: AD7BkJJcHeAYbsKsaxqyoFvmUXo6Jd2x+bZpApZABfaGeab+3s433wBfYa97BDVl/5pcL/Sa0csKZaAimXvo1w==
X-Received: by 10.31.141.2 with SMTP id p2mr12575931vkd.37.1456769948207; Mon,
 29 Feb 2016 10:19:08 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 29 Feb 2016 10:19:08 -0800 (PST)
In-Reply-To: <56D40314.7040608@moritzneeb.de>
X-Google-Sender-Auth: S--RNT_y3ioKlfmEKXssLiwCtpA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287854>

On Mon, Feb 29, 2016 at 3:36 AM, Moritz Neeb <lists@moritzneeb.de> wrote:
> The format of a line that is expected when copying notes via stdin
> is "sha1 sha1". As this is text-only, strbuf_getline() should be used
> instead of strbuf_getline_lf(), as documentation of this fact.
>
> When reading with strbuf_getline() the trimming of split[1] can be
> removed.  It was necessary before to remove potential CRs inserted
> through a dos editor.

s/dos/DOS/

This may not be worth a re-roll, but the suggestion of my v3 review
was to keep both rtrim's in this patch and then remove them in the
next patch when converting to string_list_split(). A benefit of doing
so is that you can then drop the above paragraph altogether, and both
patches become simpler (description and content), thus easier to
review.

If you do elect to keep things the way they are, then (as mentioned in
my v2 review) it would be helpful for the above paragraph to explain
that strbuf_split() leave the "terminator" on the split elements, thus
clarifying why the rtrim() of split[0] is still needed.

> Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
> ---
>  builtin/notes.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/builtin/notes.c b/builtin/notes.c
> index ed6f222..706ec11 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -290,7 +290,7 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
>                 t = &default_notes_tree;
>         }
>
> -       while (strbuf_getline_lf(&buf, stdin) != EOF) {
> +       while (strbuf_getline(&buf, stdin) != EOF) {
>                 unsigned char from_obj[20], to_obj[20];
>                 struct strbuf **split;
>                 int err;
> @@ -299,7 +299,6 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
>                 if (!split[0] || !split[1])
>                         die(_("Malformed input line: '%s'."), buf.buf);
>                 strbuf_rtrim(split[0]);
> -               strbuf_rtrim(split[1]);
>                 if (get_sha1(split[0]->buf, from_obj))
>                         die(_("Failed to resolve '%s' as a valid ref."), split[0]->buf);
>                 if (get_sha1(split[1]->buf, to_obj))
> --
> 2.4.3
