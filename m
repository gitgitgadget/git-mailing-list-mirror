From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitignore: warn about pointless syntax
Date: Mon, 09 Jan 2012 22:01:06 -0800
Message-ID: <7vd3asayfx.fsf@alter.siamese.dyndns.org>
References: <1326123647-18352-1-git-send-email-jengelh@medozas.de>
 <1326123647-18352-2-git-send-email-jengelh@medozas.de>
 <20120109162802.GA2374@sigill.intra.peff.net>
 <7vhb04ek6e.fsf@alter.siamese.dyndns.org>
 <20120109223358.GA9902@sigill.intra.peff.net>
 <alpine.LNX.2.01.1201100639340.11534@frira.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	trast@student.ethz.ch
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Tue Jan 10 07:01:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkUlo-0001Ar-PB
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 07:01:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069Ab2AJGBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 01:01:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39183 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752411Ab2AJGBK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 01:01:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C57816FE8;
	Tue, 10 Jan 2012 01:01:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ug/Lg3zoXzOMfSbOZ6TQyTPT55k=; b=v5RVSV
	iyCmXGPpU73MTzxMY1NY+RmE29LP6szBmCtLkVlg79eq1B15+iKAbCNqyVm4e/H4
	vnT+qdd0evJ8/1r4iKbZPE2wKlmzXqmipJfBN+iVM7rqVXnBxynALHhLO/d3T8o8
	4Ydq/U81KP8yjRybvoS9ehxLDzETENrjwEbD0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CeMYpyK2IKbuoDR+sfg8TPwrT3SHRsup
	EjnqwcjRziy63D3HwfbkNrQwHA7F4dofWRYn0tlTVacqnbAFtErsDdbCNJvLtHh3
	WYDza3l0ia493TTqX55PfR4fWxi6QcQhXQCGSG6W5BdFI5DMfz0CO6NuAykuWLd/
	0+MHQ32GVpE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBC7A6FE7;
	Tue, 10 Jan 2012 01:01:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4AA826FE6; Tue, 10 Jan 2012
 01:01:08 -0500 (EST)
In-Reply-To: <alpine.LNX.2.01.1201100639340.11534@frira.zrqbmnf.qr> (Jan
 Engelhardt's message of "Tue, 10 Jan 2012 06:42:11 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7D48CAB0-3B50-11E1-A81F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188223>

Jan Engelhardt <jengelh@medozas.de> writes:

> On Monday 2012-01-09 23:33, Jeff King wrote:
>>On Mon, Jan 09, 2012 at 11:43:21AM -0800, Junio C Hamano wrote:
>>
>>>>>+static inline void check_bogus_wildcard(const char *file, const char *p)
>>>>>+{
>>>>>+	if (strstr(p, "**") == NULL)
>>>>>+		return;
>>>>>+	warning(_("Pattern \"%s\" from file \"%s\": Double asterisk does not "
>>>>>+		"have a special meaning and is interpreted just like a single "
>>>>>+		"asterisk.\n"), file, p);
>>
>>You only have to implement proper backslash decoding, so I think it is
>>not as hard as reimplementing fnmatch:
>>[...]
>>
>>That being said, if this is such a commonly-requested feature
>
> Was it actually requested, or did you mean "commonly attempted use"?
>
> As I see it, foo/**/*.o for example is equal to placing "*.o" in
> foo/.gitignore, so the feature is already implemented, just not
> through the syntax people falsely assume it is.

You can either adjust the people, i.e. teach that their "false" assumption
is wrong and the feature they expect is available but not in a way that
they expect.

Or you can adjust the tool to match their expectation.

The point that Peff correctly read between my lines is that in real life,
people are harder to train than tools and often the latter is a better
approach, especially if it does not amount to too much more work than
doing the former.
