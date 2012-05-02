From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 2/2] index-v4: document the entry format
Date: Wed, 2 May 2012 08:12:13 -0700
Message-ID: <CAJo=hJvFfVbYRKtPDJbd8MXKFDAyk==Sbm8oTgypbpE2O4o1=w@mail.gmail.com>
References: <1333493596-14202-1-git-send-email-gitster@pobox.com>
 <xmqqzk9w93zu.fsf@junio.mtv.corp.google.com> <xmqqpqas93sa.fsf_-_@junio.mtv.corp.google.com>
 <87vckhuofj.fsf@thomas.inf.ethz.ch> <7vlilcczzb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Michael Barr <davidbarr@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 02 17:12:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPbET-0000HW-Se
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 17:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391Ab2EBPMf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 11:12:35 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45820 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753405Ab2EBPMe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 May 2012 11:12:34 -0400
Received: by pbbrp8 with SMTP id rp8so1213386pbb.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 08:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Yqv8cMJf6sGZcpz6D72mqbDhQdWmharPtOMeYqGHA6E=;
        b=MP1QdqZ6NrxcoTTJNdkIKaktTycQw4lLgG9HLvIOxQITMNPvi5z26gsUheb/EPrCGP
         HSDopiF+N4j3hp5C98eIahkVO3vvDYakx9jxPycAWI0NLh9VJEOKNG3gPbFYjXk/msbh
         kjkOT2vgjXAgz64FBrSfXhXRVcMFs3cRqZawo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=Yqv8cMJf6sGZcpz6D72mqbDhQdWmharPtOMeYqGHA6E=;
        b=cxSPm/iJvuUFanPEbXgV8sTPq+DXf7Xzz7RvbfrhGvSaJf773uKuAt6TjcWw7UGn4K
         YmN3KYVAxubTb0sIJytnO5fY+6e4lLDbMq+jDxY71h3WN8ZCdQ44uqTJp9C5baxxcf2g
         mNuwF8V/urWKgVTogelP/fACUX2QPxT/E9zP7jYz3q49LH64V+lfILt1Vt/XAB3XgJAo
         ovNlpN7OsoRaeyh28nOgIuc7U0sZcWksShSyglX4cmC0kYsrPke1Y7bcZ7J6P7RTt/Rb
         /PcZo4ZvGvP6l2QzCRSPVv7TH+RTTlyMEteYKy1ntQ9W7VExrKjqAq0Budoz6YOt6130
         SyEQ==
Received: by 10.68.194.227 with SMTP id hz3mr41798824pbc.23.1335971553695;
 Wed, 02 May 2012 08:12:33 -0700 (PDT)
Received: by 10.68.211.74 with HTTP; Wed, 2 May 2012 08:12:13 -0700 (PDT)
In-Reply-To: <7vlilcczzb.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQkpCqH+oDfafL1CQWoIkK4CqBRNMB63b43wytXYbSiCKjlzHz11PB9brPsi0NSkvVMLvdAx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196833>

On Mon, Apr 30, 2012 at 9:00 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>> * The prefix compression. =A0Thomas is not using this idea; we've be=
en
>> =A0 toying with making the index bisectable (within each directory) =
for
>> =A0 fast single-entry lookups, which inherently conflicts with this.=
 =A0The
>> =A0 directory-like layout partially achieves the same (elides common=
 path
>> =A0 components).
>>
>> * The varint encoding (or offset encoding, but "varint" is something=
 you
>> =A0 can google :-). =A0David suggested using it on stat() data, comb=
ined
>> =A0 with zigzag encoding and delta against the first entry in the
>> =A0 directory, which gives some good compression results. =A0Profili=
ng will
>> =A0 have to say whether the extra decoding effort is worth the space
>> =A0 savings.
>>
>> * The lack of variable padding, which is a good idea -- in any case =
I
>> =A0 seem to remember Shawn complaining about it.

I complain about a lot of things. Here is another...

> I am planning to merge this series early to 'master', before the GSoC
> student really starts working on the code, perhaps by this Wednesday.=
 The
> earlier parts of this series refactor code to make things easier to
> modify, and the later parts of it demonstrate by example both:

I think this is a bad idea.

=46or sake of argument, lets say the GSoC project goes really well, and
the student creates a great implementation of (what is now) index v5.
Lets say we all agree its a great evolution of the format, the
implementation is sane, and there is no reason not to merge it and
make it the default.

If this v4 thing merges to master and you make a release from master,
we are potentially stuck supporting this new v4 format for the next 2
years, along with v5 which we want to immediately replace it. If any
OS distro picks up a release Git that supports v4 but not v5, and
parks it into their stable tree, the rest of the Git ecosystem (e.g.
libgit2, JGit) will be supporting v4 until that OS distro release dies
and all of its users are able to move to a newer distro with a newer
Git version.

Consider my case at $DAY_JOB where we still have Git 1.7.7.3 as the
standard Git. Upstream has already shipped 1.7.10 and is well on its
way to 1.7.11, but the distro choose to freeze on 1.7.7 rather
arbitrarily because that was the latest stable release version at the
time the distro was freezing its package sets for its own release.
Yay.


IMHO, keep this in next to avoid releasing it until we know the
outcome of the GSoC project. The handful of WebKit developers that use
Git that really benefit from index v4 can use it by building and
installing their own next. If they can't work `make install
prefix=3D$HOME/git`, they might want to reconsider their career and
hobby activities. And we can be sure it won't show up in a distro
release, thereby avoiding us needing us to support what may turn out
to be a dead-end index v4. The GSoC student can build on this topic
until their own work arrives in your tree.

Its only a few months to wait and see where "v5" goes. If v5 is
successful, v4 will just be a minor footnote in the history of Git,
and other tools won't need to support v4, they can go straight to v5.
If v5 fails and we choose to ship and commit to supporting v4, its
only a few months delay. We have had index v2/v3 for years. We (and
our users) can wait a couple of additional months for a format we can
support.
