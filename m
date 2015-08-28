From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 7/9] fetch: fetch submodules in parallel
Date: Fri, 28 Aug 2015 10:45:11 -0700
Message-ID: <CAGZ79kYWJ89MuU4iJH=Mvr_jH72d+EM0hCeDhfpQuapYQH0Nkg@mail.gmail.com>
References: <1440724495-708-1-git-send-email-sbeller@google.com>
	<1440724495-708-8-git-send-email-sbeller@google.com>
	<CAGZ79kbTAVDVmw+MrXvky6tJWZcG97tT_KAxV7S-pKCiNqRp3g@mail.gmail.com>
	<20150828170141.GB8165@google.com>
	<xmqqfv332v84.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 19:45:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVNiY-0005qo-0Z
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 19:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752511AbbH1RpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 13:45:14 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:34395 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbbH1RpM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 13:45:12 -0400
Received: by ykba134 with SMTP id a134so9757398ykb.1
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 10:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UXcY9k+9miiU7hgtS+9+nh8lyvrWqwT7+bXFTqKtFE0=;
        b=iM/QIpAbOLQj/xRqu5/CpmRFrKk9wAbbNoB96ejhNTDbxTHFsfijKxbsvvd25SjzCk
         WEB+Uu/xsXPBJifsLgu0rI6tfd5Mz44W16fYUMc7Uk7Ciesql+PwxSBdyvCsoWvF/nE1
         VWBDIyALqOJehlPyvXPBlY91vxQ3XvSDd2MDeJ81OBqodm0mEtQQ6n5jR48nCcEzo1fb
         uA+RSV2lrpaQgT0oo4XubRKo2qJbKALi/fvwk+dZBOrvButTEAKPnfvMRPYp6w2GSCrv
         0nWUAYfavc8mPt/kbY63JwCqptqGw+pxDVTG/gJnQjyX/qgy1hCDRV5dBXgSYbbsnJG7
         ybGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=UXcY9k+9miiU7hgtS+9+nh8lyvrWqwT7+bXFTqKtFE0=;
        b=AkJNY6sj56oRd1psIeo9DSOYv8E/lrpKX55wTpRhwA+9xOo0zvElzRRotRJaDzVrpN
         XgIYvf66+Ysem7nXp5k61fGXVT1jAKARgvoYa+BsuAgqp9ID7Thbmk/MppeQCHyfaLg6
         pGAoxhSRQs1HfAz7Ju2iKQ44uYzgn1vwOCiYIYGD3HCvUNjrb9rnkwN7cCV4j9vcVaDa
         FHMhGaqrtnL6NnkwIjfEYS59CxCuwUIaJ+cq4V2JszqJmpCv9f+a425VGxvndrawE7IV
         jo8tva0DEy3xFtOqQtArJpZY7O9FSqBu/Ba3eWIs5XueLZ2x7Q72CIxiW877LBKXRkxA
         ZYjw==
X-Gm-Message-State: ALoCoQmCVm+1P5CsMhuHqGiKsOWtqPsnqkc5djnuut6JKQmFhTEGOJu4oVzIFcXPNLtD06hDtdxq
X-Received: by 10.129.16.212 with SMTP id 203mr9516914ywq.142.1440783911838;
 Fri, 28 Aug 2015 10:45:11 -0700 (PDT)
Received: by 10.37.21.132 with HTTP; Fri, 28 Aug 2015 10:45:11 -0700 (PDT)
In-Reply-To: <xmqqfv332v84.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276740>

On Fri, Aug 28, 2015 at 10:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Stefan Beller wrote:
>>> On Thu, Aug 27, 2015 at 6:14 PM, Stefan Beller <sbeller@google.com> wrote:
>>
>>>> This makes use of the new task queue and the syncing feature of
>>>> run-command to fetch a number of submodules at the same time.
>>>>
>>>> The output will look like it would have been run sequential,
>>>> but faster.
>>>
>>> And it breaks the tests t5526-fetch-submodules.sh as the output is done
>>> on stderr only, instead of putting "Fetching submodule <submodule-path>
>>> to stdout. :(
>>>
>>> I guess combining stdout and stderr is not a good strategy after all now.
>>
>> IMHO the "Fetching submodule <submodule-path>" output always should have
>> gone to stderr.  It is not output that scripts would be relying on ---
>> it is just progress output.
>>
>> So a preliminary patch doing that (and updating tests) would make sense
>> to me.
>
> Sounds good.
>
> I personally do not think the "we still do all the output from a
> single process while blocking output from others" buffering
> implemented in this n-th round (by the way, please use [PATCH v$n
> N/M]) is worth doing, though.  It does not make the output machine
> parseable, because the reader does not get any signal in what order
> output of these subprocesses arrive anyway.

> The payload does not
> even have "here is the beginning of output from the process that
> handled the submodule X" to delimit them.

Oh it does, but it is not handled by the buffering code, but the application
code, so for git-fetch we would have "Fetching submodule <path> "
while for git submodule foreach we would have "Entering <submodule path>"

>
> My preference is still (1) leave standard error output all connected
> to the same fd without multiplexing, and (2) line buffer standard
> output so that the output is at least readable as a text, in a
> similar way a log of an irc channel where everybody is talking at
> the same time.

In case of fetch passing the quiet flag becomes mandatory then,
because the the per-repo progress is put to stderr, which
also deletes previous output, to have the nice counters.
