From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] merge: refuse to create too cool a merge by default
Date: Fri, 18 Mar 2016 17:00:27 -0400
Message-ID: <CAPig+cRN_3kP8+w2inG+hm_81AXLVx6CFER+MPr_oenDqEdEug@mail.gmail.com>
References: <xmqqshznpmfe.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 22:00:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah1Vj-0006ZR-HY
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 22:00:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757719AbcCRVAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 17:00:32 -0400
Received: from mail-vk0-f47.google.com ([209.85.213.47]:34913 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757708AbcCRVA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 17:00:28 -0400
Received: by mail-vk0-f47.google.com with SMTP id e6so156484415vkh.2
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 14:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=8KPdFaWBt9vTrHfGDF42v4P1SJNA6lGkPzol3PFHKjA=;
        b=YE1DwBTrjte8/qA0hnRWgQbq7+L84DUXv4WUcLIbmFwpdU0CEKIE5/x2R8/gIIWhU8
         DzVUijPhCs7a/AGUqQft4e0mJaautJ+fnHb7Z/H/szw9trKH1Q5ACIM21Yy/YdfweOnQ
         Mvpo7CJ+5jtqZ1uhr8FAXcYrQtVTaAu/SbOmqeRTT+CSQQ1zdMebmg0DTdFIJIR3BVb7
         r9xQXc3K+4oMAFdsUjl+lLw7YoufGCjEOay8u4gn/Z/F3m1rqPFAlhElV3oJZlPOAjF+
         CcqCJPrNoIZg5jzzNRKDEWL6NEdI9YyEnx3ocplB0D+eF3eBEo1zLPU8q1TWfruGGf5n
         xfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=8KPdFaWBt9vTrHfGDF42v4P1SJNA6lGkPzol3PFHKjA=;
        b=GNfKpiyZqCfOEUHKKGySQx3m9lEtu5QZbW+10MKSc24YjwXa4OJVyvgoN34JDj6Qw5
         rf9XJEFp1CZ7O4d3sYUv15PH+v6WrznC/E8OefgEemocb5IOdT05vbE1/CidYWGQ6pBN
         gfhvtgqrUPwUzsOKoiu5T3jX3Pw6FAAsPnJlqwGXvboyj3ykPC0dFdvYek2EUlzkl+cP
         35pg+BL1ugD89PlvXMaV7BwPzSqLefWxRrgY3mDOHbS7Dc5EJBuxPOllTmOe/ms5u4zp
         o8gYD6+vtqmbWhCzUa36+znEtqJ5JuyAg0MiiYjYXyj8SowAdcqiew4I8qhGIK3ZrxrL
         PjxQ==
X-Gm-Message-State: AD7BkJIyPGc9VB1FNHnz5F6w9gIdFlZ28o1Z6lqfeO/+u4ioVyfnXAp4HZyH3Jo3VDV2Eyd+sMMgEf5z8c+YOA==
X-Received: by 10.31.47.135 with SMTP id v129mr19597707vkv.115.1458334827348;
 Fri, 18 Mar 2016 14:00:27 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Fri, 18 Mar 2016 14:00:27 -0700 (PDT)
In-Reply-To: <xmqqshznpmfe.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: rKn1aJFolGu4Tx6AKQIpUlB52T0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289251>

On Fri, Mar 18, 2016 at 4:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> While it makes sense to allow merging unrelated histories of two
> projects that started independently into one, in the way "gitk" was
> merged to "git" itself aka "the coolest merge ever", such a merge is
> still an unusual event.  Worse, if somebody creates an independent
> history by starting from a tarball of an established project and
> sends a pull request to the original project, "git merge" however
> happily creates such a merge without any sign of something unusual
> is happening.
>
> Teach "git merge" to refuse to create such a merge by default,
> unless the user passes a new "--allow-unrelated-histories" option to
> tell it that the user is aware that two unrelated projects are
> merged.
> [...]
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> @@ -279,9 +280,10 @@ test_expect_success 'clone shallow depth count' '
>  test_expect_success 'clone shallow object count' '
>         (
>                 cd shallow &&
> +               git prune &&
>                 git count-objects -v
>         ) > count.shallow &&
> -       grep "^count: 55" count.shallow
> +       grep "^count: 54" count.shallow
>  '

Um, wasn't this change the subject of a separate patch[1]?

[1]: http://article.gmane.org/gmane.comp.version-control.git/289246
