From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] pretty: support "mboxrd" output format
Date: Fri, 03 Jun 2016 15:36:30 -0700
Message-ID: <xmqqlh2loq6p.fsf@gitster.mtv.corp.google.com>
References: <20160530232142.21098-1-e@80x24.org>
	<20160530232142.21098-2-e@80x24.org>
	<CAPig+cQrSJe03_RtSyf5KO2vE3Rri7t70-he8SXA9Y4oBYY_Ww@mail.gmail.com>
	<20160531074506.GA8911@dcvr.yhbt.net>
	<CAPig+cQrQfxWrGhpvtb-GKYfK0tMLsx9JJ+eWRRx00F8mNXrLg@mail.gmail.com>
	<20160531182932.GA27021@dcvr.yhbt.net>
	<20160602075125.GA19551@dcvr.yhbt.net>
	<CAPig+cTLVXJBn00aco0vC9oFvZuchTgtNXtGGjpLPx1LwRZz4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Wong <e@80x24.org>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Jun 04 00:36:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8xi2-0001dN-Ok
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jun 2016 00:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011AbcFCWgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 18:36:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64501 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752986AbcFCWgd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 18:36:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 39D2722B36;
	Fri,  3 Jun 2016 18:36:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xnYsfuwMSU3EE2m5igCjQL3XOJk=; b=F01QED
	dqgXobUM3/L+jCyCHl05oHRdboTDdDjllmXLlra0mViHimBMPTJxBczIm+Y1TOn+
	rkpHbDOVWFhrZFIitt0tD9QKKgJAiWNE7hI9bAsZE81K5w+q3YFS9GtBjDCVIeBK
	h0xTJhCvy4P6qLZw/8L2VKXmrYMFmCh5AAlBc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YR9ZBBfV7zQJJTyxTKVV2TnlQopWhO6Y
	NWCfUmUbIuP/fVsIeh/kpG8FCl03N2zO0aIsI+PBPBKAX+GzrxOQsaJlqmnCxOCB
	iH6G7UidvP7I1r90zwHLyxTOMKi6jLA3jDDenqasf8WPN7Chmw6CmCMoK3qy/p/Y
	ozKl22ab5f8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3287422B34;
	Fri,  3 Jun 2016 18:36:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C17EC22B33;
	Fri,  3 Jun 2016 18:36:31 -0400 (EDT)
In-Reply-To: <CAPig+cTLVXJBn00aco0vC9oFvZuchTgtNXtGGjpLPx1LwRZz4Q@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 3 Jun 2016 18:22:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9EABD07A-29DB-11E6-9499-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296421>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Jun 2, 2016 at 3:51 AM, Eric Wong <e@80x24.org> wrote:
>> Eric Wong <e@80x24.org> wrote:
>>> Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> > On Tue, May 31, 2016 at 3:45 AM, Eric Wong <e@80x24.org> wrote:
>>> > > Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> > >> I wonder if hand-coding, rather than using a regex, could be an improvement:
>>> > >>
>>> > >>     static int is_mboxrd_from(const char *s, size_t n)
>>> > >>     {
>>> > >>         size_t f = strlen("From ");
>>> > >>         const char *t = s + n;
>>> > >>
>>> > >>         while (s < t && *s == '>')
>>> > >>             s++;
>>> > >>         return t - s >= f && !memcmp(s, "From ", f);
>>> > >>     }
>>> > >>
>>> > >> or something.
>>> > >
>>> > > Yikes.  I mostly work in high-level languages and do my best to
>>> > > avoid string parsing in C; so that scares me.  A lot.
>
> As mentioned above, it's all subjective and, of course, I have a bias
> toward the example I provided, but don't otherwise feel strongly about
> it. I do, however, like the idea of using a simple hand-coded matching
> function over the regex (but no so much that I would complain about
> it). Use whatever you and Junio feel is appropriate.

This is meant to be a replacement for the original that uses
regexec(), which in turn means the string we are checking is
guaranteed to be NUL terminated, right?

	static int is_mboxrd_from(const char *line) {
	        return starts_with(line + strspn(line, ">"), "From ");
	}

is sufficiently high-level that no longer is scary, hopefully?

I agree with you that regexec() is way overkill for something small
and simple like this.
