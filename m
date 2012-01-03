From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-svn, perl/Git.pm: add central method for
 prompting passwords honoring GIT_ASKPASS and SSH_ASKPASS
Date: Tue, 03 Jan 2012 11:42:01 -0800
Message-ID: <7v4nwcvaie.fsf@alter.siamese.dyndns.org>
References: <4EC52508.9070907@tu-clausthal.de>
 <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com>
 <4EC65DE4.90005@tu-clausthal.de>
 <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com>
 <4ED0CE8B.70205@tu-clausthal.de>
 <20111130064401.GC5317@sigill.intra.peff.net>
 <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain>
 <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de>
 <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org>
 <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5EB3.4000802@tu-clausthal.de>
 <CACBZZX7P9PEq0wZp0d3dSwDjF6J6Z3cO4VtWc9_frBengtqPLw@mail.gmail.com>
 <4F02D79B.1020002@tu-clausthal.de>
 <CACBZZX6iMobuU90skpbNPaGQFxYNOAjmZ6ceO4PGqfZSMkgePQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 03 20:42:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiAFP-0000Fg-Vl
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 20:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754374Ab2ACTmG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jan 2012 14:42:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63343 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751476Ab2ACTmE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jan 2012 14:42:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAA6E59CF;
	Tue,  3 Jan 2012 14:42:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=OttVPYYBdQvP
	CgdwCSOmXA4m6XE=; b=fpVXcqI0x/ZZeLi2sTgtR1UfPk959TING5tYbRutMrDP
	kPdswOfdJJP4yYjmMxRI66AEehRvQyPPahf2DJQ+W5kUZ2sewxymoM8b+lIlJtQR
	uhXPgqrpOv7jerJz5qb/hVpry/GJlcIoWBRDsJo/tCmF8SwrpWIjxroC7jeCTSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YKt82H
	hbVof3QN+pSBtdq+QXiZHGmowcJmBdGqPsYU1+SZlWh41KCoSC3emiYTZ6NhGIkR
	JBuUBwGu5s88VLxKu9Ab7PngvGPijxy9L1t911yjrVktHvcv1SBU3wWXeNmPEz3s
	vUclevUprDTuRv5ziVCZ2cKbmIpxXFNF1LliQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A153159CE;
	Tue,  3 Jan 2012 14:42:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 252DD59CD; Tue,  3 Jan 2012
 14:42:03 -0500 (EST)
In-Reply-To: <CACBZZX6iMobuU90skpbNPaGQFxYNOAjmZ6ceO4PGqfZSMkgePQ@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 3 Jan
 2012 13:03:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0291E21E-3643-11E1-AB34-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187880>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> And how about this:
>
>     perl -MData::Dumper -MFile::Temp=3Dtempfile -we 'my $str =3D
> "moo\015\012"; my ($fh, $name) =3D tempfile(); print $fh $str; close
> $fh; open my $in, "<:crlf", $name or die $!; my $in_str =3D <$in>;
> chomp(my $cin_str =3D $in_str); print "in_str:<$in_str>
> cin_str:<$cin_str> END\n"'
>
> It could be that there's some bug in either perl or mingw's build of
> perl where it won't turn on the :crlf IO layer by default.

I agree that PERLIO may be a solution that is supposed to work, but let=
's
not go there, at least not yet in this patch. The stripping of \015\012
(not \r\n) was copied from the original code and I would prefer to see =
the
patch focus on one primary thing it wants to enhance at a time.

Thanks.
