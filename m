From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] i18n: Not add stripped contents for translation
Date: Sun, 04 Mar 2012 19:42:28 -0800
Message-ID: <7vobsb67dn.fsf@alter.siamese.dyndns.org>
References: <1330910494-17216-1-git-send-email-worldhello.net@gmail.com>
 <7v7gyz7pei.fsf@alter.siamese.dyndns.org>
 <CANYiYbGdJ0yFmPnsK_JdABwmFraVdNi08QgFKRmGzJt-DA9tBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 04:43:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4Op8-0002i0-L9
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 04:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755182Ab2CEDmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Mar 2012 22:42:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35920 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335Ab2CEDmb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 22:42:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E83646C74;
	Sun,  4 Mar 2012 22:42:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tzhFdsjLsCxRgem22ajqk9bg8gQ=; b=ifujQi
	wP1tYOinSOrRu25tamlPi62cFQagmXVbq6OAIu48teA9jUq+/bGouwOfE9wlplp5
	lcyf3czGIOez4/f1DVIQycvECBZP1/8APg7m+hMbXAGxrDa0kn8vaaoCETkOLOX4
	UtneDRozcLthtMEoCWScP4djq9nLFVmmFd55o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cOJSqeeSYbJJRvvPQQqZMvO0UqMfpOaR
	Y12e0EBoMBJdp9Dh9+IWbkM+rSkj8lx6GTgtiJNIVBYKXo72CzzHga6DrKO36g0L
	Phz3bCaXJoh0/RnUpuF0nGjp3z3S30Y48703oF9AAGzykndGjz5mTGaFpDu92yMs
	W3VuIEKzDmc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF8316C73;
	Sun,  4 Mar 2012 22:42:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 557516C72; Sun,  4 Mar 2012
 22:42:30 -0500 (EST)
In-Reply-To: <CANYiYbGdJ0yFmPnsK_JdABwmFraVdNi08QgFKRmGzJt-DA9tBw@mail.gmail.com> (Jiang
 Xin's message of "Mon, 5 Mar 2012 11:01:30 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3C1DC202-6675-11E1-B64D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192192>

Jiang Xin <worldhello.net@gmail.com> writes:

> Orignal source code:
>
> 244   case WT_STATUS_CHANGED:
> 245     if (d->new_submodule_commits || d->dirty_submodule) {
> 246       strbuf_addstr(&extra, " (");
> 247       if (d->new_submodule_commits)
> 248         strbuf_addf(&extra, _("new commits, "));
> 249       if (d->dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
> 250         strbuf_addf(&extra, _("modified content, "));
> 251       if (d->dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
> 252         strbuf_addf(&extra, _("untracked content, "));
> 253       strbuf_setlen(&extra, extra.len - 2);
> 254       strbuf_addch(&extra, ')');
> 255     }
>
> The bad thing is strbuf_setlen() at line 253. We can not asume the translation
> of ", " must be 2 characters.

It sounds like you are merely working around a poor style in the original,
which should have been structured more like this in the first place, no?

        /* a helper function elsewhere, possibly inlined */
        static void add_iwsep_as_needed(struct strbuf *buf, int origlen)
        {
                if (buf->len != origlen)
                        strbuf_addstr(buf, _(","));
        }

        ...
        int origlen;

        strbuf_addstr(&extra, " ("))
        origlen = extra.len;
        if (a)
                strbuf_addstr(&extra, _("msg a"));
        if (b) {
                add_iwsep_as_needed(&extra, origlen);
                strbuf_addstr(&extra, _("msg b"));
        }
        if (c) {
                add_iwsep_as_needed(&extra, origlen);
                strbuf_addstr(&extra, _("msg c"));
        }
        strbuf_addstr(&extra, ")");

Cc'ing Jens whose 9297f77 (git status: Show detailed dirty status of
submodules in long format, 2010-03-08) introduced the "two-byte backstep".


This is a tangent and I am just showing aloud my ignorance, but I wonder
if there is a reasonably generic and "best current practice" way to
structure code to show an enumeration in human languages, for example,

	A, B, C and D.

in an easier-to-translate way.

I suspect that it might be sufficiently generic if we can make it possible
to allow the first and the last inter-word-separation and the token after
all the items to be different from other inter-word-separation tokens.

E.g. in English, the first one and all the "other" are ", ", the last
inter-word token is " and ", and the token at the very end is ".". In
Japanese some translators may want to say "AやBとCとD。", meaning the
first one is "や", "。" is used at the very end, and all the others may be
"と".
