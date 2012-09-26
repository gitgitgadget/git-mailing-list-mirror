From: Junio C Hamano <gitster@pobox.com>
Subject: Re: DWIM .git repository discovery
Date: Tue, 25 Sep 2012 21:21:57 -0700
Message-ID: <7v7grhv2fu.fsf@alter.siamese.dyndns.org>
References: <CACsJy8DOtPWgkq=KSHCb=J3qg4o1aPaLo4aj7U5f_qa+kCCipQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 06:22:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGj8Y-0002al-Kq
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 06:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134Ab2IZEWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 00:22:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59725 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843Ab2IZEWD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 00:22:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3D0A6120;
	Wed, 26 Sep 2012 00:22:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sYYKzjHmI9sC/fUK23GcTahhBMQ=; b=YZbgsq
	c/8dpxpGr7PYxehwzrDeZYGy1FGZS7hrinqLA2uJxLeQWzjIU0nDQT1gZVaeEiJh
	g+TSnzdOZn1lKYlCeVuBFPaOxJihYINmaO2U8+GUB12qI0du/qupjW9H2U0Xp0Zq
	d3H7+V0uPFM7Iry93J7/Fb6Iywec2QEgOejJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I2+rjwxfeVpaoxivwR2S4FpQm+GmVVW3
	w6UQ+3EdtRrNmBpnOjUyUxDuAZaOSq5W1lmmPmdrIdPxUgZOu+ixpvrlMs2KI4HE
	geRlqD3uv1XxuHWTj1HEbPBxWTtfRyr1oN4gZRflKMopR8d5tVDogy3wa6tMGnYb
	1jb2wudRwqM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 91AB0611F;
	Wed, 26 Sep 2012 00:22:01 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3B7D611D; Wed, 26 Sep 2012
 00:21:59 -0400 (EDT)
In-Reply-To: <CACsJy8DOtPWgkq=KSHCb=J3qg4o1aPaLo4aj7U5f_qa+kCCipQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 26 Sep 2012 08:49:42 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B72D7EC0-0791-11E2-AB37-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206394>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> I often find myself attempting to examine another repository,
> especially in projects that are closely related but put in different
> git repos. It's usually just a diff or log command
>
> git log --patch ../path/to/another/repo/path/to/file.c

I personally do not think it is _too_ bad to internally do

	(cd ../path/to/another/repo/path/to &&
	 git log --patch file.c)

but I doubt it is worth the numerous implications (I am not talking
about implementation complexity at all, but the conceptual burden).

For example, where in the working tree of the other project should
the command run?  The output from "log -p" happens to be always
relative to the top of the working tree, but that does not
necessarily hold true for other subcommands.

A worse thing is that there is an oddball case "diff[ --no-index]"
that changes behaviour depending on the pathspec points at inside or
outside the repository.

I think that this is a road to insanity; anybody who thinks along
this line is already on the other side of the line, I would have to
say ;-).
