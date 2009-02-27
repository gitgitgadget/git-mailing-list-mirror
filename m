From: Junio C Hamano <gitster@pobox.com>
Subject: Re: serious problem with `git format-patch' & `git am'
Date: Thu, 26 Feb 2009 18:10:46 -0800
Message-ID: <7viqmwpr2x.fsf@gitster.siamese.dyndns.org>
References: <20090225.230352.177616203.wl@gnu.org>
 <6HVVE8kW9V0CsNfW21a_Tqpt2s-IrJbt2_qdAvQ8r1tetEhb6jr18g@cipher.nrlssc.navy.mil> <m3ljrsvg0e.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>, Werner LEMBERG <wl@gnu.org>,
	git@vger.kernel.org, keithp@keithp.com
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 03:12:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcsDG-0000L7-Gq
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 03:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754656AbZB0CK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 21:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754490AbZB0CK6
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 21:10:58 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59655 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754294AbZB0CK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 21:10:57 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C25F829B6;
	Thu, 26 Feb 2009 21:10:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C815229B5; Thu,
 26 Feb 2009 21:10:47 -0500 (EST)
In-Reply-To: <m3ljrsvg0e.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Thu, 26 Feb 2009 17:11:45 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DCAE7C5A-0473-11DE-AFA7-8D02133F2F75-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111626>

Jakub Narebski <jnareb@gmail.com> writes:

> I think you want undocumented but for the git-am usage (e.g. 'git am
> -h') --rebasing option to git-am, which makes git-am preserve Subject:
> line formatting,...

I have to warn that that one requires you to have proper commit object
to begin with.  IOW, the first line "From [0-9a-f]{40} date" must record
an existing object name.

As you said, "am" is for applying e-mailed patches and filter-branch would
be the best fit for fixing imported history, but whichever tool is used, I
think it is a mistake to try preserving a "one-line-per-paragraph" format
the original poster seems to have, i.e.:

   foo foo foo foo
   bar bar bar bar
   baz baz baz baz

Yes, the low-level could create a commit object with a message like that,
but all the Porcelains rely on "paragraphs are separated with a blank
line" format.  So no matter how the conversion is done, I think it would
be a good idea to turn the above into:

   foo foo foo foo

   bar bar bar bar
   baz baz baz baz

if the user wants to keep the resulting history any useful.

To do it with "format-patch | am", you would format it like:

	Subject: foo foo foo foo
        From: author name <author.name@domain>
        Date: author date

        bar bar bar bar
        baz baz baz baz

        
