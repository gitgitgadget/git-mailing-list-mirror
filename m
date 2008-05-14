From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: resurrect "gc --auto" at the end
Date: Wed, 14 May 2008 11:13:38 -0700
Message-ID: <7vlk2coist.fsf@gitster.siamese.dyndns.org>
References: <20080330231408.GR11666@genesis>
 <20080330232612.GA23063@atjola.homenet>
 <alpine.LFD.1.00.0803301645020.14670@woody.linux-foundation.org>
 <7vr6drsl47.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0804021538220.4008@racer.site>
 <alpine.DEB.1.00.0805141607210.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 14 20:15:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwLV2-0007Zf-D3
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 20:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756782AbYENSN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 14:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756700AbYENSN5
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 14:13:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64470 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbYENSN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 14:13:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 47E37431A;
	Wed, 14 May 2008 14:13:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 733294316; Wed, 14 May 2008 14:13:52 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0805141607210.30431@racer> (Johannes
 Schindelin's message of "Wed, 14 May 2008 16:07:46 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 83C11B68-21E1-11DD-863A-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82125>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 2 Apr 2008, Johannes Schindelin wrote:
>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> 
>> As the scripted version of git-commit did, we now call gc --auto just 
>> before the post-commit hook.
>> 
>> Any errors of gc --auto should be non-fatal, so we do not catch those; the 
>> user should see them anyway.
>> 
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>> 
>> 	Junio wrote:
>> 	>
>> 	>  * "git commit" used to have one [call to 'gc --auto'] at the 
>> 	>    end in the scripted version, but seems to have lost it in C
>> 	>    rewrite.
>> 
>> 	How about this?
>
> Any news on this?

I had an impression that we accepted the hook which made "gc --auto" more
expensive by forcing it to check the hook (and possibly execute it every
time) after vetting am, svn and friends to make sure nobody triggered "gc
--auto" once per every commit, and during that vetting process we noticed
that "git commit" lost the "gc --auto" at the end.

With this patch, we would again have a command that runs "gc --auto" once
per every commit, wouldn't we?  Interactive use of git-commit is fine with
it, but if people drive "git commit" from their scripts in a loop, they
would be hurt.

Having said that, perhaps the overhead of "gc --auto" hook is not such a
big deal.  I dunno.
