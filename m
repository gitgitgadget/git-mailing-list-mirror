From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: clone breaks replace
Date: Fri, 7 Jan 2011 15:49:07 -0600
Message-ID: <20110107214907.GA9194@burratino>
References: <4D262D68.2050804@cfl.rr.com>
 <20110106213338.GA15325@burratino>
 <4D276CD2.60607@cfl.rr.com>
 <20110107205103.GC4629@burratino>
 <4D278930.7010100@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Stephen Bash <bash@genarts.com>
To: Phillip Susi <psusi@cfl.rr.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 22:49:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbKBe-0004Vo-LK
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 22:49:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753827Ab1AGVt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 16:49:26 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:49914 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425Ab1AGVtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 16:49:25 -0500
Received: by qwa26 with SMTP id 26so18255503qwa.19
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 13:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=v1BhWsTJHol29mEgDDWQKMfeKwlkNbzkrBwygm3++jQ=;
        b=n09UpRrIjbWxaaTUgE94JIM9SMOH1phX7qFggwPUOXOh/LPCJGguoguzePXkLjPGQ4
         azfQqsRqbAK6F5WROl6hgSMCl1tuI/ck9m2h4JJbMMuDWArF5ChllBmxhIfC/+FqFQpT
         FE/SZqDYq0LHlJgSZ/7UVFfVeZSrXhfxKsJ4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pUgo63vBXQeBIfazQcfu8/sHkjIAnEERDjRhqs2jO2QFjOdTwjPhzYvbeMLpndIaP9
         L1ZyB5rBkyovkD/RHO+nZmIGjHF2zphbFm906B/xXN6wYCF7HutFs2BL2krd60DW8USQ
         a94IkKm4u0U7J+RwwFUabl3XkQz8mxnqg93cE=
Received: by 10.229.240.198 with SMTP id lb6mr22219530qcb.255.1294436964609;
        Fri, 07 Jan 2011 13:49:24 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.ameritech.net [69.209.72.219])
        by mx.google.com with ESMTPS id p13sm15441432qcu.29.2011.01.07.13.49.21
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 07 Jan 2011 13:49:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D278930.7010100@cfl.rr.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164768>

Phillip Susi wrote:

> Take the kernel history as an example, only imagine that Linus did not
> originally make that first commit leaving out the prior history, but
> wants to go back and fix it now.  He can do it with a replace, but then
> if he runs filter-branch as you suggest to make the change 'real', then
> everyone tracking his tree will fail the next time they try to pull.
> You could get the same result without replace, so why bother?
>
> If the replace was fetched by default, the people already tracking would
> get it the next time they pull and would not have a problem.

Interesting.  I hadn't thought about this detail before.

> Those cloning the repository for the first
> time would get it, and avoid fetching all of the old history since they
> would be using the replace record in place of the original commit.

No, it doesn't work that way.  Imagine for a moment that each commit
object actually contains all of its ancestors.  That isn't precisely
right but in a way it is close.

To change the ancestry of a commit, you really do need to change its
name.  If you disagree, feel free to try it and I'd be glad to help
where I can with the coding if the design is sane.  Deal?

Maybe it would be nice if git replace worked that way, but that would
be fundamentally a _different_ feature.
