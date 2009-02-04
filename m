From: Jake Goulding <goulding@vivisimo.com>
Subject: Re: [RFC PATCH 1/1] git-tag: Add --regex option
Date: Wed, 04 Feb 2009 09:16:44 -0500
Message-ID: <4989A34C.4080104@vivisimo.com>
References: <1233677512-1846-1-git-send-email-goulding@vivisimo.com> <7vljsm3aow.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 15:18:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUia7-0003in-8Q
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 15:18:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbZBDOQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 09:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751708AbZBDOQ5
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 09:16:57 -0500
Received: from scalix.vivisimo.com ([207.97.211.28]:39702 "EHLO
	mail.vivisimo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683AbZBDOQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 09:16:56 -0500
Received: from mail.office.vivisimo.com (mail.office.vivisimo.com [206.210.75.84])
	by mail.vivisimo.com (Postfix) with ESMTP id EDBAD851A58;
	Wed,  4 Feb 2009 09:16:55 -0500 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.office.vivisimo.com (Postfix) with ESMTP id CDD982E68CF;
	Wed,  4 Feb 2009 09:16:55 -0500 (EST)
X-Virus-Scanned: amavisd-new at vivisimo.com
Received: from mail.office.vivisimo.com ([127.0.0.1])
	by localhost (mail.office.vivisimo.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IfzeIzpsVkfM; Wed,  4 Feb 2009 09:16:45 -0500 (EST)
Received: from [192.168.0.20] (jpg-melchior.vivisimo.com [192.168.0.20])
	by mail.office.vivisimo.com (Postfix) with ESMTP id 29A9C2E68D0;
	Wed,  4 Feb 2009 09:16:45 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <7vljsm3aow.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108363>


Junio C Hamano wrote:
> Jake Goulding <goulding@vivisimo.com> writes:
> 
>> Allows the tag pattern to be expressed as a regular expression.
> 
> We use shell globs for refname throughout the system (not just tags).  Why
> is this a good thing, other than "because we can"?
> 

I'll give the particular use-case that we are using it for:

In preparation for a release, we have a nightly tagging/building
process. We start by tagging something as 1.0.0-build1. We then do that
series for a while, then decide it is time to shift to a more thorough
QA cycle. We branch a QA branch, then start tagging at 1.0-0-rc1.
Eventually, a rc passes all QA tests and we tag that rc again as 1.0-0.

Thus, our tags look like something of the form:

1.0.0-build1
1.0.0-rc1
1.0.0

As we fix bugs, a hook automatically adds the commit hash is as a
comment to the appropriate bugzilla bug.

We whipped up a dinky little web application that takes a hash and a
branch, and shows which tags contain that particular hash (which is the
reason for my previous commit for --contains support in git tag). We
hacked bugzilla to match on git hashes, and provide a link to this webapp.

I wanted to be able to limit the search space to (builds, rcs,
releases), but globs don't allow that amount of flexibility.

Is that a complete enough description for a rational use-case?

-Jake
