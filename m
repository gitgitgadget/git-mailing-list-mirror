From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 33/67] read_branches_file: replace strcpy with xstrdup
Date: Thu, 17 Sep 2015 08:38:32 -0700
Message-ID: <xmqq7fnpkqdj.fsf@gitster.mtv.corp.google.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915154950.GG29753@sigill.intra.peff.net>
	<xmqqlhc6p2f9.fsf@gitster.mtv.corp.google.com>
	<20150916204226.GE3915@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 17 17:38:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcbGh-0003cq-Pm
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 17:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbbIQPif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 11:38:35 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36200 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbbIQPie (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 11:38:34 -0400
Received: by padhk3 with SMTP id hk3so22770161pad.3
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 08:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=0jFG7IMOqaSQizpfX+MTJzIyuU2Vt0LmMMARniMxERc=;
        b=K9SAuwYMlbGltEQG6VlOTefainnnM9cji5JMuCRlpThGevjr2/SPvBN6IPPCjMNojw
         7A+ySKD+ajv9WNUFQazgXsNPThxKQmvkcY9G7fpgFKy0Fr39DsYP1g3nB6LMNFPDVPHC
         /tD31yUB93FGgQduMIg3owYKJXDyIecY3j75MRQpSBe0+nuUEHg8hDQbgY48bwGyPQti
         b33PsyxRG9dPR7128KqHwtTGoPOUhTb8IJU9tOlNxarX8tHzGB8lXerJsya1DdkCnzn+
         lkdaQX/VlTJhafLE4m0jVOT/Lvv1JqgS3P9pMDftKOBZFToFmo/YVGjBolnH1ZdZADJz
         r5aQ==
X-Received: by 10.68.166.97 with SMTP id zf1mr73033334pbb.72.1442504313822;
        Thu, 17 Sep 2015 08:38:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:25ac:307e:6383:2d03])
        by smtp.gmail.com with ESMTPSA id lo10sm4165381pab.16.2015.09.17.08.38.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 17 Sep 2015 08:38:33 -0700 (PDT)
In-Reply-To: <20150916204226.GE3915@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 16 Sep 2015 16:42:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278123>

Jeff King <peff@peff.net> writes:

> On Wed, Sep 16, 2015 at 12:52:26PM -0700, Junio C Hamano wrote:
>
>> > diff --git a/remote.c b/remote.c
>> > index 5ab0f7f..1b69751 100644
>> > --- a/remote.c
>> > +++ b/remote.c
>> > @@ -297,7 +297,6 @@ static void read_branches_file(struct remote *remote)
>> >  	int n = 1000;
>> >  	FILE *f = fopen(git_path("branches/%.*s", n, remote->name), "r");
>> >  	char *s, *p;
>> > -	int len;
>> 
>> Hmm, we would punish those with ridiculously long remote name by
>> truncating at n but that is OK.
>
> Yeah, though that is nothing new.
>
> In some of the cases, as you've seen, I dug further in cleaning things
> up. But in others I did the minimal fix (especially in this case, the
> limitations are only about the deprecated "branches" and "remotes"
> file), mostly to try to keep the scope of work sane.

That is sensible.  As long as the result of conversion is easier to
audit (which is the primary focus of this series), I'd agree that we
should stop there, instead of making further changes.

The last thing we would want to do is to change the behaviour,
especially to unintentionally start rejecting what we have always
accepted, while doing a "code clean-up".  Letting these sleeping
dogs lie is the safest.  That various distros lag behind our release
schedule means that we may not hear about regression until a year
after we break it for a feature used by minority of users.

Thanks.
