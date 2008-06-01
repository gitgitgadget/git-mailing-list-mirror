From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH v2] gitweb: use Git.pm, and use its parse_rev method for
 git_get_head_hash
Date: Sun, 01 Jun 2008 17:44:49 +0200
Message-ID: <4842C3F1.5000001@gmail.com>
References: <20080531130450.GI18781@machine.or.cz> <1212243564-30109-1-git-send-email-LeWiemann@gmail.com> <7vzlq5bm32.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 17:46:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2plG-0004fP-RX
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 17:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbYFAPo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 11:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbYFAPo4
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 11:44:56 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:11490 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbYFAPo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 11:44:56 -0400
Received: by fg-out-1718.google.com with SMTP id 19so532019fgg.17
        for <git@vger.kernel.org>; Sun, 01 Jun 2008 08:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=A3g6Qc+/z3c+iZMgIJ2PIKN4oLLJsWa6dCN3jlV4NqA=;
        b=UmxTaqFtSKE2SeuUhbjxRTd4SoUNH1kpWaJA7a3VoJPECXj3pwTFdn3EnxrpvRrq2z5A2mVWLC90DTtXRXK8ToayYB1JRZPpthIkdrU9s1nx4AdFejYc3SpokAjroCJ/IaCj434sBvYAn5UBm6s//54iMuf/xZhP0c8a4d3b1/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=n5b1re6Axl/Gx2gISikXtOBF0wy3KMzFJg3APC7Ii+BvUXMo/XL5PvrDNUbYJhXp+6/hfj1M9+0yffgIqHNFbbxq1jLcTAkFxQlvj2/VOu5715cRB0XpY/nEAqI/xI+poPQPQ/0v0gryU/EdUN+wncKCnhtzzmU8AVnIV2xivkU=
Received: by 10.86.98.14 with SMTP id v14mr4126516fgb.74.1212335094484;
        Sun, 01 Jun 2008 08:44:54 -0700 (PDT)
Received: from ?192.168.23.50? ( [91.33.205.25])
        by mx.google.com with ESMTPS id d4sm2435834fga.8.2008.06.01.08.44.52
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 01 Jun 2008 08:44:53 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <7vzlq5bm32.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83452>

Junio C Hamano wrote:
> With this on top of your parse_rev patch (I used v2 but I do not think v3
> changes the situation in any way), you seem to have broken t9500.
> 
> [...] I suspect that you are not using your own Git in the build tree in
> your test, but an already installed one.

That was indeed the case, thanks for pointing it out!

However, after applying my two patches and your patch on a pristine 
current git.git clone, I still don't get an error, even though the 
Gitweb test uses the new Git.pm (which I tested it does).  Care to send 
me your error message so I can track it down, or even upload your 
complete tree somewhere?  Feel free to reply off-list or ping me on IRC.

> +++ b/t/t9500-gitweb-standalone-no-errors.sh
>  
> +	PERL5LIB=$(pwd)/../../perl/blib/lib

How about putting this into test-lib.sh?  There are more tests (like my 
new Git.pm test suite) that will need it, so setting it up in a central 
place would probably more convenient and prevent future problems of this 
sort.

If PERL5LIB already contains paths, can we just discard them, or should 
we preserve them?

Since perl/Makefile only copies Git.pm to blib/lib/Git.pm, we could also 
set the path to ../../perl, which would prevent us from accidentally 
running tests against an old version of Git.pm (because we haven't run 
cd perl; make before).  And perhaps add a comment to perl/Makefile about 
this, in case someone wants to change the build process in the future. 
Or is there some reason why this would be a bad idea?

-- Lea
