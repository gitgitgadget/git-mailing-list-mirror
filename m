From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: git cvsimport and case-insensitive config
Date: Tue, 30 Mar 2010 20:05:57 +0200
Message-ID: <cb7bb73a1003301105v691624sdcdadf6809c50b89@mail.gmail.com>
References: <hoscv7$hmn$1@dough.gmane.org> <7vy6h9vhuk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 20:06:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwfpb-0000vW-6t
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 20:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755077Ab0C3SGV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Mar 2010 14:06:21 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:41594 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754975Ab0C3SGU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Mar 2010 14:06:20 -0400
Received: by ewy20 with SMTP id 20so1528580ewy.1
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 11:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=5306rcF9RLB3PMfpXZfx/ppFLxD192EpdqUiC0wxIhI=;
        b=hL4thBr/TE7KgLs1rX89vxq58BGt23whqMXVHLeR2Wgz2OuIER12k8D0QCaO/EjP2L
         7SydLrrEiAaHxvJjmW/gru6wEzuy4dsf2Sg2OJ0zauIqY6kVPlOlwhPm16yCsr8GM9YE
         vpPeOD93IGdFNeItDoHRJ9AmLuYXoN+3RbbNM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=A36yBmEbFvaDoUe88pXtICH8ccqBND9EEfqLmkn87SrUGlL4v705+j3mFq/MoCyBgR
         M0tpy/QIXAlQC3SGGqFHs/l3kN+OsZfmitvyAjaRwHmAFliUFFuSdvcwoBsTNJGyGpHI
         eZgGfNaHSU5UJduvcLrzaJfhAu4Q0IdPoH90M=
Received: by 10.213.114.132 with HTTP; Tue, 30 Mar 2010 11:05:57 -0700 (PDT)
In-Reply-To: <7vy6h9vhuk.fsf@alter.siamese.dyndns.org>
Received: by 10.213.109.149 with SMTP id j21mr3650292ebp.73.1269972377209; 
	Tue, 30 Mar 2010 11:06:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143586>

On Tue, Mar 30, 2010 at 7:29 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> git cvsimport looks for cvsimport.* single-letter keys that match th=
e
>> command-line option (e.g. cvsimport.r for -r). However, since there =
are some
>> single-letter options which only differ by case (a vs A, r vs R) if =
you set
>> either you get annoying messages (and potentially also odd results, =
although
>> I haven't come across these yet).
>
> Ouch.
>
> The only sensible solution in the longer term is to eventually rename=
 them
> to spell them out e.g. cvsimport.remote vs cvsimport.userevisionmap.
>
> The transition cost would be the same for either approach.
>
> =A0(1) Introduce long options for cvsimport; the code already uses
> =A0 =A0 Getopt::Long, so this shouldn't be too bad.
>
> =A0(2) Add case-sensitive variant of "git config -l" that shows the c=
onfig
> =A0 =A0 variable names in the original case.
>
> =A0(3) Upon startup, use "git config -l -f $GIT_DIR/config" to check =
for
> =A0 =A0 historical short name (e.g. "cvsimport.a" or "cvsimport.A"). =
=A0If
> =A0 =A0 there are, map them to longer name, remove the short keys and=
 write
> =A0 =A0 the conversion back to the configuration file. =A0You might w=
ant to do
> =A0 =A0 the same for "$HOME/.gitconfig" as well.
>
> =A0(4) Then the rest of the code can stay the same.

We might be able to skip (2) by relying on the fact that if the
lowercase is boolean, the uppercase isn't, and conversely. So when
upgrading we check first for the boolean case, if we get a failure (as
opposed to no value) then we know it's the non-boolean one. Then we
can migrate the values accordingly.

--=20
Giuseppe "Oblomov" Bilotta
