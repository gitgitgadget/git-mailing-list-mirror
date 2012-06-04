From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: git ls-files and ignored directories
Date: Sun, 03 Jun 2012 19:12:44 -0700
Message-ID: <7vmx4jvn8j.fsf@alter.siamese.dyndns.org>
References: <20120530102218.0625CFC006A@dd24126.kasserver.com>
 <20120531101451.C35C5B4C00D@dd24126.kasserver.com>
 <20120601093757.GE32340@sigill.intra.peff.net>
 <7vr4tz3tpw.fsf@alter.siamese.dyndns.org>
 <CACsJy8CqMudg=uKuDmRHoYAXhUoYhOp3V2ZLuKM8W5wWWE460w@mail.gmail.com>
 <4FC9F24D.7000306@phononoia.at> <7vr4txz5j9.fsf@alter.siamese.dyndns.org>
 <4FCB4E1E.2010907@phononoia.at> <7vwr3ovxsp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	bilderbuchi@phononoia.at
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 04 04:12:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbMmr-0006Q4-Ny
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 04:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755117Ab2FDCMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 22:12:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38224 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755015Ab2FDCMs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 22:12:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 973A18270;
	Sun,  3 Jun 2012 22:12:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1AZokVoUiyijcrIXOXpDmjBPJG4=; b=p8u2Ar
	IolxNF11hzuvzY56eG7Gse3KbKg8O+IAjojfHlGf0vSenv9IS0O4YCK+DlEH1WEo
	+UpdLYbR4nBESVvOzYjII2vaeCJomfMxEHm2dWmcYzfd8/6d82F6HZu07WQF3pTH
	vykclrJZ2r7xphFbnb27bqIlc8UMW4aEOkg78=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U/E2r/vpJW4K3UyCS5W8DaLj3DeBPrsM
	QwdIZzCGtwe1DkST71TBO+hTEISvXiJ8mbdFh6+oorFHPTu4y1rc0hiCaEX4C1bl
	XxtBoWoqnO++6HWJjbkeFhm77GI15RDioJLlHZTbgQc7D8GvGqfPfCvUubW+Ill8
	9hzc2MjQcTc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F49E826F;
	Sun,  3 Jun 2012 22:12:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C7FD2826D; Sun,  3 Jun 2012
 22:12:46 -0400 (EDT)
In-Reply-To: <7vwr3ovxsp.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 03 Jun 2012 15:24:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C6EEF7B8-ADEA-11E1-B319-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199118>

Junio C Hamano <gitster@pobox.com> writes:

> As we are already in "regression fix only" phase, it won't be in the
> upcoming 1.7.11 series, even though it may deserve to be in 1.7.11.2
> maintenance release.
>
> I see other uses of excluded() in builtin/add.c and unpack-trees.c;
> these call sites need to be audited.
>
> If they have the same problem, it probably is a good idea to convert
> them to use path_excluded(), move the path_excluded() function and
> its supporting infrastructure from builtin/ls-files.c to dir.c, and
> make excluded() a file-static function to dir.c in order to avoid
> similar problems in the future.  Or their use may be alright.
>
> The work described in the previous paragraph preferrably should
> happen before the change is shipped as part of any release.

I've moved the path_excluded() stuff to dir.[ch] and queued the
result to 'pu', but didn't look at other uses of excluded().

Just in case somebody is interested in working on it further.
