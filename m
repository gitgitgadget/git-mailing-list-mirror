From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: A generalization of git notes from blobs to trees - git metadata?
Date: Sun, 7 Feb 2010 16:36:59 +1100
Message-ID: <2cfc40321002062136q64f832aesd979c9cb22f3612@mail.gmail.com>
References: <2cfc40321002060532g4d22dd4dx403bf312708e1424@mail.gmail.com>
	 <201002070236.12711.johan@herland.net>
	 <7v1vgxlr9q.fsf@alter.siamese.dyndns.org>
	 <20100207050255.GA17049@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 07 06:37:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndzpg-0006aX-Ms
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 06:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227Ab0BGFhB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Feb 2010 00:37:01 -0500
Received: from mail-pz0-f172.google.com ([209.85.222.172]:40634 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118Ab0BGFhA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Feb 2010 00:37:00 -0500
Received: by pzk2 with SMTP id 2so1544422pzk.21
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 21:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=H0t+PgVjTYIeHYe+RdX0Kh78FShr0949qlvK05Aw8fo=;
        b=Nznua99GnQRuSovC4RDWNssAQVHQmOFJwC4ZKwBnEGDLdhoVB9Dwn8kStoHaj6DrMT
         e1SJjpminF9UH4aTkmK/PD2+P1QMkiev8vBNiVckJqg1kF3tr019LFCilDuu/CxgXwOj
         /ohKqlcAYRogxIwEZmLr7d9vWrgHbrFj3Hu0U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UgpvN5xBSresAh+iYk1lwNpZClDvg05QouyNhoj93BDhLfePZg0d7U3G/3Q1wA9gVR
         9+iR2hGTF2UC7iJ/K1Q7v+RZPtSfal1y7+3Llr+hoXEQCZC35NboN0vHTJ3rbMYHylKU
         2wzpzq0lRbzskbz/wclEGQVisRMDq3W4i3KCM=
Received: by 10.114.248.23 with SMTP id v23mr2889549wah.189.1265521019874; 
	Sat, 06 Feb 2010 21:36:59 -0800 (PST)
In-Reply-To: <20100207050255.GA17049@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139220>

On Sun, Feb 7, 2010 at 4:02 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Feb 06, 2010 at 06:21:37PM -0800, Junio C Hamano wrote:
>
>> Johan Herland <johan@herland.net> writes:
>>
>> > Furthermore, although we currently assume that all note objects ar=
e blobs,
>> > someone (who?) has already suggested (as mentioned in the notes TO=
DO list)
>> > that a note object could also be a _tree_ object that can be unpac=
ked/read
>> > to reveal further "sub-notes".
>>
>> I would advice you not to go there. =A0How would you even _merge_ su=
ch a
>> thing with other notes attached to the same object? =A0What determin=
es the
>> path in that tree object?
>>
>> Clueless ones can freely make misguided suggestions without thinking
>> things through and make things unnecessarily complex without real ga=
in.
>> You do not have to listen to every one of them.
>
> I think I may have been the one to suggest trees or notes at one poin=
t.
> But let me clarify that this is not exactly what the OP is proposing =
in
> this thread.
>
> My suggestion was that some use cases may have many key/value pairs o=
f
> notes for a single sha1. We basically have two options:
>
> =A01. store each in a separate notes ref, with each sha1 mapping to
> =A0 =A0 a blob. The note "name" is the name of the ref.
>
> =A02. store notes in a single notes ref, with each sha1 mapping to a
> =A0 =A0 tree with named sub-notes. The note "name" is the combination=
 of
> =A0 =A0 ref-name and tree entry name.
>

So, of course, options (1) and (2) need not be exclusive. Use Option
(1) for different metadata sets and option (2) to partition individual
datasets.

>
> With respect to the idea of storing an arbitrary tree, I agree it is
> probably too complex with respect to merging. In addition, it makes
> things like "git log --format=3D%N" confusing. I think you would do b=
etter
> to simply store a tree sha1 inside the note blob, and callers who wer=
e
> interested in the tree contents could then dereference it and examine=
 as
> they saw fit. =A0The only caveat is that you need some way of telling=
 git
> that the referenced trees are reachable and not to be pruned.
>

As I see it, the existing use of notes is a special instance of a more
general metadata capability in which the metadata is constrained to be
a single blob. If notes continued to be constrained in this way, there
is no reason to change anything with respect to its current userspace
behaviour. That said, most of the plumbing which enabled notes could
be generalized to enable the arbitrary tree case [ which admittedly, I
have yet to sell successfully !]

In one sense, there is a sense in the merge issue doesn't exist. When
the maintainer publishes a tag no-one expects to have to deal with
downstream conflicting definitions of the tag. Likewise, if the
maintainer were to publish the /man and /html metadata trees (per my
previous example) for a release tag, anyone who received
/refs/metadata/doc would expect to receive the metadata trees as
published by the maintainer. Anyone who didn't wouldn't have to pull
/refs/metadata/doc.

I can see there are use cases where multiple parties might want to
contribute metadata and I do not currently have a good solution to
that problem, but that is not to say there isn't one - surely it is
just a question of applying a little intellect creatively?

jon.
