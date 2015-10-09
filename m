From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Reinstate the helpful message when `git pull --rebase` fails
Date: Fri, 09 Oct 2015 11:40:13 -0700
Message-ID: <xmqq4mhzq41e.fsf@gitster.mtv.corp.google.com>
References: <cover.1444336120.git.johannes.schindelin@gmx.de>
	<xmqq612grhg7.fsf@gitster.mtv.corp.google.com>
	<CACRoPnSPVMt+FtK6bwfa7Z3jBheTEkBnhU+B7qL8JrAsSmAmkQ@mail.gmail.com>
	<xmqqk2qvq570.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Brendan Forster <shiftkey@github.com>,
	Git List <git@vger.kernel.org>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 20:40:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zkcab-00009Q-1A
	for gcvg-git-2@plane.gmane.org; Fri, 09 Oct 2015 20:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754390AbbJISkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2015 14:40:16 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35445 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbbJISkO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2015 14:40:14 -0400
Received: by pabve7 with SMTP id ve7so35007859pab.2
        for <git@vger.kernel.org>; Fri, 09 Oct 2015 11:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=oX8bw4N3cjB07AP5fxnfIlinR4QQEHqhD2gUCS0wjsM=;
        b=VUly7lPmduce9lajbiY+HJ0MVjoH6hlfzy8L+l1t/puPbGjPPR9pZ/d1gtQXi6tY7t
         Tmgn/JwV53VyguWe4gG3Jx4kgW26PNOrMQWlJt5RLCBFW4oO1X5i6hcolkaKHP2BUjsY
         mdwYCb4D4T5TCqR/6fsrbHpUmBJ/WqNlX+zfP2N2YKwSmPw9dzuOSf7b0fdtEd6CWkIc
         o1ICT9QX+/PJzAz2LP7E3oXGBI9/y25cBeY9PK9ZxGi55hmkMaQo/9HOUpiZl3D/7cos
         o+BUwSd7mHA0csMYWIWeL6yMdLae+6OdvkN/I/bokZA6qbhvui3pIhEhnBuZdMTeHZMc
         Vkxg==
X-Received: by 10.66.219.227 with SMTP id pr3mr17162210pac.33.1444416014351;
        Fri, 09 Oct 2015 11:40:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:6d9f:e45b:5c65:e644])
        by smtp.gmail.com with ESMTPSA id gw3sm3798154pbc.46.2015.10.09.11.40.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 09 Oct 2015 11:40:13 -0700 (PDT)
In-Reply-To: <xmqqk2qvq570.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 09 Oct 2015 11:15:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279314>

Junio C Hamano <gitster@pobox.com> writes:

>> Instead, stepping back a bit, I wonder if we can extend coverage of
>> the helpful message to all die() calls when running git-am. We could
>> just install a die routine with set_die_routine() in builtin/am.c.
>> Then, should die() be called anywhere, the helpful error message will
>> be printed as well.
>
> That could certainly be a valid approach and may give us a better
> end result.  If it works, it could be a change that is localized
> with a lot less impact.

I looked at the codepath involved, and I do not think that is a
feasible way forward in this case.  It is not about a "helpful
message" at all.  You would have to do everything that is done in
the error codepath in your custom die routine, which does not make
much sense.

I think the most sensible regression fix as the first step at this
point is to call it as a separate process, just like the code calls
"apply" as a separate process for each patch.  Optimization can come
later when it is shown that it matters---we need to regain
correctness first.
