From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] Document pack v4 format
Date: Fri, 6 Sep 2013 20:44:11 +0700
Message-ID: <CACsJy8CVaFKZE2bM+1AZPTpq19BS8-=UrYCcvO004Aw_EX-vfg@mail.gmail.com>
References: <1377917393-28460-1-git-send-email-pclouds@gmail.com>
 <1378433643-15638-1-git-send-email-pclouds@gmail.com> <alpine.LFD.2.03.1309052319310.20709@syhkavp.arg>
 <CACsJy8AWa0NFViO+3Cnp_0Gqzqidcbx9vPd1wxCuY1jjWhyFaQ@mail.gmail.com> <alpine.LFD.2.03.1309060922020.20709@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Sep 06 15:44:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHwLJ-0004QX-OH
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 15:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813Ab3IFNon convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Sep 2013 09:44:43 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:62820 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743Ab3IFNom convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Sep 2013 09:44:42 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so3485147obc.34
        for <git@vger.kernel.org>; Fri, 06 Sep 2013 06:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=pUflsDyaaeVLytpsirhTSidVo9RoV5pzyUwULhUgTHM=;
        b=AbmNkffSiO7uXHRe7vxxI2ICyIzLQtlGAut1xY/bhQktA2iSaNOuR1BhTWEwoVqDsr
         iWH8DMj7JA+FoXe02o1uieBdDJifO2wbiKe2566RIjErh/z7yRoVpxTUjpngFsnUWtxZ
         5oxtd/18fQyJQo/12m3xna8hmm5RgeCRY3uCbtaxYo2US4fUETbCV5LRL75KT5FgBZV7
         hX3783LcakzHc+GLJQYeBhP1LLpqJDBotjrcYeBhAXaR3IFsHbIBkXPVP+izTSPRMGE+
         hVcg6uDQyQTpJn7Dju/O6dd//4nfxb2hnhohp6RBECwqRUI8FtN7IvT75MbICYYQj1Sm
         5kpw==
X-Received: by 10.182.134.229 with SMTP id pn5mr1831307obb.88.1378475081977;
 Fri, 06 Sep 2013 06:44:41 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Fri, 6 Sep 2013 06:44:11 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.03.1309060922020.20709@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234050>

On Fri, Sep 6, 2013 at 8:25 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Fri, 6 Sep 2013, Duy Nguyen wrote:
>
>> On Fri, Sep 6, 2013 at 10:23 AM, Nicolas Pitre <nico@fluxnic.net> wr=
ote:
>> > On Fri, 6 Sep 2013, Nguy=C2=ADn Th=C3=A1i Ng=C3=B7c Duy wrote:
>> >
>> >>
>> >> Signed-off-by: Nguy=C2=ADn Th=C3=A1i Ng=C3=B7c Duy <pclouds@gmail=
=2Ecom>
>> >> ---
>> >>  Should be up to date with Nico's latest implementation and also =
cover
>> >>  additions to the format that everybody seems to agree on:
>> >>
>> >>   - new types for canonical trees and commits
>> >>   - sha-1 table covering missing objects in thin packs
>> >
>> > Great!  I've merged this into my branch with the following amendme=
nt:
>>
>> I'd like to propose another change in the format to basically limit
>> the use of sha1ref format "\0<SHA-1>" to tree entries only. All form=
s
>> of deltas must have non-zero sha1 index (i.e. reference to SHA-1
>> table). It will simplify handling code, and I think it makes sense t=
oo
>
> Why?
>
> This is still some artificial limitation and I tend not to like them.
>
> "Simplifying handling code" is not a good enough reason on its own,
> especially if it reduce flexibility for possible future layout
> optimizations.
>
> In what way is the code more difficult?

That'll be two ways of linking to another in-pack object. The linked
object must be in the pack anyway, its sha-1 should be present in the
sha-1 table. "\0<sha1>" is a longer encoding for nothing. If the
linked sha1 is not in the pack (similar to the old ref-delta), it
makes the pack depend on another one, which is what we've been
avoding. In your code you reject sha1ref starting with zero too
(sha1_file.c::get_base_delta and packv4-parse.c::decode_entries)
--=20
Duy
