From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: use Git.pm, and use its parse_rev method for
 git_get_head_hash
Date: Sun, 01 Jun 2008 22:35:46 -0700
Message-ID: <7vbq2k9z65.fsf@gitster.siamese.dyndns.org>
References: <1212188412-20479-1-git-send-email-LeWiemann@gmail.com>
 <m3lk1q24nb.fsf@localhost.localdomain> <4841471E.2070302@gmail.com>
 <200806020019.23858.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 07:36:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K32iw-0005ri-Td
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 07:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbYFBFf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 01:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbYFBFf5
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 01:35:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47751 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbYFBFf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 01:35:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8658338B4;
	Mon,  2 Jun 2008 01:35:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7C32538B3; Mon,  2 Jun 2008 01:35:49 -0400 (EDT)
In-Reply-To: <200806020019.23858.jnareb@gmail.com> (Jakub Narebski's message
 of "Mon, 2 Jun 2008 00:19:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C4F7B0C8-3065-11DD-A710-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83491>

Jakub Narebski <jnareb@gmail.com> writes:

> On Sat, 31 May 2008, Lea Wiemann wrote:
> ...
>> So you end up with these layers: 
>> 
>> (Layer 0: Front-end [HTML] caching.)
>> Layer 1: Application (Gitweb)
>> Layer 2: Back-end caching
>> Layer 3: Repository access (command parsing)
>> Layer 4: Calls to the git binary
>> 
>> Layer 3 and 4 are application-independent (i.e. not Gitweb specific), 
>> and since they form a usable API, they might as well be written as a 
>> separate API rather than lumped together with Gitweb.  Git.pm is a start 
>> of such an API (it does layer 4 and a little bit of layer 3), so it 
>> seems natural for me to extend it.
>
> This assumes that command parsing used by gitweb are generic enough
> to put them in Git.pm.  But some IMVHO are very gitweb-specific, for
> example the part in parse_commit_text() beginning with 
>   # remove leading stuff of merges to make the interesting part visible
> and the 'age_string*' keys there, parse_difftree_raw_line() which
> currently does not support '-z' output, parse_from_to_diffinfo() which
> is _very_ gitweb specific, git_get_heads_list() which is not generic
> enough (it gets info which gitweb needs, but no more), etc.
>
>> Layer 2 is application-independent as well, so it can become an extra 
>> class in Git.pm or a separate module.  (It should stay independent of 
>> layers 3 and 4).
>
> I think it would be better as separate module.  Would it be Git::Cache
> (or Git::Caching), Gitweb::Cache, or part of gitweb, that would have
> to be decided.  Besides, I'm not sure if it is really application-
> -independent as you say: I think we would get better result if we
> collate data first, which is application dependent.  Also I think
> there is no sense to cache everything: what to cache is again
> application dependent.

Even though I (for some unknown reason) rarely agree with Jakub on this
list, I agree 100% with the above paragraph.  In fact I yesterday started
to write exactly the same thing but I could not word it well enough, and I
am glad Jakub said what I wanted to say in a form that is much clearer
than I would have ;-).
