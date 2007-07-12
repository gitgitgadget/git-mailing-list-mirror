From: "Matt McCutchen" <hashproduct@gmail.com>
Subject: Re: [PATCH] gitweb: snapshot cleanups & support for offering multiple formats
Date: Wed, 11 Jul 2007 21:15:45 -0400
Message-ID: <3bbc18d20707111815i1de3cb35sadfa316ddee7f3f6@mail.gmail.com>
References: <1183053733.6108.0.camel@mattlaptop2>
	 <7vir8w6inf.fsf@assigned-by-dhcp.cox.net>
	 <200707111755.50018.jnareb@gmail.com>
	 <7vir8q4opc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Luben Tuikov" <ltuikov@yahoo.com>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 03:15:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8nHc-0005e4-Fm
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 03:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761589AbXGLBPs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 21:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758887AbXGLBPs
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 21:15:48 -0400
Received: from nz-out-0506.google.com ([64.233.162.228]:4304 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760264AbXGLBPr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 21:15:47 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1529809nze
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 18:15:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V/V3pMmSkAUn7KVX2twmVeKqzxQlqD/U0TBxRCbsR7NMu9fQceEq2ztVI0BfL8V7G1z50pw9sLSXheKysHt0XCG21RjdSRvslDTBjcpTws8gim8mCib3DTzbcAft37yYdLZoGF2e26kh6Yhj6n89ND4USUECLsvGjS894HEn0v0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AZkfsXvV/nqUY6yPwza13IWY8/It6X957cHh8VkTHoK/UZpruPi1Dxkuu581vkw4UMWmCYt7HM64v+suCu2zb00eOrRyMV5amJhQnKJ2T9jEULVyVgEMkxKhOGjPRE/XHpr9Laqicn1rYdAXXFUqiDae4oEeVdnKiCvxWIUdJiA=
Received: by 10.143.39.16 with SMTP id r16mr6941wfj.1184202945531;
        Wed, 11 Jul 2007 18:15:45 -0700 (PDT)
Received: by 10.143.30.9 with HTTP; Wed, 11 Jul 2007 18:15:45 -0700 (PDT)
In-Reply-To: <7vir8q4opc.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52227>

On 7/11/07, Junio C Hamano <gitster@pobox.com> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>
> > I'm not sure if we want to store whole 'application/x-gzip' or only
> > 'x-gzip' part of mime type, and if we want to store compressor as
> > '| gzip' or simply as 'gzip'.

Storing only 'x-gzip' assumes that all archive formats have MIME types
beginning with 'application/'.  Even if this assumption is justified
by the MIME specification, I felt it was inappropriate to code it into
gitweb.  The advantage of '| gzip' is that the lack of a compressor is
not a special case.  This is why I wrote %known_snapshot_formats the
way I did, but of course you all are welcome to overrule me.

> > This would break not only existing _gitweb_ configuration (when
> > gitweb admin installs new gitweb it isn't that hard to correct
> > gitweb config), but also git _repositories_ config: gitweb.snapshot
> > no longer work as it worked before, for example neither 'gzip'
> > nor 'bzip2' values work anymore ('zip' doesn't stop working).
>
> I realized after seeing your other message on this patch that
> this can be done while retaining backward compatibility, as you
> suggested.  Matt, does Jakub's suggestion make sense to you?

It's not clear to me what the suggestion is: offer format names 'gzip'
and 'bzip2' instead of 'tgz' and 'tbz2', or in addition to them, or
what?  I prefer 'tgz' and 'tbz2' because they carry more information
and are properly analogous to 'zip', so I don't want to offer 'gzip'
and 'bzip2' instead of them.  Furthermore, I would like the user to
see 'snapshot (tgz tbz2)' even if the repository owner wrote 'gzip
bzip2', so just adding two rows to %known_snapshot_formats is
insufficient.  Either an additional column could be added to
%known_snapshot_formats for the display name, or 'gzip' and 'bzip2'
could be specified as aliases in %known_snapshot_formats and
feature_snapshot could be taught to resolve them.  I would prefer the
second option; shall I implement it?

It would be possible to make the gitweb site configuration
backward-compatible too; here's one possible approach.  On startup,
gitweb would check whether $feature{'snapshot'}{'default'} is a
three-element list that appears to be in the old format.  If so, it
would save the settings in $known_snapshot_formats{'default'} and then
set $feature{'snapshot'}{'default'} = 'default' .  This is a hack; is
it justified by the compatibility benefit?

Matt
