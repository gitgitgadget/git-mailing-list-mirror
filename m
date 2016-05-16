From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 63/94] builtin/apply: make apply_all_patches() return
 -1 on error
Date: Sun, 15 May 2016 23:44:43 -0400
Message-ID: <CAPig+cQAM8i2sFY9UUYfN23PRGgFacG7KiTD6mZwnm=PgKBL7A@mail.gmail.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<20160511131745.2914-64-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 05:45:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b29TS-00049r-ED
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 05:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148AbcEPDop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 23:44:45 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:36358 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbcEPDoo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 23:44:44 -0400
Received: by mail-ig0-f193.google.com with SMTP id c3so5925465igl.3
        for <git@vger.kernel.org>; Sun, 15 May 2016 20:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=7PlPyCtfSOma8uJNXr6RMrYcSfTu75omj9/R7r5pMl0=;
        b=vLsr1BO2GM7b98uTioodoOIzh/lpRMtrPw2YRdgOBoCeyKOv5L7ZBp4Fgmm/p76BBp
         2TElC130lzp/b2HPU1i5TTRozqLKRaVEJ2SO01AJU0wChvLRjxSzrOWahc990LZLPLGB
         5h9YZkjWbe9EX3rBq1TRqEim4+7naPjiftbZyWLHGod4jMCC6Z0FRU5BIRkppkNFeS5Q
         2MSfP8Ax7E0T0TtE+Ven27kq7gjaOqfbfrvUfPhEJMSD8dIdzV2LRwQ9qTZn5kS0crL7
         RvYwp6+8tesebHBUw7h/tqkQ0UtlYAWv0KKqed8eDWJGJzON3JVWJgsRpopvu3EQuV6+
         OJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=7PlPyCtfSOma8uJNXr6RMrYcSfTu75omj9/R7r5pMl0=;
        b=F6XzFuz8r4A5uSliqyQIqaCA5HNjLDn0DVPhMBTgi3acPIuksZRcs0EwRfwMEZ++IU
         SW8oJ5rLw6+3p0VESWseifDmaauHKs7OXkIxP06eS9GcV026hA9eQMTD1bNU7rhj1Zn0
         9x3kGLtH/5pSMjIYCPgFu+WntMjZusFTlV/8GbmhLoalC1yvyrmu0Wi+a0+tpKBd+t3U
         AaMW0gQzAqGGUIRKhaLW4nqFJthGJr1yupwxxwQaycTjS4SYucGf8wuEEmpnqNey8ZrS
         LyxRRqoUcmamyOXjUQgpwtZWLscxe4iCzAREJT/SHBDrfjictplExavOIL3F55vADBux
         YpOA==
X-Gm-Message-State: AOPr4FWWZjb0CeuaKjzW4VUlRWmqwJ++Ca0PGXMJ25gy7riD1veXLg3RaAms1LPjbnsU3aU4QTUGE798GV9K1A==
X-Received: by 10.50.3.105 with SMTP id b9mr9166557igb.17.1463370283790; Sun,
 15 May 2016 20:44:43 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Sun, 15 May 2016 20:44:43 -0700 (PDT)
In-Reply-To: <20160511131745.2914-64-chriscool@tuxfamily.org>
X-Google-Sender-Auth: U1HbTbfmz3OaDz1IhZyyhBJ-LDY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294721>

On Wed, May 11, 2016 at 9:17 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> To finish libifying the apply functionality, apply_all_patches() should not
> die() or exit() in case of error, but return -1.
>
> While doing that we must take care that file descriptors are properly closed
> and, if needed, reset a sensible value.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/builtin/apply.c b/builtin/apply.c
> @@ -4613,9 +4613,10 @@ static int apply_all_patches(struct apply_state *state,
>         }
>
>         if (state->update_index) {
> -               if (write_locked_index(&the_index, state->lock_file, COMMIT_LOCK))
> -                       die(_("Unable to write new index file"));
> +               res = write_locked_index(&the_index, state->lock_file, COMMIT_LOCK);
>                 state->newfd = -1;

Does write_locked_index() unconditionally close the file descriptor
even when an error occurs? If not, then isn't this potentially leaking
'newfd'?

(My very cursory read of write_locked_index() seems to reveal that the
file descriptor may indeed remain open upon index write failure.)

> +               if (res)
> +                       return error(_("Unable to write new index file"));
>         }
>
>         return !!errs;
