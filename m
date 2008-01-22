From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [RFC] Design for pathname encoding gitattribute [RESEND]
Date: Mon, 21 Jan 2008 22:26:43 -0800
Message-ID: <7vlk6iv0ik.fsf@gitster.siamese.dyndns.org>
References: <20080122050215.DE198200A2@wilber.wgtn.cat-it.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Kevin Ballard <kevin@sb.org>
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Tue Jan 22 07:27:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHCbz-0006AT-Nc
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 07:27:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096AbYAVG1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 01:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753720AbYAVG1L
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 01:27:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56391 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754089AbYAVG1K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 01:27:10 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BD856173;
	Tue, 22 Jan 2008 01:27:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D460B6170;
	Tue, 22 Jan 2008 01:26:54 -0500 (EST)
In-Reply-To: <20080122050215.DE198200A2@wilber.wgtn.cat-it.co.nz> (Sam
	Vilain's message of "Tue, 22 Jan 2008 17:41:59 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71421>

Sam Vilain <sam.vilain@catalyst.net.nz> writes:

> Some projects may like to enforce a particular encoding is used for
> all filenames in the repository.  Within the UTF-8 encoding, there are
> four normal forms (see http://unicode.org/reports/tr15/), any of which
> may be a reasonable repository format choice.  Additionally, some
> filesystems may have a single encoding that they support when writing
> local filenames.  To support this, iconv and a normalization library
> must have the information they need to perform the correct conversion.

Isn't there a chicken-and-egg problem?  The attributes are by
nature per-path, and you need to match the pathname string with
a pattern to decide which attribute definition to apply to a
given path.  Before knowing what encoding the pathname you have
just read from readdir(3), how would you match that pathname
with the pattern in the gitattributes file?

I can buy the .git/config (and an in-tree .git-encoding,
perhaps), though.
