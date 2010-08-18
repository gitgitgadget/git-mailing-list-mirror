From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 03/24] t7600 (merge): do not launch gitk for --debug
Date: Wed, 18 Aug 2010 08:55:59 +0000
Message-ID: <AANLkTikBmYH1xC_7iiXQK8-vo0yavwX_ELR=z1kfVSLj@mail.gmail.com>
References: <20100817065147.GA18293@burratino>
	<20100817065459.GC22057@burratino>
	<AANLkTi=1Fz_wdf-grxFB17zUXpW+d26MudbbJP5K=fO_@mail.gmail.com>
	<20100818022931.GA19868@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Lars Hjemli <hjemli@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 10:56:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OleRN-0005fX-Rg
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 10:56:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208Ab0HRI4E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 04:56:04 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43120 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab0HRI4C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Aug 2010 04:56:02 -0400
Received: by iwn7 with SMTP id 7so434822iwn.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 01:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=I8LtyJ6z+k553Sj8vornFP8n+GPRGFh8V4H8Upj5ztw=;
        b=DPAW+XlDIPvmhrqzq+434y+XJsa+aOh/Yy8Ku3XpP4j2hskGPR5WfZH/lmMhvLgd44
         fAuB6QaxBm7wbocA5k+hjuDDU10K5a7gm3EQwUcuPh2JCoeiYC84WJe4oyMzF7NZ3L1p
         5tN9GbpSRZFAcSIw6kRpZwewfS+durZHLI/nE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qTAXl5DNTOK7i6ywVf8aZuHeflt8isuSM35K6iwQxeBfEx+ecQpslwtr1+sbVVvVEw
         KLTT0PSlPAEhPQYCWA7ogu+2NdxisLO8926k6N5pe1fqPDs6VXh8r/7EcpoG47OI4XVN
         qrXof1qqADLEhoOva3Xf4L5VG3v3aBhijfyc0=
Received: by 10.231.167.130 with SMTP id q2mr8840087iby.163.1282121759989;
 Wed, 18 Aug 2010 01:55:59 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Wed, 18 Aug 2010 01:55:59 -0700 (PDT)
In-Reply-To: <20100818022931.GA19868@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153818>

On Wed, Aug 18, 2010 at 02:29, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Sverre Rabbelier wrote:
>> On Tue, Aug 17, 2010 at 01:54, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
>
>>> -test_debug 'gitk --all'
>>> +test_debug 'git log --graph --decorate --oneline --all'
>>
>>> -test_debug 'gitk --all'
>>> +test_debug 'git log --graph --decorate --oneline --all'
> [...]
>> Really? Why can't you stuff the command to execute in a variable? On
>> that note, why wasn't that done in the first place?! This kind of
>> repetition is not very DRY.
>
> My thought was that
>
> =C2=A0test_debug '$debug_command'
> =C2=A0...
> =C2=A0test_debug '$debug_command'
> =C2=A0...
> =C2=A0[etc]
>
> is not very DRY either, so I am hoping some configurable version of
>
> -- 8< --
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index e8f21d5..65b0e35 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -373,6 +373,7 @@ test_run_ () {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if test "$verbose" =3D "t" && test -n "$HA=
RNESS_ACTIVE"; then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo ""
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
> + =C2=A0 =C2=A0 =C2=A0 test_debug "git log --graph --decorate --oneli=
ne --all"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0
> =C2=A0}
>
> -- >8 --
>
> appears to replace it. =C2=A0In the short term, the "s/gitk --all/git=
 log
> --graph --decorate --oneline --all/" was just meant as a quick fix
> so as not to drop the feature. =C2=A0Ideas?

The main issue here is that --debug means two things. It runs
test_debug() code AND instructs the test-lib not to remove the trash
directory when it's done.

If we had a separate --keep-trash option most of this problem would go
away, no?

Aside from that it's better to use git log rather than gitk in
test_debug, since it's in text form it can be easily sent along with a
failing test, which is not the case for dozens of gitk invocations.
