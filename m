From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 7/7] gitweb: group remote heads
Date: Mon, 20 Sep 2010 11:38:03 +0200
Message-ID: <AANLkTi=20gzw8DOuT=NWRqbt86AyJDEPxoo-V9A3Rvim@mail.gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com>
 <201009200102.22960.jnareb@gmail.com> <AANLkTim0X-3PFccXTjH3Mo5eEHL+7zBcifqHu9hWp_RP@mail.gmail.com>
 <201009201059.07742.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 11:38:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxcpR-0001HM-DE
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 11:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756119Ab0ITJiY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Sep 2010 05:38:24 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40901 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754485Ab0ITJiY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 05:38:24 -0400
Received: by iwn5 with SMTP id 5so4132568iwn.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 02:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=x3wjRU/f4XbaJflJmf+Hk4GB6JYaecntnsFI/F9Sbuo=;
        b=k6stgrECaxvER0mLp2BfyhzH639z0hhsvJp/XUduaNz4tMK/XHATdSsqL5n2I+JE0L
         P8X1jlF0G8uRbTHGsfRaNx19he5zH3HDLUqVkVSUsCo0jBg6WqbMCNbwtgE+cHXk9n7W
         XKSlAglA0Ec9iaJ0BbKFqVQrDzE/hxOHzPfXo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=xhbBJaa4ucgVJ/k5i2T/YK3fWANzDrHrneY/9yFfmk/xMdajNTt449yWLt6HM/BAs4
         EsGfuaSwPF8ZcOcUGwLFd199ttSNQkKlTjfyLLU3V2GcQqnomCRy/vSZPqlfbvH6tUQX
         zFMIMQznpRg10x85ZDhWIfWow+1xtDq/E62aQ=
Received: by 10.231.169.210 with SMTP id a18mr9994554ibz.5.1284975503327; Mon,
 20 Sep 2010 02:38:23 -0700 (PDT)
Received: by 10.231.150.202 with HTTP; Mon, 20 Sep 2010 02:38:03 -0700 (PDT)
In-Reply-To: <201009201059.07742.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156607>

On Mon, Sep 20, 2010 at 10:59 AM, Jakub Narebski <jnareb@gmail.com> wro=
te:
> Giuseppe Bilotta wrote:
>> On Mon, Sep 20, 2010 at 1:02 AM, Jakub Narebski <jnareb@gmail.com> w=
rote:
>> > The solution (1) i.e. limiting number of remote heads per remote, =
with
>> > or without limiting number of remotes behaves, as you wrote, most
>> > similarly to other components of 'summary' view. =A0On the other h=
and
>> > with large number of remotes, and large number of remote heads in =
those
>> > remotes it might be too large for a *summary* view.
>>
>> So you maintain that limiting the amount of data in summary view
>> should be primary wrt to limiting the amount of time?
>
> Well, what really affect gitweb performance is calling git commands, =
both
> because of fork overhead, and because it means disk access (and gitwe=
b
> performance from what I have heard is affected mainly by IO, and not =
CPU).
> With grouping (displaying remotes) the difference between displaying
> remote-tracking branches (or information from them) and not displayin=
g
> them is an argument to git-for-each-ref. =A0So I don't think it would
> affect performance much.

Getting the list of remote branches is, I would say, the most
IO-intensive operation. I'm not sure how much I/O it would do though,
even with a large number of remotes and heads. So maybe always gather
all the information is the way to go.

>> > The solution (3) i.e. displaying only list of remotes (perhaps lim=
ited
>> > to 15 remotes) is simple and fast to render. =A0On the other hand =
it offers
>> > least information and might be too little in the case of single re=
mote.
>>
>> If time spent processing is not an issue, we can retrieve the number
>> of heads for each remote and display that, for example. Or even play
>> with some more dynamic stuff like making each group collapsible,
>> starting with it collapsed and then display the content when the use=
r
>> hovers it with the mouse, for example.
>
> The dynamic stuff is IMHO a good idea... provided we can either do it
> without JavaScript, or we can ensure that browser supports JavaScript
> (see current hack used for turning 'blame' into 'blame_incremental'
> view in gitweb).

What I had in mind was something that is very easy to implement with CS=
S only.

> Yet another solution would be to display only abbreviated list of rem=
otes
> if its more of them than some threshold, and list remotes with abbrev=
iated
> list of remote-tracking branches if there are only a few remotes.

So something like this:

(1) if there are more than N remotes, only show N remote _names_ (no he=
ads)
(2) if there are no more than N remotes, show all remote names, each
with no more than M heads

(with N and M to be decided, e.g. the usual 16)

>> Yes, this is something I have to take into consideration. Skip
>> displaying them is probably the best idea (unless we have other ways
>> to gather information about them).
>
> Right.

=46or this, it would be nice to have `git remote show`, but even if I
sent a patch to this effect gitweb should probably be left able to
cope with older git versions not supporting it ...

> P.S. It is not necessary for this series, but I think we should think
> about "single remote" view... also because your code currently links
> to such views, which do not exist yet (remotes/<remote> in path_info:
> how it would be represented in CGI query format?).

Maybe pass the remote name as head parameter?

--=20
Giuseppe "Oblomov" Bilotta
