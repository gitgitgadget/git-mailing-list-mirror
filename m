From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv1bis 1/2] git apply: option to ignore whitespace 
	differences
Date: Fri, 3 Jul 2009 08:40:01 +0200
Message-ID: <cb7bb73a0907022340l88a226egad74a275055fb972@mail.gmail.com>
References: <1246556921-5819-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<1246556921-5819-2-git-send-email-giuseppe.bilotta@gmail.com> 
	<7vvdmb6ium.fsf@alter.siamese.dyndns.org> <cb7bb73a0907021202ra322425pc64b54953f4f544d@mail.gmail.com> 
	<cb7bb73a0907021228q7e9d2791vafead8e0c5b06b79@mail.gmail.com> 
	<7vhbxu6f87.fsf@alter.siamese.dyndns.org> <cb7bb73a0907021333t6f377d61v1c1479c15b72c436@mail.gmail.com> 
	<7vhbxuzlkk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Robert Fitzsimons <robfitz@273k.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 03 08:40:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMcS3-0008MF-Mj
	for gcvg-git-2@gmane.org; Fri, 03 Jul 2009 08:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752878AbZGCGkX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jul 2009 02:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751943AbZGCGkU
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jul 2009 02:40:20 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:40495 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808AbZGCGkS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jul 2009 02:40:18 -0400
Received: by fxm18 with SMTP id 18so1947504fxm.37
        for <git@vger.kernel.org>; Thu, 02 Jul 2009 23:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=FMfUOrYZVK/+fIrNTzZnelHud9DDTrwWJuZW2yPMMBM=;
        b=xkzjkviV7ozcJ0BCBbVjIsX49zRyQqOm7dI6jwnFJVPaMnxIrD+xrp8Q9D5coRhDnQ
         GkwRgMran6HPobFTNJk4PnzoyV85VmScY/AsyV15C4eS9H5+4VeGcLY+sL96ZldiZYu4
         QIZFOIaUAIf3L92JL9T0RhLeFbtIMDEUP+n/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=wCaD1iLoLWzAM4Vs2mqqrC+MHtoDHoaMwr1wt/QFszWU99FYx1cbtAGCiYX5IXANwh
         gdmmHEMjS0AN8go0Zkhh4FjDTn3I+n1ObR/rceEXJTjKxZrhy5HB0EKmemnmytQW9NLy
         7ueeqg5hodkXF3kPkMWiMGwygjpCrO+6q4hyc=
Received: by 10.204.53.1 with SMTP id k1mr918541bkg.125.1246603221132; Thu, 02 
	Jul 2009 23:40:21 -0700 (PDT)
In-Reply-To: <7vhbxuzlkk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122687>

On Fri, Jul 3, 2009 at 1:55 AM, Junio C Hamano<gitster@pobox.com> wrote=
:
> By the way, I think we need to make sure your understanding of how th=
e
> current code works matches mine before you go any further.

Souns reasonable.

> Are the words "preimage", "postimage" and "target" used consistently
> between us? =A0By these words, I mean:
>
> =A0preimage =3D the lines prefixed with '-' and ' ' in the patch
>
> =A0postimage =3D the lines prefixed with ' ' and '+' in the patch
>
> =A0target =3D lines in the file being patched that corresponds to the=
 preimage

It _did_ take me a little to understand the names when I started
working on the feature, but I got on track pretty soon (at the first
segfault ;-)).

> The point of patch application is to find a block of lines in the tar=
get
> that matches preimage, and replace that block with postimage. =A0When=
 the
> patch applies cleanly (which is the case we should optimize for), the
> preimage match the target byte-for-byte. =A0The hunk starting at line=
 1690
> does a memcmp of the whole thing, without ws fuzz, for this reason. =A0=
You
> do not want to touch that part with your patch (and that is why I am
> writing this message to make sure you understand what you are doing).

Of course.

> After that, as a fallback, we compare line-by-line, while fixing the
> whitespace breakage in the preimage (what the patch author based on) =
and
> the target (what we currently have).

> [...] preimage and target won't match byte-for-byte, but by
> applying the whitespace breakage on each of the preimage line and the
> corresponding target line, they will match in either of the above cas=
es.
> While doing this "convert-and-match", we prepare a version of preimag=
e
> with whitespace breakage fixed to give to update_pre_post_images() at=
 the
> end of the function in fixed_buf.

Indeed. This is why in my 2/2 patch I do a similar operation to bring
the preimage whitespace to match the target whitespace if matching was
done ignoring whitespace (but we never got to that part, for obvious
reasons).

> This is another point I am worried about your patch. =A0Suppose you h=
ave this
> target:
>
> =A0 =A0a a a
> =A0 =A0b b b
> =A0 =A0c c
> =A0 =A0d
> =A0 =A0e e
>
> And we have a broken patch that needs --ignore-whitespace to apply:
>
> =A0 =A0diff --git a/file b/file
> =A0 =A0index xxxxxx..yyyyyy 100644
> =A0 =A0@@ -1,4, +1,5 @@
> =A0 =A0 a =A0a =A0a
> =A0 =A0 b b =A0b
> =A0 =A0+q
> =A0 =A0 c =A0c
> =A0 =A0 =A0 d
>
> Your preimage is "a =A0a =A0a\nb b =A0b\nc =A0c\n =A0d\n",
> target is =A0 =A0 =A0 =A0"a a a\nb b b\nc c\nd\ne e\n",
> and postimage is "a =A0a =A0a\nb b =A0b\nq\nc =A0c\n =A0d\n".
>
> Wouldn't you want to have this as the result of patch application?
>
> =A0 =A0a a a
> =A0 =A0b b b
> =A0 =A0q
> =A0 =A0c c
> =A0 =A0d
> =A0 =A0e e
>
> With whitespace squashed, the preimage would match the target (perhap=
s
> after fixing line_matches()), but wsfix_copy() called while we fix ea=
ch
> preimage line won't have changed anything in the fixed_buf that is to
> become the new preimage, and update_pre_post_images() while copying t=
he
> fixed preimage to the postimage won't have corrected "a a a" back to =
"a a
> a" that was in the target as the result.
>
> So I suspect that you would instead end up with:
>
> =A0 =A0a =A0a =A0a
> =A0 =A0b b =A0b
> =A0 =A0c =A0c
> =A0 =A0 =A0d
> =A0 =A0e e

This is indeed the case with my 1/2 patch: no whitespace adjustment is
done on the pre- and postimage when the preimage and target match with
whitespace fuzz and ignore_whitespace is active. In the first RFC I
sent I expressely mentioned that this was not what I liked about my
patch. When I first sent a _series_, it was made of two patches, the
second of which served the purpose of realigning the whitespaces of
the patch (pre and postimage) to the whitespaces of the target (at
least for the common lines).

> I think the intent of --ignore-whitespace is "don't worry about ws
> differences in the context when locating where to make the change", a=
nd it
> is not "I do not care about getting whitespace mangled anywhere in th=
e
> file the patch touches."

I totally agree. This is important because it also means that when
re-diffing the applied patch you still get changes ONLY in the lines
where you SHOULD get changes, and not in the nearby context that only
had different whitespace.

I sent the thing in two patches to make it easier to review. If you
think it's more appropriate to squash them, I can do that no problem.

> correct_ws_error is special in that we can
> afford to take the fixed pre/postimage, "because we are fixing the ws
> breakage anyway", but arguably it _might_ be nicer to limit the chang=
e to
> the lines marked with '-' and '+' in the patch even in that case.

But that's a path we're not going to hit in match_fragment when
ignoring whitespace. Instead, one thing we could consider in this case
(ignore_whitespace) is to adjust the leading space in the + lines to
match the ws transformations done in the context lines, but that might
be making whitespace fixing a little too far. Or we should rename it
to whitespace=3Dadjust...

--=20
Giuseppe "Oblomov" Bilotta
