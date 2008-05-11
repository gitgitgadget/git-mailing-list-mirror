From: nathan spindel <nathans@gmail.com>
Subject: Re: [PATCH] instaweb: make it compatible with Mac OS X 10.5's apache installation.
Date: Sun, 11 May 2008 10:11:50 -0700
Message-ID: <843D3D0E-0121-42E2-B285-E1F4AB9415E4@gmail.com>
References: <1210483565-12415-1-git-send-email-nathans@gmail.com> <1210483565-12415-2-git-send-email-nathans@gmail.com> <7vhcd572e3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 11 19:12:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvF6H-0000pP-N8
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 19:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130AbYEKRLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 13:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754112AbYEKRLx
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 13:11:53 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:31035 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421AbYEKRLw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 13:11:52 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1969896wfd.4
        for <git@vger.kernel.org>; Sun, 11 May 2008 10:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        bh=w+8M0NKE5BI8ZPbJb61siT1nfC4hgMWtKWIK8ctqEY8=;
        b=qPjS2siVo4GXCE87+yerglOERn0OZkZQjUpn+Dm2mEW/k6ms9vViAcENTnPAplfAc7RPvDPBH9FwQPWJ0mClvfdMK6RLLD4q7upOySlVEksCh135HTZS9FhoPZqrXG3VvlZor4JPWZPw1+keZuy9lObZlkeZkzQFZ7lkTXysc0o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        b=H+0iIxjJznqrNZ88VfJTX+bElh+obJVj+QCbCWiidUW/4oiC9/8w7wy6j5PAwbHdYj9Yhemz7MXmGwinTbwEYHP/AjjzPi+G15buW5nnAxvi0bDCYbuuNRetFVA1K9UDPJq3cunupw6+OMc1p107VOonIIWDJnZhiG0CoUSpPkQ=
Received: by 10.142.158.3 with SMTP id g3mr102060wfe.347.1210525912224;
        Sun, 11 May 2008 10:11:52 -0700 (PDT)
Received: from ?10.0.1.4? ( [76.14.71.118])
        by mx.google.com with ESMTPS id 30sm15646160wfg.9.2008.05.11.10.11.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 May 2008 10:11:51 -0700 (PDT)
In-Reply-To: <7vhcd572e3.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81798>

On May 10, 2008, at 11:58 PM, Junio C Hamano wrote:

> nathan spindel <nathans@gmail.com> writes:
>
>> When in apache2 mode if there isn't an apache2 binary on the system  
>> but
>> there is a httpd command in /usr/sbin/ (like there is on Mac OS X)
>> use that instead.
>
> How would you ensure that httpd is actually Apache and not something  
> else?

Good point. How about running it with -v and searching for Apache in  
the first line?

>> +	httpd_only="`echo $httpd | cut -f1 -d' '`"
>> +	type $httpd_only > /dev/null 2>&1;
>> +	test $? != 0 && test -x /usr/sbin/httpd && httpd=${httpd/apache2/ 
>> httpd}
>
> I see the same "type" issue as I mentioned, but I see that we use  
> them in
> mergetool and web--browse and we haven't heard breakages so perhaps  
> this
> is portable enough ;-)

Yes, inspection of mergetool and web--browse were what led me to use  
type.  I will see if the other method you suggested can work and use  
that here if so.

> Please avoid ${parameter/pattern/string} expansion, which is not  
> even in
> POSIX.  It is bashism and unportable.

I didn't know that was just a bashism. I'll fix that usage.

>> +	if test -z "$module_path"
>> +	then
>> +		for path in /usr/lib/apache2/modules /usr/libexec/apache2; do
>
> Hmm.  If you do discovery like this, maybe you would want to do  
> discovery
> for "httpd" the same way?  After all, why look for it only in /usr/ 
> sbin?

Yes, it should look in multiple locations.
