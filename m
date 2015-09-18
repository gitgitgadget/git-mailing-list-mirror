From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] send-email: fix uninitialized var warning for $smtp_auth
Date: Fri, 18 Sep 2015 18:47:20 -0400
Message-ID: <CAPig+cR+W0Kt2y+vspS5dF6FHU=XLWZXJR46r7Rv4JP4gNiKTA@mail.gmail.com>
References: <1442614370-39880-1-git-send-email-computersforpeace@gmail.com>
	<20150918222524.GA22410@flurp.local>
	<20150918224242.GA45466@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jan Viktorin <viktorin@rehivetech.com>,
	Junio C Hamano <gitster@pobox.com>
To: Brian Norris <computersforpeace@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 19 00:47:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zd4RW-0001CS-2o
	for gcvg-git-2@plane.gmane.org; Sat, 19 Sep 2015 00:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754346AbbIRWrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 18:47:21 -0400
Received: from mail-vk0-f54.google.com ([209.85.213.54]:33509 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753799AbbIRWrV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 18:47:21 -0400
Received: by vkgd64 with SMTP id d64so38388009vkg.0
        for <git@vger.kernel.org>; Fri, 18 Sep 2015 15:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=WVIUS/2hJnfr3masM+VCF7NspDZVS8D022dNJcY2jVc=;
        b=zdTsvkZR7saCz0ZUfkswSDbohb5utxzVy91Q+dS6PCGVULxCUSzQMO6pRjq6UvAAw7
         hXo9odD4ofFvYg8K+8UT8k3/tUdG/1bTLfj2MLKR0bs0hodG0OiJky1P3vMxGmIY6skA
         0cm+/3mU7V4dpbrcGGkIneK7rAUAZtean+WGa4xdF5atR9qNwwNubMbb7zBbwRTpP/bx
         Ovn2/HSYOAHvbr0widLf0gQwBshecE7b/PlFDRX95uS1hXDl31QvrNrxQLp2EfyCzI1B
         HorKp5EYsDN9x1nJSnQaYkPBmVWrlHQhXLCE58itQIYQ1ZhCpYnbtA+9kE3cd6q1xowP
         GtzQ==
X-Received: by 10.31.11.202 with SMTP id 193mr5268607vkl.84.1442616440338;
 Fri, 18 Sep 2015 15:47:20 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Fri, 18 Sep 2015 15:47:20 -0700 (PDT)
In-Reply-To: <20150918224242.GA45466@google.com>
X-Google-Sender-Auth: UGmL-DmcoosZ0YQe2v8pbp-vEuw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278226>

On Fri, Sep 18, 2015 at 6:42 PM, Brian Norris
<computersforpeace@gmail.com> wrote:
> On Fri, Sep 18, 2015 at 06:25:24PM -0400, Eric Sunshine wrote:
>> Thanks, makes sense. I wonder if moving the check to the point where
>> $smtp_auth is actually used (despite the noisier diff) would be cleaner,
>
> By moving the patch into the sub-subroutine (is this a lambda? I'm not
> too familiar with my perl), I think you change the order of the checks.
> So, previously, initial password auth would happen after the
> $smtp_auth format check. With your patch, it comes first.
>
> My patch:
>
>   $ git send-email --smtp-auth="@" ...
>   ...
>   Send this email? ([y]es|[n]o|[q]uit|[a]ll): y
>   invalid smtp auth: '@' at ./git-send-email.perl line 1140.
>
> Your patch:
>
>   $ git send-email --smtp-auth="@" ...
>   ...
>   Send this email? ([y]es|[n]o|[q]uit|[a]ll): y
>   Password for xxxx:
>   invalid smtp auth: '@' at ./git-send-email.perl line 1155.
>
> Seems like the former is a little better, so you don't have to waste
> time with your password too many times.

Makes sense (again). Thanks for the explanation.
