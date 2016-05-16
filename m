From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/12] commit.c: use strchrnul() to scan for one line
Date: Mon, 16 May 2016 16:41:57 -0700
Message-ID: <CAPc5daXM9a=W2R6YE=4PSuHWKXoZs_-VT+48ajh3mq1RoqYncA@mail.gmail.com>
References: <20160516210545.6591-1-gitster@pobox.com> <20160516210545.6591-2-gitster@pobox.com>
 <CAGZ79kbeXCsCs35hva2FWUhOD2F37ZDrzupEZLGBVbqnMxPjXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 17 01:42:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2S9X-0006Si-MN
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 01:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764AbcEPXmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 19:42:19 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34389 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310AbcEPXmS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 19:42:18 -0400
Received: by mail-yw0-f196.google.com with SMTP id i22so21663373ywc.1
        for <git@vger.kernel.org>; Mon, 16 May 2016 16:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=6ylxOJiQsuGTE1zPwWFn1JVJKNQd83ndrq3Fr6l5Cwo=;
        b=Zb86NSzNG4dgjk6knevgUoAH19UHZsVd0+IKnf5nsbm/Q25Cf+qKd63I+EZMt8/WM/
         9u+DjpGtF9Tj/AqTYAeWQf0zQqVIzgsiT++N8n9sIIdVEOJnC7/IDpA5vPtOlo6kdgZ4
         jFoCbEt4nxXiJRM/UzYwCfXsEbqQrIyTIR5JBSuNU2sZ0CWrmeukeFQsAMVtY09KvCk9
         B6us+QGyNfgvaz3Xd6O2lDG3UbZ07mqn/skS2TYflMsq1W7bVK+fFvrrAOwt08obIA9o
         7R62cfslMJ+j0eZMFcRCZdmOv0u6WUEqu4sefhoZ3coKTKbKT7bjCK73kGeXfBeZOZ/A
         8jvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=6ylxOJiQsuGTE1zPwWFn1JVJKNQd83ndrq3Fr6l5Cwo=;
        b=PqQ1ZrQFgcS48d1TWY+tmNQ4mdBS2RyO+fPcDHgxQMDED2Ajoig1c9J/hlBd3HGGQw
         /5sKzhNgXsoR1B1wvpIZfy6Wf3Xq39bevwjGsenQRX8WLParUVdAfoDRmvOij23pkX3T
         2PLtpQbzjeFNlqxZY+Pad8IKbG5FFFLsihPiBszplzeVyBiHHtKpE50uqS4Mv/XWPKw9
         t0B5fTbINZtktonvpqmkDwLaJzEC8C88yACOcV4LDFjBQvY/FZ5mU4IICp0kuX9Y8m+B
         LX0A6bYUb6ixlFVHPd2SrBpUUh0wrnEKcASi5kN9K/p7q4l4c/zZPmO9IVpq0AV1dVIj
         iPKg==
X-Gm-Message-State: AOPr4FXpqLd7NeanWCT1q5C7J0u1PRM16NkI/2ytBmRaE1jiUaPD5aSgqL5cDbs76eohcIAQLKg5MAi9GOsuVA==
X-Received: by 10.37.99.214 with SMTP id x205mr6403942ybb.123.1463442137209;
 Mon, 16 May 2016 16:42:17 -0700 (PDT)
Received: by 10.13.251.71 with HTTP; Mon, 16 May 2016 16:41:57 -0700 (PDT)
In-Reply-To: <CAGZ79kbeXCsCs35hva2FWUhOD2F37ZDrzupEZLGBVbqnMxPjXQ@mail.gmail.com>
X-Google-Sender-Auth: 8brJR9J2f0ehUJvdGjZh3Y_-yKw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294820>

On Mon, May 16, 2016 at 4:19 PM, Stefan Beller <sbeller@google.com> wrote:
>>         if (*p) {
>>                 p += 2;
>> -               for (eol = p; *eol && *eol != '\n'; eol++)
>> -                       ; /* do nothing */
>> +               eol = strchrnul(p, '\n');
>
> Nit:
> You could include the +2 into the arg of  strchrnul,
> such that you can drop the braces.

You're right. With or without braces,

  eol = strchrnul(p + 2, '\n');

would be easier to understand (I do not know offhand if the value of p
matters after this part, as I am responding from GMail Web UI without
access to the wider context in the source, though).
