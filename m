From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/6] convert various shell functions in git-bisect to C
Date: Wed, 15 Jun 2016 13:53:33 -0400
Message-ID: <CAPig+cTV8Mum1b7XxUit4Kn5WBX2kukWvvjkhOCqxnFtcjfp0w@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com> <20160615140026.10519-1-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 19:53:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDF0V-0001mo-FR
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 19:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbcFORxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 13:53:35 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36572 "EHLO
	mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbcFORxe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 13:53:34 -0400
Received: by mail-it0-f68.google.com with SMTP id h190so4325449ith.3
        for <git@vger.kernel.org>; Wed, 15 Jun 2016 10:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=IvnKvFtxbumJfU5sQvur1j8ggrNVu5Am6g5KD9tiGf4=;
        b=mtVniYhrp6YhdXsWdgvaZ7DkNJSw57wAvAUJVGXyXmvHitrG99nTTpNJ6QAZSB+AK5
         /ntdrGkGF6TTwGAUxI1uKKECh2kXjGYz/3QO2BK9jiAgnq8pHkyIMWq5EzUh8MmwoB/h
         vlXyy+PMEc/cYLrmNZs/UHP7LUlDvA6xOtjLzl8RZNBkxjG/nE2lAMB+i4kk2p8exy6W
         owAtRkVVynPe/P/KQ9pTNkwBJLRjjFW+y/8sGmV7sLC61rx/ilGZLisWIwaIDoEOkQ0t
         pOR1+cbUECFVr5N0pMVl/ifJpU1BTw9SW2gf7+8vIfjP0BMHQlbqLlm6HDsjVwB/M0Jj
         1Wvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=IvnKvFtxbumJfU5sQvur1j8ggrNVu5Am6g5KD9tiGf4=;
        b=IOP1zy6JGIseMfnjFuCoyKXsVz+8IsrMnn8a2Eiq5vzUDJ4Qv8pCNK5Oc6uPBWt2y8
         EAkceYc+4gNEgecPg6L/yhtxBlvZ+9RxmFyEEoYrUEC8g1+oG0duyEcOdVFmVTBsiYzX
         z/NnMmo6+vWoiYmtjgZfdhZOImdI9PbGLNBvvR6rhT4EWiElhadwxRsLIQILtageOWR1
         E0qUEZIeqrwMiU+2i4rDfrj8G73m9tFjg0bQpoirMT+KnUUqTL+YxuiFBQx1LE7cbzHq
         o2eB3jeCk422NsjZl85UUqeUUek0yaI2ZXgRf4FsCDWTr2PRr2tR2LzIFa1EVB57OCf+
         jucw==
X-Gm-Message-State: ALyK8tJAlI58TkgkMNtmd1X2f3l1T+Tifk8UlfH4Y9Epwq48svYATqwPY4oH/CYKm28fP/yk058GLsWG0b3aPQ==
X-Received: by 10.36.207.137 with SMTP id y131mr19534872itf.32.1466013213631;
 Wed, 15 Jun 2016 10:53:33 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Wed, 15 Jun 2016 10:53:33 -0700 (PDT)
In-Reply-To: <20160615140026.10519-1-pranit.bauva@gmail.com>
X-Google-Sender-Auth: 8k6JHOE-IW3AVjIvP9KVD16DB7Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297380>

On Wed, Jun 15, 2016 at 10:00 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Changes wrt previous version:
>  * Use STRING_LIST_INIT_NODUP to avoid leaks in bisect_clean_state()
>  * Use test_path_is_missing in the patch 2/6
>  * drop file_size()
>  * move is_empty_file() method from builtin/am.c to wrapper.c
>  * use static for methods
>  * remove the variable status in bisect_reset() altogether and put the whole
>    thing inside the if block.
>  * one more method converted namely bisect_write().

As an aid to reviewers, in the future, please also include in the
cover letter an interdiff between the previous and current version of
the patch series. Thanks.
