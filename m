From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] log which temporary file could not be created
Date: Sun, 10 Oct 2010 13:09:09 -0500
Message-ID: <20101010180909.GA12320@burratino>
References: <20101009201751.GK9348@bzzt.net>
 <20101010024124.GA20305@burratino>
 <20101010103327.GO9348@bzzt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Arnout Engelen <arnouten@bzzt.net>
X-From: git-owner@vger.kernel.org Sun Oct 10 20:12:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P50O4-0004QW-9r
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 20:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982Ab0JJSM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 14:12:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61813 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090Ab0JJSMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 14:12:25 -0400
Received: by iwn6 with SMTP id 6so2446217iwn.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 11:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=a79L9fhFaszojCF88XW4Pw0HBHEp4Cv4d05vJ6qBHew=;
        b=YFrb0UJPPh+4pQzVEVgtUvilttuYP1B1G+sQhpEaMsVrea4o2AkihxrtSAiI2QNYFk
         YRztUBfZqhvqyhmWxill/LUxDmvfRVLX3nPAzwemart8RGcUZm8wl5ZiF/qvspKNTZPc
         r6Dmyu8Q60GQffrv/h18UwXNhJzZDdCyuIuy8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xMDeLXAMztat8RG62RlpwZiub4CsFSuN+aW3ruT3lGgU5MKnL0/DVhdY2c77OmRERJ
         XBCODDHahhCEKEih5vngMaxlmMWsZ2LwZ56d+cFVfyNhPh+uVFdzqrEPpi4kcLf3zVTp
         PbEbtFjanzVgmULdkNegJa26hxDNa06tdKYGQ=
Received: by 10.42.149.2 with SMTP id t2mr207808icv.333.1286734344748;
        Sun, 10 Oct 2010 11:12:24 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id u6sm6272738ibd.6.2010.10.10.11.12.23
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 11:12:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101010103327.GO9348@bzzt.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158683>

Arnout Engelen wrote:
> On Sat, Oct 09, 2010 at 09:41:24PM -0500, Jonathan Nieder wrote:

>> 	fatal: Unable to create temporary file '.merge_file_Sc7R5c': File exists
>> 	fatal: Unable to create temporary file 'newrepo/.git/tOWHcxk': No space left on device
>
> Perhaps we should also log the current working directory when the temporary 
> filename is relative?

Let's step back for a moment.  Was there an example that prompted
this patch?  Were you aware of where git would be trying to create
files in that example?  (I'm genuinely curious.)

Converting the filename to an absolute path with make_absolute_path
might be useful, but I am not entirely sure it is worth the
complication.

>> 	fatal: Unable to create temporary file '': Permission denied
>>
>> What should git do in this situation?
>
> Perhaps we should strdup() the template before mkstemp(), and log the 
> strdup()'ed template when the original has been cleared?

Is it be preferable for the filename to always have XXXXXX in it?  If
so, then copying it into a temporary buffer (on-stack, preferably)
could be a sane solution, yes.

Jonathan
