From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] How to make a shared/restricted repo?
Date: Tue, 24 Mar 2009 17:49:36 -0700
Message-ID: <7vr60mbf4v.fsf@gitster.siamese.dyndns.org>
References: <200903250105.05808.johan@herland.net>
 <sL3rt6iQWyznVMwP2SukD7BiuS1AVuqwVkMR4XSwA5SnK9TLmqyqAg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Mar 25 01:56:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmHQI-0002af-9V
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 01:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760344AbZCYAts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 20:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760332AbZCYAtr
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 20:49:47 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37325 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760320AbZCYAtq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 20:49:46 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0D10CA4221;
	Tue, 24 Mar 2009 20:49:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C3119A421E; Tue,
 24 Mar 2009 20:49:38 -0400 (EDT)
In-Reply-To: <sL3rt6iQWyznVMwP2SukD7BiuS1AVuqwVkMR4XSwA5SnK9TLmqyqAg@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Tue, 24 Mar 2009 19:26:17 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D4396982-18D6-11DE-A8E4-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114530>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Johan Herland wrote:
>> Hi,
>> 
>> Some colleagues of mine are working on a "secret" project, and they want to 
>> create a central/server/integration repo that should be group-writable, but 
>> not at all accessible to anybody outside the group (i.e. files should be 
>> 0660 ("-rw-rw----"), dirs should be 0770 ("drwxrws---")).
>> 
>> I started setting this up for them in the following manner:
>> 
>>   mkdir foo.git
>>   cd foo.git
>>   git init --bare --shared=group
>>   cd ..
>>   chgrp -R groupname foo.git
>>   chmod -R o-rwx foo.git
>> 
>> ...and everything looks good, initially...
>> 
>> However, when I start pushing into this repo, the newly created files are 
>> readable to everybody (files are 0664 ("-rw-rw-r--"), dirs are 0775 
>> ("drwxrwsr-x")).
>
> But nobody has access to anything under foo.git since you did
> 'chmod o-rwx foo.git' above.
>
> Unless I'm missing something, I think you already have what you want.

The toplevel is never recreated so it should be Ok in practice.

The core.sharedrepository only loosens the effect of overtight umask
setting that a project member has.  But you can notice inconsistency when
you run "ls -l", which may bother you ;-)
