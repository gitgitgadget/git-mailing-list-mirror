From: Michael Wookey <michaelwookey@gmail.com>
Subject: Re: [PATCH] MSVC: fix build warnings
Date: Sat, 3 Oct 2009 09:28:28 +1000
Message-ID: <d2e97e800910021628t13bba313he119ba59babdecee@mail.gmail.com>
References: <d2e97e800910021440q46bd46c4y8a5af987620ffc5c@mail.gmail.com> 
	<7v7hvd4flb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 03 01:29:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtrYU-0006ir-Bx
	for gcvg-git-2@lo.gmane.org; Sat, 03 Oct 2009 01:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753625AbZJBX2p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Oct 2009 19:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753300AbZJBX2o
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 19:28:44 -0400
Received: from mail-yw0-f176.google.com ([209.85.211.176]:61496 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbZJBX2o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Oct 2009 19:28:44 -0400
X-Greylist: delayed 6499 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Oct 2009 19:28:44 EDT
Received: by ywh6 with SMTP id 6so932781ywh.4
        for <git@vger.kernel.org>; Fri, 02 Oct 2009 16:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=Ufj613kHItGi64ROTurPTgjc3fdbcDlq87AHz3dtvuw=;
        b=CgCoxBZadLmdal45jqUs/ygYQqz2B4ZQg9OJCk4gp/uvaLA40O14Dcc49ThB8R+haB
         GXSNHiGxPjIbvLzXfCco/MpDawW2Vzxhw8A9CVUz1fHuupSVtJcIDC7+H/AS08HgosD4
         UVEa3RTRDhFQvnE6OdIBeuw9R+kKDB2PDKPLE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=FGOYWghMCfHGgA08nVapO6gNrB4Cc3MNVtrTWIee6HVPaCmkGwwrQAi/x14vV4AiDq
         Xk5Rbm9QxPCPnvbnPY/CpCLWJxs6fSkF7/eh8olryIpcoU6OtHOWI4liQbPmXe/vpkeV
         IdgWsYxtahT2zu6rwgEe991MviIZ6y8cBJXeA=
Received: by 10.101.209.23 with SMTP id l23mr3455000anq.173.1254526128076; 
	Fri, 02 Oct 2009 16:28:48 -0700 (PDT)
In-Reply-To: <7v7hvd4flb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129470>

2009/10/3 Junio C Hamano <gitster@pobox.com>:
> Michael Wookey <michaelwookey@gmail.com> writes:
>
>> diff --git a/builtin-branch.c b/builtin-branch.c
>> index 9f57992..cf6a9ca 100644
>> --- a/builtin-branch.c
>> +++ b/builtin-branch.c
>> @@ -93,7 +93,7 @@ static const char *branch_get_color(enum color_bra=
nch ix)
>>
>> =C2=A0static int delete_branches(int argc, const char **argv, int fo=
rce, int kinds)
>> =C2=A0{
>> - =C2=A0 =C2=A0 struct commit *rev, *head_rev =3D head_rev;
>
> I haven't tried, but the patch may break build with "gcc -Werror".
>
> This is a common and unfortunate idiom to tell the readers of the cod=
e
> that this initialization is unnecessary, gcc is not clever enough to
> notice and gives warnings, and we are squelching it, knowing what we =
are
> doing.

I can't build with -Werror on Ubuntu 9.04 (gcc 4.3.3) because of the fo=
llowing:

  http://article.gmane.org/gmane.comp.version-control.git/127477

With the current git.rc2, I also get the following warnings:

  builtin-mailinfo.c: In function 'handle_commit_msg':
  builtin-mailinfo.c:789: warning: ignoring return value of
'ftruncate', declared with attribute warn_unused_result

It would be nice to get those warnings removed.

I just tried my patch with gcc 4.2.1 (Mac OSX 10.6) and there are a
few warnings that are generated because some of the variables have had
their initial values removed. I can send a V2 if you like, however
these variable were initialised that way for a reason and it might not
be sensible to clean them up in the way I was proposing.

What would be a good method of fixing these warnings now that we have
the ability to compile with MSVC? Explicitly initialising the
variables (to something sane) or should we start to introduce compiler
specific pragmas (ugly...) that aim to clean the various build
warnings? I just want to reduce (and eventually remove) all the build
noise when building using MSVC.

=46rom what I have seen so far, building with MSVC spews out a lot of
warnings. I am building with MSVC in both the IDE and from a build
console via:

    devenv git.sln /useenv /build "Debug|Win32"

If you compile using gcc with "-Wextra" you will see a similar amount
of build noise that gets generated. See the following for some
previous discussion:

  http://article.gmane.org/gmane.comp.version-control.git/128967
