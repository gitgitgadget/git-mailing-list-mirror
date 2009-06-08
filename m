From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] hooks/pre-commit: check for cycles in dependencies
Date: Mon, 8 Jun 2009 09:31:01 +0200
Message-ID: <36ca99e90906080031r3f5f545eo26c077e1966bf67@mail.gmail.com>
References: <1244148073-2313-1-git-send-email-bert.wesarg@googlemail.com>
	 <20090605202526.GB671@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Mon Jun 08 09:31:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDZKB-0002bH-UN
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 09:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753575AbZFHHbB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jun 2009 03:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753374AbZFHHbB
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 03:31:01 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:49378 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390AbZFHHbA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2009 03:31:00 -0400
Received: by bwz9 with SMTP id 9so2828788bwz.37
        for <git@vger.kernel.org>; Mon, 08 Jun 2009 00:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=z2/oBErC3R5NSmTksk3AoEB3x9DfEhdzdyvAzj6+pcE=;
        b=exVTIcE54g/Q/U6h2mDow47tkAxFDnpGNhK6giQcu/O6CNSPmg9BtkZzRQq12UohGb
         opqRJpSRhYj0/6AXRmAB11LiRHcMN9ty7aFJ6JSxbRMTqQbnPtpeGU2Fk3O3+j93FKsL
         nXHWB/ur7XF258otH3iDQVCZbnLGAz9JpFoR8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OQG+VXkExDwiRkB56LSvKRiQ45lLrd72ecak+hs/ly1ryRNS5akePZJ4n6WEdGuCta
         5UwK0/ox0M9Hz7sr9Y6FEOWMn7guea/NA+fPMtrCZ7kpdukuATKGengUzQKs74f0O8kK
         XpuK0V1Hz7CD3rVbEhNYcX4ETalwYOUmuDFAM=
Received: by 10.223.105.75 with SMTP id s11mr3565694fao.4.1244446261103; Mon, 
	08 Jun 2009 00:31:01 -0700 (PDT)
In-Reply-To: <20090605202526.GB671@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121044>

2009/6/5 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
> Hi Bert,
Hi, Uwe,

>
> On Thu, Jun 04, 2009 at 10:41:13PM +0200, Bert Wesarg wrote:
>> Only newly added dependencies needs to be considered. =C2=A0For each=
 of these deps
>> check if there is a path from this dep to the current HEAD.
>>
>> Use recursive_dep() for this task. =C2=A0Even if recursive_dep() use=
s a DFS-like
>> traversal it will not run into an infty-loop if there would be a cyc=
le, because
> I'm not sure how understandable this is. =C2=A0After some thinking I
> understood DFS. =C2=A0Up to now I thought infty is just the LaTeX mac=
ro name
> for "infinity", but apart of this, is this really the right term here=
?
> endless loop?
Yeah, 'endless loop' is the right term here.

>
>> recursive_dep() takes .topdeps only from committed trees. =C2=A0And =
it is required
>> that the committed dependency graph is acyclic.
>
> I didn't check the implementation deeply. =C2=A0But all in all I don'=
t have
> the usual warm and fuzzy feeling about it. =C2=A0What happens during =
a remote
> update if only the merged dependency graph has a cycle[1]?
I suspect the merge commit, which would introduce this cycle, will abor=
t.

BTW: Do you have any infos or need help on your TopGit successor?

Bye,
Bert

>
> Best regards
> Uwe
>
> [1] The question is a bit theoretic because remote updating is broken
> here. =C2=A0If you are my remote and changed a .topdep file, my updat=
e simply
> discards your change.
>
> --
> Pengutronix e.K. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| Uwe Kleine-K=C3=B6=
nig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
> Industrial Linux Solutions =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| http://www.pengutronix.de/ =C2=A0|
>
