From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5] format-patch: introduce format.outputDirectory configuration
Date: Wed, 13 Jan 2016 01:52:11 -0500
Message-ID: <CAPig+cTCRq9VCT7t8E9yjk4QcHYB2_qeBwGB_31keB4nTjkLkA@mail.gmail.com>
References: <CAPig+cRjBockaXKacYA-pxWQe_gzAAvjAwonQKn1kSANHORt1A@mail.gmail.com>
	<1452660493-5430-1-git-send-email-ischis2@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: "Stephen P. Smith" <ischis2@cox.net>
X-From: git-owner@vger.kernel.org Wed Jan 13 07:52:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJFI1-0003KH-K9
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 07:52:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753793AbcAMGwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 01:52:14 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:35071 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684AbcAMGwN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 01:52:13 -0500
Received: by mail-vk0-f67.google.com with SMTP id i129so7042588vkb.2
        for <git@vger.kernel.org>; Tue, 12 Jan 2016 22:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=uk2q1IULhDSzlmOmSzQZem9oYon9l/cW7fXKuAyk8Eo=;
        b=SWnk8K98vVgf/RnQnsxfBxY+5dwx6FTvch3iNmoi5FyaHaQ5/l3VOcmMa8WPaZzUWd
         UyZlXHLB87gnClYdwUfxh/RXcg1NUkErKMSETQlbEcjlMkSG3dK/y9h6GArecomIsx7c
         dS+RG8OEJh6d8Ly7CU0Rm4PtxO2rX/OXrecrPrQuPjbHNAcRP0HavCF29SW8dd6v3nMX
         v1xpUEPBQ8EdI767xHDITXrWQolgG57/ABUaBBkddz2lB+zXHcN4DSfSybm3mWWGWU9L
         iuL81E0eu8o15hWgjze4NxDPQmOcVEfRmc+YCYAfZ/j4kUC/+SqUBbuEd2TNsCozonqe
         8wmg==
X-Received: by 10.31.164.78 with SMTP id n75mr63050459vke.14.1452667931954;
 Tue, 12 Jan 2016 22:52:11 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 12 Jan 2016 22:52:11 -0800 (PST)
In-Reply-To: <1452660493-5430-1-git-send-email-ischis2@cox.net>
X-Google-Sender-Auth: 57o94Qti0ihMsdsZ7CEWms02q0w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283883>

On Tue, Jan 12, 2016 at 11:48 PM, Stephen P. Smith <ischis2@cox.net> wrote:
> From: Alexander Kuleshov <kuleshovmail@gmail.com>
>
> We can pass -o/--output-directory to the format-patch command to store
> patches in some place other than the working directory. This patch
> introduces format.outputDirectory configuration option for same
> purpose.
>
> The case of usage of this configuration option can be convinience

Mentioned several times already: s/convinience/convenience/

> to not pass every time -o/--output-directory if an user has pattern
> to store all patches in the /patches directory for example.
>
> The format.outputDirectory has lower priority than command line
> option, so if user will set format.outputDirectory and pass the
> command line option, a result will be stored in a directory that
> passed to command line option.
>
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> Signed-off-by: Stephen P. Smith <ischis2@cox.net>
> ---
> Notes:
>     Fixed bug which was found when moving the tests to the end of the
>     script by removing the hardcoded expected count and replacing with a
>     computation of the number of actual patches.

Thanks, this version looks better. Aside from the misspelling above
and a minor comment below, this version is:

Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

>     Mailing list web interface is again not working; therefore, I don't
>     have URLs for the earlier review comments.

The full set of attempts is here [1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/272180

> diff --git a/builtin/log.c b/builtin/log.c
> @@ -707,6 +707,8 @@ enum {
>         COVER_AUTO
>  };
>
> +static const char *config_output_directory;

I don't care strongly, but I wonder why this new variable is placed
below the enum rather than being grouped with other similar variables
just above this enum. (Probably not worth a re-roll, though.)

>  static int git_format_config(const char *var, const char *value, void *cb)
>  {
>         if (!strcmp(var, "format.headers")) {
