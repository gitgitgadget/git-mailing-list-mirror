From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: Re: [PATCH/RFD] builtin-revert.c: release index lock when
 cherry-picking an empty commit
Date: Sun, 8 Mar 2009 16:09:50 -0500
Message-ID: <B0CBEE84-0F46-4AF2-86B1-C80BADAEF4E5@pobox.com>
References: <1236418251-16947-1-git-send-email-chris_johnsen@pobox.com>
 <7v63ikmz11.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 22:11:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgQHK-0008MG-Bc
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 22:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754448AbZCHVJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 17:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754308AbZCHVJy
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 17:09:54 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52027 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754195AbZCHVJx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 17:09:53 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 532F74C16;
	Sun,  8 Mar 2009 17:09:51 -0400 (EDT)
Received: from [192.168.1.241] (unknown [76.201.177.183]) (using TLSv1 with
 cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A284E4C13; Sun, 
 8 Mar 2009 17:09:48 -0400 (EDT)
In-Reply-To: <7v63ikmz11.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.753.1)
X-Pobox-Relay-ID: 76BBEA4A-0C25-11DE-81CE-CBE7E3B37BAC-07245699!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112643>

On 2009 Mar 7, at 22:14, Junio C Hamano wrote:
>> UNEVEN TREATMENT OF EMPTY CHANGES
>>
>> fetch, push, bundle
> They just transfer an existing history from one place to another  
> without
> modifying, so it is unfortunately true that they preserve such a  
> broken
> history with empty commits.

>> 'format-patch', 'send-email', 'apply', 'am', 'rebase' (automatic,
>> non-fast-forward; and --interactive).
>
> These are all about creating history afresh, and they actively  
> discourage
> empty commits to be (re)created.
>
> There is no "uneven treatment".

>> 36863af16e (git-commit --allow-empty) says "This is primarily for
>> use by foreign scm interface scripts.". Is this the only case
>> where empty commits _should_ be used?
>
> If foreign scm recorded an empty commit, it would be nice to be  
> able to
> recreate such a broken history _if the user wanted to_, and that is  
> where
> the --allow-empty option can be used.

Thank you for the clarification. I will explain the source of my  
confusion.

The current documentation "Usually recording [an empty commit] is a  
mistake... This option ... is primarily for use by foreign scm  
interface scripts." implied to me that there was room outside foreign  
scm interface for "normal" use of empty commits.

My confusion was that I took "usually a mistake" to refer to the case  
where the user meant to commit content changes but forgot to first  
stage any changed content. But your clarification shows that "usually  
a mistake" really means that making any empty commit, intentional or  
not, is (considered to be) a fundamental misuse of SCM machinery.

Would it be acceptable to strengthen the language in the  
documentation for --allow-empty? Possibly something like the  
following paragraph:

Empty commits are a broken concept and should never be made during
normal usage. By default, the command prevents you
from making such a commit. This option bypasses the safety, and is
primarily for use by foreign scm interface scripts.

If such a change is acceptable, I will send a patch.

-- 
Chris
