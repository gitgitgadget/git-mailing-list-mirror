From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [RFC/PATCH 1/4] builtin: add git-check-mailmap command
Date: Thu, 11 Jul 2013 08:45:42 +0200
Message-ID: <CALWbr2zJTBSptGsOr6tqrr4KcVd2GOWCkgy4GgdZ2+0Vz7DU4w@mail.gmail.com>
References: <1373483041-27901-1-git-send-email-sunshine@sunshineco.com>
	<1373483041-27901-2-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Marius Storm-Olsen <marius@trolltech.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 08:52:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxAjS-0002t0-2a
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 08:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755531Ab3GKGv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 02:51:58 -0400
Received: from mail-qc0-f173.google.com ([209.85.216.173]:37027 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437Ab3GKGv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 02:51:57 -0400
Received: by mail-qc0-f173.google.com with SMTP id l10so4102897qcy.32
        for <git@vger.kernel.org>; Wed, 10 Jul 2013 23:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=b+hjApzI8NIQu2QRoDBGwkK03kNavuUnEKD4mb3HKIA=;
        b=L1pL5q8EDWpOZKQHieScu9i8BTjSy5b9Zf7vRZQsUFIgxx1ZklgKh2G0JzThVz+xHn
         5nnXFaExYaT1yto0kcsQ2hkgrVdyvWzBYBaBRmfYOY0TBkBRApTRyRA/Cdkik/LoRzsX
         hzVcIDnaSB1S1gphOMQVfaz56zvOGZboJcVWGDiUdsHlqaGVfgZHzWmjzzhwzqdofuWC
         KPJiwphGYsxJyO+S6odEZvl4Fu8lGhjJg62ynyYDxLeoyPSuoV6PjhKt2Bm9BibmzBq5
         lN+Agm1TLKB6wHF0eNdojgc/EjKNNQfz333/m5dYxsB8c1OUS7SiyeXAchRoNZ0IZHxa
         tMYg==
X-Received: by 10.224.124.193 with SMTP id v1mr31194675qar.62.1373525142493;
 Wed, 10 Jul 2013 23:45:42 -0700 (PDT)
Received: by 10.49.108.105 with HTTP; Wed, 10 Jul 2013 23:45:42 -0700 (PDT)
In-Reply-To: <1373483041-27901-2-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230078>

On Wed, Jul 10, 2013 at 9:03 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> +static void check_mailmap(struct string_list *mailmap, const char *contact)
> +{
> +       const char *name, *mail;
> +       size_t namelen, maillen;
> +       struct ident_split ident;
> +       char term = null_out ? '\0' : '\n';
> +
> +       if (split_ident_line(&ident, contact, strlen(contact)))
> +               die(_("unable to parse contact: %s"), contact);
> +
> +       name = ident.name_begin;
> +       namelen = ident.name_end - ident.name_begin;
> +       mail = ident.mail_begin;
> +       maillen = ident.mail_end - ident.mail_begin;
> +
> +       map_user(mailmap, &mail, &maillen, &name, &namelen);

Would it be useful to check the return value of this function, to
display a message when the name can't mapped ?

> +       if (namelen)
> +               printf("%.*s <%.*s>%c",
> +                       (int)namelen, name, (int)maillen, mail, term);
> +       else
> +               printf("<%.*s>%c", (int)maillen, mail, term);
> +}
