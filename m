From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: possible bug in autocompletion
Date: Wed, 19 Sep 2012 20:16:22 +0200
Message-ID: <CAMP44s1Xvvs7g1quUEs2b43VciK2=Nt-AntJcwG0CPf6p8Xk_A@mail.gmail.com>
References: <BLU0-SMTP405CDB35308082B180185A6B4DB0@phx.gbl>
	<20120717121232.GA32571@sigill.intra.peff.net>
	<CAMP44s2X5-BUyLtkTqGMa6w5K6uT25YLEp+Q2TdVR_qCObOpeA@mail.gmail.com>
	<20120919174336.GA11699@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeroen Meijer <jjgmeijer@hotmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 19 20:16:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEOpJ-0001Ko-RB
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 20:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932892Ab2ISSQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 14:16:23 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:59117 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932868Ab2ISSQW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 14:16:22 -0400
Received: by oago6 with SMTP id o6so1360201oag.19
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 11:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=p6riwoxEgzcWVPF+WjyDrk8jT1NbFCjzy3i4T3wIxqE=;
        b=05WYYhj7GFTxY9EIn9NLAl+HWgf/xRLJj4kZ0e56D56C1GDF/f8a0YhF17Ya6SA8mS
         UK8HWmbLe8JymJt/ZUMABHQzO+jOUn0ey+d8Wxi4oT2/i25cxRtJPA7uhnmXrVO8sV+5
         LObDbDq1RQbGZ5gEWLMiCk4qmAqixnZP1ftrIJgun7YvQWSG6hJX3PzhW4sE8ooFQdX/
         wIYhpT2b/8vPaMWDlGgN0+U/vUuELqcM4A5OkYmVhZdgy+Qlu7NRho+tjupYhlPoYAJv
         vN7yRq/iCxLgYSzLw+RfQ33Ui0k6S3F7upbIc07WMWontos1ddNczTrhfkl4kupfjvxO
         /NKA==
Received: by 10.60.11.1 with SMTP id m1mr3589107oeb.47.1348078582170; Wed, 19
 Sep 2012 11:16:22 -0700 (PDT)
Received: by 10.60.164.7 with HTTP; Wed, 19 Sep 2012 11:16:22 -0700 (PDT)
In-Reply-To: <20120919174336.GA11699@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205967>

On Wed, Sep 19, 2012 at 7:43 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Sep 19, 2012 at 07:08:09PM +0200, Felipe Contreras wrote:
>
>> On Tue, Jul 17, 2012 at 2:12 PM, Jeff King <peff@peff.net> wrote:
>>
>> > --- a/contrib/completion/git-completion.bash
>> > +++ b/contrib/completion/git-completion.bash
>> > @@ -261,7 +261,12 @@ __gitcomp ()
>> >  __gitcomp_nl ()
>> >  {
>> >         local IFS=$'\n'
>> > -       COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}"))
>> > +       local words=$1
>> > +       words=${words//\\/\\\\}
>> > +       words=${words//\$/\\\$}
>> > +       words=${words//\'/\\\'}
>> > +       words=${words//\"/\\\"}
>> > +       COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$words" -- "${3-$cur}"))
>> >  }
>>
>> What about something like this?
>>
>> local words
>> printf -v words "%q" "$w"
>> COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$words" -- "${3-$cur}"))
>
> Thanks, I didn't know about bash's internal printf magic. That is a much
> more elegant solution.
>
> Care to wrap it up in a patch?

I'm trying to, but unfortunately "\n" gets converted to "\\n", so it
doesn't get separated to words. Any ideas?

-- 
Felipe Contreras
