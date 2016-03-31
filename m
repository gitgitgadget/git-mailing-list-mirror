From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] clone: respect configured fetch respecs during initial fetch
Date: Thu, 31 Mar 2016 15:44:26 -0700
Message-ID: <xmqqbn5ul12t.fsf@gitster.mtv.corp.google.com>
References: <20160307153304.GA23010@sigill.intra.peff.net>
	<1459349623-16443-1-git-send-email-szeder@ira.uka.de>
	<xmqq1t6qr5c1.fsf@gitster.mtv.corp.google.com>
	<xmqq1t6qo4rd.fsf@gitster.mtv.corp.google.com>
	<20160331225055.Horde.1X4mNM4L4J85rAeMFQzAEH_@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Apr 01 00:44:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1allKN-0002fK-L5
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 00:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655AbcCaWob convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2016 18:44:31 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:64620 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753136AbcCaWo3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2016 18:44:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EFDF052633;
	Thu, 31 Mar 2016 18:44:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AtPxRwttNsCZ
	4UN88hns0BkKz7Y=; b=AVyTyIuw6dQ69eSRcIjB5M0CLscsttcrwkgqIkj8PYrw
	caaAZikA8+9PcglpSkqgV1dKdXI/aRnfQR8oHNiXyiQVyiuJo8920Q382HzVtDV2
	Mgz3CT9+7gEF5h8EYdehcipr+1xxPJdrk81dOpGgmQncf9eAbHpTc02g88qVk5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YPZOsa
	AUtpLY64Ra8J0XHea+tNpyAlmR5J1T3SQEE//wvSHtTTOgwvefSu2njNHFG/uIeN
	UtFybGcIGFgIGPfpf6eStCqxtpZ6SqC3IC/Z8nwXWAReCaMGREgP+B2F9U6IBW/z
	63qtxXd0JekZIEYAjCqnpk2MNBlA2TpLtGDYI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E6BC652632;
	Thu, 31 Mar 2016 18:44:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6200452631;
	Thu, 31 Mar 2016 18:44:28 -0400 (EDT)
In-Reply-To: <20160331225055.Horde.1X4mNM4L4J85rAeMFQzAEH_@webmail.informatik.kit.edu>
	("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Thu, 31 Mar 2016 22:50:55
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2051AF18-F792-11E5-9457-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290482>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> Quoting Junio C Hamano <gitster@pobox.com>:
>
>> IOW, special casing -c remote.origin.fetch=3Dspec
>> is a bad idea.
>
> I completely agree :)
> But it's the other way around.
>
> 'remote.origin.fetch=3Dspec' during clone is special _now_, because t=
he
> initial fetch ignores it, no matter where it is set.
>
> My patch makes it non-special, so that the initial fetch respects it,
> the same way it already respects 'fetch.fsckObjects' and
> 'fsck.unpackLimit', or the way the initial checkout respects e.g.
> 'core.eol'.

=2E.. but does "git -c core.eol clone" leave that configuration in the
resulting repository's .git/config?  "git -c user.name=3Dfoo" for that
matter.

They may affect the one-shot operation but are not left in the
resulting .git/config, which was what I was driving at.  To make
clone behave as if it is truly a short-hand of

	git init
	git config ;# with default and necessary tweaks to adjust
		   ;# for things like -b, -o, --single-branch
        git fetch
        git checkout

which by the way I think everybody agrees is a worth goal, then
shouldn't the update to the current code be more like "prepare the
default config, tweak with whatever configuration necessary, and
re-read the config before driving the equivalent of 'git fetch'?"

And the conclusion my rhetorical questions led to was that "adjust
for things like..." should not include what comes from "-c var=3Dval"
because there is no sensible way to incorporate them in general.

The most important point is that "-c var=3Dval" is the wrong source of
information to blindly propagete to the resulting .git/config.  And
the point of "--branches" option is not that it would be short and
tidy, but it is more targetted.  With such an approach, nobody would
imagine "git -c random.var=3Dvalue clone" would be propagated into the
resulting .git/config in a random and unspecified way.

Once you learn what custom set of refs the user wants to fetch, you
would need futzing of the refspecs like you did in your patch. That
part of your patch is salvageable.  The part that special cased the
information that came from "-c remote.origin.fetch" while ignoring
others like user.name that came from exactly the same mechanism via
"-c user.name" is not.
