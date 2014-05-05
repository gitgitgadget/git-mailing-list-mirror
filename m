From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 0/3] Use ref transactions for fetch
Date: Mon, 5 May 2014 08:08:43 -0700
Message-ID: <CAL=YDWmG8Q0kk+4fc6C15Ai2cTr-K8bNn--J7MrjNnHVuW44jg@mail.gmail.com>
References: <1398192327-21302-1-git-send-email-sahlberg@google.com>
	<53677483.4050409@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 06 18:42:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whi3K-0006KZ-AK
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933099AbaEEPIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 11:08:44 -0400
Received: from mail-vc0-f176.google.com ([209.85.220.176]:63252 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932842AbaEEPIn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 11:08:43 -0400
Received: by mail-vc0-f176.google.com with SMTP id lg15so6022851vcb.35
        for <git@vger.kernel.org>; Mon, 05 May 2014 08:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qi/w6mlLVNziKvD3pjciEsAsCjzVPyPj+KbnJvPXM5g=;
        b=A5Y08ZNfnHHcPtFtddN0vnyIJeykDI+Gn4ajwM9g0B2Ksn0uVapEEgFaSYn5B6EOmV
         qumggGJBrBGM3w6YwHB+IdBRHuQHLLuf3Wcihjwwmzk+tqqjSLjUMx4bnBSZWZhNYe3w
         nALiWeWE/qlH4vZqicdFhQaasV05GtFKOtMdrXA3Io0PtXIsfgeu7Jxt1iWsCreFmbPV
         Ve/vcQrajazsoZShFMdEZJM2odMu2f4W3r5/kDd7si/n1E1dxp77O++Z3uFXIb+NQMeB
         82YqTCZARLftXEtKaLEsQSUkEI7cW3rcsQG2BZmqrhj7cWiFPy12qJgsdTQcSP+7hKf0
         dOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=qi/w6mlLVNziKvD3pjciEsAsCjzVPyPj+KbnJvPXM5g=;
        b=li6oS8zV/frrXlbWMA2hbpGDo9trTGtdwB9CZnot7hiPdgdxl7tAjTilKyoNPQamgs
         qjHUDSOGQ41YC2kK75EjDSUOj4Aj4BuzDZ0WgDR16bDfhLwScoOuYZshNcWMOHy7VU8f
         aZWZYPNRrRrWRSxsPRrh4JnHO0n0Q9DN3ty7jlK/YbBG+7QFep6jLG9mvLc6aZsroq/S
         QW0KvAWCxMcaPg4iHYSM5NTuoORat8wGwdzoXgU7nCkWuQFdjBvxc+Z8fW4XV4XACaPF
         i18lBv7HCZULzd/2U8try5ao8Smixvivqx5egL2BvSaIBZSNOXadbD7qS8fpheWISkow
         3ing==
X-Gm-Message-State: ALoCoQk03/0ctWZFSNUsyUp7UoIEoh/DQBqu5bnvQULU1xjCRif1bOdhK4lrTTWTlSqIGmS3JSe9
X-Received: by 10.52.0.176 with SMTP id 16mr541305vdf.60.1399302523112; Mon,
 05 May 2014 08:08:43 -0700 (PDT)
Received: by 10.52.0.139 with HTTP; Mon, 5 May 2014 08:08:43 -0700 (PDT)
In-Reply-To: <53677483.4050409@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248150>

On Mon, May 5, 2014 at 4:22 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 04/22/2014 08:45 PM, Ronnie Sahlberg wrote:
>> This change is based on the previous ref transaction patches.
>> This is sent as a separate patch series since it implements a lot more
>> non-trivial changes to the behaviour than the previous patches and thus can
>> use more detailed review.
>>
>> Update fetch.c to use ref transactions when performing updates. Use a single
>> ref transaction for all updates and only commit the transaction if all other
>> checks and oeprations have been successful. This makes the ref updates during
>> a fetch (mostly) atomic.
>
> Is this always an improvement?  What kind of checks are there that might
> fail?
>
> It would be pretty annoying to spend a lot of time fetching a big pack,
> only to have the fetch fail because one reference out of many couldn't
> be updated.  This would force the user to download the entire pack
> again, whereas if the successful reference updates had been allowed,
> then probably most or all of the second download would have been avoidable.
>
> On the other hand, if a reference was renamed on the remote side,
> allowing a partial reference update could cause history to be discarded
> locally if the old name's delete was accepted but the new name's
> addition was rejected.  This wouldn't be the end of the world, because
> the history is presumably still available remotely to fetch again, but
> it's not ideal either.
>
> I'm not sure myself what I would prefer, but I wanted to point out that
> it is IMO not obvious that atomicity here is an improvement.
>

We could make it a .git/config option ?
