From: Nathan Bullock <nathanbullock@gmail.com>
Subject: Re: Autocompletion - commands no longer work as stand alone
Date: Mon, 30 Jan 2012 07:00:23 -0500
Message-ID: <CAPx=Vfo20wWKOTeeKc=WM9dOpm85enTZHJsTnBL5uh8v0r6PRQ@mail.gmail.com>
References: <CAPx=Vfp_HVr5W1fFic_1k+JsKr2RAKd-RK=VkfSgo7qkb5GsAw@mail.gmail.com>
	<CAPx=Vfqj3UZuFv3Xmupy7k9arUxyZJyprm628p9QVKabdOz8cw@mail.gmail.com>
	<7vwr8mdvo8.fsf@alter.siamese.dyndns.org>
	<20120124232658.GD2256@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Jan 30 13:00:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrpuP-0006cS-DX
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 13:00:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632Ab2A3MAZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jan 2012 07:00:25 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:58591 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752605Ab2A3MAY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 07:00:24 -0500
Received: by obcva7 with SMTP id va7so3805382obc.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 04:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=tEI0FPWJJeoI7ksQo4TjJc14NCHVP3lDrWrba/SAZR8=;
        b=vV18FBvQWRGUFfrFH95hj4UCck5M3+djtrz1Q8JBzIqQN+Xkxhb2BmOCpZVPYy0GG0
         by2CLlFK7XidAebB1JZRcRDjJpz07EJd6Kzq+jouTnyYJvE+9a9ngG959xITCow0OJOL
         h27byjZd9QK8hat/obolOAVyPjPo7oSR4I2MQ=
Received: by 10.182.38.70 with SMTP id e6mr28358027obk.13.1327924823631; Mon,
 30 Jan 2012 04:00:23 -0800 (PST)
Received: by 10.60.43.170 with HTTP; Mon, 30 Jan 2012 04:00:23 -0800 (PST)
In-Reply-To: <20120124232658.GD2256@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189355>

2012/1/24 SZEDER G=E1bor <szeder@ira.uka.de>:
> Hi,
>
>
>> Nathan Bullock <nathanbullock@gmail.com> writes:
>>
>> > I have for a number of years had the following in my .bashrc
>> >
>> > alias br=3D"git branch"
>> > complete -F _git_branch br
>> >
>> > As well as similar commands for co and log.
>> >
>> > Recently though this broke, now when I type something like "br
>> > mas<command completion>" it will occasionally complain with messag=
es
>> > like:
>> > bash: [: 1: unary operator expected
>> >
>> > From digging through the source it looks like this was broken back=
 in
>> > April. (The commit is show at the bottom of this email.)
>> >
>> > So my questions are:
>> > 1. Is it reasonable for things like _git_branch to work as a
>> > standalone autocompletion function instead of having to go through
>> > _git? I certainly like it to work as a standalone function. I also=
 use
>> > it to add autocompletion to other bash scripts that I use frequent=
ly.
>> >
>> > 2. If I add code that verifies that the variable cword exists at t=
he
>> > start of these functions and only if not call something like
>> > _get_comp_words_by_ref -n =3D: cur words cword prev. Would that be
>> > reasonable?
>
> That would be too fragile, it will break if $cword is set in the
> environment from which you invoke _git_<cmd>() completion functions
> directly (i.e. not though _git()).
>
>> > I think this should address the performance concerns that
>> > caused these to be removed in the first place, but it may make the
>> > code uglier.
>
> Actually it was not a performance problem, but a cleanup in a patch
> series to fix a zsh-related bug. =A0Without this cleanup the bugfix
> would have been much more intrusive.
>
> =A0http://thread.gmane.org/gmane.comp.version-control.git/172142/focu=
s=3D172369
>
>
>> > I have already added wrapper functions in my bashrc so that this i=
s no
>> > longer a problem for me, but there may be other people who start
>> > hitting this as well once they start using newer versions of git.
>
> This issue was reported earlier, so it seems there are people who
> would like to use it. =A0But getting $cur, $cword, etc. variables rig=
ht
> in _git_<cmd>() completion functions is just part of the problem,
> there are other issues, as mentioned in the previous thread:
>
> =A0http://thread.gmane.org/gmane.comp.version-control.git/185184/focu=
s=3D185232
>
> Unfortunately, I couldn't come up with a solution yet that doesn't
> introduce too much code churn and doesn't cause yet another
> inconsistency between bash and zsh. =A0I also haven't looked whether
> there are other issues similar to that with _git_fetch() mentioned on
> the above link.

At the end of this thread that you refer to,
http://thread.gmane.org/gmane.comp.version-control.git/185184/focus=3D1=
85232,
there is a set of wrapper functions that look reasonably good for
solving this problem. There was a question if those could be included
in the main git code base. Do you know if that is likely to happen?

Nathan
