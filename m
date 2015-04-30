From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Thu, 30 Apr 2015 12:46:02 -0700
Message-ID: <xmqqegn1z9fp.fsf@gitster.dls.corp.google.com>
References: <1430341032.14907.9.camel@ubuntu>
	<xmqqlhha4otr.fsf@gitster.dls.corp.google.com>
	<1430343059.14907.18.camel@ubuntu> <20150429214817.GA2725@peff.net>
	<1430346576.14907.40.camel@ubuntu> <20150429231150.GB3887@peff.net>
	<20150430003750.GA4258@peff.net> <1430355983.14907.55.camel@ubuntu>
	<20150430011612.GA7530@peff.net> <1430358345.14907.62.camel@ubuntu>
	<20150430033725.GB12361@peff.net> <1430421924.22711.57.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 21:46:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnuPb-000106-59
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 21:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbbD3TqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 15:46:07 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64131 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752321AbbD3TqE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 15:46:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 06B8B4DD8B;
	Thu, 30 Apr 2015 15:46:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7dLn4ELSzI0J7gLTPshHtjVZLpk=; b=M2JpcG
	ML+IHTuEUdn+ieRir/tUAM3RQIxBnE330dgOyRoR+o7LPitgMAgwHektW9qLA2Z4
	yscccsKmoaznjq4DwerlHsF2fr26mqc2KBwkQe1jpSAMItucka+OXciYXPVa7x1h
	VbtUgR6npWsde6hsD7YEQpVr5guL2EBgJpM68=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BXD6QuI2gCpgVp7VQs+tcaxEeeXApOxF
	7CLf33why5X5VfFv8w5HAaqNsrqfZJtdCs+qRUVyQ2ceuyji5vZ14BiZxf+cKrQP
	Eat1NKuIy1AWETLASuloNss1kX3vo4jNYT49rh9iNZvCt8L+Z+U5AeK60OAVlDVM
	ue9CIu7GyHA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F2DD04DD86;
	Thu, 30 Apr 2015 15:46:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 770994DD80;
	Thu, 30 Apr 2015 15:46:03 -0400 (EDT)
In-Reply-To: <1430421924.22711.57.camel@ubuntu> (David Turner's message of
	"Thu, 30 Apr 2015 12:25:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 88E551DA-EF71-11E4-8A51-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268097>

David Turner <dturner@twopensource.com> writes:

> The weirdest case is log.  If I say git log HEAD^{resolve} --
> foo/bar/baz,...

That invocation does not make any sense to me, at least within the
context of what has been discussed for ^{resolve}, which is an
instruction to the "name to object name" mapping layer to notice
symbolic links while it traverses the tree containment relationships
starting from the root of the tree to arrive at a single object
name.

    git rev-parse HEAD^{resolve}:path/that/might/involve/symlink/some/where
    git cat-file HEAD^{resolve}:path/that/might/involve/symlink/some/where
    git grep -e pattern HEAD^{resolve}:path/that/might/involve/symlink/some/where

would, though.  In other words, ^{resolve} that is not followed by a
colon and path is something entirely different from what we have
been discussing.
