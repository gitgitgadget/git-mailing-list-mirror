From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 05/11] Remove va_copy at MSVC because there are va_copy.
Date: Mon, 17 Aug 2009 18:53:59 +0200
Message-ID: <4A898B27.3040507@gnu.org>
References: <1250525040-5868-1-git-send-email-lznuaa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Johannes.Schindelin@gmx.de
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 18:54:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md5TM-00076u-2q
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 18:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757486AbZHQQyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 12:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756710AbZHQQyG
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 12:54:06 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:47319 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756326AbZHQQyE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 12:54:04 -0400
Received: by ewy10 with SMTP id 10so3096228ewy.37
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 09:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=D8bA//Mbc50c0gk2Wwm1c90pIMHFpFwc8Ba1zGp/ktE=;
        b=pPvq7z+6iiR2aVjwumfJz1r8xyWgdIabdmKbtQZvDsknzvZ/NG+Be6eRJgKrwq75CR
         nwWNS7i38Nz4iD647XIZQHKXAYgzDlaL/ZZNXbd+Q3+APcS5WbPflfAIfqr4m8UPde+W
         jn1EH+ICrjUBQOpJhAtPOlq5fCZdaQEkk5V7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:newsgroups:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=UqHWkBCDUx9iRMn1VvQN41oQkxPGnCSYpHZ2WM8tYAWNd7cPcjApGd03obM0s2P8s7
         2I1//3raW0j3+TJZW3tbAqg82oQRIETE+/g+zMZ64VwbuHuy+xcDCKOfMdNbmxotNZsE
         CfsCrearqc0qbXxG49AfQl9ns/DSAMOI7Fwns=
Received: by 10.210.68.17 with SMTP id q17mr3506747eba.6.1250528043682;
        Mon, 17 Aug 2009 09:54:03 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq.redhat.com [62.40.79.66])
        by mx.google.com with ESMTPS id 5sm3729500eyf.8.2009.08.17.09.54.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 09:54:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1) Gecko/20090814 Fedora/3.0-2.6.b3.fc11 Lightning/1.0pre Thunderbird/3.0b3
Newsgroups: gmane.comp.version-control.git,gmane.comp.version-control.msysgit
In-Reply-To: <1250525040-5868-1-git-send-email-lznuaa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126229>

On 08/17/2009 06:04 PM, Frank Li wrote:
> MSVs have not implemented va_copy. remove va_copy at MSVC environment.
> It will malloc buffer each time.

... but only a 257-byte buffer as dscho pointed out.

In many places that do not have va_copy, a simple assignment works.  And 
va_end is almost always a no-op. So what about

#ifndef va_copy
#define va_copy(dst, src)	((dst) = (src))
#endif

if it works on MSVC?

Paolo
