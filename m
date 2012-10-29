From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCHv2] git-status: show short sequencer state
Date: Mon, 29 Oct 2012 18:26:44 -0400
Message-ID: <CABURp0qBRvZQvnBbOraQ7c7DRg8v0TjnY+MOGYaWnWwjCqi23Q@mail.gmail.com>
References: <1351022574-27869-1-git-send-email-hordp@cisco.com>
 <1351022574-27869-2-git-send-email-hordp@cisco.com> <20121025092919.GG8390@sigill.intra.peff.net>
 <5089633C.8030307@cisco.com> <CABURp0o7b5aZV6jNM=DSweh-8zVgGppxVsXisAcoNk7TxHrdgQ@mail.gmail.com>
 <20121029214103.GD20513@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Phil Hord <hordp@cisco.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, konglu@minatec.inpg.fr,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 29 23:27:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSxnl-0001Ex-6O
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 23:27:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755416Ab2J2W1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 18:27:08 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:41536 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755159Ab2J2W1G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 18:27:06 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so4161182lag.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 15:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gvKL8yWDoFj75m4j35hLVevBYOr3Zk/iE6ZutZAjVrg=;
        b=Lnr+MsiaL1X6pY064qDH5XvyUYpxyIi8la59L01zpAwgiFZeizT/qXDettqWgLPzZ0
         1DHsvoDZRGUk1Vq33my72+PWndvbnkhrbz/83yI5sUXGqqia3xop3SCvofcQ62Lvt4oB
         eaQQBHN+GMkboDMX5YnyljKJ4O/zIdEzivctKTWdxbtOcFz43kSKkqeZ4NebNwTNYhW9
         qvkAkcz5LSONIMfj/dmmxYeGe8EuUQRS+fakBL5OO5ZK8607Rui3257sJj2ulfBJGDrk
         N/qdorygTLdKRIiUaKaiTR5NtoQjbf/9PTukvoBXZizUT/W3tMMgsEvPY73WEufcrdpQ
         HM1Q==
Received: by 10.112.27.70 with SMTP id r6mr12371278lbg.51.1351549625018; Mon,
 29 Oct 2012 15:27:05 -0700 (PDT)
Received: by 10.114.26.166 with HTTP; Mon, 29 Oct 2012 15:26:44 -0700 (PDT)
In-Reply-To: <20121029214103.GD20513@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208651>

On Mon, Oct 29, 2012 at 5:41 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Oct 29, 2012 at 02:05:14PM -0400, Phil Hord wrote:
>
>> I'm currently splitting this out into a series and reconsidering some
>> of it along the way.  I need some guidance.
>>
>> I want to support these two modes:
>>
>>   A.  'git status --short' with sequence tokens added:
>>        ## conflicted
>>        ## merge
>>        ?? untracked-workdir-file
>>        etc.
>>
>>   B.  Same as (A) but without workdir status:
>>        ## conflicted
>>        ## merge
>>
>> The user who wants 'A' would initiate it like this:
>>     git status --sequencer
>>   or
>>     git status -S
>>
>> How do I spell the options for 'B'?  I have come up with these three
>> possibilities:
>>     git --sequencer-only   # Another switch
>>     git --sequencer=only   # An OPTARG parser
>>     git -S -S           # like git-diff -C -C, an OPT_COUNTUP
>
> Might it be easier to spell 'A' as:
>
>   git status --short -S
>
> and B as:
>
>   git status -S
>
> this is sort of like how "-b" works (except you cannot currently ask for
> it separately, but arguably you could). If we have a proliferation of
> such options, then we might need config to help turn them on all the
> time (I'd guess people are probably already using aliases to do this).

I think I like this path.

I expect a common idiom to be 'git status -S --porcelain --null', and
both --porcelain and --null imply --short.  I think I can still do The
Right Thing, but the code is starting to spaghettify.  I'll take a
crack at it.

Thanks.

P
