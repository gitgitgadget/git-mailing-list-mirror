From: Stephen Kazakoff <sh.kazakoff@gmail.com>
Subject: http.c (curl_easy_setopt and CURLAUTH_ANY)
Date: Fri, 28 Aug 2015 16:07:36 +1000
Message-ID: <CAF0pADEsO0y_6wcx-xNwRqjauJmMcQ8mUmbUbbWCBrK2gQ1quA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 28 08:07:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVCpB-0003e8-78
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 08:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbbH1GHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 02:07:37 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:32884 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbbH1GHg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 02:07:36 -0400
Received: by padfo6 with SMTP id fo6so12765002pad.0
        for <git@vger.kernel.org>; Thu, 27 Aug 2015 23:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=mpkkaE80F3ICwk41abce4U4UFMGPJ79+mVH2fwHdatQ=;
        b=lKUjrAVXRm76+VG+20hGJLKkxxWDsN9YSCYw4IOsGJnvj7NAMFGyBA/n9kNYN7SX3F
         EYw1AMq3m+MoFEJDtlNCfuTgOG22h9fizBKCikzZWeWkaDmlKBdnyONvQ6saCm5Ah7gQ
         QMTubPT2S84q5ZuNm6JPut3s4VgYt5tdUA1/vPahkjCrWpr9kUZZ5VNpwk42MorqZ6dt
         1kv6Z+/pVNKGp3oM1KcBOqfuTJhjSpAc7GfgdTeyF410CX3FllvAdfM5W74gwX8fdqZy
         IIJAMCRRZA1BIlJrnk68Y/TUiPMlbJ2ByZJ0ujLels2X0K5igMdVFPJ1qiObHu+2K91+
         axOg==
X-Received: by 10.66.159.197 with SMTP id xe5mr13291261pab.32.1440742056141;
 Thu, 27 Aug 2015 23:07:36 -0700 (PDT)
Received: by 10.66.21.136 with HTTP; Thu, 27 Aug 2015 23:07:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276705>

Hi,

When I'm behind a proxy (with BASIC authentication), I'm unable to
perform a git clone.

I managed to fix this by editing http.c and recompiling. The change
I'd like to propose is to line 452.


From:

curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);

To:

curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_BASIC | CURLAUTH_NTLM);


I did however find the CURL documentation
(https://secure.php.net/manual/en/function.curl-setopt.php) slightly
conflicting. On one hand, "CURLAUTH_ANY" is effectively the same as
passing "CURLAUTH_BASIC | CURLAUTH_NTLM". But the documentation for
"CURLOPT_PROXYAUTH" says that only "CURLAUTH_BASIC" and
"CURLAUTH_NTLM" are currently supported. By that, I'm assuming
"CURLAUTH_ANY" is not supported.

Also, I do not have access to a NTLM proxy, so I cannot test that
behaviour. Would someone be able to confirm or deny this bug?


Kind regards,
Steve
