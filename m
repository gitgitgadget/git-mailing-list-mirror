From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 07:16:20 +0200
Message-ID: <48C8A9A4.7030906@gnu.org>
References: <20080909132212.GA25476@cuci.nl> <20080909211355.GB10544@machine.or.cz> <20080909225603.GA7459@cuci.nl> <20080910122118.GI21071@mit.edu> <20080910141630.GB7397@cuci.nl> <20080910151015.GA8869@coredump.intra.peff.net> <20080910215045.GA22739@cuci.nl> <20080910215410.GA24432@coredump.intra.peff.net> <20080910223427.GB22739@cuci.nl> <20080910225518.GA24534@coredump.intra.peff.net> <20080910231900.GF22739@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Theodore Tso <tytso@MIT.EDU>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Sep 11 07:17:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdeYh-00028c-Lo
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 07:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbYIKFQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 01:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbYIKFQ2
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 01:16:28 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:8034 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbYIKFQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 01:16:27 -0400
Received: by wr-out-0506.google.com with SMTP id 69so122104wri.5
        for <git@vger.kernel.org>; Wed, 10 Sep 2008 22:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=YNZMCqhiiHgXKWMRBBpbWMt6Eju6L4qzRtAaE6rZy24=;
        b=brVYwPIUMLvsLHjWQMh17CNAwiBjhgpOF5ZW4/ontE4dqZyLclN516U/uvQMhuBgMm
         AkYNL5Xtpg8axmnau/sA+0SFrx/FW8b9QGHBI4yVCtmfVJvJV0zq/4bsTdvOtZdCWXNu
         U16neWLD6TbZvt0u3vCBtHuFxmEgeAkXICOds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender;
        b=qpkXmDSuXfnmIWbTBDndIpbv5BVJw+rTHct0GzF8Oco4lDooLd1jpQXTcUGzIbHxKv
         LUky0QNhFnFEqytfZzXDIWQs+PIccsmM0/j9GE9oVQjkh2/Avw7ZnGVjH3dNmp3uprzo
         CFB7L8tNXBDkyrEodgF8UumzXA9dHlLCYKYzM=
Received: by 10.103.23.20 with SMTP id a20mr1490715muj.128.1221110183061;
        Wed, 10 Sep 2008 22:16:23 -0700 (PDT)
Received: from scientist-2.lan ( [89.96.108.150])
        by mx.google.com with ESMTPS id j2sm4270622mue.4.2008.09.10.22.16.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Sep 2008 22:16:22 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <20080910231900.GF22739@cuci.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95580>


>>> - The origin information is no longer cryptographically protected (under
>>>   certain circumstances this could be considered an advantage and a
>>>   disadvantage at the same time).
> 
>> I haven't thought enough about it to decide whether there is a scenario
>> where making such a "cherry-picked from" annotation might make use of
>> that property.
> 
> Being able to subvert the authenticity of git blame by providing fake
> origin information is not very appealing.

You could use a dummy submodule to ensure that each commit pointed to
the right set of notes.  It would force to create a separate commit
whenever you modified the notes, which is actually not bad.

Alternatively, the header of the commit can be modified to add a pointer
to a tree object for the notes; I suppose this is more palatable than
the origin link.  The tree could be organized in directories+blobs like
.git/objects to speed up the lookup.

I actually like the commit notes idea, but then I wonder: why are the
author and committer part of the commit object?  How does the plumbing
use them?  Isn't that metadata that could live in the "notes"?  And so,
why should the origin link have less privileges?

Paolo
