From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 12:57:12 -0400
Message-ID: <v2q32541b131005070957j819890dbqe613985ff5f65b84@mail.gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com> 
	<cover.1273183206.git.eyvind.bernhardsen@gmail.com> <7v4oijhdsi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org, hasan.aljudy@gmail.com,
	kusmabite@googlemail.com, torvalds@linux-foundation.org,
	prohaska@zib.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 07 18:57:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAQs3-0007zn-Hb
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 18:57:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754178Ab0EGQ5f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 12:57:35 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:53835 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410Ab0EGQ5e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 12:57:34 -0400
Received: by yxe1 with SMTP id 1so858826yxe.33
        for <git@vger.kernel.org>; Fri, 07 May 2010 09:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=EaSXyzs/xf98hE4dK8fWm33bSHI0X+2veM40SXkusDo=;
        b=Xz23I1g+rLVcq9diuwQTyUZYD2v0MOWvfRBp5pK7TcyR8AfkVp8aZmtGUxipfXH72N
         NQHFkJcnLeD38FtfpQnQ5B8UbhrPds+qtoqOKHPWCFdOLFn6WobvdpJfgtygX31ICXgc
         PiBcrdVBdyRfefuURCtA/dUr4YEMWcFtcHS1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=dP7fQEJMOUEgND4T7oS0Te4rg/mnx+Bt4IKFeun17+g6BL1PpO1mR7KdlU4LE61WX9
         Xi9f2MbfJlGP+OqpyK2xiQHSPC7N1lBr4exLb7rKOkeLE0sxumSGCPBdkFDnXsbpkxKC
         6GSIjmFql2RItyMnL46rcRWhQ8aEJvVU8ssVI=
Received: by 10.150.160.1 with SMTP id i1mr2056865ybe.367.1273251452578; Fri, 
	07 May 2010 09:57:32 -0700 (PDT)
Received: by 10.150.217.12 with HTTP; Fri, 7 May 2010 09:57:12 -0700 (PDT)
In-Reply-To: <7v4oijhdsi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146543>

On Fri, May 7, 2010 at 12:33 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com> writes:
>> - An attribute called "auto-eol" is set in the repository to turn on
>> =A0 normalization of line endings. =A0Since attributes are content, =
the
>> =A0 setting is copied when the repository is cloned and can be chang=
ed in
>> =A0 an existing repository (with a few caveats). =A0Setting this att=
ribute
>> =A0 is equivalent to setting "core.autocrlf" to "input" or "true".
>
> In what way is this attribute different from existing "crlf" attribut=
e?

Mostly that it relates to the new core.eolStyle config option instead
of core.autocrlf.  Arguably you could use the same gitattribute to set
both config options, but I don't know how you'd make that respond in a
sane backwards-compatible fashion.

> It feels as if this series is fixing shortcomings of the combination =
of
> core.autocrlf configuration and crlf attribute while trying very hard=
 to
> keep their shortcomings when the user doesn't say so. =A0What is the
> downside of making the existing "core.autocrlf" + "crlf" combination =
do
> what your patch wanted to do without retaining this "keep the existin=
g
> shortcomings for backward compatibility"?

Is this even possible?  If core.autocrlf is set, then files all over
the place start getting crlf conversion, even if no attributes are set
at all.  If core.eolStyle is set, only files with the auto-eol
attribute set appropriately will experience any conversion.

Maybe the options aren't named ideally.  "core.eolStyle" might better
be named "core.nativeEol" - it tells git what the native EOL style is
on your computer / in this repository, but it doesn't tell git to *do*
anything with this information.  The problem with core.autocrlf is
that it mixes two concepts: identifying your native EOL style, and
telling git to do stuff.  The existing gitattribute can then tell git
*not* to do stuff, but almost no projects have a .gitattributes file
that does this.

>> 1. Setting core.autocrlf in your global or system configuration is a
>> pain
>
> This is a wrong thing to do to begin with, and not worth discussing.

Ha, doesn't msysgit do this by default?  It did at one point, anyway.
I use cygwin git (which doesn't because it thinks it's Unix) so I
don't know.

If this was ever the default behaviour, then it's at least not
*obviously* wrong.

The end result is that nobody really likes the current autocrlf
behaviour, though, so I'd agree that it *ends up* being wrong.  Just
as setting it on a per-checkout basis also ends up being wrong,
because it's so easy to forget.

>=A0You
> know and your readers know that line ending convention in the reposit=
ory
> data (i.e. blobs) is under project control while line ending conventi=
on in
> the working tree is end user preference.

Yes.  But the current system doesn't make it very easy to state your pr=
eference.

>> 2. Setting core.autocrlf in an individual repository would be okay
>> except that naive users will do it after they have already cloned:
>> unless core.autocrlf is set globally, the clone will have the wrong =
line
>> endings, and the user needs to know how to refresh it manually (rm -=
rf *
>> && git checkout -f).
>
> This may be a worthy goal. =A0But if a "auto-eol" attribute "fixes" t=
his,
> perhaps "crlf" attribute can be taught to fix it the same way, no?

It fixes it by making the global setting actually do what people want.
 I'm not sure the existing config option can be made to work like
that.

Again, maybe it would make sense to combine a single attribute but
have two config options (and people can eventually just stop using
core.autocrlf altogether).  I suspect it might subtly break some
existing projects, though.

Have fun,

Avery
