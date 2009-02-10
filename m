From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-branch: highlight current remote branches with
 an asterisk
Date: Mon, 09 Feb 2009 16:24:44 -0800
Message-ID: <7viqnjrveb.fsf@gitster.siamese.dyndns.org>
References: <1234222326-55818-1-git-send-email-jaysoffian@gmail.com>
 <alpine.DEB.1.00.0902100048410.10279@pacific.mpi-cbg.de>
 <20090210000321.78025483@crow>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Burton <markb@ordern.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 01:26:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWgSD-0006GR-JL
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 01:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbZBJAYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 19:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbZBJAYx
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 19:24:53 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51208 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbZBJAYw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 19:24:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 557ED980D8;
	Mon,  9 Feb 2009 19:24:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id ADBC6980D1; Mon,
  9 Feb 2009 19:24:47 -0500 (EST)
In-Reply-To: <20090210000321.78025483@crow> (Mark Burton's message of "Tue,
 10 Feb 2009 00:03:21 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3B56539A-F709-11DD-8388-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109168>

Mark Burton <markb@ordern.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> Let's hope that nobody's scripts rely on a single star in front of the 
>> local HEAD...
>
> I don't know if I have any scripts that rely on a single star in front of
> the local HEAD or not (I'm sure some people must have them), but I do
> think this new feature would be very confusing, especially when used
> with -a.

People use "git branch | sed -ne 's/^\* //p' in their scripts (you can say
"against recommendation" but I think it is a sign that the recommendation
against use of Porcelain in the scripts is not loud enough).  I do not
think anybody greps in "git branch -a", though, for that purpose.

The current "branch -a" output is a mess.  It omits "remotes/" even though
it includes the local ones in the output.  Perhaps with remotes/, the
output may become a bit more readable:

    $ git branch -a
    * master
      next
      pu
    * remotes/dscho/master
    * remotes/origin/master
      remotes/origin/next
      remotes/origin/pu
    * remotes/spearce/master

which may still be too loud with asterisks, but at least there is no
confusion.  Or perhaps like this:

    $ git branch -a
    * master
      next
      pu
      remotes/dscho/HEAD -> master
      remotes/dscho/master
      remotes/origin/HEAD -> master
      remotes/origin/master
      remotes/origin/next
      remotes/origin/pu
      remotes/spearce/HEAD -> master
      remotes/spearce/master

with an obvious twist when there is no mixed output:

    $ git branch -r
      dscho/HEAD -> master
      dscho/master
      origin/HEAD -> master
      origin/master
      origin/next
      origin/pu
      spearce/HEAD -> master
      spearce/master
