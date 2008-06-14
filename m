From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [RFC/PATCH (WIP)] gitweb: Use Test::WWW::Mechanize::CGI to test
 gitweb output
Date: Sat, 14 Jun 2008 20:31:12 +0200
Message-ID: <48540E70.4030507@gmail.com>
References: <200806141447.28052.jnareb@gmail.com> <4853D84D.5010303@gmail.com> <200806142007.35288.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 20:31:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7aXM-0003oY-RI
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 20:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753777AbYFNSar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 14:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbYFNSar
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 14:30:47 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:64551 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbYFNSaq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 14:30:46 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3013010fgg.17
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 11:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=THSDq6A440x2JJMxL0gT9C4u4SvLwWrKfNQueaWswJU=;
        b=EEXLl2N2QryOQz7A4FIk6uOD+vX5S6cDrzRFN8xpDoP7AdJeSOjSrSMXbE7uts/eGT
         BkQUdCVKfFcQ6ABY0L/jbpkgERtNpgbn3Ny7fJ935aaLuaCSHETsw5tExAzwTGqFQUn9
         LFDxgzPo/2OGbjykL0FkE0Fx30HQY5Fc5TzpI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=smzNElz6aTSNYeBi8cKhkrW3VwFZtnTvD4CAvBr0fUevNu8yxOB2bOpfFw5bqmVZ85
         65zE+r1dGzuKohj8DEHLiPR5SHiRdcHZf/Vt+6NufXejYsDnvLzpZNGcKoWK+Luk3usM
         S059Ihx9aAtYLqsKoTsBuRfRyOwHWIGt9QerA=
Received: by 10.86.71.1 with SMTP id t1mr6137701fga.36.1213468239971;
        Sat, 14 Jun 2008 11:30:39 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.200.93])
        by mx.google.com with ESMTPS id 3sm9247562fge.3.2008.06.14.11.30.38
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 14 Jun 2008 11:30:39 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <200806142007.35288.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85034>

Jakub Narebski wrote:
> Lea Wiemann wrote:
>> I think that gitweb should not be writing stuff to stderr unless an
>> internal or serious error occurs
>
> There is no option to git-rev-list to not write any output to stderr

Okay, this one will go away with the new API I'm writing, which uses 
cat-file --batch-check instead of rev-list.  In the meantime (and in 
other cases) I guess diverting stderr in the test code is fine.  (I 
wouldn't want to ignore stderr in all cases, even where you're not 
expecting any output on stderr, since that might actually indicate an 
error.)

> [snip]  It should work.  test-lib.sh sets up $PATH to have 'git' binary
> (just compiled git binary) in it...

Since you're accessing http://localhost/ URLs, the web server's PATH is 
in effect, which doesn't get overridden by the tests.  But anyways, 
using an environment variable (see my other email) will move the 
responsibility for this to the developer running the tests.

> I have changed t/t9503-gitweb-Mechanize.sh... 
> 
> -our \$GIT = "git";
> +our \$GIT = "$safe_pwd/../../git";

For t9503 this'll go away if the GITWEB_TEST_BASE_URL thing is 
implemented.  For t9500 (which contains $GIT = "git" as well), it should 
  be fine as is since test-lib.sh sets PATH and thus gitweb picks up the 
right binary.

-- Lea
