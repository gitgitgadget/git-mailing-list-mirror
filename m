From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Fw: git-core: SIGSEGV during {peek,ls}-remote on HTTP remotes.
Date: Sun, 1 Nov 2009 15:46:40 +0100
Message-ID: <fabb9a1e0911010646v2043bdb7l9215f1114e9e8385@mail.gmail.com>
References: <20091101.010702.527849118592864646._deepfire@feelingofgreen.ru> 
	<7v8weq50pm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Samium Gromoff <_deepfire@feelingofgreen.ru>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Mike Hommey <mh@glandium.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 15:47:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4bhz-00071W-6r
	for gcvg-git-2@lo.gmane.org; Sun, 01 Nov 2009 15:47:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703AbZKAOq5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Nov 2009 09:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752569AbZKAOq4
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Nov 2009 09:46:56 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:33404 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564AbZKAOq4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Nov 2009 09:46:56 -0500
Received: by ewy28 with SMTP id 28so4135652ewy.18
        for <git@vger.kernel.org>; Sun, 01 Nov 2009 06:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Lw4A+K5mJ1RVwuS/12zP3Ap6xwJ4xCoBZnkq7kE5nrc=;
        b=PEsO290OEB1wMLmFKQ9fH5lS9luCud/Qz6PYpRqoXahHeBlP76Y2DPH8Rt4Wa0Royc
         +swE71y3Ozocgo9qTEX0FFLMhxN9VQIZbg6s/HbbYTyFfjbhMFmBVywPKv83mjrAqlrl
         vPcOBcqwLPeaKyQNkk9dSzi+PFRpmQmjmK57A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=AufSy5ilQ4lw+sdt1KGifIFEtlOrX0JCQsb3eUmDdN+bkoH+3ANKfSToehjtCKKTxG
         nZw1YYIbuyfuTqNxuB8yTdPS1Nru4Dfgk/SOd2OKp2lpOJaIb99eTb0wR3noOc2iG7zF
         Sptt/rTZgHXDr3rD96y7AoK0sddEgRt+/ErIA=
Received: by 10.216.90.198 with SMTP id e48mr1679350wef.188.1257086820137; 
	Sun, 01 Nov 2009 06:47:00 -0800 (PST)
In-Reply-To: <7v8weq50pm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131870>

Heya,

On Sun, Nov 1, 2009 at 05:27, Junio C Hamano <gitster@pobox.com> wrote:
> =A0- Should we fix get_helper() in transport-helper.c, instead of tou=
ching
> =A0 ls-remote.c like this patch does?

Probably, yes.

> =A0 This issue really boils down to this question: is it valid for a
> =A0 transport to have NULL in its remote field, and should all the co=
de
> =A0 that touch transport be prepared to deal with such a transport
> =A0 structure?

I think the code in transport-helper should be prepared to deal with
such a field appropriately, since it knows beforehand that only a few
operations will be performed on such a remote (I'm guessing just the
'list' command).

> =A0 In general, what should the initial environment for helpers be? =A0=
Should
> =A0 they assume that they have to figure out where the git repository=
 is
> =A0 themselves (in other words, should they assume they cannot rely o=
n
> =A0 anything the caller does before they are called?

Let's not duplicate that logic, if git can figure out where we are, it
should do so, if it can't, then the helper can't either.

> =A0 Would the caller
> =A0 generally have done the usual repo discovery (including chdir() t=
o the
> =A0 toplevel), and there are some set of assumptions they can make? =A0=
If so
> =A0 what are they?

Probably the above, if there is going to be a git repository, we'll
have found it, if there isn't one, we're in 'bare' mode.

--=20
Cheers,

Sverre Rabbelier
