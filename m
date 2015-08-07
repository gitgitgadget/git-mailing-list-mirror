From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v9 02/11] ref-filter: introduce ref_formatting_state
Date: Thu, 6 Aug 2015 23:36:14 -0400
Message-ID: <CAPig+cTBnBXeNjR53wDUYf6Ewu5t5nZqFB8P-Q8QyE1p98==uA@mail.gmail.com>
References: <CAOLa=ZSBMk9y1VGTVKSVsGMdYuPtjhPADciVUaEVwESRdSvWZg@mail.gmail.com>
	<1438692188-14367-1-git-send-email-Karthik.188@gmail.com>
	<1438692188-14367-2-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 05:36:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNYSL-0005jJ-M9
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 05:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671AbbHGDgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 23:36:16 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:36719 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbbHGDgP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 23:36:15 -0400
Received: by ykeo23 with SMTP id o23so79317909yke.3
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 20:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=jBUhWPDQ6zZU7eMO2lbQm0g9gXDYzqe/A3G92UVcW80=;
        b=BHO9ri4rslWC0ojjjLFKerFnAFodmAf4BWdT/jtqol82Q91iVBWnWCZ6QPoUivL2hl
         06dDnGRpUIMWlDIUsyn43E/xEJkAehi1kUQp0y/sT26Hl6maG9wMiaOEWJeUfr8rik+J
         ktr8lQaRqioE6LRxO9YtPviDnBq2jsP+Pj6MKpPDYc03t+mzBUqiYx7Kr5hs9agN7lQc
         pe78tPS6JVetu/lsGV0lCkSXabBhUCHKUjd667AkPbq/pD515cA+KkHGV1us846VOfvj
         4V1eZF/Q4Qd67xZqu6eBrWP4Lk45naM83Pc3A5IKip6S9uHU10wmOCfUL0lnPH8AVJA8
         YAwQ==
X-Received: by 10.170.112.208 with SMTP id e199mr5499976ykb.69.1438918575032;
 Thu, 06 Aug 2015 20:36:15 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Thu, 6 Aug 2015 20:36:14 -0700 (PDT)
In-Reply-To: <1438692188-14367-2-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: --XxtGfn7H0GFTX6DY5sGGzX6c8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275457>

On Tue, Aug 4, 2015 at 8:42 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Introduce a ref_formatting_state which will eventually hold the values
> of modifier atoms. Implement this within ref-filter.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> index 91482c9..2c074a1 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1238,35 +1238,58 @@ static void emit(const char *cp, const char *ep, struct strbuf *output)
> +static void apply_formatting_state(struct ref_formatting_state *state, struct strbuf *final)
> +{
> +       /* More formatting options to be evetually added */

I forgot to mention this in my earlier review of this patch:

s/evetually/eventually/

> +       strbuf_addbuf(final, state->output);
> +       strbuf_release(state->output);
> +}
