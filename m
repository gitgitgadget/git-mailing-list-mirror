From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fsck.c: fix bogus "empty tree" check
Date: Tue, 04 Mar 2008 11:57:14 -0800
Message-ID: <7vfxv65kkl.fsf@gitster.siamese.dyndns.org>
References: <7vbq5u91lf.fsf@gitster.siamese.dyndns.org>
 <20080304152635.40451f7c.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Sergey Vlasov <vsu@altlinux.ru>
X-From: git-owner@vger.kernel.org Tue Mar 04 20:58:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWdGz-0006ZX-UH
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 20:58:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756198AbYCDT5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 14:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757757AbYCDT5Z
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 14:57:25 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41281 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356AbYCDT5X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 14:57:23 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 291293749;
	Tue,  4 Mar 2008 14:57:20 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6FC183748; Tue,  4 Mar 2008 14:57:16 -0500 (EST)
In-Reply-To: <20080304152635.40451f7c.vsu@altlinux.ru> (Sergey Vlasov's
 message of "Tue, 4 Mar 2008 15:26:35 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76131>

Sergey Vlasov <vsu@altlinux.ru> writes:

>>    I'll revert the following two commits for now:
>>
>>    d5ef408 (unpack-objects: prevent writing of inconsistent objects)
>>    28f72a0 (receive-pack: use strict mode for unpacking objects)
>>
>>    as I have verified that running with receive.fsckobjects set to false
>>    fixes the issues for me, and the repository at the receiving end (both
>>    before and after the push) pass git-fsck without problems.  Needless to
>>    say, I am not a happy camper right now.
>
> This part of commit d5ef408 changes is bogus:
>
>> @@ -144,9 +205,36 @@ static void added_object(unsigned nr, enum object_type type,
>>  static void write_object(unsigned nr, enum object_type type,
>>  			 void *buf, unsigned long size)
>>  {
>> -	if (write_sha1_file(buf, size, typename(type), obj_list[nr].sha1) < 0)
>> -		die("failed to write object");
>>  	added_object(nr, type, buf, size);
>
> The write_sha1_file() call here was calculating obj_list[nr].sha1; now
> it is removed, but added_object() needs this value:

Thanks, somehow I missed that when merging it up for 'next'.

> However, I do not have time to create a proper test case for this.

That's Ok.  What we need is a fix but it is not that urgent as the stuff
is now reverted for now.

Sorry for being a sloppy maintainer.  I have to admit that I did not read
every single line of patches in a few topics merged to 'master' recently,
due to workload pressure, and some extra eyeballs after-the-fact are
greatly appreciated.
