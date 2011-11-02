From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Wed, 2 Nov 2011 13:04:30 -0700
Message-ID: <CA+55aFz7TeQQH3D4Tpp31cZYZoQKeK37jouo+2Kh61Wa07knfw@mail.gmail.com>
References: <20111026202235.GA20928@havoc.gtf.org> <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike> <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org> <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <7vwrbjlj5r.fsf@alter.siamese.dyndns.org> <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
 <7vk47jld5s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-ide-owner@vger.kernel.org Wed Nov 02 21:04:58 2011
Return-path: <linux-ide-owner@vger.kernel.org>
Envelope-to: lnx-linux-ide@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-ide-owner@vger.kernel.org>)
	id 1RLh3P-0004BZ-Hs
	for lnx-linux-ide@lo.gmane.org; Wed, 02 Nov 2011 21:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174Ab1KBUEy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;lnx-linux-ide@m.gmane.org>); Wed, 2 Nov 2011 16:04:54 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54456 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab1KBUEx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Nov 2011 16:04:53 -0400
Received: by wyh15 with SMTP id 15so521211wyh.19
        for <multiple recipients>; Wed, 02 Nov 2011 13:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=SV4uJPgTyZKyWVKVGXehDubw/YegELxjJ7TNvR98pWE=;
        b=WXnMO3/MiLs7hk7naH4NOw0lo1kMuui98P56LEKeIB2sTzPmogOmAhV/L377F8qhyg
         iL6NEg2P6FE44hXUNIxOoxm1p8Eefm/ca7D6BAx6ecWnqveul3JnpISPbidOT2WCGwPl
         7juI5UOZuOVyvoN4MPkXDSy+t2pXqlHfdOzug=
Received: by 10.216.24.39 with SMTP id w39mr6532026wew.67.1320264291116; Wed,
 02 Nov 2011 13:04:51 -0700 (PDT)
Received: by 10.216.166.3 with HTTP; Wed, 2 Nov 2011 13:04:30 -0700 (PDT)
In-Reply-To: <7vk47jld5s.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: _zKSswQEQMX8QTtG301TtzynOoo
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184660>

On Tue, Nov 1, 2011 at 2:56 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>
> But on the other hand, in many ways, publishing your commit to the ou=
tside
> world, not necessarily for getting pulled into the final destination
> (i.e. your tree) but merely for other people to try it out, is the po=
int
> of no return (aka "don't rewind or rebase once you publish"). =A0"pus=
hing
> out" might be less special than "please pull", but it still is specia=
l.

So I really think that signing the top commit itself is fundamentally w=
rong.

That commit may not even be *yours*. You may have pulled it from a
sub-lieutenant as a fast-forward, or similar. Amending it later would
be actively very very *wrong*.

So quite frankly, I think the stuff in pu (or next?) is completely
mis-designed. Doing it in the commit is wrong for fundamental reasons,
which all boil down to a simple issue:

 - you absolutely *need* to add the signature later. You *cannot* do
it at "git commit" time.

That's a fundamental issue both from a "workflow model" issue (ie you
want to sign stuff after it has passed testing etc, but you may need
to commit it in order to *get* testing), as well as from a
"fundamental git datastructures" issue (ie you would want to sign
commits that aren't yours.

"git commit --amend" is not the answer - that destroys the fundamental
concept of history being immutable, and while it works for your local
commits, it doesn't work for anybody elses commits, or for stuff you
already pushed out.

And "add a fake empty commit just for the signature" is not the answer
either - because that is clearly inferior to the tags we already had.

I dunno. Did I miss something? As far as I can tell, the signed tags
that we've had since day one are *clearly* much better in very
fundamental ways.

                             Linus
