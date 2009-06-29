From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: [PATCH] git mailinfo strips important context from patch subjects
Date: Mon, 29 Jun 2009 12:21:14 +0200
Message-ID: <4A48959A.3060404@gmail.com>
References: <20090628193858.GA29467@codelibre.net> <1246219664-11000-1-git-send-email-bonzini@gnu.org> <4A48870B.5050802@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org,
	Roger Leigh <rleigh@codelibre.net>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Jun 29 12:21:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLDzM-0004ZP-Ps
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 12:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581AbZF2KVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 06:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752604AbZF2KVS
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 06:21:18 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:55507 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016AbZF2KVR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 06:21:17 -0400
Received: by ewy6 with SMTP id 6so5471420ewy.37
        for <git@vger.kernel.org>; Mon, 29 Jun 2009 03:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=90EWqoY4ZXm/7b8irRjnT+Cud+Tl/oDztaHi+tauxOI=;
        b=VK23TRDGHOMQPGJBaxuFY1TNQDJlweaefAhEB4W4kKWCFL65WyYLTRTHZNMBMEtEWO
         kbz7j0W4PCS00OyI3ydtH5j46oBm2eDpqTDChYb0MAJ7J7q1Mp1ZPy7kpvA1NZUp56zf
         wEKwjoC0a877+PB1krp8pVky3lD7EFb34zbaU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=uVREvrbcUTy2kADHtHSB7XlGfekouitnhMI5RVH3PRBXK0CeuCsbvEtam16E6PdfJl
         TBsC1cQYMg262EnGMXB/Xj4fSeSYcp2PQdCzfpVHqT0HYbBrpCJd+mZrI8CGntkBUe/a
         podR7flV5wcsECVG+/JN12m5wuxCd5HXdJWKw=
Received: by 10.211.179.6 with SMTP id g6mr2965460ebp.65.1246270879172;
        Mon, 29 Jun 2009 03:21:19 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq.redhat.com [62.40.79.66])
        by mx.google.com with ESMTPS id 10sm7941288eyz.11.2009.06.29.03.21.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Jun 2009 03:21:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090513 Fedora/3.0-2.3.beta2.fc11 Thunderbird/3.0b2
In-Reply-To: <4A48870B.5050802@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122435>


>> case '[':
>> if ((pos = strchr(subject->buf, ']'))) {
>> remove = pos - subject->buf;
>> - if (remove <= (subject->len - remove) * 2) {
>> + if (remove <= subject->len * 2 / 3
>> + && memmem(subject->buf, remove, 'PATCH', 5)) {
>> strbuf_remove(subject, 0, remove + 1);
>> continue;
>> }
>
>
> Pardon my ignorance, but wouldn't this still remove not only
> "[PATCH 4/5]", but all of [PATCH 4/5] [sbuild]" anyway? The
> parameters to strbuf_remove() seem unchanged.

I don't exclude I've screwed up, but note that pos is computed with 
strchr, not strrchr.  Since the second memmem does not find [PATCH], it 
does not remove anything.

(BTW, cairo uses the [...] convention).

Paolo
