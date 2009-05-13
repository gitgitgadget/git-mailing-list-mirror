From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Quote LF in urls git fetch saves in FETCH_HEAD
Date: Wed, 13 May 2009 18:09:42 +0200
Message-ID: <81b0412b0905130909x2ad67407p53ad6f79966c1ea3@mail.gmail.com>
References: <200905112208.21017.Hugo.Mildenberger@namir.de>
	 <200905121557.18542.Hugo.Mildenberger@namir.de>
	 <81b0412b0905120759u15f1ec73k73625a7904515792@mail.gmail.com>
	 <200905121900.00625.Hugo.Mildenberger@namir.de>
	 <81b0412b0905121018lbccda1fvf6c4c19417cdde00@mail.gmail.com>
	 <20090512172452.GA32594@blimp.localdomain>
	 <7vws8l7w0d.fsf@alter.siamese.dyndns.org>
	 <81b0412b0905122306w4ed41bdiab073a05587fab55@mail.gmail.com>
	 <alpine.LNX.2.00.0905131109240.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Hugo Mildenberger <Hugo.Mildenberger@namir.de>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed May 13 18:09:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4H1j-0005Ao-Bd
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 18:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758359AbZEMQJo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 May 2009 12:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758041AbZEMQJn
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 12:09:43 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:42203 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757703AbZEMQJm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2009 12:09:42 -0400
Received: by bwz22 with SMTP id 22so743256bwz.37
        for <git@vger.kernel.org>; Wed, 13 May 2009 09:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=E7p9yj+EjVx1AQX4H2IOVDdFPOQpllkJTM+NoP2UYUs=;
        b=nKnICNMv4fYMRPOp2CmeARdyaSSsX8hP6/YTP6TmLS15JyyBMUpvRWupWuF1F8l6be
         i1qQQ4gJ+pav/wwvWZyrCT/6q8iII2mdXwp8Myxbnvjkze8lB7q5LJ/pcfzGXRtnXtI9
         Zo9eIHHR6ws7iNFkVMpN6+Gye1y3JqQMrvwPk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kBu94Nh6EzRgfduQf67xFRcxIQzeqXSTWYRu/bNo9GCjdGM7NOPADF3KaztOcAO4gy
         l6RLFZyO96/m3ojxBa6qz0lY0n2c+9G7fATqS30aMmEya6Ht+8R90Knz3FOSLEAWkFI1
         xH2l+KDyXoFhOzhA8BBB7KRQqtGPyZtiGK43w=
Received: by 10.204.68.10 with SMTP id t10mr1046696bki.182.1242230982048; Wed, 
	13 May 2009 09:09:42 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0905131109240.2147@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119062>

2009/5/13 Daniel Barkalow <barkalow@iabervon.org>:
> On Wed, 13 May 2009, Alex Riesen wrote:
>> 2009/5/13 Junio C Hamano <gitster@pobox.com>:
>>
>> > If it is just informational use only, then it might make more sens=
e to
>> > drop this ugly "quoted \n" silently. =C2=A0I dunno.
>>
>> That'd mean to loose the information completely. Which is just as ba=
d
>> as putting the LF in the url in the first place.
>
> Looking back at the original message, it looks like the user included=
 a
> newline in an argument to clone, and the fetch must have stripped it =
out
> (or ignored it in some other fashion), because data was retrieved fro=
m a
> repository that doesn't have a newline in its name.

_That_ looks like a bug to me. We should have asked exactly the name
we were given, or notify the user about what we have used for the url
if we have ignored user's input and decided to use something else.
Patches follow.

> ... Most likely, the
> newline should just be prohibited in the URL in the config file in th=
e
> first place, and we shouldn't be able to get to the point of writing =
a
> FETCH_HEAD with that value.

What I cannot understand is what's wrong with url containing an LF?
Especially if we can handle it, all the tools can handle it, and puttin=
g
LF in a filename is a long-standing UNIX tradition.
