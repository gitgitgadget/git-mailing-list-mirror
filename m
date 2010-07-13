From: Daniel F <nanotube@gmail.com>
Subject: Re: git am mangles commit author name.
Date: Tue, 13 Jul 2010 11:48:55 -0400
Message-ID: <AANLkTimCjfFh25vbzotufpTnUjfRglzHiQeDzWz8O5RJ@mail.gmail.com>
References: <AANLkTinqTL7gH4CHEfy8UrhK13xcO_3UzgIyQka00MAh@mail.gmail.com>
	<20100713054949.GB2425@burratino>
	<AANLkTinPCZ79vwZ9eVeHChgTuFGBrz3ACi_grM28Q5Y-@mail.gmail.com>
	<AANLkTikAcZa5J8XhKKJuDCHY3VMhSRzETv0ZQ34EcjMx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 17:49:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYhjE-0005jn-3E
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 17:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756832Ab0GMPs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 11:48:58 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36937 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457Ab0GMPs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 11:48:57 -0400
Received: by vws5 with SMTP id 5so5952117vws.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 08:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=TEYcOo2i9Cyctzuk8V18GwyFC7LhM8B/xFaNVaQGQY0=;
        b=FWr1l7xcOXP3FfPIzLiAxFjD89p+XqWx8oLfWuLkAQ7UOcWOWsGiqVOD8JDzzKZA83
         4vbT58s8R7guCBuC9LlPZEBQTIMp39PHbY/GUhAuFeaDCGggHZ/QIo/xQzVQPciuzXVV
         eyyRt2YUatYCOHrXbdZZD0TJFyi+q9CL5Frzg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=U1Y6V6ILlxN82iFQD9vBd0dPg5vpwFoz71lG8Ys0ARZe+SSJRYg5UUQykwRYulL2EQ
         vT7EV+YfXNzPlchzjMZ7lIoNsEU3rk7bKB8lmDgudXhEO+K9CgyKNC4xo9MNCm1heS/c
         aaw4biqcXGSITJy5jRrekd7qrkOx6aDVZQjEg=
Received: by 10.220.124.66 with SMTP id t2mr7895457vcr.46.1279036136015; Tue, 
	13 Jul 2010 08:48:56 -0700 (PDT)
Received: by 10.220.186.132 with HTTP; Tue, 13 Jul 2010 08:48:55 -0700 (PDT)
In-Reply-To: <AANLkTikAcZa5J8XhKKJuDCHY3VMhSRzETv0ZQ34EcjMx@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150903>

On 7/13/10, Jay Soffian <jaysoffian@gmail.com> wrote:
> On Tue, Jul 13, 2010 at 10:54 AM, Daniel F <nanotube@gmail.com> wrote:
>> Apparently, git-am fails when the username is just one word.
>
> And is less than 3 characters.
>
> This is happening due to the get_sane_name check in mailinfo.c. The
> rules for a "sane" name are actually from Linus' original code. From
> 2744b23 (Start of early patch applicator tools for git., 2005-04-11):
>
> +static char *sanity_check(char *name, char *email)
> +{
> +       int len = strlen(name);
> +       if (len < 3 || len > 60)
> +               return email;
> +       if (strchr(name, '@') || strchr(name, '<') || strchr(name, '>'))
> +               return email;
> +       return name;
> +}
>
> You could add an option to mailinfo to disable the sanity check and
> then plumb that option into its various callers.
>

Ah yes, indeed... Well, is there any reason to even have that
length sanity check in the first place? If someone wants to be
identified with a nick of 1 or 2 chars, what's wrong with that?

I have approximately zero familiarity with various git internals,
so not sure if anything else depends on this length checkbeing there... But
if not, if it is essentially arbitrary... why add complexity with
extra options, instead of removing complexity by simply taking
out the minimum length check?

At any rate... seeing as how it is hard-coded at the moment,
I guess my immediate solution would be to discuss with my
patch submitter about choosing a longer nick :)

Thanks,
Daniel
