From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] git-send-pack: fix --all option when used with directory
Date: Thu, 31 Mar 2016 18:55:22 -0400
Message-ID: <CAPig+cS-Yk7Ey8_+waG7HqG-9BijrQNrtP+0szcgbmVycv_qvQ@mail.gmail.com>
References: <1459432509-12934-1-git-send-email-stanislav@assembla.com>
	<xmqq1t6qmlxk.fsf@gitster.mtv.corp.google.com>
	<xmqqoa9ul30c.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	dborowitz@google.com, stanislav@assembla.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 00:55:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1allUt-0007XY-FX
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 00:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754351AbcCaWzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 18:55:23 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36266 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572AbcCaWzW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 18:55:22 -0400
Received: by mail-yw0-f196.google.com with SMTP id p65so13950374ywb.3
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 15:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=QSUTROpFFgjzSTTW+03QDJ9sl+N9+SV7uN1Dg3XST2I=;
        b=R9Oz3J2rK6ZQ8LfNQBadlREotfbMqJ288pWaQcB2TLFg+soZ49yBJejyP7Svdj4nkM
         FQZcuFnxwPi2k5jXkBOOgN5I93JR9dpkVKQRusZIhhYlU8WZ/CeVIUzBC1NYLXd28UaM
         t3D9b6hjPKZwPxiqHdmyep9uFeqDqzvaW3qm6pJLiVwynSJ088HVbnJdlN+jOkptSyTs
         J9YVJaYDvlWZ06c8+PYaHmhR/3sczGzcEBNsbB1XSNaKixaVr+mQslYOHf7ieWOy5SnF
         skphr+G7PYRL/KOUcS9hZHsp4zm4Ro0gbpSvwTs5329sE/1obKu77EA2eWiluUlSHJsq
         zPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=QSUTROpFFgjzSTTW+03QDJ9sl+N9+SV7uN1Dg3XST2I=;
        b=crmvQxb1zJ3chKb7u4/4au0INmR3S+Ux+TRSBeOnjTn85V9zTG5UcxC13jghZAAkdd
         AUBOiCjXtfM4hWvfFnNsTDQnHUFZlKc7e+LPEmOFep1ZJrY5vJAgpY2OTSkfScNnRrIk
         RvuG+LA5RS2qIo3T0bQpX8r8OPhq7BRY0t6FO3YEwM3l3MrTi/w4mXVm/aMU4hVk6HLe
         QnONBpvdEFDNKyWEruTDaspD4U62bTXc2t/tQJuFOk64wuoH2LhIWfsQTtcWcIuD/ANH
         c9o/KfSy9b7jH6GR7+H1tn2iIDxp+vkMKhRcugSQZs5NagrXmYQVJFA7nnFB3HoRB/Zw
         lbNA==
X-Gm-Message-State: AD7BkJL0vL1WadZm25ZHutnzOmsVf+34PFCa7IVBqKAjUdKqEMyKQGZ8r+VMEwFRQz+vKER70pIoBNl2WrzPxg==
X-Received: by 10.159.33.206 with SMTP id 72mr742951uac.14.1459464922153; Thu,
 31 Mar 2016 15:55:22 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Thu, 31 Mar 2016 15:55:22 -0700 (PDT)
In-Reply-To: <xmqqoa9ul30c.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: A5cpxXgZTwbkxqGWXUpSraGABCk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290484>

On Thu, Mar 31, 2016 at 6:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> By the way, for some reason it was unusually painful to find the
> exact breakage by bisecting between maint-2.4 and maint-2.6.  It
> somehow ended up on fingering random places like v2.6.0 itself.
>
> The true culprit is 068c77a5 (builtin/send-pack.c: use parse_options
> API, 2015-08-19).  I didn't dug deep enough to tell if we recently
> broke "git bisect" or if there are something wrong in the shape of
> my history.

I had a similar experience a couple months ago where I was bisecting
to find a fix (rather than breakage), and each time I ran bisect, it
seemed (randomly) to arrive at a different commit, often a merge,
rather than the real fix (which I eventually located by manually
examining commits near the commits bisect identified). At the time, I
thought I was doing something wrong (and perhaps I was), but your
descriptions sounds eerily similar to that experience.

Unfortunately, I no longer recall precisely for what I was searching
(other than that someone reported a Git bug which I recalled having
been already fixed, and wanted to use bisect to respond with the exact
commit which fixed the problem), and the bisect "run" script was
throwaway, so I can't consult that for further details.
