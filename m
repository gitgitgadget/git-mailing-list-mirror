From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] GSoC Change multiple if-else statements to be table-driven
Date: Mon, 17 Mar 2014 02:29:10 -0400
Message-ID: <CAPig+cSG0YsdTGWWyxWrg+s235qDe7Xr-jXT2mOkpvA6OaGWyg@mail.gmail.com>
References: <CAPig+cQu7D3AUghOSUOZBwf5+iHCPkxPbY1WuQmPJk1muCk7tQ@mail.gmail.com>
	<1394742059-7300-1-git-send-email-zhaox383@umn.edu>
	<CAPig+cRF_eQiGugR8TSks5ki375y-5wiQ7HWKyKRudJ5apd4cg@mail.gmail.com>
	<xmqqiorghgaj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yao Zhao <zhaox383@umn.edu>, Git List <git@vger.kernel.org>,
	Adam <adam@sigterm.info>, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 07:29:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPR3K-0001Eh-KL
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 07:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbaCQG3N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Mar 2014 02:29:13 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:63317 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbaCQG3L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Mar 2014 02:29:11 -0400
Received: by mail-yk0-f177.google.com with SMTP id q200so13940510ykb.8
        for <git@vger.kernel.org>; Sun, 16 Mar 2014 23:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=Xn76ahTNnKbHouT+OspX/lOYx7JOWlvJCOXVi5jiX1c=;
        b=l8ErzoBpCzZHJEgtFKzXW2ixwwSTiPa+JWwIrP0XPdbM5OYkhduykWjpiKgvIc26Y9
         ZtoX2jKCotvwsNJiqo+8FNhh4CBYGK/NOFLqs+hxI9M9abZAN086DY87V7WkmmCT65DA
         Lxewtbq0u73GyjN7P5++p1rBhZO7GhQ3c8AI7brE+pQUQDCXQGuDAVD9Zop+OPgulkkk
         Pvp8wbIx4Atek0HmQdbDpdthJRpYwXsEM9FaNuKlT7ZLdhBbFNFWOlPVo39OGepUDAIZ
         uo0Ys2D3aXa+k9NWoyCF6Iw0D5SI3pZ8OG1jF9pNqu2k+ooPnJFr925JCmbkme/osadm
         G8pQ==
X-Received: by 10.236.65.72 with SMTP id e48mr1898348yhd.17.1395037750895;
 Sun, 16 Mar 2014 23:29:10 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Sun, 16 Mar 2014 23:29:10 -0700 (PDT)
In-Reply-To: <xmqqiorghgaj.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: hNDdjgShKJ-NmGRjAYxhCdTOFjU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244220>

On Fri, Mar 14, 2014 at 12:54 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Thu, Mar 13, 2014 at 4:20 PM, Yao Zhao <zhaox383@umn.edu> wrote:
>>> Subject: [PATCH] GSoC Change multiple if-else statements to be tabl=
e-driven
>>
>> It's a good idea to let reviewers know that this is attempt 2. Do so
>> by saying [PATCH v2]. Your next one will be [PATCH v3]. The -v optio=
n
>> for "git format-email" can help.
>
> Yao, I think Eric meant "git format-patch".

Correct. Sorry for the confusion.

>> An alternate approach might be to use a multi-dimensional array,
>> where the boolean values of rebasing, remote_is_branch, and origin
>> are keys into the array. This would allow you to pick out the
>> correct PRINT_LIST entry directly (no looping), thus eliminating
>> the need for those b_rebasing, b_remote_is_branch, and b_origin
>> members.
>
> Correct.
>
> After seeing so many "table driven" submissions, I however tend to
> agree with your earlier comment on another thread on this same
> micro, where you said an nested if-else cascade that was rewritten
> in a clearer way (sorry, I do not remember whose submission it was

It was Adam NoLastName [1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/243704

> offhand) may be the best answer to the "Would it make sense to make
> the code table-driven?" question, even though I tentatively queued
> d7ea7894 (install_branch_config(): simplify verbose messages logic,
> 2014-03-13) from Pawe=C5=82 on 'pu'.

Perhaps it is time to mark this microproject as "taken" on the GSoC
page [2], along a fews others for which we have received multiple
submissions.

[2]: https://github.com/git/git.github.io/blob/master/SoC-2014-Micropro=
jects.md
