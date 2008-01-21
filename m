From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] git-commit: add a prepare-commit-msg hook
Date: Mon, 21 Jan 2008 07:16:49 +0100
Message-ID: <479438D1.2050107@gnu.org>
References: <4790BCED.4050207@gnu.org>	<7vbq7ibxhh.fsf@gitster.siamese.dyndns.org> <4791C3A8.7000308@gnu.org>	<alpine.LSU.1.00.0801191119050.5731@racer.site> <7vd4rw6siv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 07:17:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGpyF-00011Z-Iu
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 07:17:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327AbYAUGQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 01:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752932AbYAUGQy
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 01:16:54 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:43413 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324AbYAUGQx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 01:16:53 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1703802fga.17
        for <git@vger.kernel.org>; Sun, 20 Jan 2008 22:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=GrcVRI4G2CmAnN02Bv0sMrCfVWNOtHYXdyaO/xB70Q4=;
        b=vYx5p7LHzGT4ZKRHgiwOMK92BaAHCuk4df9QfN8AigsYcH3MealDJ0aVhSTvD9nI2R/kMOOipLdkQ4hkAs/VHjzGIqKXzbrX4nTGOdyAB41wvivnB98cg+0bGPkPs7aY9WbrYBnTBdwuO+yw+YXTI2/+cYowkyx1kdqojiBjmT0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=ohmyVNE8ImJW05wlpVGhs4yNi0Q0USUQgKTcj/w88oUigV5DxqZ3o05/xP72X44YheirhAsQPnOwOkRw3+IQ9hj5PDR4JOuaokF/QPAwXf9qWJzciv6TUe6sNpl7uygvwQZ6g2LI2FZsAgh8ovBFPsNciylw4L5Z8/rZ3WhsHV4=
Received: by 10.86.9.8 with SMTP id 8mr6098803fgi.70.1200896212287;
        Sun, 20 Jan 2008 22:16:52 -0800 (PST)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id d4sm7911280fga.2.2008.01.20.22.16.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 20 Jan 2008 22:16:50 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Macintosh/20071031)
In-Reply-To: <7vd4rw6siv.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71225>


> I think that the approach has one huge advantage.  Commands
> other than "git commit" itself ("git merge", "git rebase", "git
> am", etc.) do call "git commit" to record the changes they made.
> I suspect these command would not want this template behaviour,
> and not adding this custom commit message "feature" to "git
> commit" would avoid the risk of breaking them.

My patch does not do that.  Of all these commands, only git-rebase uses 
porcelain git-commit rather than plumbing git-commit-tree, and it uses 
the -C or -F options (which disable the hook in my patch).

> At the same time, this exact issue could be a drawback.  Some of
> them _might_ want it.  But in that case, the the custom template
> "hook" needs to be told _why_ it is being called, so that it can
> adjust its behaviour.

I would like to understand why both of you have not considered the point 
  that the script would need the updated index from git-commit.  Because 
short of reusing half of the old Bourne-shell git-commit, I don't see 
how this would be possible, but maybe there's something obvious.  Or 
maybe we need new plumbing like git-build-index -- then I'd still need 
to complicate my script to build a template commit message, but I 
wouldn't need to muddle myself (not too much at least) in handling the 
command line.

Paolo
