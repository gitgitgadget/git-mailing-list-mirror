From: demerphq <demerphq@gmail.com>
Subject: Re: [PATCH] git remote update: New option --prune (-p)
Date: Thu, 2 Apr 2009 18:07:33 +0200
Message-ID: <9b18b3110904020907i23f246aelccc2a0770acc2574@mail.gmail.com>
References: <20090402123823.GA1756@pvv.org>
	 <9b18b3110904020634i17633645ue4ba91701ea243a1@mail.gmail.com>
	 <20090402134414.GB26699@coredump.intra.peff.net>
	 <9b18b3110904020717h3a0d4b34h7f4b2b83527e6743@mail.gmail.com>
	 <20090402143112.GA26974@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 02 18:09:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpPTy-0003W6-AS
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 18:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758793AbZDBQHi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Apr 2009 12:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758667AbZDBQHh
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 12:07:37 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:48992 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001AbZDBQHg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Apr 2009 12:07:36 -0400
Received: by qyk16 with SMTP id 16so1178500qyk.33
        for <git@vger.kernel.org>; Thu, 02 Apr 2009 09:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=McA/QcA9oyrXUhWITyK3ZIX9kJJkYZrGBCsp70DT3gA=;
        b=vRL8TGGTp6CtAC+SyQ0KpuCRZqWlgHZql8DRnVgEWxamDVCfWY6POoxG7HfQH1F4I9
         DNNF9Zzstd0LXhUOXtSulmES5Lz7/6+KOFuPa5HpByXxspY+f1qVm5q/gfNvHCD4/ZsI
         0ObMETrMQu0InD2HtacLCQL50QinkFGdimUqc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=e4Iym/NIwb9YfaVMcGMnkRQi9TKJr//XxvDARHFIWuEWGgEooy+3Hw1KHQdj3gonYl
         UC5CZQhSyoyXXCuQowAcvYPlBYIxCFpVQLRK/u09vX2p+khKorlQr4NUw9NzojIIiVxl
         74x9hVCCShdJNgSKiC6luCc0Z4fuw9R1Bxazc=
Received: by 10.231.15.74 with SMTP id j10mr69844iba.10.1238688453333; Thu, 02 
	Apr 2009 09:07:33 -0700 (PDT)
In-Reply-To: <20090402143112.GA26974@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115474>

2009/4/2 Jeff King <peff@peff.net>:
> On Thu, Apr 02, 2009 at 04:17:35PM +0200, demerphq wrote:
>
>> > But "git remote update" actually respects "remote groups", so it i=
s not
>> > just "--all". I think what you want is "git remote prune <group>".
>>
>> Are there any implicit groups defined, like "all-remotes" or
>> something? It seems less than desirable to have to define such a gro=
up
>> for an operation that IMO is pretty reasonable to expect to happen
>> regularly.
>
> Yes. From "git help remote":
>
> =A0 =A0 =A0 update
> =A0 =A0 =A0 =A0 =A0 Fetch updates for a named set of remotes in the r=
epository as
> =A0 =A0 =A0 =A0 =A0 defined by remotes.<group>. If a named group is n=
ot specified on
> =A0 =A0 =A0 =A0 =A0 the command line, the configuration parameter rem=
otes.default will
> =A0 =A0 =A0 =A0 =A0 get used; if remotes.default is not defined, all =
remotes which do
> =A0 =A0 =A0 =A0 =A0 not have the configuration parameter
> =A0 =A0 =A0 =A0 =A0 remote.<name>.skipDefaultUpdate set to true will =
be updated. (See
> =A0 =A0 =A0 =A0 =A0 git-config(1)).
>
> So without defining any other config, "git remote update" will by
> default update everything

Er, personally i find that documentation pretty cryptic. And when i
check git config for group, i see this:

       remotes.<group>
           The list of remotes which are fetched by "git remote update
           <group>". See git-remote(1).

and

       remote.<name>.skipDefaultUpdate
           If true, this remote will be skipped by default when updatin=
g using
           the update subcommand of git-remote(1).

Neither of which really explain groups, how to define them properly,
(the list is separated by what? and includes the remote name?) or
whether there are implicit groups. I mean, it seems logical that if
you can have user defined groups that there are some built in ones
too, like "all" and "none" or perhaps groups defined by transport
"http" or "git" for instance.

>> I personally haven't found any use for defining =A0remote groups yet=
 to
>> be honest. Its a granularity of operation that hasnt served much
>> purpose for me yet. Although i could see it being useful in the
>> future.
>
> I haven't either. I suspect it would be useful if you had a complex s=
et
> of repo relationships, like an integration manager pulling from an
> upstream but also from other developers.

Now that you have called my attention to them in more detail i suspect
ill end up using them for a few things. Maybe ill try to write up a
doc patch once i have.

>> Generally tho I either want to update and prune one remote only, wit=
h
>>
>> =A0 =A0git fetch $remote; git prune $remote,
>
> It might be useful if "remote update" treated an unconfigured group a=
s a
> simple remote. So that "git remote update --prune $remote" would do w=
hat
> you wanted here.

It seems reasonable to me that names for groups and remotes should
stay distinct and that remotes are treated as being groups which
contain only the remote of the same name. These would be yet more
implicit groups.

>
> I could even see "remote.*.autoprune" config being useful so you coul=
d
> avoid --prune. It is living dangerously, I suppose, for some workflow=
s;
> but I generally consider whatever is in my remote tracking branches t=
o
> be throwaway, and automatically pruning is not really dangerous.

Me too.

>> or i want to update and prune all with something like:
>>
>> =A0 git remote update; for r in $(git remote); do git remote prune $=
r; done;
>>
>> This patch makes the latter better huffman encoded, but I'd kind of
>> expect both to be doable as single commands in terms of how often I
>> want to do them.
>>
>> Maybe git fetch --prune would be a nice complement to this patch.
>
> I think we have tried to keep pruning out of fetch, as fetch does not
> necessarily use or know about tracking branches. But the "git remote
> update $remote" proposal I gave above would do basically the same thi=
ng
> (except you would call it "remote update" instead of "fetch").

Ok, that makes sense.  I see why fetch would be left out. Thanks for ex=
plaining.

cheers,
Yves




--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
