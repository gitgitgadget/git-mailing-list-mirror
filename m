From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2010, #06; Wed, 24)
Date: Fri, 26 Mar 2010 00:11:51 +0100
Message-ID: <81b0412b1003251611h62222eabw247ec59678c198ad@mail.gmail.com>
References: <7v7hp1kzbn.fsf@alter.siamese.dyndns.org>
	 <fcaeb9bf1003250811g777b2881l332e6f61456d699@mail.gmail.com>
	 <25yNvbuAivZlBuEJoRhXtfoEc7HEZorM5qOrwgQKk7FER_fdzljyMQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Mar 26 00:12:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuwDY-0000ub-Lw
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 00:12:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713Ab0CYXLy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Mar 2010 19:11:54 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:48505 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192Ab0CYXLy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Mar 2010 19:11:54 -0400
Received: by bwz1 with SMTP id 1so1369185bwz.21
        for <git@vger.kernel.org>; Thu, 25 Mar 2010 16:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=m29DH/cO/GtxCKmmR5pryL7R1NO0545gfl0xw+6sKSk=;
        b=kwdntl1C00llxI2u+xr9jUM0kCvTB5+bJI5bCy/ghXFUXml+5Zkf+S7yKlL7xvnbsV
         IHbKCY0Xhay6lwv1SUYY37trWRehMSsnqo4u4jJ5Qzu8EtSn2wT2c2POVPZm9lO5gqsK
         pWse0CLEH0eou387juXzif7Mt7JcyeJX9z7m0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BBylTxKFusc8Ga6whciE7kgqgceoycR7Aofsm1JDUe3LUwY73U+k4ruHcTjThDi6dw
         zCVEte3CdEQy+BnBztpIT8IHqDb9kTYQ0JkQCYJ+sbWQQxA62zzLImnXE/YZwMay09Nm
         +Eg84q9ItJ0N1rB5CMJ9SIIje9z0KDexxAgxk=
Received: by 10.204.175.68 with SMTP id w4mr1832080bkz.163.1269558712210; Thu, 
	25 Mar 2010 16:11:52 -0700 (PDT)
In-Reply-To: <25yNvbuAivZlBuEJoRhXtfoEc7HEZorM5qOrwgQKk7FER_fdzljyMQ@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143200>

On Thu, Mar 25, 2010 at 17:27, Brandon Casey
<brandon.casey.ctr@nrlssc.navy.mil> wrote:
> On 03/25/2010 10:11 AM, Nguyen Thai Ngoc Duy wrote:
>> 2010/3/25 Junio C Hamano <gitster@pobox.com>:
>>> * ar/config-from-command-line (2010-03-19) 1 commit
>>> =C2=A0- Allow passing of configuration parameters in the command li=
ne
>> This breaks my build on Solaris because it uses strndup, which is no=
t available.
>
> A quick glance at ar/config-from.. also detected an unchecked calloc(=
).
>
> Alex, any reason xcalloc wasn't used?

Just missed it. Long time away from Git sources.

> btw, me also thinks the code is a little hard to read. =C2=A0For exam=
ple, I initially
> thought your calloc was not allocating enough space for the nul termi=
nator.
>
> =C2=A0 ct =3D calloc(1, sizeof(struct config_item) + (text - name));
> =C2=A0 memcpy(ct->name, name, text - name);
>
> I traced the code, but it wasn't until I noticed that your data struc=
ture looks
> like this:
>
> =C2=A0 struct config_item
> =C2=A0 {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct config_item *next;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *value;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char name[1];
> =C2=A0 };
>
> that I realized that room for the nul terminator in the 'name' array =
was allocated
> by the structure itself, since the name declaration looks like name[1=
] and not
> name[FLEX_ARRAY].

Hmm, I kinda liked how the space for the terminator was reserved and
all the flex array incompatibilities were worked around.

> Would the code be simpler if strbufs were used? =C2=A0Then you wouldn=
't need to duplicate
> the skip_space and trailing_space functionality provided in the strbu=
f library, and
> would just need a new function named strbuf_tolower.

But this indeed makes sense. Promise to take a look at it after some sl=
eep.

> Also, should config_parametes_tail be spelled config_parameters_tail?

Yep.

Thanks!
