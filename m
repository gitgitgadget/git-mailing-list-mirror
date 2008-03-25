From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] Enhance TkCVS interoperability
Date: Mon, 24 Mar 2008 18:08:46 -0700
Message-ID: <7vd4pjr4o1.fsf@gitster.siamese.dyndns.org>
References: <cover.1206393086.git.dash@foobox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin@catalyst.net.nz>,
	Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: Damien Diederen <dash@foobox.net>
X-From: git-owner@vger.kernel.org Tue Mar 25 02:09:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdxfk-0006w6-Na
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 02:09:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321AbYCYBI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 21:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752482AbYCYBI5
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 21:08:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56985 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbYCYBI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 21:08:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A96081126;
	Mon, 24 Mar 2008 21:08:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id DF2C11122; Mon, 24 Mar 2008 21:08:50 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78138>

Damien Diederen <dash@foobox.net> writes:

> This series was developed to improve interoperability between
> git-cvsserver and TkCVS, a CVS client that is fairly popular at least
> in some corporate environments.
>
> Patches 1-6 are "obvious" improvements, implementing missing features
> or fixing incorrect behaviour.  7 is more questionable, but likely to
> result in more intelligible log output in a majority of cases.

If anything, I think 7/7 is an improvement that consolidates a few
duplicated code that massage authorship information in the commit object
into CVS form.  I cannot readily tell what is going on from this old code
sequence:

-    $metadata->{$commithash}{author} =~ s/\s+.*//;
-    $metadata->{$commithash}{author} =~ s/^(.{8}).*/$1/;

but I can tell what is going on in the latter even without the help from
the leading comment.

+# Generate a CVS author name from Git author information, by taking
+# the first eight characters of the user part of the email address.
+sub cvs_author
+{
+    my $author = shift;
+
+    $author =~ s/.*<([^>]+)\@[^>]+>$/$1/;
+    $author =~ s/^(.{8}).*/$1/;
+
+    $author;
+}

And 1/7-6/7 looked all good, but this is just from _looking_.  I do not
run cvsserver myself, so people should take this with a moderate amount of
salt.

Martin, Frank?
