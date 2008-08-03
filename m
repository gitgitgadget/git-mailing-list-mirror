From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: chdir now properly sets PWD environment variable
 in msysGit
Date: Sun, 03 Aug 2008 14:13:42 -0700
Message-ID: <7v7iaxu7i1.fsf@gitster.siamese.dyndns.org>
References: <bad7471c0808011250v569ffaaby9e20a5ba1f971927@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: simon@lst.de, shausman@trolltech.com, marius@trolltech.com,
	hanwen@google.com, gitster@pobox.com, git@vger.kernel.org
To: "Robert Blum" <rob.blum@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 23:15:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPkut-0001BA-CE
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 23:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756927AbYHCVNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 17:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756728AbYHCVNz
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 17:13:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45259 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756682AbYHCVNy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 17:13:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2229E48BF7;
	Sun,  3 Aug 2008 17:13:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 416D548BF5; Sun,  3 Aug 2008 17:13:44 -0400 (EDT)
In-Reply-To: <bad7471c0808011250v569ffaaby9e20a5ba1f971927@mail.gmail.com>
 (Robert Blum's message of "Fri, 1 Aug 2008 12:50:03 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 12A2A064-61A1-11DD-9101-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91272>

"Robert Blum" <rob.blum@gmail.com> writes:

> P4 on Windows expects the PWD environment variable to be set to the
> current working dir, but os.chdir in python doesn't do that by default

Missing full stop at the end of sentence aside, this comment makes me
wonder if there is an optional way to have it set it, as opposed to the
inconvenient way it behaves "by defualt".  If there is none, I think your
patch, even though it looks ugly, is the least evil approach.  Another way
might be to wrap callsites of system() by introducing a "run_p4" function,
like:

	def run_p4(arg):
        	os.environ['PWD'] = os.getcwd() if os.name == 'nt'
		return system(arg)

> ---
>
> Pushing it out to the list since I'm not entirely sure who the git-p4 owner
> even is. CC'ed likely suspects for ownership ;)

Thanks.  I've been waiting for an Ack from somewhere or success reports
from p4 users on Windows.
