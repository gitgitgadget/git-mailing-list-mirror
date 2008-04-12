From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add two core.sharedRepository options: group-readable
 and world-readable
Date: Sat, 12 Apr 2008 03:03:26 -0700
Message-ID: <7vprsvie4x.fsf@gitster.siamese.dyndns.org>
References: <20080411140916.GA30667@zakalwe.fi>
 <7vfxtrnban.fsf@gitster.siamese.dyndns.org>
 <20080412030021.GB31039@zakalwe.fi>
 <7vzlrzlluj.fsf@gitster.siamese.dyndns.org>
 <20080412091723.GB20443@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Heikki Orsila <shdl@zakalwe.fi>, git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 12 12:04:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jkcat-0006gy-VE
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 12:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757051AbYDLKDi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Apr 2008 06:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757628AbYDLKDi
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 06:03:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48499 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757051AbYDLKDh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Apr 2008 06:03:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1DA5D1916;
	Sat, 12 Apr 2008 06:03:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 294BF1915; Sat, 12 Apr 2008 06:03:28 -0400 (EDT)
In-Reply-To: <20080412091723.GB20443@atjola.homenet> (=?utf-8?Q?Bj=C3=B6rn?=
 Steinbrink's message of "Sat, 12 Apr 2008 11:17:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79342>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> On 2008.04.11 21:48:36 -0700, Junio C Hamano wrote:
>> ...
>> My question was about the "o=3D" part.  I did not see you dropping b=
its for
>> others in your patch.
>>=20
>> And if your answer is "the user should have xx7 umask", that defeats=
 the
>> whole point of your patch, as you are trying to dissociate the umask=
 used
>> by the user for his usual task and enforce particular permission pol=
icy
>> for the repository.
>
> I don't think it defeats the purpose of the patch...
> ... From that point of view, I think that the patch is a natural
> enhancement, allowing to override the umask in a way that only grants
> additional read permissions for either the group, or the group and
> others. And that's exactly what Heikki was after.

That is exactly my point.

If a patch (cl)aims to improve things by overriding user's umask, why
should it limit itself only in the loosening direction?

The patch adds a handful new keywords allowed in the config area; if we
want to replace or enhance what Heikki's patch does later with a more
general mechanism that allows both loosening and tightening user's umas=
k,
these keywords that represent "a set of umask modifications that were
designed with only loosening in mind" can become maintenance burden, as=
 we
must keep them for backward compatibility.

They may look small, but these things add up.  Even though incremental
improvement is possible and it generally is a much better way to enhanc=
e
the system, compared to an overengineered complexity that ends up being
not used by anybody, it is my job to bring it up as a potential issue w=
hen
there is a future enhancement possibilty (which may or may not be usefu=
l
after all) that may become more cumbersome to implement if we do this
half-step now.

=46or this reason, I am not impressed by a "this is a half-step and is
better than the status quo" as a supporting argument.  A supporting
argument that says "Theoretically tightening could also be useful, but =
it
is much less so, compared to loosening which Heikki implemented.  The
reason why tightening is not so useful is because of such-and-such.
Hence, it is reasonable to implement only loosening."  is much much mor=
e
convincing.

Please fill in the "such-and-such" above, convince me and others, so th=
at
I can apply Heikki's patch.

I use quite a liberal umask myself for normal uses and a natural
expectation for a patch to improve in this area from me is to allow
applying a tighter-than-usual mask for a particular set of repositories
that house my personal stuff.  One practical workaround I can think of =
is
to just manually limit the access by running chmod at the toplevel of t=
he
repository, so that _could_ be your "such-and-such".  Although it feels
somewhat hacky, I can live with it.
