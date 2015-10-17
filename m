From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git tag --contains now takes a long time
Date: Sat, 17 Oct 2015 14:28:44 -0700
Message-ID: <xmqq1tctchgz.fsf@gitster.mtv.corp.google.com>
References: <20151016220739.GF17700@cantor.redhat.com>
	<CAOLa=ZTDd3MSmqXArtNz8i5n=uj2NEB6UPk2jSnEhUsAqbr7nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jerry Snitselaar <jsnitsel@redhat.com>, Git <git@vger.kernel.org>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 17 23:28:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnZ22-0003DE-Q7
	for gcvg-git-2@plane.gmane.org; Sat, 17 Oct 2015 23:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbbJQV2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2015 17:28:47 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33565 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbbJQV2q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2015 17:28:46 -0400
Received: by pabrc13 with SMTP id rc13so152182759pab.0
        for <git@vger.kernel.org>; Sat, 17 Oct 2015 14:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=EMmLv89hEIZtTiAQ+WQCz9NgZ1huf9nmHUB9uE//tOM=;
        b=V2nw49AKwStQyo+AreNn1yEVw5nFKgg+RuTENvTyTyxtl42klPsiAJtdwmPw8bw42a
         fZ2fOgIGKnZWZ4HnAyYaj2Zagd+2lM5L5676xMmLLGsrR+1khMbOsUrT4w/sPxTkf1k2
         j1ZPrxsmJTNhrUbJ8SL+iKc+kH5pA3iksY8uDPRkKUV9bNbEXYLOvZASAPehQVjorj+6
         JVYfKUGIfvDNjiMiuYax9cdFNof1Bpp3dH8K2EJ88XzIAjugL2GkX+xBcMwQbgApslOQ
         0rbfpPGsoZCp4xhU4yXbcVHGIPPkyJ+1jg7bS9MSK4KgjU3L9kPKR0qn2wBmYLvpzE8E
         ikJw==
X-Received: by 10.66.62.198 with SMTP id a6mr7894770pas.42.1445117326122;
        Sat, 17 Oct 2015 14:28:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:305b:5af5:2c51:11cd])
        by smtp.gmail.com with ESMTPSA id ey17sm28478379pac.26.2015.10.17.14.28.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 17 Oct 2015 14:28:45 -0700 (PDT)
In-Reply-To: <CAOLa=ZTDd3MSmqXArtNz8i5n=uj2NEB6UPk2jSnEhUsAqbr7nQ@mail.gmail.com>
	(Karthik Nayak's message of "Sat, 17 Oct 2015 12:14:58 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279795>

Karthik Nayak <karthik.188@gmail.com> writes:

> So I did poke around a little. I think I missed this out on the
> original commit (b7cc53e92c806b73e14b03f60c17b7c29e52b4a4).
>
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 977a18c..2c5a9f1 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -49,6 +49,7 @@ static int list_tags(struct ref_filter *filter,
> struct ref_sorting *sorting)
>                 format = "%(refname:short)";
>
>         verify_ref_format(format);
> +       filter->with_commit_tag_algo = 1;
>         filter_refs(&array, filter, FILTER_REFS_TAGS);
>         ref_array_sort(sorting, &array);
> ...
>
> Could you Squash that in, Junio?

Do we have two implementations that are supposed to compute the same
thing, and with the bit set to 1, the faster of these two is used?
Is there a reason somebody may want to use the slower one?  What
difference other than performance does the choice of this bit makes,
and why?

I think the answers to the above questions deserve to be in the log
message (no, I do not think I can "squash it in", rewriting the
commit that has already been merged to 'next' and 'master').

Thanks.
