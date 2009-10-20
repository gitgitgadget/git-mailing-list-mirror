From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git hang with corrupted .pack
Date: Tue, 20 Oct 2009 17:36:28 +0200
Message-ID: <81b0412b0910200836q3f519ac3l912cc1c4299047f4@mail.gmail.com>
References: <20091014042249.GA5250@hexapodia.org>
	 <20091014142351.GI9261@spearce.org>
	 <alpine.LFD.2.00.0910141208170.20122@xanadu.home>
	 <20091014161259.GK9261@spearce.org>
	 <alpine.LFD.2.00.0910141234540.20122@xanadu.home>
	 <20091014180302.GL9261@spearce.org>
	 <alpine.LFD.2.00.0910141435040.20122@xanadu.home>
	 <7vbpk985t1.fsf@alter.siamese.dyndns.org>
	 <81b0412b0910200814v269e91fbkd7841308685e1c54@mail.gmail.com>
	 <fabb9a1e0910200823h280a875p98c61eb5e5e6018a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andy Isaacson <adi@hexapodia.org>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 17:36:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0GlI-0001lt-Dc
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 17:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552AbZJTPg0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Oct 2009 11:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752514AbZJTPg0
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 11:36:26 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:61813 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbZJTPgZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Oct 2009 11:36:25 -0400
Received: by ewy3 with SMTP id 3so4942608ewy.17
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 08:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=icPd6btZcIa7B0nGA5MsWEUvXreGHp7ep9bIa5YeiRQ=;
        b=nxzwyHsCJRRCI/H7J2Ahf6+GqH3etpMi/2nqE+RTJWn6d/mQFNrdGYHdzHZ7Rs3NG3
         Ys0mWpOENmCZx93SKXwABjVxy6WhYKvf64Hq2Uef/K6hjNtdWtxNiPWdGdF8DCiINwfK
         ik1jIVoMXVOlnwXBmlkCfO0vWlNDAnbZu6L0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lScC0yiuKOGHP2omlZ6xUbX1GriAP83wBERYn4H2ojBEpovM+eRuE2VxlPVgjWEE1/
         Wsv3masb3a3cOs98C0iyZZjyWLZCyAGyrn7ZR0pBhb0L9g5hhGZR+2m07aeDPxO1q6mn
         8LaaeYxTtxmtolR2BpCcZE1EUAhM5/73j2pyI=
Received: by 10.211.156.13 with SMTP id i13mr7511081ebo.22.1256052988945; Tue, 
	20 Oct 2009 08:36:28 -0700 (PDT)
In-Reply-To: <fabb9a1e0910200823h280a875p98c61eb5e5e6018a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130803>

On Tue, Oct 20, 2009 at 17:23, Sverre Rabbelier <srabbelier@gmail.com> =
wrote:
> Heya,
>
> On Tue, Oct 20, 2009 at 10:14, Alex Riesen <raa.lkml@gmail.com> wrote=
:
>> - =C2=A0 =C2=A0 =C2=A0 buffer =3D xmalloc(size + 1);
>> + =C2=A0 =C2=A0 =C2=A0 buffer =3D xmalloc(size + 8);
>
>> - =C2=A0 =C2=A0 =C2=A0 stream.avail_out =3D size;
>> + =C2=A0 =C2=A0 =C2=A0 stream.avail_out =3D size + 8;
>
> That seems wrong at first glance, you go from '+1' to '+8' on the
> first part, and then from '+0' to '+8' in the second part, am I
> missing something obvious?

Yes. The "size" (the variable) is never changed. It is just the output
buffer size, not how many data expected or something like that.
IOW, I just wanted the buffer to be obviously (to zlib) more than enoug=
h.
