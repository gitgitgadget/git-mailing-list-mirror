From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log-tree: use custom line terminator in line termination
 mode
Date: Tue, 01 May 2012 09:12:10 -0700
Message-ID: <7v1un3c23p.fsf@alter.siamese.dyndns.org>
References: <86ty01qez7.fsf@red.stonehenge.com>
 <1335811555-23564-1-git-send-email-jk@jk.gs>
 <7vaa1tf1w8.fsf@alter.siamese.dyndns.org>
 <20120501085649.GD4998@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>, git@vger.kernel.org,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 01 18:12:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPFgb-00026C-Ge
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 18:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757458Ab2EAQMP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 12:12:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50338 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756193Ab2EAQMN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2012 12:12:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2F3B6F6C;
	Tue,  1 May 2012 12:12:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5B6wg75tu1BB
	28m0sK+Be+P1HPc=; b=RgOjqvjBsuFMp2N4ocVsWCAe51EPuRtS/zXNx9FEKf5E
	iU0tNft1V0EGIohfezkdIWNKUZxazCJeU7X9YY7IeBVso3atHctlYTGGe3AD/ifi
	lgYJuX57IpjhouYQyTc1eS7bISs4tdxeeLS55Jw+IOk7lmSTThiMr+L6PsXeR8o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xxmE35
	EbNA5hkSojJM2bHEDXRQE+MS4kGhkFERCxMK1swGo5RN5U8zFmXa1O+xPzWd2mx/
	4EIo68YIC2XU7I9HYWSVNzU4Rs1i0novL88tJTEXgVE4fLHW2VdWy0/qDRNPwFrv
	mw63KJ+xQpWOV7nVrTGEghmrzq4ayQp/8voB4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9F596F6B;
	Tue,  1 May 2012 12:12:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4CF0C6F6A; Tue,  1 May 2012
 12:12:12 -0400 (EDT)
In-Reply-To: <20120501085649.GD4998@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 1 May 2012 04:56:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6900BE36-93A8-11E1-BF53-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196687>

Jeff King <peff@peff.net> writes:

> On Mon, Apr 30, 2012 at 12:36:07PM -0700, Junio C Hamano wrote:
>
>> Jan Kr=C3=BCger <jk@jk.gs> writes:
>>=20
>> > When using a custom format in line termination mode (as opposed to=
 line
>> > separation mode), the configured line terminator is not used, so t=
hings
>> > like "git log --pretty=3Dtformat:%H -z" do not work properly.
>> >
>> > Make it use the line terminator the user ordered.
>> >
>> > Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
>> > ---
>> >  log-tree.c |    2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/log-tree.c b/log-tree.c
>> > index 34c49e7..44f0268 100644
>> > --- a/log-tree.c
>> > +++ b/log-tree.c
>> > @@ -682,7 +682,7 @@ void show_log(struct rev_info *opt)
>> >  	if (opt->use_terminator) {
>> >  		if (!opt->missing_newline)
>> >  			graph_show_padding(opt->graph);
>> > -		putchar('\n');
>> > +		putchar(opt->diffopt.line_termination);
>> >  	}
>> > =20
>> >  	strbuf_release(&msgbuf);
>>=20
>> Looks sensible.  Perhaps we would want to add a test?
>
> Hmm. This came up before, and the issue is (or can be) slightly more
> complex:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/122478/focus=
=3D122568

Yeah, the test given completely forgets about "log -p" case, as you sai=
d
in the above:

    But we can't just modify that to use the specified line terminator,
    because sometimes it is acting as a separator between commit messag=
e and
    diff, and sometimes it is acting as the terminator of the whole rec=
ord.

So the patch is not quite right for the "log -p -z" (or "log --stat -z"=
)
case.

The correct output would have NUL after each commit, so "-z --format=3D=
%s"
would have a single-liner subject with the line-terminating LF replaced
with NUL, and "-p/--stat -z --format=3D%s" would have a single-liner su=
bject
with its line-terminating LF, followed by the diff/diffstat in which th=
e
terminating LF of the last line is replaced with NUL, but to be consist=
ent
with what "-p/--stat -z --pretty=3Dformat:%s" does, I think it is OK to
append NUL to the diff/diffstat part instead of replacing its last LF w=
ith
NUL.
