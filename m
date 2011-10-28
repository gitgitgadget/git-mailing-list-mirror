From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC/PATCH] define the way new representation types are encoded
 in the pack
Date: Fri, 28 Oct 2011 16:07:43 -0700
Message-ID: <CAJo=hJsEzkFV9k8N+GAwWddmEZH8pQeJZrg_MXD72stbAW0ceQ@mail.gmail.com>
References: <7v62j9veh3.fsf@alter.siamese.dyndns.org> <CAJo=hJt-YZcdxw+D=1S4haPmY-8-LLjXD=MvDGeWbdJ88_VOGw@mail.gmail.com>
 <alpine.LFD.2.02.1110290031540.30467@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Oct 29 01:08:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJvX2-0006cg-E3
	for gcvg-git-2@lo.gmane.org; Sat, 29 Oct 2011 01:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933751Ab1J1XIG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Oct 2011 19:08:06 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:60107 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933739Ab1J1XIE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Oct 2011 19:08:04 -0400
Received: by ggnb1 with SMTP id b1so4106666ggn.19
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 16:08:04 -0700 (PDT)
Received: by 10.236.192.132 with SMTP id i4mr6906985yhn.80.1319843284059; Fri,
 28 Oct 2011 16:08:04 -0700 (PDT)
Received: by 10.147.125.20 with HTTP; Fri, 28 Oct 2011 16:07:43 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1110290031540.30467@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184437>

On Fri, Oct 28, 2011 at 15:48, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Fri, 28 Oct 2011, Shawn Pearce wrote:
>> - The immediate next byte encodes the extended type. This type is
>> stored using the OFS_DELTA offset varint encoding, and thus may be
>> larger than 256 if we ever need it to be.
>
> I'd say it is just a byte. =A0No encoding needed. =A0Let's not be sil=
ly
> about it. =A0If we really have more than 255 object types one day (an=
d I
> really hope this will never happen) then the value 0 in that byte cou=
ld
> indicate yet another extended object type encoding. =A0But I truly ho=
pe
> we'll have pack v9 or v10 by then and that we'll have obsoleted the
> current 3-bit encoding completely at that point anyway.

Yes. I probably wouldn't code the parser to use a varint here. I would
say the extended types stored in this byte must be >=3D 8, and must be
<=3D 127. Any values out of this range are unsupported and should be
rejected. We can later reserve the right to set the high bit and
switch to the OFS_DELTA varint encoding if we need that many more
types, and we explicitly define codes 0-7 as illegal if detected here
in the extended byte field.
