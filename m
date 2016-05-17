From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3] pack-redundant: free all memory
Date: Mon, 16 May 2016 23:42:46 -0400
Message-ID: <CAPig+cTAZfRp=bD=CNgcfYcpkRfGuxdCbPCimhpM1Q_atv8G4g@mail.gmail.com>
References: <20160517032247.25092-1-sbeller@google.com>
	<20160517032247.25092-3-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Stefan Beller <stefanbeller@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 17 05:42:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2VuG-0001L8-EC
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 05:42:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204AbcEQDms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 23:42:48 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34332 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754185AbcEQDmr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 23:42:47 -0400
Received: by mail-io0-f193.google.com with SMTP id d62so1174094iof.1
        for <git@vger.kernel.org>; Mon, 16 May 2016 20:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=o5w6Nxyuj3CRAeU0Ejdnejtz6cepHFf7YwPr2JD37EY=;
        b=KhyhiJQbI/JJeG78gKbPQdf4tpT4t5Hr0DylISl/JrbVe6JOMgRZSJc2WM2bmDAWb4
         GZSXq1tcoAgBdaSTU++DbJXT8rSQPbAbSgNPcs5HG66LJ+1GEnatNVvAAqLprsQGR9mm
         yNq4IgLqw4jKZGco/Xrsox7VrGo4WswWtU7qd9Gu845FjoAZD76LDBiitrebX/yCsOTN
         wnQDvg+LYa4X95I5OLs8FzypLDR39tF0r56iVEYjqdiPjnlYhB6QmOaPe+T6urDhmoq0
         lXMd1EXq4i5nF0GG39CTJW49+cO/199Z7Om7beH17BSMO+Bb5DMSvmSuGR7KVvgsgkv/
         tSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=o5w6Nxyuj3CRAeU0Ejdnejtz6cepHFf7YwPr2JD37EY=;
        b=jfkgrcOc5TMFam/OjzJECG1Ec75OgryeGy+vi1rzeIPiYBQbLy5S9RnZzALZaTHsQu
         fX8cfha7j1nBVW8aZtuF4vN8yHT2L843NeHR5Ufw5UVywOBT2ycWog5TZqrCXpz9DYte
         pnvl3ExcMKkL5tGzu2qdshQWpqCcz+Zpje5gAOus6BRzD1BCu+YNu0unQLZmRY4pScDH
         vM7cIgLDtM8nVeOBbpxZnvuqgJPQxS7o9lyI4t59JA8y2azVXmoYmTGqfDgju6YjTBNI
         oakaMnt9Cv61TPBWRYIN+po+fdvZFswNGnInn3HVaeRZ04r7kCuUurO5CowKwMBf1eT7
         WXWA==
X-Gm-Message-State: AOPr4FVGjEKZ/TRTO3P9fBc/gSIinGXpczLlAcHDjPXbv2kHHQy9plP1t2Q9FIJP+S2yKTqujjQe8tZpizdK3w==
X-Received: by 10.107.47.37 with SMTP id j37mr21205411ioo.168.1463456566915;
 Mon, 16 May 2016 20:42:46 -0700 (PDT)
Received: by 10.79.139.135 with HTTP; Mon, 16 May 2016 20:42:46 -0700 (PDT)
In-Reply-To: <20160517032247.25092-3-sbeller@google.com>
X-Google-Sender-Auth: aaVfR1aApww-v3qFQQfvo_xoT2o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294848>

On Mon, May 16, 2016 at 11:22 PM, Stefan Beller <sbeller@google.com> wrote:
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
> @@ -223,6 +223,18 @@ static inline size_t pack_list_size(struct pack_list *pl)
> +static inline void pack_list_free(struct pack_list *pl)

s/inline//

> +{
> +       struct pack_list *cur_pl;

You can declare this within the scope of the while-loop.

> +       while (pl) {
> +               llist_free(pl->unique_objects);
> +               llist_free(pl->all_objects);
> +               cur_pl = pl;
> +               pl = pl->next;
> +               free(cur_pl);
> +       }
> +}
