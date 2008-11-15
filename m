From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH v2 05/11] gitweb: git_split_heads_body function.
Date: Sat, 15 Nov 2008 13:25:59 +0100
Message-ID: <cb7bb73a0811150425j2475db8dsdee57c1cc5e208ab@mail.gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1226616555-24503-5-git-send-email-giuseppe.bilotta@gmail.com>
	 <1226616555-24503-6-git-send-email-giuseppe.bilotta@gmail.com>
	 <200811150059.14515.jnareb@gmail.com>
	 <7vprkx5gqb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org,
	"Petr Baudis" <pasky@suse.cz>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 13:27:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1KFe-0002fz-G4
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 13:27:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592AbYKOM0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 07:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754547AbYKOM0D
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 07:26:03 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:17043 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754110AbYKOM0B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 07:26:01 -0500
Received: by ey-out-2122.google.com with SMTP id 6so719579eyi.37
        for <git@vger.kernel.org>; Sat, 15 Nov 2008 04:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=DTysRy++lF7Gn+6CqcSeYkGr+daoepXq1AegIkhLepo=;
        b=MjG/d4pVqo/Ie20DUoOUmdbDtvyOB7P+HWLkJl8a5QyBoCyO1AaudbPpEwEjs+jWYq
         zUDUeBCgAAtuA7/huaaZILOcqTYKeG6mb1khtLl3CdjAB4qZ4OTGwjr9uRcVM6GY1pdh
         K8RMsIHOPfNy71x0mUn4PCy91DL6EZyvbtXBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Te57onY5nNPIppHd9zi6jeSkH7NthmI96dB6t0Y98pYHPbr8G9ZhraTS12577xMd4O
         WY6nnS56PipiWQWaw1ZTWzMiqkCp6XzwmSfQz2SKyN7L+2WESbTywVwQkVAAu8O5U3hr
         ZfmAoecvKKGBSWRkuehoYLuCk3vTef77yrUFw=
Received: by 10.210.56.7 with SMTP id e7mr2110500eba.32.1226751959980;
        Sat, 15 Nov 2008 04:25:59 -0800 (PST)
Received: by 10.210.132.16 with HTTP; Sat, 15 Nov 2008 04:25:59 -0800 (PST)
In-Reply-To: <7vprkx5gqb.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101065>

On Sat, Nov 15, 2008 at 1:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>
>> Second, this patch wouldn't do what you want from it if there are
>> remotes with '/' in name.  I for example use "gsoc2008/gitweb-caching"
>> for Lea Wiemann repository with her GSoC 2008 work on adding caching
>> to gitweb.
>
> I think your point is if you also use gsoc2008/gitstats from another
> remote repository, these two sets of remote tracking branches will be
> shown grouped together.  But is it a bad thing?  After all, you chose to
> use hierarchical names for them, _and_ you chose to use the same toplevel
> hierarchy name for them.  Doesn't that mean you _wanted_ to have them both
> appear in the same GSoC 2008 group?

The problem is that we have gsoc2008/gitweb-caching/branch1
gsoc2008/gitweb-caching/branch2 gsoc2008/gitstats/branch3
gsoc2008/gitstats/branch3, and my current code would show
gitweb-caching/branch1, gitweb-caching/branch2 etc under gsoc2008.

Having branch1 and branch2 under gsoc2008/gitweb-caching, and branch3
and branch4 under gsoc2008/gitstats would be more logical,
remote-wise, but it would of course lose the coupling between all the
gsoc2008 remotes.

If deep nesting is not a problem, I can code something to have
gitweb-caching and gistats under gsoc2008, and the respective branches
within.




-- 
Giuseppe "Oblomov" Bilotta
