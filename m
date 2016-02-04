From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 06/12] ref-filter: introduce color_atom_parser()
Date: Thu, 4 Feb 2016 17:25:19 -0500
Message-ID: <CAPig+cTemTCwOUoyO9p+d544iDcxeYw0gh9DtEkL9hoHVLmuEQ@mail.gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
	<1454262176-6594-7-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 23:25:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRSL8-00025w-0D
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 23:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756189AbcBDWZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 17:25:22 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:35616 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756415AbcBDWZU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 17:25:20 -0500
Received: by mail-vk0-f66.google.com with SMTP id e185so2014404vkb.2
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 14:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=qfzKUB7zo5DCGjGrrBL4DwMNuscdrna582SHEi7w75M=;
        b=Vt+urem+q/aGIGBL567IovStJzNw23fGerKDKmMnlwKnifZP+6u+0B+9/Q9+laN8Om
         dP2AZmMfwFEEb5xiHXujNdZkGAemiatFueX0OJ69+5V3MjUhEBiCzKnsiQOowiuDy06m
         2nH4iTJqGA3qGlkf8gUigx1arQroLXvrA6gNIzWdu+SVp7Mr6cglIR8BTZkku+TelokX
         87fQ+Uqq4CRHpWVAMmsM7ePCs+gkQ5hsz+oPXa7MijpvCd0BNzsLYiXSozZ55no4r2Sl
         RrwSx+xYmLHQ/EC0G34oHbY0yeM59y7o7c2k4IKK5Vp8pAtZbN1Q4Eo7gELbepGMpWTI
         Ek5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=qfzKUB7zo5DCGjGrrBL4DwMNuscdrna582SHEi7w75M=;
        b=VGXYqfm3kTLlMLZqlrxzDOKV+QUNYDmB8fUa5qEtHBzL9Kg4DKJJWXNmZLc/bv82R6
         V2apmtAeT4FKvtDcFAeVBKQHLm5VuFJUFaFKDyKrkIIagZdLiiy96lLw/v4m4ciCrQHN
         hAxDim65aUIroSIS24tHUwIcWrLdFpDhZNJ9Rv0yAX+HoRd69IWN6XTok4UWNTTBXNe3
         oSSpYIuARKrIB4nZ3rE/qfxIU6F5CG266Tv0Fn+D80rpvm8HYikSkJ76omoO8BJ/rXDq
         YelHcuXmc4Yo3UCV7faniIEhqpdpraMSZacIpW6DC2dT2yFKtU+A0TQ2pzTHGsHyU5Ln
         RCng==
X-Gm-Message-State: AG10YOTijnORlOz1gE4q+A840XvlyUHcf64wlWegkbMciO5HZFweGWmtujOw6vCNg97T/oTeNnRVUTX5bkHgyQ==
X-Received: by 10.31.141.2 with SMTP id p2mr7275469vkd.37.1454624719474; Thu,
 04 Feb 2016 14:25:19 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 4 Feb 2016 14:25:19 -0800 (PST)
In-Reply-To: <1454262176-6594-7-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: k48H8ksNOjtj4fC9tZIuFk1pJKQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285511>

On Sun, Jan 31, 2016 at 12:42 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Introduce color_atom_parser() which will parse a "color" atom and
> store its color in the "used_atom" structure for further usage in
> populate_value().
>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> @@ -29,10 +29,21 @@ typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
>  static struct used_atom {
>         const char *name;
>         cmp_type type;
> +       union {
> +               char color[COLOR_MAXLEN];
> +       } u;
>  } *used_atom;
>  static int used_atom_cnt, need_tagged, need_symref;
>  static int need_color_reset_at_eol;
>
> +static void color_atom_parser(struct used_atom *atom, const char *color_value)
> +{
> +       if (!color_value)
> +               die(_("expected format: %%(color:<color>)"));
> +       if (color_parse(color_value, atom->u.color) < 0)
> +               die(_("invalid color value: %s"), atom->u.color);

Shouldn't this be:

    die(_("invalid color value: %s"), color_value);

?

> +}
