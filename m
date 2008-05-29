From: "Geoffrey Irving" <irving@naml.us>
Subject: Re: caching commit patch-ids for fast git-cherry
Date: Thu, 29 May 2008 10:34:10 -0700
Message-ID: <7f9d599f0805291034l6c655ccbk219dd74964c65737@mail.gmail.com>
References: <7f9d599f0805291001mdbb4b42q6f3a1b79bc9bc4e9@mail.gmail.com>
	 <alpine.DEB.1.00.0805291809340.13507@racer.site.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 29 19:35:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1m1x-0003Mu-0A
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 19:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890AbYE2ReN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 13:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbYE2ReN
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 13:34:13 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:56911 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522AbYE2ReM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 13:34:12 -0400
Received: by rv-out-0506.google.com with SMTP id l9so4196115rvb.1
        for <git@vger.kernel.org>; Thu, 29 May 2008 10:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=TR4jXI7q+DrZwWr/ANN0wo+Sf1elpW+hM1sLplhT+yg=;
        b=gwZNNatj9YiLcGeGO65P5eORMMKufPE+OYPFDDFXk+gmiRgV7Mb2uAtAa2oKd0ljsEB38nhK+Z4XbmZVP6ndtaffj7O8B1HLHz0kZVxOvQLY0tYYF7Z4m1jS2wHMhDkTvdJ43rknwueNgjICvkmmSDctnoXm4Tj6NVjLttcTjAw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=IP8icWPtVAt3vzDr82jBIVlxeOtaYN7IBFxHLjMExjW7kkvHCOXBNZ/X4BAK4BnwWSCk5zdQOU5grop3DJM1tc9CJM7ZbiEWiLS9X6e+UfpRRBVik/k70S8Md2/dRVxsvtjRMOE7gc4Tf8pKe8JSQlD362/egjDiW9wH0mJ/xAU=
Received: by 10.141.83.15 with SMTP id k15mr2318990rvl.74.1212082450391;
        Thu, 29 May 2008 10:34:10 -0700 (PDT)
Received: by 10.140.178.16 with HTTP; Thu, 29 May 2008 10:34:10 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805291809340.13507@racer.site.net>
Content-Disposition: inline
X-Google-Sender-Auth: 1df4106224b40076
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83224>

On Thu, May 29, 2008 at 10:13 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 29 May 2008, Geoffrey Irving wrote:
>
>> I'm planning to use cherry picking to manage long term syncing between
>> cvs/perforce and git repositories.  This means I'll have scripts running
>> git-cherry between branches with hundreds of uncommon commits, and I
>> want git-cherry to be much, much, faster.
>>
>> It looks like I can do this by caching commit->patch-id pairs from
>> commit_patch_id() in patch-ids.c to a file, say
>> $GIT_DIR/commit-patch-id-cache.  The file would be binary and append
>> only, and could be blown away if .  Any suggestions / concerns before
>> I write this?  Is there any reusable efficient map code for storing
>> the commit->patch-id map, or should I just mirror the blocked storage
>> + binary search used for struct patch_ids?
>
> I would store the stuff sorted, so that the lookup is fast, generation
> less so.

The motivation for append-only was robustness, not speed, but I don't
think either concern is very significant.

> For inspiration, you might want to look at the "notes" branch in my
> personal fork:
>
> http://repo.or.cz/w/git/dscho.git?a=shortlog;h=refs/heads/notes

Cool.  I'd rather copy just that code entirely rather than use it for
inspiration, since it does exactly what I need.  It would be silly to
have two blocks of code implementing "persistent map from 20 byte hash
to 20 byte hash".

I'll start by just copying the entire nodes-index implementation (with
a few name substitutions), and we (or I) can refactor it later if both
end up in the same respository.

Geoffrey
