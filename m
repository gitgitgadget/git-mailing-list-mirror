From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC 5/6] fetch: pass refspec to http server
Date: Sat, 16 Apr 2016 22:33:38 -0400
Message-ID: <CAPig+cSxkuWB5qqVY3-m9ESmmHMKwXM+qtbRsZ1j1osjp2i3HQ@mail.gmail.com>
References: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
	<1460747949-3514-6-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 04:33:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arcX5-0006DG-HO
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 04:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbcDQCdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2016 22:33:42 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:32823 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbcDQCdj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2016 22:33:39 -0400
Received: by mail-io0-f196.google.com with SMTP id g185so19576096ioa.0
        for <git@vger.kernel.org>; Sat, 16 Apr 2016 19:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=Nc50oywJ0DkhAVwNPO1v9pfddicZMeB/Evn3aeHtbfg=;
        b=mjPJakRxzMWtuJP/JsuMwYNtDwgxu4+loro9m2K/A3zd5VrQBIMpQy+LGsKWl2p+Q8
         fOJ7mW6dv/Qo2Kw+Ks3PbZrMaoNTiWeaX2JkqOJa6hA4abuD+szZ6iuTiCflCJa5izRv
         DlVtWt4ctpRmqeWOGhS4eG2dVAuMB1hzyJ3fD7IWi/pTxNx+WoUqDMib/uJjyOpiTxgB
         E9ThU4CX65OOaciJbJtpVYDpbsMFejjx9TLPlXv5UXAEqnw4UQFuyYQ2qzUBo3SQF0X+
         itFtCScMk7bGfneeuFYI4J7c6xLxYoUwwNSg9ilTpEYOzWuandBCXcPXcyZf4wheExnL
         kCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Nc50oywJ0DkhAVwNPO1v9pfddicZMeB/Evn3aeHtbfg=;
        b=hrObT/dVAuWWi6IWIbTg2CbiUiFvc4ApUDd3/KwNk5b3bQI5zNC1uZDPuUwgYQrhDe
         27GQQQ9XgT0RkFVb/fiNx1tTd3hDEX1/hUcwIIZ1V+JvNitSjvLrtBz11cQeo8nThP/O
         wieNU2VMi5GAmTsbova9+qDZ9/KHnZ0un5EH00CKzzp/DyCwwhV7ui+Vvoqg/ZYbJBJY
         P7Dp6xa73WMq4D26+jWTbzvSfyQ08ye27UqK3xgYB6VdrV1+KvoWjWbk6sxx4u61qU58
         Il8Hu0F+4IJ9+rol6UzglrUiCH87bGOcfuz2AIW/Q+yTW3TkI9WrVyy1BaaoDSZdn9zX
         nCZA==
X-Gm-Message-State: AOPr4FVoD/tfbLaIpJU6o4cr7ms/SAYvwjG5GirWSzJmPZ+SWaNpRtkvmIIXdce9cwqIAki7c++W/PTGHzpx9A==
X-Received: by 10.107.9.28 with SMTP id j28mr30146159ioi.104.1460860418302;
 Sat, 16 Apr 2016 19:33:38 -0700 (PDT)
Received: by 10.79.139.71 with HTTP; Sat, 16 Apr 2016 19:33:38 -0700 (PDT)
In-Reply-To: <1460747949-3514-6-git-send-email-dturner@twopensource.com>
X-Google-Sender-Auth: AYHENIBLP6gHziqKeF7qKnUqAaI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291738>

On Fri, Apr 15, 2016 at 3:19 PM, David Turner <dturner@twopensource.com> wrote:
> When fetching over http, send the requested refspec to the server.
> The server will then only send refs matching that refspec.  It is
> permitted for old servers to ignore that parameter, and the client
> will automatically handle this.
>
> When the server has many refs, and the client only wants a few, this
> can save bandwidth and reduce fetch latency.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> @@ -302,9 +302,27 @@ static struct ref *get_ref_map(struct transport *transport,
> -       remote_refs = transport_get_remote_refs(transport, NULL, 0);
> +       qualified_refspecs = xcalloc(refspec_count, sizeof(*qualified_refspecs));
> +       for (i = 0; i < refspec_count; i++) {
> +               if (starts_with(refspecs[i].src, "refs/")) {
> +                       qualified_refspecs[i].src = xstrdup(refspecs[i].src);
> +               } else {
> +                       struct strbuf buf = STRBUF_INIT;
> +                       strbuf_addf(&buf, "refs/heads/%s", refspecs[i].src);
> +                       qualified_refspecs[i].src = strbuf_detach(&buf, NULL);

Alternately, replace these three lines with:

    qualified_refspecs[i].src = xstrfmt("refs/heads/%s", refspecs[i].src);

and drop the braces.

> +               }
> +       }
> +
> +       remote_refs = transport_get_remote_refs(transport, qualified_refspecs,
> +                                               refspec_count);
> +
> +       for (i = 0; i < refspec_count; i++) {
> +               free(qualified_refspecs[i].src);
> +       }
> +       free(qualified_refspecs);
> diff --git a/t/t5552-http-fetch-branch.sh b/t/t5552-http-fetch-branch.sh
> @@ -0,0 +1,42 @@
> +test_expect_success 'make some more commits' '
> +       (
> +               cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> +               test_commit 2 &&
> +               git checkout -b another_branch &&
> +               test_commit 3

Broken &&-chain.

> +               git checkout -b a_third_branch &&
> +               test_commit 4
> +       )
> +'
> +
> +test_expect_success 'fetch with refspec only fetches requested branch' '
> +       test_when_finished "rm trace" &&
> +       (
> +               cd clone &&
> +               GIT_TRACE_PACKET="$TRASH_DIRECTORY/trace" git fetch origin another_branch &&
> +               ! grep "refs/heads/master" ../trace
> +       )
> +'

This could be done without the subshell, perhaps?

    GIT_TRACE_PACKET=blah git -C clone fetch ...
