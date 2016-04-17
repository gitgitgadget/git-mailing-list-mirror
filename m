From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC 6/6] clone: send refspec for single-branch clones
Date: Sat, 16 Apr 2016 22:36:06 -0400
Message-ID: <CAPig+cRGDsBn4EKWn7Vqqmt_ZhZbYgUh9Tg-rgQPchn015SNMw@mail.gmail.com>
References: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
	<1460747949-3514-7-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 04:36:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arcZJ-0007Jy-H8
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 04:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161AbcDQCgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2016 22:36:08 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35763 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129AbcDQCgH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2016 22:36:07 -0400
Received: by mail-io0-f196.google.com with SMTP id u185so19479478iod.2
        for <git@vger.kernel.org>; Sat, 16 Apr 2016 19:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=AycvdeZtbfIpYL3iLSDuct54b/U+YsZRWFAOWFCNRCY=;
        b=eK4K0dX8xYKSP+Z/AJAAw0GNRly+NF9ktlLd5zy4qJ9RjU9OZFDrudnNTfGwZU5Pul
         c6EviGEy/z3vwOpUj/0ofVAzUcAhaQqk63vL0GacXtRjfQuUDdRvXvqM+sKp8IGxGjp5
         38XK9vGvWh+LGGIbFftFYnTK0jE+1DAbXto9GfI6vQFJpjsKtfEZpf7NNyc+PCFQbMpt
         scRjSOY0y7RYiC4kAFWM/pmnXffEUR4jFAL9Yk84mU4KbG2GK1mJxKrby838FQR8OIq5
         pbFEjGCsgO4+zCL11W0pxO/Y6ZfZ2es7pnhEF3DUl5gm8oEfiPH7O3qMymzlzesplBBt
         Npiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=AycvdeZtbfIpYL3iLSDuct54b/U+YsZRWFAOWFCNRCY=;
        b=L2ccQfLasoF91G/VFtmrmcAYNHVgasj9tuuaqP6bWNTDm+mZzZ0uWM23T645A0eo16
         /L4TXxPOCMVQnLzOwcWU701PcfuU71U1FucioJBsXwaIz84jANSxqbF5fRGyv7cf+nx1
         GZP65qzw5tmf+NyvI2PejVDvsACe+rEiCjJl87xwplzN62fsij/4m2wAAOrTya3H9glk
         MJDpMfteJ4WtSyr1KZAJcf7UDjKmrOdWn4aETPGekp0KK8veMSGY8F/tQMFWFLMZc5BU
         8xK6b5vqTiexflXKHOEMwYeXfWgLCoRD1nLv9nDVdIbd4mx5Y5lYMmwfQCqnn3HcPQat
         fTPg==
X-Gm-Message-State: AOPr4FXEsOwXML1H3UjPashEHHjjkPMg0ZSXtOuflTSqvoYeM6ci16PPV/c9cPX1H6PSSmw9ygVbLvDYdQzdAQ==
X-Received: by 10.107.8.141 with SMTP id h13mr33178877ioi.34.1460860566539;
 Sat, 16 Apr 2016 19:36:06 -0700 (PDT)
Received: by 10.79.139.71 with HTTP; Sat, 16 Apr 2016 19:36:06 -0700 (PDT)
In-Reply-To: <1460747949-3514-7-git-send-email-dturner@twopensource.com>
X-Google-Sender-Auth: SSS1zVHGXl7wgl0PR2dSC7t1r_I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291739>

On Fri, Apr 15, 2016 at 3:19 PM, David Turner <dturner@twopensource.com> wrote:
> For single-branch clones (when we know in advance what the remote
> branch name will be), send a refspec so that the server doesn't
> tell us about any other refs.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
> diff --git a/builtin/clone.c b/builtin/clone.c
> @@ -1010,7 +1010,21 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
> +       if (option_single_branch && option_branch) {
> +               struct refspec branch_refspec = {0};
> +
> +               if (starts_with(option_branch, "refs/")) {
> +                       branch_refspec.src = xstrdup(option_branch);
> +               } else {
> +                       struct strbuf buf = STRBUF_INIT;
> +                       strbuf_addf(&buf, "refs/heads/%s", option_branch);
> +                       branch_refspec.src = strbuf_detach(&buf, NULL);

branch_refspec.src = xstrfmt("refs/heads/%s", option_branch);

> +               }
> +               refs = transport_get_remote_refs(transport, &branch_refspec, 1);
> +               free(branch_refspec.src);
> +       } else {
> +               refs = transport_get_remote_refs(transport, NULL, 0);
> +       }
