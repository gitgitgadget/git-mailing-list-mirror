From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH 09/11] branch.c: use 'ref-filter' data structures
Date: Tue, 28 Jul 2015 10:17:09 +0200
Message-ID: <CAP8UFD3L4QEYQMCda7AbByXGZcvgy5r9y0LMBqEysb6AZ+ydOQ@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	<1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
	<1438066594-5620-9-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 10:17:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK04d-000160-P7
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 10:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778AbbG1IRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 04:17:12 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:38110 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbbG1IRK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 04:17:10 -0400
Received: by wibxm9 with SMTP id xm9so148905633wib.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 01:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WBKFlXlPp6Q1Oql5aQRP3/wdeFBPepccF4MYjS1MeAg=;
        b=oFxUYjx0kmBpyZi3ls9DtivLENZCxurGFE8/qPFmNTfoV2ugWBwjNmRHseggfe+Lvg
         pOuHS9kQBlWifYHz++Fydve8gaQbsF9mIchZrn+w3ndRkhOzCBvPyEN4NYbZY8Cxhl6Q
         K8dTHGmjbtPsP8lhj1vI3wMcIAXaoTuswCiePp8W37dU8LzDJf94ZXul+HGnelWZfZVe
         g3NHkkGjExrDJEcFUfBQy4juXUKWGT8U6xYcn0SbdUR0aiN23qiiMjd00XjliPwbjR7l
         OArNi2GnP6L3oIoCa9sSRVnR0lmrr+TDeZFY6ROhgQs6qcWjUR443/nJQfAWCZbq+qY8
         6ymg==
X-Received: by 10.180.77.69 with SMTP id q5mr32776892wiw.75.1438071429647;
 Tue, 28 Jul 2015 01:17:09 -0700 (PDT)
Received: by 10.194.36.106 with HTTP; Tue, 28 Jul 2015 01:17:09 -0700 (PDT)
In-Reply-To: <1438066594-5620-9-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274756>

On Tue, Jul 28, 2015 at 8:56 AM, Karthik Nayak <karthik.188@gmail.com> wrote:

> +static void ref_array_append(struct ref_array *array, const char *refname)
> +{
> +       size_t len = strlen(refname);
> +       struct ref_array_item *ref = xcalloc(1, sizeof(struct ref_array_item) + len + 1);
> +       memcpy(ref->refname, refname, len);
> +       ref->refname[len] = '\0';
> +       REALLOC_ARRAY(array->items, array->nr + 1);
> +       array->items[array->nr++] = ref;
> +}

This function belongs more to ref-filter.{c,h}...

[...]

> -       ALLOC_GROW(ref_list->list, ref_list->index + 1, ref_list->alloc);
> +       ref_array_append(array, refname);
> +       item = array->items[array->nr - 1];

...and the above is a bit ugly.
