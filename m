From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: Commit cce8d6fdb introduces file t/t5100/nul, git tree is now
 incompatible with Cygwin (and probably Windows)
Date: Mon, 26 May 2008 13:37:52 -0400
Message-ID: <483AF570.9000609@gmail.com>
References: <483AC2CE.7090801@gmail.com> <alpine.DEB.1.00.0805261521130.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 26 19:38:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0gen-0003PE-Tt
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 19:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863AbYEZRh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 13:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753717AbYEZRh6
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 13:37:58 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:28499 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753034AbYEZRh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 13:37:58 -0400
Received: by an-out-0708.google.com with SMTP id d40so428410and.103
        for <git@vger.kernel.org>; Mon, 26 May 2008 10:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=ozyUJsjQf6HobQr812j05G+sjyU/aG22ae0Q0U1rJg8=;
        b=flYdYvcRiF2/9qeYbFMZfR3arnOb98F5724h5OhAhTIrvLOPJxdk1dvvtrmohKm2rjFSAf1yywTsnmvMbxHu8vLpAfGt+ld0wZcEdRld7nR128OiiUJyjssweGOoBfbawlizhS6nEfHppcxMmwSHOt/IMU0fWVW9+JbzT+XQ184=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=FifpqwibY81zKcLPtMRBk8C57cxb16whpwRv8zbezQVQ3SwO4Gpk3lBw/antD5WK4SNm872tTqEoQub+FgZwdkVLCYeVtquw0FwWnJWUCC4BAHnmzWJxcAYxl8+OPvAbilGM3ASAw5oBoFbuvu6Qo0R2Zoo3HacU/Gk6cjZ8ZFQ=
Received: by 10.100.4.1 with SMTP id 1mr410305and.135.1211823476353;
        Mon, 26 May 2008 10:37:56 -0700 (PDT)
Received: from ?192.168.1.117? ( [71.126.133.203])
        by mx.google.com with ESMTPS id i18sm7450817wxd.16.2008.05.26.10.37.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 May 2008 10:37:54 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <alpine.DEB.1.00.0805261521130.30431@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82943>

Johannes Schindelin wrote:
>> As a for instance of the troubles:
>>
>> git>git checkout -f origin/master
>> Previous HEAD position was a2f5be5... Merge branch
>> 'jk/maint-send-email-compose' into maint
>> error: git-checkout-index: unable to create file t/t5100/nul (File exists)
>>
>> As this commit is part of the published master branch, I am not sure the 
>> correct resolution: leaving this commit in place means that any commit 
>> between it and a commit fixing this will always cause an error on Cygwin 
>> / Windows. Of course, it *is* on the published master branch.
>>     
>
> That's the case for all regressions: we do not rewrite history for them.
>
>   
I understand that, and the reasons: however, as this leads to a long 
sequence of commits pointing to *illegal* trees, not just trees with bad 
code, a different policy might be in order here. Or, it might not.
> As for the resolution, could you quickly try the 'my-next' branch of 
> git://repo.or.cz/git/dscho.git?
>
>   
I can check that branch out, but don't get very far in the tests:

*** t0004-unwritable.sh ***
*   ok 1: setup
* FAIL 2: write-tree should notice unwritable repository


                (
                        chmod a-w .git/objects
                        test_must_fail git write-tree
                )
                status=$?
                chmod 775 .git/objects
                (exit $status)


* FAIL 3: commit should notice unwritable repository


                (
                        chmod a-w .git/objects
                        test_must_fail git commit -m second
                )
                status=$?
                chmod 775 .git/objects
                (exit $status)


* FAIL 4: update-index should notice unwritable repository


                (
                        echo a >file &&
                        chmod a-w .git/objects
                        test_must_fail git update-index file
                )
                status=$?
                chmod 775 .git/objects
                (exit $status)


* FAIL 5: add should notice unwritable repository


                (
                        echo b >file &&
                        chmod a-w .git/objects
                        test_must_fail git add file
                )
                status=$?
                chmod 775 .git/objects
                (exit $status)


* failed 4 among 5 test(s)
make[1]: *** [t0004-unwritable.sh] Error 1
make[1]: Leaving directory `/usr/src/dscho
make: *** [test] Error 2

I don't have access to a linux box today, so I can't manipulate master 
to find if that branch with your patch would work right now.

Mark
