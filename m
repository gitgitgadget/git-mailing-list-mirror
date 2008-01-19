From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] git-commit: add a prepare-commit-msg hook
Date: Sat, 19 Jan 2008 10:32:24 +0100
Message-ID: <4791C3A8.7000308@gnu.org>
References: <4790BCED.4050207@gnu.org> <7vbq7ibxhh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 19 10:33:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGA4S-00045l-4w
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 10:33:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513AbYASJc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 04:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752499AbYASJc2
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 04:32:28 -0500
Received: from hu-out-0506.google.com ([72.14.214.226]:17547 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322AbYASJc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 04:32:26 -0500
Received: by hu-out-0506.google.com with SMTP id 19so452817hue.21
        for <git@vger.kernel.org>; Sat, 19 Jan 2008 01:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=1NZXQ4u6temq83SXsa2Dogph7mi0gzAoLhH5LRW99kU=;
        b=oXgaKaJy92D8var4eoG4GH9CLWfZ4Y74j9LnjSDEHOQdQVUQXaM7k8Za/arQsvRXFr5+fhjdhTrtKngeBt7Y+jEOZkM4kittO981lIfAATwKk88E9VBzu5nNyPc94CR2T8VJxoZ22MXkVBgD/qGVCPUR5TQllGi/NsKFagHGGzc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=Tfwk5/FlOqMg7muu6vQL4MQWUT9SWpK1CnAdPUrf+kbcK271SOcpdpnk5FjkYzi+Kp3w1VMnnJ+61vhSsfPk8kzP+L2P7EnZKMr8EppcWk+sXd/sSibCni7Nu7dds7ZT8Qurd7fcBUxfKwi9pnNAwPaG/wqopwEAnoN0a7130iM=
Received: by 10.86.65.11 with SMTP id n11mr4059045fga.26.1200735143867;
        Sat, 19 Jan 2008 01:32:23 -0800 (PST)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id l12sm5342184fgb.8.2008.01.19.01.32.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 19 Jan 2008 01:32:22 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Macintosh/20071031)
In-Reply-To: <7vbq7ibxhh.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71090>


> On the other hand, if you want to always cause an action before
> running a git opeation locally, you do not have to have a hook.
> You can just prepare such a message based on GNU ChangeLog and
> then run git-commit with -F, both inside your wrapper.

I see two other possibilities:

1) Would you prefer allowing to run a command by setting commit.template 
to something starting with an exclamation mark, i.e. something like 
"!git diff --cached --name-status -r"?

2) The pre-commit could receive a file name on the command line.  If it 
creates that file, it would be used as a template for the commit 
message.  The default implementation of pre-commit could include, 
commented out, a reimplementation of prepare_log_message.  I like this 
the least.

3) Consider that the patch, as I implemented it, does not act solely on 
local data, because the index could be modified by the pre-commit hook. 
  This possibility is contemplated explicitly in builtin-commit.c:

         /*
          * Re-read the index as pre-commit hook could have updated it,
          * and write it out as a tree.
          */

Paolo
