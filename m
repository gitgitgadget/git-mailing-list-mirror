From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Question about 'branch -d' safety
Date: Sat, 10 Jul 2010 17:17:24 -0500
Message-ID: <20100710221724.GA3891@burratino>
References: <20091230065442.6117@nanako3.lavabit.com>
 <20091229223123.GA12965@vidovic>
 <20091230121238.6117@nanako3.lavabit.com>
 <20100710065549.GA24296@localhost>
 <20100710214050.GA3680@burratino>
 <m3lj9jknlr.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 11 00:18:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXiNE-0002SB-Pg
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 00:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366Ab0GJWSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jul 2010 18:18:11 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42106 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035Ab0GJWSK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jul 2010 18:18:10 -0400
Received: by iwn7 with SMTP id 7so3425109iwn.19
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 15:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=WPxIvGQbOQK9iKyC24IcyZCG0puNhINwJ5GCljq/tNQ=;
        b=tGG8IF7aaC+mhb2/eKK5v4WLhIYwWCmElVDgXi2oDMoW8O4dWbWYDFZb6bv3TsYaWL
         JLX8apM3Fr74GGg9D1XYB0bPR6gO/RZeOEcOI0NF686h6mD8KbIjxR5KNi39hucs7X9q
         AVafLiOoEp3Ft0XMgNAbaqMhBuMO5a8XPqqvY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=honmbZgP2H2iDjjkoEvApn27+gPY0AajF2HRd6yPPoHRS791h+AFIw50CsK+lD4X3T
         OsIw8fnjfjJyyQXdyjt88EmV7O3bDsFKdwNuT40/hH7ylVI7+no6zs9OT2dnCc5B9wvB
         p/bgZgmGwMUUJ9Ga6FFlBeJCh0EtjGhMiDnPg=
Received: by 10.231.146.135 with SMTP id h7mr12534461ibv.149.1278800288933;
        Sat, 10 Jul 2010 15:18:08 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id e8sm11229985ibb.2.2010.07.10.15.18.07
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 10 Jul 2010 15:18:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m3lj9jknlr.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150734>

Jakub Narebski wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> +++ b/refs.c
>> @@ -1084,7 +1084,6 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
>>  	 */
>>  	ret |= repack_without_ref(refname);
>>  
>> -	unlink_or_warn(git_path("logs/%s", lock->ref_name));
>>  	invalidate_cached_refs();
>>  	unlock_ref(lock);
>>  	return ret;
>
> It's unfortunately not so easy.  The problem you have to solve is D/F
> conflict: if you have 'foo/bar' branch, you can't create 'foo' branch,
> but after deleting 'foo/bar' you want to be able to create 'foo'
> branch and reflog for 'foo' branch.

Thanks for the pointer.  Here are some more, for the interested.

 - http://thread.gmane.org/gmane.comp.version-control.git/144250/focus=145366
   the dead_refs namespace

 - http://thread.gmane.org/gmane.comp.version-control.git/73838/focus=73877 
   why to make and why not to make the change
