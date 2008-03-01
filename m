From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] git-submodule: New subcommand 'summary' (1) -
 code framework
Date: Sat, 01 Mar 2008 12:52:43 -0800
Message-ID: <7vejauxj38.fsf@gitster.siamese.dyndns.org>
References: <1204306487-15849-1-git-send-email-pkufranky@gmail.com>
 <80aa1c46ced6f0b92ca2fca3b917d383343b3161.1204306070.git.pkufranky@gmail.com>
 <7vk5km7vir.fsf@gitster.siamese.dyndns.org>
 <46dff0320803010227r5024d152g259a6a07a2441351@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 21:53:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVYi8-00021k-Ep
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 21:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756691AbYCAUw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 15:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756833AbYCAUw6
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 15:52:58 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38816 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755619AbYCAUw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 15:52:57 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 01B282242;
	Sat,  1 Mar 2008 15:52:54 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 3F3B62241; Sat,  1 Mar 2008 15:52:51 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75700>

"Ping Yin" <pkufranky@gmail.com> writes:

>>  > +             grep '^:160000\|:[0-9]\+ 160000' |
>>
>>  This looks troublesome.
>>
>>   - [0-9] is obviously wrong and [0-7] is what you meant;
>>   - \| and \+ are not BRE but GNU.
>>
> man grep says
>  In  basic regular expressions the metacharacters ?, +, {, |, (, and )
> lose their special meaning; instead use the backslashed versions \?,
> \+, \{, \|, \(, and \).
>
> Doen't it mean that '\|' is BRE ?

It just says unlike in ERE, these characters are not special in BRE; it
does not at all say using backslash like \?, \+, and \| makes them so.

And they are not.  \(...\), \{m\}, \{m,\} and \{m,n\} are part of BRE, but
the two you used (\+ and \|) are not.  GNU accept these two as extensions,
but other POSIX implementations may have troubles with them.

  http://www.opengroup.org/onlinepubs/000095399/basedefs/xbd_chap09.html

Please be gentle to porters to non GNU systems.  Either stay inside BRE
(which I think we have managed to do with our usage of grep) or explicitly
ask for ERE with "grep -E".
