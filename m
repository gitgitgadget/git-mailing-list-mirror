From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/4] Make check-{attr,ignore} -z consistent
Date: Fri, 12 Jul 2013 02:55:26 -0400
Message-ID: <CAPig+cRuLpNzYaQQBe2Cw1Y4OQbMjM6YYJtuGcDyXAcy4fnBdw@mail.gmail.com>
References: <1373609927-3244-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 08:55:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxXGR-0000tc-Qn
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 08:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756727Ab3GLGzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 02:55:32 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:50162 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077Ab3GLGzb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 02:55:31 -0400
Received: by mail-la0-f48.google.com with SMTP id lx15so7476869lab.35
        for <git@vger.kernel.org>; Thu, 11 Jul 2013 23:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=OeLAnW/75UDf37ez4RVwJU/58kjXmrRYEZuIqHCExGk=;
        b=a9rpX7+T5frdIZfAVhNl4f5ZxH7Au35VywARhv/AV8a/UFEc57k6Ju0W+KhTVydtWv
         hRX7lusLnfr3HJdcYyuNYwpe/aGgFqHqw1tc2bd8IcVqcs7HXK3qAobnp/5WMa68CO5l
         Nx/6rCvwVhXeuHV1VcRmrtRYfV4SV/S/L33I4hrVq7HoWWa9fHcbWS2fi5TDdL7JU2+I
         ofZoSLZ2ohbuXbE7K1O5/7SmIVaw/ymqX+Ery783SD6Vi1F52ERIzdXkkxyve3+j+3Gb
         VsNfdDArvvF6jBg5mL0m24hSLft5IRZu9oubWbGfImgShB2PqbiBeFBgE8psNSNri2zo
         m3Ng==
X-Received: by 10.152.120.105 with SMTP id lb9mr19062947lab.20.1373612126920;
 Thu, 11 Jul 2013 23:55:26 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Thu, 11 Jul 2013 23:55:26 -0700 (PDT)
In-Reply-To: <1373609927-3244-1-git-send-email-gitster@pobox.com>
X-Google-Sender-Auth: CGZ6ArsYVd3JwJpj9djwpolHG3Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230182>

On Fri, Jul 12, 2013 at 2:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
> A command that has to deal with input/output that may contain LF
> needs to offer the "-z" (--nul-terminated-records) option, and if it
> does not support separate --nul-terminated-{input,output} options,
> the "-z" option should govern both input and output.  A caller that
> uses "-z" knows that the paths it feeds to these commands as input
> may have LF that cannot be expressed in LF delimited input format,
> and the output from these commands do contain the same paths, so
> there is no way for their output to be expressed unambiguously for
> an input that requires "-z".

FWIW, applying to the entire series:

Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

> Unfortunately, "git check-attr -z" was broken and ignored the option
> on the output side.  This is a backward-incompatible fix, so we may
> need to add a "checkAttr.brokenZ" configuration to allow people to
> keep the existing breakage on top of these fixes, and then flip the
> default at Git 2.0 boundary (sometime early next year).
>
> Credit goes to Eric Sunshine for finding this discrepancy
> ($gmane/230158).
>
> Junio C Hamano (4):
>   check-ignore: the name of the character is NUL, not NULL
>   check-attr: the name of the character is NUL, not NULL
>   check-ignore -z: a single -z should apply to both input and output
>   check-attr -z: a single -z should apply to both input and output
>
>  Documentation/git-check-attr.txt |  9 +++++++--
>  builtin/check-attr.c             | 20 ++++++++++++++------
>  builtin/check-ignore.c           | 12 ++++++------
>  3 files changed, 27 insertions(+), 14 deletions(-)
>
> --
> 1.8.3.2-911-g2c4daa5
