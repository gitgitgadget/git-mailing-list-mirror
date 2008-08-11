From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: git-bisect: weird usage of read(1)
Date: Mon, 11 Aug 2008 21:47:25 +0200
Message-ID: <38b2ab8a0808111247w4837a1bfn774b9c2e9b98d38b@mail.gmail.com>
References: <38b2ab8a0808110657y24ac9526wca4acea3bddaec00@mail.gmail.com>
	 <alpine.DEB.1.00.0808111615260.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	 <38b2ab8a0808110718x2f63608ga3d2d77e317ce4eb@mail.gmail.com>
	 <3f4fd2640808110859r148550d2h833dae05b9e6544e@mail.gmail.com>
	 <20080811164945.GI32184@machine.or.cz>
	 <48A0705B.3030107@lsrfire.ath.cx>
	 <7v7ianxtqv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?Ren=E9_Scharfe?=" <rene.scharfe@lsrfire.ath.cx>,
	"Petr Baudis" <pasky@suse.cz>,
	"Reece Dunn" <msclrhd@googlemail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 21:48:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSdNV-0003Bk-J6
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 21:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbYHKTr0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Aug 2008 15:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbYHKTr0
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 15:47:26 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:31777 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbYHKTrZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Aug 2008 15:47:25 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2407917rvb.1
        for <git@vger.kernel.org>; Mon, 11 Aug 2008 12:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=jICRHiAx4ELVvSbggZHSbG6Mk2rOqKdjLYFeuQh6S3M=;
        b=P3B4ulfxXn9lpPJgHduxde2itgoGpu4QIyTZG8XOGLGCwXlN3tMWkllN5RV5lCptEa
         Ild1EIDrnVnp3j47blDA6zOj/mYzAHgyRgKPetuEgWshCcAgJWI7KSv4vvsFd6G9TK/2
         JL49Z8x/yMkt3EkImp8dRJtBoeBsLO9NKdkm8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=UWvbQH6oAM7iEXV0W9dz1d5a7QIW8zjBZffqyBDPhyL0ZRkgezVFtEtmkoo/g7nHeK
         U2AniIWlWwvbBhm/7HbgcQJJBcrWJmYNEsva35nAEah18U49IxzPW7NDrv7ad/xXj1HU
         47/nrOls9P/11KpZVH/a0+k5F+2rznxW6pKuk=
Received: by 10.141.168.16 with SMTP id v16mr3759122rvo.233.1218484045072;
        Mon, 11 Aug 2008 12:47:25 -0700 (PDT)
Received: by 10.140.170.16 with HTTP; Mon, 11 Aug 2008 12:47:25 -0700 (PDT)
In-Reply-To: <7v7ianxtqv.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91987>

On Mon, Aug 11, 2008 at 8:59 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>
>> Petr Baudis schrieb:
>>> On Mon, Aug 11, 2008 at 04:59:32PM +0100, Reece Dunn wrote:
>>>>>> On Mon, 11 Aug 2008, Francis Moreau wrote:
>>>>>>>               case "$(read yesno)" in [Nn]*) exit 1 ;; esac
>>>> does not work as expected. Replacing this with
>>>>
>>>>                case "$(read yesno; echo $yesno)" in [Nn]*) exit 1 =
;; esac
>>>>
>>>> would work as intended, as Mikael has pointed out.
>>>
>>>   Wouldn't it be more elegant to
>>>
>>>      case "$(head -n 1)" in [Nn]*) exit 1 ;; esac
>>
>> Only if head is a built-in, otherwise you fork needlessly.  Not that
>> this is a performance critical part, but I wouldn't call it "elegant=
".
>>
>> What's wrong with the following variant, already used a few lines up=
 in
>> the file?
>>
>>       read yesno
>>       case "$yesno" in [Nn]*) exit 1 ;; esac
>
> That's the right way to spell it.  Sorry, I must have been too tired
> when I did this.
>
>
>

I sent a patch to fix that way already

Cheers.
--=20
=46rancis
