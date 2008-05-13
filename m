From: nathan spindel <nathans@gmail.com>
Subject: Re: [PATCH v2] instaweb: make it compatible with Mac OS X 10.5's apache installation.
Date: Mon, 12 May 2008 19:54:01 -0700
Message-ID: <21CA1226-223D-4347-A119-1D5A2CEA003E@gmail.com>
References: <1210534569-48466-1-git-send-email-nathans@gmail.com> <B3990C52-0AF9-490C-86E1-B311144C6661@gmail.com> <200805121952.55492.chriscool@tuxfamily.org> <7v7idzz7no.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 13 04:55:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvkfh-000857-0o
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 04:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbYEMCyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 22:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751695AbYEMCyH
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 22:54:07 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:25745 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbYEMCyF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 22:54:05 -0400
Received: by rv-out-0506.google.com with SMTP id l9so2998586rvb.1
        for <git@vger.kernel.org>; Mon, 12 May 2008 19:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        bh=WAlq49Q8lzvWf5cMkyIUteeCAeRLhnsYKSOd7WVrCFA=;
        b=nDDJzD1gxgDDYVPTglNm693zeDq4F6Ryb+Fk31Np5gSbSsYzvK+jx9/xgrd7Imn9vxugPKCKlaYWZZS+6JWpi1LVMuGBWgsVFNp4v5nwmpandxhdaDhIES0WLaZ5Kn569p0bBR0b8fwi2yhC9HYG6R5kGs4lyJu4m0OMM3c4604=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        b=v8s4tvl5r+5i0wBmWhFUIGg1XFRx+gS6GzRVEyX4DrR5SC9aKqJ1VsYkLuJKW5eiBSnYUnuA+0XKGLntPjKBtB+v+/GZToZDKFXCqqWcEc+1xO2gDJeYclt/TtfzIsYakADdUl+9YNrKb/yRcngRnh35A13LHJhR8rJ53L+4d+c=
Received: by 10.142.49.4 with SMTP id w4mr3571394wfw.220.1210647243015;
        Mon, 12 May 2008 19:54:03 -0700 (PDT)
Received: from ?10.0.1.4? ( [76.14.71.118])
        by mx.google.com with ESMTPS id 29sm19207678wfg.0.2008.05.12.19.54.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 May 2008 19:54:02 -0700 (PDT)
In-Reply-To: <7v7idzz7no.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81982>

On May 12, 2008, at 11:42 AM, Junio C Hamano wrote:

> Christian Couder <chriscool@tuxfamily.org> writes:
>
>> Maybe you can use a function like this not tested one:
>>
>> check_cmd() {
>> 	cmd="$1"
>>
>> 	if type "$cmd" > /dev/null 2>&1; then
>> 		if "$cmd" -v | grep Apache > /dev/null 2>&1; then
>> 			httpd=$(echo "$cmd" | sed "s/apache2/httpd/")
>> 		fi
>> 	fi
>> }
>
> One worry I have with that approach is if any and all random
> implementations of "httpd" that live somewhere in path do not do any  
> harm
> when started with "-v" option.  Namely, they should exit without  
> becoming
> a daemon and/or start the service.
>
> I am not convinced that would be the case.

I agree with that worry. Solving that in the general case is pretty  
difficult, so I think we could instead look for other clues in the  
system. Some ideas:

- Use $HTTPD as defined in apachectl. (How portable is that?)

- Inspect the text of 'man httpd' to determine if it's Apache or not.

- Only fallback on the httpd command on Mac OS X 10.5? That's pretty  
safe.
