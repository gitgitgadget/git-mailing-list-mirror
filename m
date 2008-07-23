From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not
 been set
Date: Tue, 22 Jul 2008 17:12:37 -0700
Message-ID: <7vy73tihl6.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807222255450.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 02:13:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLRzE-00059H-14
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 02:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011AbYGWAMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 20:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752903AbYGWAMo
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 20:12:44 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:32788 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823AbYGWAMn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 20:12:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8F206374F3;
	Tue, 22 Jul 2008 20:12:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 91CFF374F1; Tue, 22 Jul 2008 20:12:39 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1186529C-584C-11DD-A4CD-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89574>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> When a file's crlf attribute is explicitely set, it does not make sense
> to ignore it, just because the config variable core.autocrlf has not
> been set.

I am not sure if I agree with that reasoning.

Attribute defines what each path is.  Is it a text file, is it a binary?
The nature of the contents does not change between people on POSIX and
Windows, and that is why it is described in .gitattributes and cloned
across repositories.

On the other hand, the configuration defines what to do with contents with
various attributes in this particular repository.  Do I want to see a text
file checked out with CRLF endings, or LF?

So it is perfectly valid and normal for a cross-platform minded project to
use the crlf atttribute to say "These files are text" and expect them to
be checked out with LF endings on POSIX while making sure they are checked
out with CRLF on Windows.  Adding CR at the end of line for such files on
POSIX systems is positively a wrong thing to do in such a case.

Projects like the kernel that originate from LF side of the world may not
bother marking things as such, though.
