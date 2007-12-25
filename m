From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Force new line at end of commit message
Date: Tue, 25 Dec 2007 01:34:37 -0800
Message-ID: <7v4pe7p176.fsf@gitster.siamese.dyndns.org>
References: <87ve6ub3u7.fsf@gollum.intra.norang.ca>
	<8763yof9lg.fsf@gollum.intra.norang.ca>
	<Pine.LNX.4.64.0712241835210.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	<20071225044202.GO14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bernt Hansen <bernt@alumni.uwaterloo.ca>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 25 10:35:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J76Bw-0005kl-Im
	for gcvg-git-2@gmane.org; Tue, 25 Dec 2007 10:35:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbXLYJet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Dec 2007 04:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751594AbXLYJes
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Dec 2007 04:34:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56187 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbXLYJes (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Dec 2007 04:34:48 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 196C5A62C;
	Tue, 25 Dec 2007 04:34:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 88148A62B;
	Tue, 25 Dec 2007 04:34:39 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69230>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> I'd like to hear Junio's or Linus' two cents on the matter, but
> if we really want to say that all commits must end with an LF then
> maybe git-commit-tree, git-hash-object and git-fast-import should be
> performing that sort of validation before creating such an object in
> the ODB.

I've so far tried to keep the lowest-level plumbing commit-tree
(and even lower hash-object) without such an artificial limit.
At the lowest level, commit objects should be able to hold any
byte sequence (this includes NUL bytes) as the user wishes.
People who want to use git to implement/experiment a data
structure that may not have anything to do with the usual SCM
should be able to do so using such low-level.

It is a different story about what conventions should Porcelains
enforce.  For example, I'd be perfectly happy if git-commit (at
least under its default mode of operation) does not allow NULs
nor incomplete lines in the message, and if git-format-patch and
git-am do not to pass something you cannot e-mail sanely (but
that is only true once we rewrite rebase not to rely on the
pipeline between them).  Porcelain level should really make it
easy and safe for the users to work with git as an SCM.
