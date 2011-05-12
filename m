From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: [BUG?] read_directory(), core.ignorecase and pathspec
Date: Thu, 12 May 2011 20:24:25 +0700
Message-ID: <BANLkTimqJvLoWGxMzeSs9n7LrrLaE-azwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 12 15:25:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKVt1-0000tg-F4
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 15:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756069Ab1ELNY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 09:24:57 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40314 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192Ab1ELNY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 09:24:56 -0400
Received: by bwz15 with SMTP id 15so1286789bwz.19
        for <git@vger.kernel.org>; Thu, 12 May 2011 06:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=U50fW7gQjDTrGeuy7BMi9WqGiNQ6Xg3zudhzk5StTDs=;
        b=PZeQTlrJFXv5GE1R9BtgYeI+yySLAwm23ObUf2r+DpJP+m70pFYxiWMhsgjPE6d5tY
         iIyjLfs1xEjgHstG5FF7SR9u1ltYU/Q9/fUCTWJW5UjZXWr0/qQoSgWAWs3aBzsQxWdX
         N17wfvXAhMqW1qrWkBKFth1KYp097+paTr2dE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=fFYpdjIndEzmFJgO58dsX5THHPWMhyE9xIsUV4mEAfU2Tn+RqGczs4sxlTBVxr/Brx
         nS0fGNUPuC+c5WrQpQAwyGmUDCcf/Ufu7W7JD1vKV8hgyF6iFKpTpby7fbbncEzi6SPB
         N2z31l7C4kHwSHmR+FibojUJDmSbvUCNqH15o=
Received: by 10.204.73.157 with SMTP id q29mr201746bkj.101.1305206695108; Thu,
 12 May 2011 06:24:55 -0700 (PDT)
Received: by 10.204.53.13 with HTTP; Thu, 12 May 2011 06:24:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173468>

I was looking at how read_directory() uses pathspec, and it seems that
simplify_away(), the function that cuts out directories early if
they're definitely outside given pathspec, does exact match (ie.
memcmp) regardless core.ignorecase. This means "git add -- '*.c'" may
not work as expected when core.ignorecase is on.

I haven't tested it though. Just heads up. If you care about
core.ignorecase (I don't apparently), you can try it out.

The whole simplifying thing in read_directory() will eventually be
replaced with real pathspec matching as we put more magic in pathspec.
-- 
Duy
