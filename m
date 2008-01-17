From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 09:58:40 -0800
Message-ID: <7vfxwwjpv3.fsf@gitster.siamese.dyndns.org>
References: <478E1FED.5010801@web.de>
	<76718490801162043w3884435ex435f38b9de837540@mail.gmail.com>
	<76718490801162059i2472cd82va34010caa3130b7e@mail.gmail.com>
	<7vejchkp6o.fsf@gitster.siamese.dyndns.org>
	<32DB7E53-1062-4F7C-A42D-6EC5945A70A3@wincent.com>
	<alpine.LSU.1.00.0801171106510.17650@racer.site>
	<C7439732-3B79-4F2B-9D0C-679C1EC8EA0E@simplicidade.org>
	<16D4755D-EAEC-4F4A-B6B4-F262A6841F66@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pedro Melo <melo@simplicidade.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian+git@gmail.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 18:59:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFZ1T-0002ZJ-Gq
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 18:59:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756010AbYAQR66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 12:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755990AbYAQR66
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 12:58:58 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33000 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755962AbYAQR65 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 12:58:57 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B15B21CDA;
	Thu, 17 Jan 2008 12:58:55 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 114821CD6;
	Thu, 17 Jan 2008 12:58:48 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70885>

Wincent Colaiuta <win@wincent.com> writes:

> If this is really just a platform-specific hack, can we use platform- 
> specific code to do the normalization?

Unfortunately, I do not think this can be a platform-specific
hack.

If a project wants to be usable on both sane and insane
filesystems, people on platforms whose filesystems treat "foo"
and "Foo" as two distinct pathnames (and "Ma<UMLAUT>rchen" and
"M<A-with-UMLAUT>rchen" as two distinct ones) need to be
prevented from creating both in their tree objects at the same
time.  Once you create two pathnames xt_connmark.c and
xt_CONNMARK.c in the same tree object in your project, people on
case insensitive filesystems cannot work with your project (you
cannot check out the kernel source tree and work on it on vfat).

This is exactly the same logic as making autocrlf=safe (or at
least 'input') the default for projects that people need to work
both on UNIX and Windows, which Steffen Prohaska has been
adovocating in another thread.
