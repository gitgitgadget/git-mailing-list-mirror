From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/4] dir: introduce file_size() to check the size of file
Date: Wed, 8 Jun 2016 03:37:47 -0400
Message-ID: <CAPig+cTgnp3tm_S7ybDBiGfesw9mh3J4_OtEV7timnsgL0AGjA@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com> <20160607205454.22576-3-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 09:37:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAY3k-0006PM-T5
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 09:37:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755638AbcFHHht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 03:37:49 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:35125 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743AbcFHHhs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 03:37:48 -0400
Received: by mail-io0-f181.google.com with SMTP id o189so2077298ioe.2
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 00:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=v4JRinS0D7F18vMpUUolDpNnW2o3Eg1BFmtMk6HksVM=;
        b=arMI79y8NTWCRF0rNj07GxSft9OUDKn9QVwEykfkhtBuaRQOu6zuhl3/chmXlLDHda
         fwS1/JeZe451dxhnXp7KOVNaQZjTxYyjG/1TEc+FAczfAIGhSdeKwzVKSKj0gPahoCAt
         GwxbTvZO5h9KuzSusbXtqE07pmBu2buZ3vsz2yVCtBXxrODDk+BQObeTFadSXrLcUI4D
         R6XUpoQRhiRpU330bBxZIzGnmwp2U5l2qrjc6jDN0aR/U44uvNsn/lO2jqqrDIz4ClHl
         MzkLe9w1pvB1tfTGtTpw6NU+LP2yAaRcSA5f4gavJET+8BhfliYgnO/yF7zh/3mfd64/
         +U5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=v4JRinS0D7F18vMpUUolDpNnW2o3Eg1BFmtMk6HksVM=;
        b=JZ6nVNqEOQ0Tv75f9YeRX61FMlHaWHSvMjp1D0w+RTSfF6B5TR3xhmpCTlNCHCQIkk
         f/wflMCpqPKolFRVFJ7lIChNq+JydogUu4NnUKr8Vw4CMg9MZaa0TUBvplsq4jdLidh3
         3y7tf74EDXffyi5+L31ALC1iSM8eqGC6ERontMoHTDp9P9AnY1D1acqKb3Shkk2krQWS
         8x9pQTE1+RrFoVQbASesAqrn4wa7W5INyzBo0QVHdqIdKEml1yBbycD9Iniudg7JsudU
         ULeii/vdl/PMHajozkF7hyg5VHpdt7YQjnpBXPut6cbZE7YdMFubSyqUYmXggvve7Ir+
         ZNaw==
X-Gm-Message-State: ALyK8tL9JWIEvGFoOB29Gfy3pNz5CngTbDl/OXtNSmpvUSH9gQjGv73IvoGzga7NNPlaa9FB7PAhQoXwUMXwcw==
X-Received: by 10.107.25.13 with SMTP id 13mr5945305ioz.104.1465371467799;
 Wed, 08 Jun 2016 00:37:47 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Wed, 8 Jun 2016 00:37:47 -0700 (PDT)
In-Reply-To: <20160607205454.22576-3-pranit.bauva@gmail.com>
X-Google-Sender-Auth: Rfw4TYtFOnFt4rirnllksPlTmbo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296760>

On Tue, Jun 7, 2016 at 4:54 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> dir: introduce file_size() to check the size of file
>
> At times we require to see if the file is empty and get the size of the
> file. By using stat we can get the file size without actually having to
> open the file to check for its contents.

The sole caller of this function in patch 4/4 does so only to check if
the file exists; it doesn't even care about the file's size, thus
neither this function nor this patch seem justified and probably ought
to be dropped unless some better and stronger justification can be
shown.

> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> diff --git a/dir.c b/dir.c
> @@ -2036,6 +2036,14 @@ int file_exists(const char *f)
> +ssize_t file_size(const char *filename)
> +{
> +       struct stat st;
> +       if (stat(filename, &st) < 0)
> +               return -1;
> +       return xsize_t(st.st_size);
> +}
> +
> diff --git a/dir.h b/dir.h
> @@ -248,6 +248,13 @@ extern void clear_exclude_list(struct exclude_list *el);
> +/*
> + * Return the size of the file `filename`. It returns -1 if error
> + * occurred, 0 if file is empty and a positive number denoting the size
> + * of the file.
> + */
> +extern ssize_t file_size(const char *);
