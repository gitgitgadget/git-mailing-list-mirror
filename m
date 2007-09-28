From: Dan Farina <drfarina@gmail.com>
Subject: Re: backup or mirror a repository
Date: Fri, 28 Sep 2007 00:20:03 -0700
Message-ID: <1190964003.31911.13.camel@Tenacity>
References: <1190921742.2263.17.camel@Tenacity>
	 <Pine.LNX.4.64.0709272255360.28395@racer.site>
	 <1190940704.2263.32.camel@Tenacity>
	 <Pine.LNX.4.64.0709280253150.28395@racer.site>
	 <1190947063.2263.46.camel@Tenacity>
	 <7vsl4zqp8l.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 09:20:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbA9A-00036G-HK
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 09:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757577AbXI1HUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 03:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757569AbXI1HUQ
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 03:20:16 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:33679 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757547AbXI1HUO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 03:20:14 -0400
Received: by wr-out-0506.google.com with SMTP id 36so1251137wra
        for <git@vger.kernel.org>; Fri, 28 Sep 2007 00:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=48b5h7C252eGQgN1WqKBk9h1sYZc3H/CWyy+/RkLV1g=;
        b=I5jSp4FsIKUqw9FBiSjlhbXStvC1VjFK4c9HSGVPXLg4A9VQ0nNEwj9UrRUL2gNwW2HeuD085x8Tln+uVSWqefMnSC9TfFWuqlcwxUCgozmvPDzl/qxxFM36zSlh8MdaSjMPfGuAZaKfR4EDwr6Hc7QS6ivJ584RUho/ZY1+MoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=nGl7i2jq5LCpITsdkL4huzVxDchHWA0gRv+cgNdG6o7CioHoRrpTJrTGpDpiw/Xw1oJijypD+vkMza/4cY89Y/fFAXJEDVrlbVzWvCQFR+vHCwOHl/U+sB1EBewKxf7DYrcNwQ7LKTn7iu2Z1pq6EY34u30kw7kh9neuaq+ASjk=
Received: by 10.90.51.17 with SMTP id y17mr4827885agy.1190964013510;
        Fri, 28 Sep 2007 00:20:13 -0700 (PDT)
Received: from ?192.168.1.101? ( [71.134.240.3])
        by mx.google.com with ESMTPS id n80sm2209181pyh.2007.09.28.00.20.11
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 28 Sep 2007 00:20:12 -0700 (PDT)
In-Reply-To: <7vsl4zqp8l.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59375>

On Thu, 2007-09-27 at 23:27 -0700, Junio C Hamano wrote:
> You can almost do it with
> 
> 	git push --all $remote
> 
> except there is no way to automagically remove the branch you
> removed from the local repository.  For that, we would need a
> new --mirror option to "git-push".

Yup! I actually was looking for such a thing in the git-push man page,
but was unsuccessful. I was living with git-push --all for a little
while before I thought I'd ask. Unfortunately, the preferred setup
(having the backup machine actively perform fetch and prune) is not very
nice for me due to firewalls.

> 
> I think it is trivial to do for native transports, as we first
> get the list of all refs from the remote side before starting
> the transfer.  You need to change the last parameter called
> 'all' to remote.c::match_refs() into an enum ('push_all' being
> one of choices), introduce another enum 'push_mirror', and teach
> it to "match" the remote (i.e. dst) ref that does not have
> corresponding entry on our side (i.e. src) with an empty object
> name to mark it removed.  Then the part marked as "Finally, tell
> the other end!"  in send-pack.c::send_pack() will take care of
> the actual removal.

I should have a look, but if someone else wants to work on this they
shouldn't block on me: work already made me get hit by a bus on one
project (luckily I wasn't important), and the storm is not over.

Thanks,
fdr
