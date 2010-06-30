From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/8] bundle: give list_prerequisites() loop body its
 own function
Date: Wed, 30 Jun 2010 15:37:59 -0500
Message-ID: <20100630203759.GD23400@burratino>
References: <20100119002641.GA31434@gnu.kitenet.net>
 <20100626061735.GA15881@burratino>
 <20100626062047.GD15881@burratino>
 <7vmxuc5rcv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org,
	554682@bugs.debian.org, Adam Brewster <adambrewster@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 30 22:38:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OU43C-0002H8-Hr
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 22:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755740Ab0F3UiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 16:38:25 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50544 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754796Ab0F3UiY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 16:38:24 -0400
Received: by iwn7 with SMTP id 7so1233856iwn.19
        for <git@vger.kernel.org>; Wed, 30 Jun 2010 13:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=oOLCGe7iY7OLXSy3jc+n1sBiWXMIYhhPQkSOVBVcbPg=;
        b=xEekzfkmeaBLVPI3ePoDFwJm6LDvU+5xsJhXFWn3WKGLpMMr53ObBoAnsFAyvZ9wXP
         4a+UI2aDfu9ayQOi3e8l9+yIGZjPqqnNSyCfOh3v9vEGLFjW8kUjX8Erxmx2bupyQyQi
         VIXDPj+27MDeUa3gK/OC3wGOPtSC4EBluCoqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Whzqs/M1p2yfO3UUcpmzN7P71nhjoOK3SNnQ5jVwZwcayO7dtQB+OVa8MgdiZpv+W5
         eRUj2aV0y6troUItb4QyJuZlFrI+87o6ieIOxLQue35uuvbpDJ6nqogOS0SpKkVAgsuw
         jvLnK9rAtnfahKXRzDfdlMJSms1GyDRJopLcQ=
Received: by 10.231.11.3 with SMTP id r3mr9248404ibr.68.1277930303718;
        Wed, 30 Jun 2010 13:38:23 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 13sm699727ibo.18.2010.06.30.13.38.22
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 30 Jun 2010 13:38:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vmxuc5rcv.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149995>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> @@ -209,33 +236,11 @@ static int list_prerequisites(int bundle_fd, struct rev_info *revs,
>>  	if (prepare_revision_walk(&boundary_revs))
>>  		return error("revision walk setup failed");
>>  
>> -	while ((rev = get_revision(&boundary_revs))) {
>> -		if (rev->object.flags & BOUNDARY) {
>> -...
>> -		} else {
>> +	while ((rev = get_revision(revs))) {
>> +		if (rev->object.flags & BOUNDARY)
>> +			list_prerequisite(bundle_fd, revs, rev);
>> +		else
>>  			rev->object.flags |= SHOWN;
>> -		}
>
> You used to walk boundary_revs but now you walk revs that is given by the
> caller

Agh!  Typo.  Thanks for catching it.
