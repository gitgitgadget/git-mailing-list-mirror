From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix for a merge where a branch has an F->D transition
Date: Wed, 13 May 2009 13:33:33 +0200
Message-ID: <81b0412b0905130433x6aa780cbt61d99e9f3d0f2720@mail.gmail.com>
References: <81b0412b0905110242u3624f0eeyc0dc9b2b987bfa2b@mail.gmail.com>
	 <20090511192536.GA1485@blimp.localdomain>
	 <7v63g57ce4.fsf@alter.siamese.dyndns.org>
	 <81b0412b0905122338q774454cj65edfde3d73948e3@mail.gmail.com>
	 <alpine.DEB.1.00.0905131159180.5046@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>,
	git@vger.kernel.org, Samuel Tardieu <sam@rfc1149.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 13 13:34:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4Cil-0005EP-W0
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 13:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756311AbZEMLdf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 May 2009 07:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754973AbZEMLde
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 07:33:34 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:46576 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbZEMLdd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2009 07:33:33 -0400
Received: by fxm2 with SMTP id 2so584216fxm.37
        for <git@vger.kernel.org>; Wed, 13 May 2009 04:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=s0fbTr3kgaZav1qk4LOzBK4Xj3LGXEvLSHGcgE/C6FA=;
        b=YOynzOOamShQtqKx/J0Ah/aaukFdjZ1fMTHt2qpSlAGkmX1O7eJvOgYlbiVoBa2ceY
         xzwYCyJCrKCa7+Pw4IKVY47/hxEK7QdmnssYuEmsUD2mFUXi5AlwOaKU/z9Y5Ehp1F9I
         gIETdkCYIG+rBqza9/sodJ7lqGAfON1WO4A2o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ua3cI9vlHLjyNZqxDYdpfi43G+QkE+RWHiLRLBfXCrproRpDVJiMoXIQLfKUW/CJL5
         b9sT7xEoxJc9qGZfdv+di9J2JpEcgoCKiw9nrdzgwPMBJWYvYDAw3pIR65dsZK1pMEZM
         hvLVG9AkkYuFovvA8B+U2kpSK/oahVejVDBEY=
Received: by 10.204.124.10 with SMTP id s10mr849253bkr.34.1242214413344; Wed, 
	13 May 2009 04:33:33 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0905131159180.5046@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119035>

2009/5/13 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> On Wed, 13 May 2009, Alex Riesen wrote:
>> 2009/5/13 Junio C Hamano <gitster@pobox.com>:
>> > Alex Riesen <raa.lkml@gmail.com> writes:
>> >> Frankly, I'm not really sure. The solution came largely ... empir=
ical
>> >> way. IOW, I tried more or less random things which looked like th=
ey
>> >> should fix the problem. So a review is very much appreciated. Ple=
ase.
>> >
>> > I've always thought that D/F conflict logic in merge-recursive is =
placed
>> > at the wrong processing phase. =C2=A0IIRC, it enumerates potential=
 D/F
>> > conflicting paths before even attempting to process renames, and i=
t is
>> > easy to miss a path that was previously file going away as the res=
ult of a
>> > clean merge (in which case it is ok to have a directory there as t=
he
>> > result of a merge for other paths). =C2=A0This breakage could be a=
 small
>> > example of it.
>> >
>> > Regardless, I think your patch is a reasonable fix to go to the
>> > maintenance track. =C2=A0Thanks for looking into it.
>>
>> I'm afraid the fix is not that simple: the "if" branch where the cha=
nge
>> is placed supposed to prevent updating files in the working tree
>> which already have the same content as the merge's output.
>> My change may force them to be updated regardless. I think...
>> Johannes, you know this area the best, could you please have
>> a look?
>
> Sorry, no time at the moment...
>

Maybe the patch could live on master or next for while? Many people
track master, so a performance degradation, if it happens, will be noti=
ced.
And with master (or even better - next) we have an auditory which is at
least capable to complain.
