From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2] tests: A SANITY test prereq for testing if we're root
Date: Mon, 9 Aug 2010 19:02:13 +0000
Message-ID: <AANLkTi=68=ffWqmXyMckJuSvbW4Wk9-7JWR-S9nheOEA@mail.gmail.com>
References: <1280934026-25658-1-git-send-email-avarab@gmail.com>
	<1281132549-11587-1-git-send-email-avarab@gmail.com>
	<7vd3tr7mkj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 21:02:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiXce-0002iW-Sd
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 21:02:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754916Ab0HITCS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 15:02:18 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47876 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754703Ab0HITCQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Aug 2010 15:02:16 -0400
Received: by mail-yw0-f46.google.com with SMTP id 1so3498570ywh.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 12:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=X6Kv8u6ovdfgODnzxdIqrifKjC9B27u9wlJw76dKh9c=;
        b=gARclYJk6vjyu5aviaadMEjnNcchPnHPFRpz95aQBEmx+wCNCec1szaaVHCa6Tj/r5
         5MFOda/3wUzGlGXcXp7Z17sBHDHD5Oz7FNHaVCg4J3LNESAYlG3baRWjds/0PLcrMbjF
         gW44Jkyw52aEWXW6AojJfc9TOhDDkEb6hUW/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Y7VbE5n+CqJ5bLqcWMdSN78MHc+X9tupAcp2o6s9KttiFECVaxF5L9Pc58C197UNZu
         Wh3BjB4GNpzysdCytJE1PazYYp7cOkz6AroXdZEzwuqErzj7DQOnuXAfgwISUdxCQ3FT
         KPmChJcepbuRDQ2NM1ZlY+0SY+pbJpS9dYf30=
Received: by 10.100.154.15 with SMTP id b15mr18207727ane.20.1281380533557; 
	Mon, 09 Aug 2010 12:02:13 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Mon, 9 Aug 2010 12:02:13 -0700 (PDT)
In-Reply-To: <7vd3tr7mkj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152999>

On Mon, Aug 9, 2010 at 16:55, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> write=
s:
>
>> + - SANITY
>> +
>> + =C2=A0 Test is not run by root user, and an attempt to write to an
>> + =C2=A0 unwritable file is expected to fail correctly.
>
> As I said in the previous round, I am indeed in favor of having a sin=
gle
> "running as root---code that expects that the normal UNIXy permission
> based protection to apply, aka 'running in sane environment', will no=
t
> work correctly" prerequisite token, rather than having separate "can =
I
> expect an unwritable file to be unwritable?" =C2=A0"can I expect an u=
nreadble
> file to be unreadable?" bits.

I probably shouldn't have used your docs as-is, you're right. It could
be explained better.

> The name of the token _might_ be subject to debate (I am fine with
> either SANITY or NOROOT), but the explanation should mention this is
> defined to be a bit more broad than "unWRITABLE", I think.

NOROOT is better I think,.

> "test -w /" is a traditional way to approximately check if you are
> running as root (technically, it only checks if you are running with
> unduly high privilege---your sysadm _could_ have done "chmod 2775 /"
> and made it owned by the admin group).

Initially I wrote it as:

     # test whether the filesystem supports symbolic links
     ln -s x y 2>/dev/null && test -h y 2>/dev/null && test_set_prereq =
SYMLINKS
     rm -f y
    +
    +# test whether we can make read-only files
    +mkdir hla
    +chmod -w hla
    +touch hla/gh >/dev/null 2>&1
    +test -f hla/gh || test_set_prereq SANITY
    +rm -rf hla

But then I saw your old "test -w /" implementation and figured it was
good enough without doing all this work on setup. I can submit another
patch with that fixup if you like, maybe it'll prevent odd failures on
someone's odd system.
