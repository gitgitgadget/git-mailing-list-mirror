From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 3/7] show: honor --textconv for blobs
Date: Mon, 13 May 2013 08:41:25 -0700
Message-ID: <7vhai6opju.fsf@alter.siamese.dyndns.org>
References: <7vy5c1l6nb.fsf@alter.siamese.dyndns.org>
	<c4ed1e0b67877e6453b8c269290e09e1672ce37d.1368197380.git.git@drmicha.warpmail.net>
	<7vy5bm22f8.fsf@alter.siamese.dyndns.org>
	<518E0741.1060008@drmicha.warpmail.net>
	<518E16B1.7000505@drmicha.warpmail.net>
	<7vtxm7qxql.fsf@alter.siamese.dyndns.org>
	<20130513115451.GA3903@sigill.intra.peff.net>
	<5190FF73.1080606@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon May 13 17:41:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbusW-0001Yr-Sn
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 17:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755021Ab3EMPl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 11:41:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54161 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753297Ab3EMPl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 11:41:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6712E1E3A4;
	Mon, 13 May 2013 15:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YZv4BI0MmpHjELWBF1qrWJWawgo=; b=yT34lH
	1DIeFrB+5s5ZCYX8cbYmaxkriso52E3l9eS8q3bnZQFb+2rXgnsxdhbpxz41NP5j
	DYEiftChfSceSVCCAtIgN12oIuTfpbKs9sbtxmVMCAfDj1GJsdESZlo6U/QgTqEz
	lWANvxHwDc9fPujXtshoRrcuh5hoCYh7kXk7g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d1cXHkkLR25QqLOkjQ0bQA7XqJVkqgMF
	xNMBtNtqPK+drcRJIvatC76by6k1CVx7odERJLTvYHNptz+jCdKpQaNoDyZFMEbG
	kBnFsv3A28gJP8WAr5HSJ6Tp0+pwoNEV+ZNrNxgiO6kzNgqv8Sfd0V0oUgrc9LJu
	Xox16882thU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DF971E3A2;
	Mon, 13 May 2013 15:41:27 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3E101E39F;
	Mon, 13 May 2013 15:41:26 +0000 (UTC)
In-Reply-To: <5190FF73.1080606@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Mon, 13 May 2013 16:57:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 92AFAD5A-BBE3-11E2-9E2B-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224172>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> But you do have the possibility to use different drivers for diff and
> show. For example, for showing a file some sort of automatic pagination
> or line numbering can be helpful whereas it would hurt the diff case.

I do not find the example convincing (yet); it looks more like you
are grasping for straws.

You would certainly do not want "line numbering" in grep.  My gut
feeling is that normal users would expect to have a single "text
version" and pass that to "pr" (if they want pagination) or "cat -n"
(if they want line numbering), regardless of where it comes from, be
it "git show --textconv" or some other program output, but you seem
to want to have different "text version"s for different purposes out
of a single binary file....

> I strongly disagree here. I have textconv filters for pdf, gpg, odf,
> xls, doc, xoj... I know, ugly. At least some of them would benefit from
> different filteres or different settings.

.... and an example to show why it is useful would help here.  I do
not feel that I have seen anything to substantiate "at least some of
them would benefit" yet.

Would it follow that "grep" and "cat-file" should be controlled by
yet two other knobs so that optionally the user can use different
"text version"s meant for them?

> The way I propose it, a user would just have to add "show=foo" to the
> "diff=foo" lines without having to ad an extra filter, but with the
> flexibility to do so.
>
>> And of course for any workflow-oriented config, you will sometimes want
>> to override it for a particular operation. But that is why we have a
>> command-line escape hatch, and that part is already implemented.
>
> One may ask what a purely ui output oriented setting like "show" has to
> do in .gitattributes, of course, but that applies to "diff" as well.
> Separating the two (one in attributes, one in config) looks artificial
> to me.

I am not sure what you mean by "artificial", but the separation of
the roles between attribute and config is not artificial at all. It
is very much deliberate and done for a good reason.

The attribute specifies what the type of the file is project wide
and is meant to go in in-tree .gitattrbute file, shared among people
on different platforms.  It says things like "These files are PDF".

The config specifies what should happen to the type of a file on a
particular platform each user uses to work in the copy of the
project, i.e. repository.  It says things like "Pass PDF files
through /opt/bin/pdf2txt", which obviously cannot be shared across
platforms.
