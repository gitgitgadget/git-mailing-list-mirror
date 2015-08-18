From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v12 00/13] port tag.c to use ref-filter.c APIs
Date: Tue, 18 Aug 2015 15:18:42 -0400
Message-ID: <CAPig+cTauPEH5dTemwMcq0oE2WgKfcWKcK6-mvs8C7HUNqC4Bw@mail.gmail.com>
References: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 21:18:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRmPH-0005rc-EI
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 21:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933AbbHRTSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2015 15:18:43 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:36486 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654AbbHRTSm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2015 15:18:42 -0400
Received: by ykfw73 with SMTP id w73so115259303ykf.3
        for <git@vger.kernel.org>; Tue, 18 Aug 2015 12:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ACSMRtvypyEA7gRPUCDZ0PtuDl6B12o8DQCFOvawK94=;
        b=XulBcY2HC8BmURrnaSIWRc/qBeWgeCpzPL6D2iNpymSFDmyavIPSbxcLu/iY3is6VR
         AkB9Ut/K64fybkjGcItsrp0wDnKuYdVu7rskE2onpMpznqBjUwCg5faflK3gPGTVTvew
         svTU5FOnBagp0sjlkPbfqK1DMVLXRww2ePmYX39FYBjSJVL2iGyI3Y6omb7t7ncy1amw
         aVG3Q5RRApmJbarYNigqHGO4IZy51dkg4UYsT4BDcy8q3gCVHfwCTw9L/tmqa6ch7/QD
         raYLI1KgBCKxqAIOSMiag4/1rS/qSPefusXaCTb3IfjZYSFM59/+Kwcu2r3GuN81akPU
         Yhdg==
X-Received: by 10.129.76.151 with SMTP id z145mr9381152ywa.17.1439925522177;
 Tue, 18 Aug 2015 12:18:42 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Tue, 18 Aug 2015 12:18:42 -0700 (PDT)
In-Reply-To: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: 8_bBz0OiAGkRHAhm3lGyOZh6ITU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276156>

On Tue, Aug 18, 2015 at 2:37 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Version 11 was posted here:
> http://article.gmane.org/gmane.comp.version-control.git/275997
>
> Changes in this version:
> * Small style and formatting changes.
> * Remove unnecessary variable from push_new_state().
> * pop_state doesn't return a value now and attaches the buffer
>   into the previous state.
> * use strcmp() rather than starts_with() while checking for
>   alignment position.
> * Change attend to at_end
>
> Interdiff:
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 3099631..760d719 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -128,8 +128,8 @@ color::
>         are described in `color.branch.*`.
>
>  align::
> -       left-, middle-, or right-align the content between %(align:..)
> -       and %(end). Followed by `:<position>,<width>`, where the
> +       Left-, middle-, or right-align the content between %(align:..)
> +       and %(end). Followed by `:<width>>,<position>`, where the

I haven't had a chance to look closely at this version yet, but this
popped out while quickly scanning the interdiff since the previous
round had the same sort of problem:

    s/>>/>/

>         `<position>` is either left, right or middle and `<width>` is
>         the total length of the content with alignment. If the
>         contents length is more than the width then no alignment is
