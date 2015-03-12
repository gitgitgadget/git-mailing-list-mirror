From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/10] Define a structure for object IDs.
Date: Thu, 12 Mar 2015 11:24:32 -0700
Message-ID: <xmqqwq2m2hwf.fsf@gitster.dls.corp.google.com>
References: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
	<1425770645-628957-2-git-send-email-sandals@crustytoothpaste.net>
	<CEA07500-9F47-4B24-AD5D-1423A601A4DD@gmail.com>
	<20150311220825.GB46326@vauxhall.crustytoothpaste.net>
	<xmqqr3sv3vsf.fsf@gitster.dls.corp.google.com>
	<55016A3A.6010100@alum.mit.edu>
	<20150312104651.GF46326@vauxhall.crustytoothpaste.net>
	<CACsJy8AL0jGwzTfWDSszkvyqzNtPA7o7vQRT5NFaBYrVU02nOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 19:24:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YW7mi-0005IV-Do
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 19:24:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbbCLSYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 14:24:35 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50805 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751826AbbCLSYe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2015 14:24:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D9AC3F198;
	Thu, 12 Mar 2015 14:24:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qbASZZvfOPNcAFOya9DtzVAQrdg=; b=GTs54a
	Wacy/zl/YjiuWHFVUguqX3ll60Mr2i4aye8LqPpGny8388vZcpF7KNZHARE1Px9J
	VBnbJGaLENwEBCHKow8MdjEj09hR014LUNKT6gZGSQPyUDgZ8ZKdoC6ipFhTbEZY
	jlUpYciUrOHRXBpZVqxfnCNAUjGvLyFWPRplQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TCT9/LjEkCBrLMmWFjRavvz74PtdGJjX
	EFwSbjgAwIuKpotqOxmsaUI6JnTVXVGUcLaLC8jnhaHwaUE9J30ftH2wQK18Ob+1
	9EFtwrsczj7cmKg6dWsWNUTZJbAPlD/Sr13xPi97BQP+KB5eZV9iiTSrcQE2Ligi
	qbAt4j0a86c=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 46B8B3F197;
	Thu, 12 Mar 2015 14:24:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C2E6A3F196;
	Thu, 12 Mar 2015 14:24:33 -0400 (EDT)
In-Reply-To: <CACsJy8AL0jGwzTfWDSszkvyqzNtPA7o7vQRT5NFaBYrVU02nOA@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 12 Mar 2015 18:16:49 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 08360802-C8E5-11E4-90F9-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265365>

Duy Nguyen <pclouds@gmail.com> writes:

> This may or may not fall into the "mix different hash functions"
> category. In pack files version 4, trees are encoded to point to other
> trees or blobs by a (pack, offset) tuple. It would be great if the new
> object_id could support carrying this kind of object id around because
> it could help reduce object lookup cost a lot. (pack, offset) can be
> converted back to SHA-1 so no info is lost and hashcmp() can compare
> (pack, tuple) against an SHA-1 just fine.

You mean "if it came in <pack, offset> format, convert it down to
<sha1> until the last second that it is needed (e.g. need to put
that in a tree object in order to compute the object name of the
containing tree object)"?

After converting an object name originally represented as <pack,
offset>, if we are doing the "union in struct" thing, to <sha1>
representation, you would have to look it up from .idx in order to
read the contents the usual way.  If that happens often enough, then
it may not be worth adding complexity to the code to carry the
<pack, offset> pair around.

Unless you fix that "union in struct" assumption, that is.

To me, <pack, offset> information smells to belong more to a "struct
object" (or its subclass) as an optional annotation---when a caller
is asked to parse_object(), you would bypass the sha1_read_file()
that goes and looks the object name up from the list of pack .idx
and instead go there straight using that annotation.
