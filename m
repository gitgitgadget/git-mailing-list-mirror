From: Jaime Soriano Pastor <jsorianopastor@gmail.com>
Subject: Re: [PATCH 1/2] Check order when reading index
Date: Mon, 25 Aug 2014 22:26:49 +0200
Message-ID: <CAPuZ2NGy7VSW0ibfXwqAndJbDcnByDMJzNZrrLDYt8vDfYPYTg@mail.gmail.com>
References: <xmqq38cpsmli.fsf@gitster.dls.corp.google.com>
	<1408903047-8302-1-git-send-email-jsorianopastor@gmail.com>
	<xmqqvbpgmqmh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 25 22:26:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XM0qs-0006aG-IU
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 22:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756495AbaHYU0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 16:26:51 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:40710 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754873AbaHYU0u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 16:26:50 -0400
Received: by mail-pa0-f53.google.com with SMTP id rd3so21855417pab.12
        for <git@vger.kernel.org>; Mon, 25 Aug 2014 13:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=Idk3t6ufv5W9ZwM2yN8tAHbZvkd+p9JZwF41vRAE9o4=;
        b=O0YElDLQyzXfpTcWF6FrIdb7ko7sbkrG3ite3Js2VA5KPLg547p5n60ZpiDfZQA/T/
         RuPSiGMWwvytCBKW4NIX/JMAHyLLRb73isHWhtZkapop1A7xsQIo7d7xdncZpZfPjP7B
         q/ej8gAiZqpDo/Xdoc46OEVoraFXVRdORKKhPs0CXeOttNJSK0Z1MTaZac05+H1typg9
         B7MH97NOFhHpFxM1Vpnv0eYYquWU9SjBupW9XubW0LjHM89XqFhnz1hjpyPvT6EKXGeV
         RN4hP4P5/gnt+uvZwdkLPZpW5ao7RE1tUHiJTxBPD1YwScqKdKup3F/KsCDJjKL0ssFu
         bi6g==
X-Received: by 10.70.56.101 with SMTP id z5mr1872437pdp.47.1408998410056; Mon,
 25 Aug 2014 13:26:50 -0700 (PDT)
Received: by 10.70.37.2 with HTTP; Mon, 25 Aug 2014 13:26:49 -0700 (PDT)
In-Reply-To: <xmqqvbpgmqmh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255863>

On Mon, Aug 25, 2014 at 7:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jaime Soriano Pastor <jsorianopastor@gmail.com> writes:
>
>> Subject: Re: [PATCH 1/2] Check order when reading index
>
> Please be careful when crafting the commit title.  This single line
> will be the only one that readers will have to identify the change
> among hundreds of entries in "git shortlog" output when trying to
> see what kind of change went into the project during the given
> period.  Something like:
>
>     read_index_from(): catch out of order entries while reading an index file
>
> perhaps?
>
Ok, reprashing it.

>> +void check_ce_order(struct cache_entry *ce, struct cache_entry *next_ce)
>
> Does this have to be global, i.e. not "static void ..."?
>
Not really, changing it to static.

>> +             if (ce_stage(ce) >= ce_stage(next_ce))
>> +                     die("Unordered stage entries for '%s'",
>> +                             ce->name);
>
> Not quite.  We do allow multiple higher stage entries; having two or
> more stage #1 entries is perfectly fine during a merge resolution,
> and both ce and next_ce may be pointing at the stage #1 entries of
> the same path.  Replacing the comparison with ">" is sufficient, I
> think.
>
Ok, but like Jeff, I'm also curious about how to have multiple stage
#1 entries for the same path.

Thanks.
