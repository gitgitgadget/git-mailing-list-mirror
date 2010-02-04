From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Making custom git-remove-tree command
Date: Thu, 04 Feb 2010 17:43:59 +0100
Message-ID: <4B6AF94F.6070604@viscovery.net>
References: <87iqad2x09.fsf@mithlond.arda> <4B6A9985.4050909@viscovery.net> <87tytxhsgc.fsf@mithlond.arda>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Thu Feb 04 17:44:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd4oc-00026a-AE
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 17:44:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758407Ab0BDQoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 11:44:05 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:14769 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758363Ab0BDQoC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 11:44:02 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Nd4oB-0008NV-Ra; Thu, 04 Feb 2010 17:44:00 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 765651660F;
	Thu,  4 Feb 2010 17:43:59 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <87tytxhsgc.fsf@mithlond.arda>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138977>

Teemu Likonen schrieb:
> * 2010-02-04 10:55 (+0100), Johannes Sixt wrote:
> 
>> I think you should be able to reduce all of this to just
>>
>> git read-tree --index-output=/tmp/empty.index -m -u \
>> 	4b825dc642cb6eb9a060e54bf8d69288fbee4904 # empty tree
>> rm -f /tmp/empty.index
>>
>> (with the usual caveats about temporary files).
> 
> Thanks, it works. It's also _much_ faster than my "git ls-tree" with
> shell loop thing. It prints ugly error, though:
> 
>     fatal: unable to write new index file

Then put the temporary index into your git-dir:

   gitdir=$(git rev-parse --git-dir)
   git read-tree --index-ouput="$gitdir/tmpindex" ...
   rm -f "$gitdir/tmpindex"

The purpose of this temporary index is only that your real index is not
cleared. If you don't mind that your index is purged as well, then you can
just drop the --index-output parameter.

-- Hannes
