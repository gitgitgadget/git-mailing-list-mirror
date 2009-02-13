From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] builtin-branch: improve output when displaying remote
 branches
Date: Thu, 12 Feb 2009 23:36:45 -0800
Message-ID: <7viqneeqk2.fsf@gitster.siamese.dyndns.org>
References: <7vhc30qki2.fsf@gitster.siamese.dyndns.org>
 <1234503271-78569-1-git-send-email-jaysoffian@gmail.com>
 <7v7i3ug7y9.fsf@gitster.siamese.dyndns.org>
 <20090213064707.GA17681@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Fri Feb 13 08:38:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXscw-00075k-9z
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 08:38:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455AbZBMHgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 02:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753260AbZBMHgx
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 02:36:53 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35658 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176AbZBMHgw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 02:36:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1190598D5A;
	Fri, 13 Feb 2009 02:36:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BAE5D98D58; Fri,
 13 Feb 2009 02:36:47 -0500 (EST)
In-Reply-To: <20090213064707.GA17681@piper.oerlikon.madduck.net> (martin f.
 krafft's message of "Fri, 13 Feb 2009 07:47:07 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1487DBD6-F9A1-11DD-B0DC-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109719>

martin f krafft <madduck@madduck.net> writes:

> also sprach Junio C Hamano <gitster@pobox.com> [2009.02.13.0735 +0100]:
>> Once you start making each case arm do more things, it might make sense to
>> rewrite the above unrolled loop into something like this:
> [...]
>> 	} ref_kind[] = {
>>         	{ REF_LOCAL_BRANCH, "refs/heads/", 11 },
>>         	{ REF_REMOTE_BRANCH, "refs/remotes/", 13 },
>> 	};
> [...]
>
>> Then we can later add new elements more easily, e.g.
>> 
>>                 { REF_TOPGIT_BASE, "refs/top-base/", 14 },
>
> As soon as TopGit is integrated into Git proper, this could make
> sense. However, I don't know when this will happen. In the mean
> time, hardcoding extensions like you suggest might not scale too
> well. Wouldn't it make more sense to provide an interface that
> allowed tools to register their own namespaces, and handle those
> appropriately within Git?

The comment applies to the way how ref_kind[] array is initialized, and
yes it would be nicer to make it extensible once the code that uses the
array is in palce.

However, the codepath that uses the array once it is initialized will not
have to change, if you add your interface to register namespaces.

That is why I suggested the code restructuring first *with* the known two
hierarchies we know we would want to handle *now*.
