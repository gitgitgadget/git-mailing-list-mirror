From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] gitk: Add ability to define an alternate temporary
 directory
Date: Thu, 12 Nov 2009 01:36:13 -0800
Message-ID: <20091112093611.GA47285@gmail.com>
References: <1257904149-44381-1-git-send-email-davvid@gmail.com>
 <4AFA368F.207@vilain.net>
 <20091111040715.GA44672@gmail.com>
 <7vr5s5y8n8.fsf@alter.siamese.dyndns.org>
 <20091111164451.GA45475@gmail.com>
 <20091112083559.GB17552@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Sam Vilain <sam@vilain.net>,
	paulus@samba.org, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 12 10:36:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8W6L-0001nm-1k
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 10:36:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677AbZKLJgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 04:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752652AbZKLJgO
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 04:36:14 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:63601 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbZKLJgN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 04:36:13 -0500
Received: by pwi3 with SMTP id 3so1242357pwi.21
        for <git@vger.kernel.org>; Thu, 12 Nov 2009 01:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=RyonIwVNwB5ge8acY0OW9771rUtqvL9mAmcNK/khj0o=;
        b=Ege11wA/XMqvDYJ6UH4zrQS9/iD+dZeAP2U+2hag53qAYUZIswmlk5IrR5g+NOzJMG
         BalnqYo/hM8b9kfeWdUxcI3awBmfOH6pI1p3E0F83Y34/8FXLi0iE/pnpAHe+rH0U1O+
         8IvHGvByQwZk4WGfB6A3UQJwLPQJS8Y6eOfFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sW5Xu7JdBLQI8DGLKWoWciU+IJQKI1SKzxGlj7G7GOEOMjmpv5ZFWGWXSiZp0Rm88W
         xyHwtALCsoTVp2mDdHd4mfbkk99njyMafaksqnt2JnGQzAnmZ4GkgDIC+LVHvvyQijEI
         udRFYId7QKcbfWDR6VkBvKQLJZwRM7/0kkGLU=
Received: by 10.114.2.25 with SMTP id 25mr2927357wab.103.1258018578773;
        Thu, 12 Nov 2009 01:36:18 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 20sm1554232pzk.9.2009.11.12.01.36.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Nov 2009 01:36:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091112083559.GB17552@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132754>

On Thu, Nov 12, 2009 at 03:35:59AM -0500, Jeff King wrote:
> On Wed, Nov 11, 2009 at 08:44:53AM -0800, David Aguilar wrote:
> 
> > gitk writes file@commit and file@commit^ to temporary files
> > and diffs them using an external diff tool.
> > 
> > Shall I reroll with s/GITK_TMPDIR/TMPDIR/ ?
> 
> gitk seems to use a very predictable temp filename (".gitk-tmp.$PID").
> Have you checked that you are not introducing any security holes by
> creating that predictable filename in a publicly writable tmpdir?
> 
> It looks like it always tries to "mkdir" the file. Does tcl's mkdir
> function barf on an existing directory? If so, then I think we may be
> safe from the naive:
> 
>   tmp=.gitk-tmp.`pidof_other_users_gitk`
>   mkdir $tmp
>   ln -s /file/for/other/user/to/destroy /tmp/1
> 
> attack. And I think we are not susceptible to races because we fail if
> the mkdir fails (instead of doing something stupid like stat followed
> by mkdir).
> 
> But it has been a long time since I thought about /tmp security, so I
> may be forgetting something.
> 
> -Peff

Thanks for the review.
I'm about to reroll with a new subject, "gitk: Honor TMPDIR..."

When I have more time I can switch gitk over to git-difftool
which I know is /tmp safe.  I only dabble in tcl but the
docs say that mkdir does not error out when given
directories that already exist.  It does error out when
given a file.

The /tmp trick would require them knowing the SHA-1 that
we're diffing and symlinking the names to paths they want
us to destroy.  It seems paranoid to worry about it ;)
but since if it's a real concern than I'll try to
get to the git-difftool rework within the next two week.
I only dabble in tcl ;)

-- 
		David
