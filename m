From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: [PATCH] avoid exponential regex match for java and objc function
 names
Date: Thu, 18 Jun 2009 08:45:37 +0200
Message-ID: <4A39E291.8030207@gmail.com>
References: <20090617102332.GA32353@coredump.intra.peff.net>	<1245248766-14867-1-git-send-email-bonzini@gnu.org> <7vab46rev0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 08:46:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHBNn-0007Gg-Ka
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 08:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960AbZFRGps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 02:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753136AbZFRGpr
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 02:45:47 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:21672 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200AbZFRGpr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 02:45:47 -0400
Received: by ey-out-2122.google.com with SMTP id d26so142066eyd.37
        for <git@vger.kernel.org>; Wed, 17 Jun 2009 23:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Bnz81vboYj/Z4uTANqa8wXIBqEAM5vIWKjtkBs7zLrU=;
        b=xElabaOkY6n6MKP6VsZVn9QSVUlYHlDbomiHM3BbQb5PLthZTHRYE7pYEUt6BkjZi7
         rrLb9K34FccMBOD14lQiMCHNGU50nmvpYWUqvGiqcmk6GPvt81pt2a0w/NT2jOqDiEXE
         w1bq5hJp7+GvrwSwOTqRVP8YuRnaHCimUkx80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=ESROd9AUudKYom7WHziJWT02IpxIwvehUhg0z1gc/0P+TPg2du4dZofxLPy/da8Nhs
         BVq4W7rchIay6VECXPCGFfZoM3zqsLKlaf+xxFDJvfx6n5/+0oW+Ha5oCkJYTtvpAJ/j
         ++oMokdAmx58ri4iR8vfKKtfFwhX+noWAyKPs=
Received: by 10.210.42.20 with SMTP id p20mr1299842ebp.92.1245307548395;
        Wed, 17 Jun 2009 23:45:48 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq.redhat.com [62.40.79.66])
        by mx.google.com with ESMTPS id 10sm590425eyz.41.2009.06.17.23.45.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Jun 2009 23:45:47 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20081009)
In-Reply-To: <7vab46rev0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121797>


> Should I remove the "/* -- */" or is it for better readability I should
> keep?

It helps detecting the separation between the function regex and the 
word regex:

>> -	 "^[ \t]*(([ \t]*[A-Za-z_][A-Za-z_0-9]*){2,}[ \t]*\\([^;]*)$",
>> +	 "^[ \t]*(([A-Za-z_][A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",
>> +	 /* -- */

I stole the idea from the Objective-C part:

>>  	 /* C functions */
>> -	 "^[ \t]*(([ \t]*[A-Za-z_][A-Za-z_0-9]*){2,}[ \t]*\\([^;]*)$\n"
>> +	 "^[ \t]*(([A-Za-z_][A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$\n"
>>  	 /* Objective-C class/protocol definitions */
>>  	 "^(@(implementation|interface|protocol)[ \t].*)$",
>>  	 /* -- */

Paolo
