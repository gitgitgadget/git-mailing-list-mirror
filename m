From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tag: Use OPT_BOOL instead of OPT_BOOLEAN to allow one action multiple times
Date: Wed, 31 Jul 2013 16:10:22 -0700
Message-ID: <7vbo5itjfl.fsf@alter.siamese.dyndns.org>
References: <1375207251-4998-1-git-send-email-stefanbeller@googlemail.com>
	<7va9l3x34f.fsf@alter.siamese.dyndns.org>
	<51F83010.2060804@googlemail.com>
	<7vfvuvvg0r.fsf@alter.siamese.dyndns.org>
	<51F8E81E.6000705@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Aug 01 01:10:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4fXL-0007Ov-AF
	for gcvg-git-2@plane.gmane.org; Thu, 01 Aug 2013 01:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877Ab3GaXK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 19:10:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42949 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888Ab3GaXK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 19:10:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB45B35564;
	Wed, 31 Jul 2013 23:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oaHj/mgOgufSRLhc+DGV93GU3f8=; b=llzYPG
	rmNE3n2sJJy3dVYt3dUSkfo2U35nOZVQ8oyl9cGMF7KUcgBczC/azLhDRFF+VaWl
	jvAH7euo/VIUEYNkgBHIfg2rAPd16L6vULIuoyC5EmYtl1MvefNq/iNBc4weNDyu
	pKcWBQj3NHmr1of8Ga0kG/BHOVU8MH5KN4IUU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m8Vd35nTUOLkQwfOpFneGYYFlCyNrSVk
	izRj5OPejnd54AyES8Lga7adwfzjHIYxhufhvj3a6Rzoa6ZGqQ6qaJTG/E2ap0po
	AL8u3awhjiOFwoA43o9yCl8t8O3oCGZYkxhpznqjoDcse5OjHa2v75KD1Pda33mX
	2E1CBug/gvA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 498E635563;
	Wed, 31 Jul 2013 23:10:25 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A58373555C;
	Wed, 31 Jul 2013 23:10:23 +0000 (UTC)
In-Reply-To: <51F8E81E.6000705@googlemail.com> (Stefan Beller's message of
	"Wed, 31 Jul 2013 12:34:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 60FCBB22-FA36-11E2-9904-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231478>

Stefan Beller <stefanbeller@googlemail.com> writes:

> On 07/31/13 00:28, Junio C Hamano wrote:
>> 
>> we could just do
>> 
>> #define OPT_CMDMODE(s, l, v, h) \
>>     { OPTION_CMDMODE, (s), (l), (v), NULL, \
>>       (h), PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, (s) }
>> 
>
> I agree that's a better proposal than mine.

By the way, I haven't convinced myself that it is a good idea in
general to encourage more use of command mode options, so I am a bit
reluctant to add this before knowing which direction in the longer
term we are going.

 - Some large-ish Git subcommands, like "git submodule", use the
   mode word (e.g. "git submodule status") to specify the operation
   mode (youe could consider "status" a subsubcommand that
   "submodule" subcommand takes).  These commands typically began
   their life from day one with the mode words.

 - On the other hand, many Git subcommands, like "git tag", have
   "the primary operation mode" (e.g. "create a new one" is the
   primary operation mode for "git tag"), and use command mode
   options to specify other operation modes (e.g. "--delete").
   These commands started as single purpose commands (i.e. to
   perform their "primary operation") but have organically grown
   over time and acquired command mode options to invoke their
   secondary operations.

As an end user, you need to learn which style each command takes,
which is an unnecessary burden at the UI level.  In the longer term,
we may want to consider picking a single style, and migrating
everybody to it.  If I have to vote today, I would say we should
teach "git submodule" to also take command mode options (e.g. "git
submodule --status" will be understood the same way as "git
submodule status"), make them issue warnings when mode words are
used and encourage users to use command mode options instead, and
optionally remove the support of mode words at a large version bump
like 3.0.

One clear advantage mode words have over command mode options is
that there is no room for end user confusion.  The first word after
"git subcmd" is the mode word, and you will not even dream of asking
"what would 'git submodule add del foo' do?" as it is nonsensical.
The command mode options, on the other hand, gives too much useless
flexibility to ask for nonsense, e.g. "git tag --delete --verify",
"git tag --no-delete --delete", etc., and extra code needs to detect
and reject combinations.  But commands that took mode options cannot
be easily migrated to take mode words without hurting existing users
and scripts (e.g. "git tag delete master" can never be a request to
delete the tag 'master', as it is a request to create a tag whose
name is 'delete' that points at the same object as 'master' points
at).
