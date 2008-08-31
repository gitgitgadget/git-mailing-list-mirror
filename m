From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] change Perl syntax to support Perl 5.6
Date: Sun, 31 Aug 2008 09:27:38 -0700
Message-ID: <7v63ph40at.fsf@gitster.siamese.dyndns.org>
References: <20080830173947.GF7185@schiele.dyndns.org>
 <20080830183413.GG7185@schiele.dyndns.org>
 <20080830183949.GA16415@coredump.intra.peff.net>
 <200808302237.17017.jnareb@gmail.com>
 <32541b130808302235g6a23efcfs78efe2ef557cd9c7@mail.gmail.com>
 <8663phnw3z.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Avery Pennarun" <apenwarr@gmail.com>,
	"Jakub Narebski" <jnareb@gmail.com>, "Jeff King" <peff@peff.net>,
	"Robert Schiele" <rschiele@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Lea Wiemann" <lewiemann@gmail.com>
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Sun Aug 31 18:31:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZppO-0003dq-5X
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 18:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989AbYHaQ1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 12:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752894AbYHaQ1w
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 12:27:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53842 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873AbYHaQ1v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 12:27:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5E1CA54803;
	Sun, 31 Aug 2008 12:27:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8DB6854802; Sun, 31 Aug 2008 12:27:41 -0400 (EDT)
In-Reply-To: <8663phnw3z.fsf@blue.stonehenge.com> (Randal L. Schwartz's
 message of "Sun, 31 Aug 2008 06:37:52 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C1000CD0-7779-11DD-8C44-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94491>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Avery" == Avery Pennarun <apenwarr@gmail.com> writes:
>
> Avery> Shell quoting is a disaster (including security holes, where relevant)
> Avery> waiting to happen.  The above is the only sane way to do it, and it
> Avery> isn't very hard to implement.  (Instead of system() in the subprocess,
> Avery> you can use exec().)
>
> quotemeta() is about regex quoting.  This is not precisely the same as shell
> quoting, and is both misleading, and potentially broken.

Agreed to, and grateful for, both of your comments.

Do you like the one Jakub quoted from how gitweb does it?  It looks like
this:

    # quote the given arguments for passing them to the shell
    # quote_command("command", "arg 1", "arg with ' and ! characters")
    # => "'command' 'arg 1' 'arg with '\'' and '\!' characters'"
    # Try to avoid using this function wherever possible.
    sub quote_command {
           return join(' ',
                       map( { my $a = $_; $a =~ s/(['!])/'\\$1'/g; "'$a'" } @_ ));
    }
