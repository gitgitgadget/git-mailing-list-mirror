From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] Add a new option 'merges' to revision.c
Date: Sun, 22 Mar 2015 18:25:07 -0700
Message-ID: <xmqqegogbj4c.fsf@gitster.dls.corp.google.com>
References: <1427048921-28677-1-git-send-email-koosha@posteo.de>
	<xmqqoankbodw.fsf@gitster.dls.corp.google.com>
	<550F6175.9050606@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Koosha Khajehmoogahi <koosha@posteo.de>
X-From: git-owner@vger.kernel.org Mon Mar 23 02:25:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZr7W-0008Ev-TT
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 02:25:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103AbbCWBZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 21:25:29 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61754 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751962AbbCWBZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 21:25:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D231843929;
	Sun, 22 Mar 2015 21:25:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=svnRKNoMskKs7mcZak2jFQ2BKl4=; b=W6IEh2
	HUcHsmCxi2SUQHYrbinzwaicpxvNh4f742I4lj+GELlkj+BDHhLMeUL28qiRe3YY
	QID/qVm/JvPDeje64mR3oihzVJMK798hRT04S5Kzh2R4RqO9l0nhUaYFIvtrI60d
	yE+P7qlsnSpPrP0pal/HVN3q5y1kTfTQEVONo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jjh+RXaA8cDSnZobnl4S/C4FVDgVgM4T
	AJNZVkByqQTmR8I2yGynMxGuoTG1gkTE3LlHtveopq5OUnZxj6i020PUs5+15yNy
	Vex4Z7PR29b0NKLvPy9CFnDMX+sZGXaoizel86fqnDWQi5V0yCoVvDWN/Z7SFBOz
	0Fx7bF6fQ0k=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C945143928;
	Sun, 22 Mar 2015 21:25:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3FCFA43927;
	Sun, 22 Mar 2015 21:25:08 -0400 (EDT)
In-Reply-To: <550F6175.9050606@posteo.de> (Koosha Khajehmoogahi's message of
	"Mon, 23 Mar 2015 01:42:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7136E11E-D0FB-11E4-8C0D-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266113>

Koosha Khajehmoogahi <koosha@posteo.de> writes:

>>>  	} else if (!strcmp(arg, "--merges")) {
>>> +		revs->max_parents = -1;
>>>  		revs->min_parents = 2;
>> 
>> But is this change warranted?  An existing user who is not at all
>> interested in the new --merges= option may be relying on the fact
>> that "--merges" does not affect the value of max_parents and she can
>> say "log --max-parents=2 --merges" to see only the two-way merges,
>> for example.  This change just broke her, and I do not see why it is
>> a good thing.
>
> The point is that if you have your log.merges conf option set to 'hide'
> and you use git log --merges (two mutually conflicting options),
> git will silently exit without anything to show.

That is not an excuse to break "--merges" and "--no-merges" for
existing users who do not care about setting log.merges option to
anything.

The whole point of introducing a new "--merges=show" option was so
that people can sanely countermand log.merges configuration from the
command line without breaking --merges and --no-merges, wasn't it?
