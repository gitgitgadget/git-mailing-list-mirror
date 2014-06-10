From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v1] config: Add hashtable for config parsing & retrival
Date: Tue, 10 Jun 2014 07:45:45 -0400
Message-ID: <CAPig+cSosjLsRekAb6+jqmL3Lcyjpp5Z7MPWXJB+j+tj_g7FGg@mail.gmail.com>
References: <1402318146-5062-1-git-send-email-tanayabh@gmail.com>
	<1402318146-5062-2-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>,
	Torsten Bogershausen <tboegi@web.de>,
	Brian Gesiak <modocache@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 13:45:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuKUw-0001CZ-Da
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 13:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683AbaFJLpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 07:45:46 -0400
Received: from mail-yh0-f53.google.com ([209.85.213.53]:41921 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbaFJLpp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 07:45:45 -0400
Received: by mail-yh0-f53.google.com with SMTP id b6so2205616yha.40
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 04:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gvx4fzkvni0px3k+vBghS0TGbrr/cY7zWxvpQtbTZ/8=;
        b=0CDJ6eaBeoULx6RnIirCnvR4dsioEh6iHB4dZHrV7HQU1nLxa+0WbPKtaXHu+HtJ0B
         XcQ+sEqxilOz88R4hb8rfUNtQdpv281hY5lFSLaJeEzbNQvYSwQYvkOT3+cmQzJVZajl
         8+QuvADOMgvxshlURCymS2HGE/bZ38mSWWowUOM7NKkL1EOo6aSJAnZYFRG8p5xJbDc8
         MCAemUwuuQGNbLBbqY+yF9+33/CBJIYmHiMNN7//+VOZBfWj82KrBAG2zfQyF/daaYx8
         MgDk1CdlbDtToL3b1KWGmkEgD5gX3ArkTdhOq0W53gwuzZS269ppoKk1sqGbMKfp2Bpk
         57tA==
X-Received: by 10.236.101.198 with SMTP id b46mr21924869yhg.68.1402400745107;
 Tue, 10 Jun 2014 04:45:45 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Tue, 10 Jun 2014 04:45:45 -0700 (PDT)
In-Reply-To: <1402318146-5062-2-git-send-email-tanayabh@gmail.com>
X-Google-Sender-Auth: dRkbva75FJVupoPnuQG2Z6FsEOI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251179>

One additional comment...

On Mon, Jun 9, 2014 at 8:49 AM, Tanay Abhra <tanayabh@gmail.com> wrote:
> +static int config_cache_set_value(const char *key, const char *value)
> +{
> +       struct hashmap *config_cache;
> +       struct config_cache_entry *e;
> +
> +       config_cache = get_config_cache();
> +       e = config_cache_find_entry(key);
> +       if (!e) {
> +               e = xmalloc(sizeof(*e));
> +               hashmap_entry_init(e, strhash(key));
> +               e->key = xstrdup(key);
> +               e->value_list = xcalloc(sizeof(struct string_list), 1);

Order of xcalloc() arguments is incorrect [1].

[1]: http://git.661346.n2.nabble.com/PATCH-00-15-Rearrange-xcalloc-arguments-td7611675.html

> +               e->value_list->strdup_strings = 1;
> +               string_list_append(e->value_list, value);
> +               hashmap_add(config_cache, e);
> +       } else {
> +               string_list_append(e->value_list, value);
> +       }
> +       return 0;
> +}
