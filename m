Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FC052018E
	for <e@80x24.org>; Fri,  5 Aug 2016 15:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759988AbcHEPkG (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 11:40:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52166 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759978AbcHEPkF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 11:40:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 70A7930A19;
	Fri,  5 Aug 2016 11:40:03 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4mbcR+5O73ymDfo/eFwXY4Uh0G4=; b=JwU8nb
	osXnPJpkuIA+Sk1zrsTqs9pIBDNzFOP2heM6chrTOGcsqVnOwjxZ8Vxw4ACHX+dB
	lEVw8cAhZ1su9NW3jVcNwNx6X03YsD4NAEHM4HYDK6zyHwuKAJbrvEklD8TBGlpz
	tN0PizMmWrFBXtzY4FUXn8D8TipCLBEi9xGOg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e6w3wni28DNUEwIW89vnrcmCQTeYp17l
	KD0tayeNV0WQSQFWjjJtvsiGQFoAkON5tvj1DsnJ/BTuV7ywKQNW7k6ZLX/+5HF5
	pHf7IkVyhthyD+vrivjMvnVdyTbTHYJYuWiFqdaAap/d4ecnBnnha0MZmqb7zbC3
	Ryn7GIs5R7A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 667B930A18;
	Fri,  5 Aug 2016 11:40:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2C94B30A15;
	Fri,  5 Aug 2016 11:40:02 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	"Michael S. Tsirkin" <mst@redhat.com>
Cc:	Martin Fick <mfick@codeaurora.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Git List <git@vger.kernel.org>, repo-discuss@googlegroups.com
Subject: Re: storing cover letter of a patch series?
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
	<xmqqh9n241el.fsf@gitster.mtv.corp.google.com>
	<18979417.pyyHNUINeQ@mfick1-lnx>
	<xmqqzj0u2k5m.fsf@gitster.mtv.corp.google.com>
	<20160804234920.GA27250@redhat.com>
Date:	Fri, 05 Aug 2016 08:39:58 -0700
In-Reply-To: <20160804234920.GA27250@redhat.com> (Michael S. Tsirkin's message
	of "Fri, 5 Aug 2016 02:49:20 +0300")
Message-ID: <xmqqy44bxm0h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DFF53BA2-5B22-11E6-B7AD-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Thu, Sep 10, 2015 at 11:39:49AM -0700, Junio C Hamano wrote:
>> The problem with "empty commit trick" is that it is a commit whose
>> sole purpose is to describe the series, and its presence makes it
>> clear where the series ends, but the topology does not tell where
>> the series begins, so it is an unsatisifactory half-measure.
>
> Actually, when using topic branches the series always ends at head, so
> it's better to keep the empty commit where series begins.

But that would mean that you would need to destroy and recreate more
commits than you would need to.  If you have a five-commit series
(with the bottom "description" one, you would have six commits) and
you are already happy with the bottom two but want to update the
third one, you wuld have to "rebase -i" all six of them, reword the
bottom "description" to adjust it to describe the new version of the
third one _before_ you even do the actual update of the third one.

That somehow feels backwards, and that backward-ness comes from the
fact that you abused a single-parent commit for the purpose it is
not meant to be used (i.e. they are to describe individual changes),
because you did not find a better existing mechanism (and I suspect
there isn't any, in which case the solution is to invent one, not
abusing an existing mechanism that is not suited for it).

If this were part of a workflow like this, I would understand it:

 * Build a N-commit series on a topic.

 * You keep a "local integration testing" branch ("lit"), forked
   from a mainline and updated _every time_ you do something to your
   topics.  You may or may not publish this branch.  This is the
   aggregation of what you locally have done, a convenient place to
   test individual topics together before they get published.

 * A new topic, when you merge it to the "lit" branch, you describe
   the cover as the merge commit message.

 * When you updated an existing topic, you tell a tool like "rebase
   -i -p" to recreate "lit" branch on top of the mainline.  This
   would give you an opportunity to update the cover.

Now the tool support for the last one is the missing piece.  In
addition to what "rebase -i -p" would, it at least need to
automatically figure out which topics have been updated, so that
their merge commit log messages need to be given in the editor to
update, while carrying over the merge log message for other topics
intact (by default).

With that, you should also be able to teach "format-patch --cover"
to take these merge messages on "lit" into account when it creates
the cover letter.
