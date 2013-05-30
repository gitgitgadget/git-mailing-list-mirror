From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Poor performance of git describe in big repos
Date: Thu, 30 May 2013 17:03:27 +0530
Message-ID: <CALkWK0ndKMZRuWgdg6djqPUGxbDAqZPcv2q0qPrv_2b=1NEM5g@mail.gmail.com>
References: <CAJ-05NPQLVFhtb9KMLNLc5MqguBYM1=gKEVrrtT3kSMiZKma_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Thu May 30 13:34:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui17Y-0006Ls-Ac
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 13:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147Ab3E3LeM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 May 2013 07:34:12 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:63262 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab3E3LeJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 May 2013 07:34:09 -0400
Received: by mail-ie0-f170.google.com with SMTP id e14so326550iej.1
        for <git@vger.kernel.org>; Thu, 30 May 2013 04:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=3cA2w1jbUr6VkLvq9zyc2Yzql7+kg5aw0SaoOjyd2LY=;
        b=dvGXf3MjiKA/eisy7fyDgFg/v6Oj5j0S7or+swkCQDb2I3wxrI4b2vT4Uc8yAhVej1
         g6W2tou7hCOXfNOvHdPpOyxkOH4eHCneWxVUXUA3puw+gju1leRM83mDzAZ+C0ev/Wvn
         WDl3HgqnevQHeq+DqOMXN/L+U7JG/Cm0tznEhifUWUct6SJ8QnJVhHGMPRmEcIzEzVm3
         KAN9QDZpoOhhsW+WDSnUzT5aByqhTq7EL3JICFY9BwMgcBl/DXD7K2zDY6EbiFMUdd8r
         QNEMESiiH5xQ8ylvuX6AO6RWaSVA8PQWriQtV8zMIvCAi6TXti2V6mmmY353Kc47HEfE
         4Zdw==
X-Received: by 10.50.41.99 with SMTP id e3mr11468684igl.104.1369913648976;
 Thu, 30 May 2013 04:34:08 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Thu, 30 May 2013 04:33:27 -0700 (PDT)
In-Reply-To: <CAJ-05NPQLVFhtb9KMLNLc5MqguBYM1=gKEVrrtT3kSMiZKma_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225957>

Alex Benn=C3=A9e wrote:
>>time /usr/bin/git --no-pager
> traversed 223 commits
>
> real    0m4.817s
> user    0m4.320s
> sys     0m0.464s

I'm quite clueless about why it is taking this long: I think it's IO
because there's nothing to compute?  I really can't trace anything
unless you can reproduce it on a public repository.  On linux.git with
my rotating hard disk:

$ time git describe --debug --long --tags HEAD~10000
searching to describe HEAD~10000
 annotated       5445 v2.6.33
 annotated       5660 v2.6.33-rc8
 annotated       5884 v2.6.33-rc7
 annotated       6140 v2.6.33-rc6
 annotated       6467 v2.6.33-rc5
 annotated       6999 v2.6.33-rc4
 annotated       7430 v2.6.33-rc3
 annotated       7746 v2.6.33-rc2
 annotated       8212 v2.6.33-rc1
 annotated      13854 v2.6.32
traversed 18895 commits
more than 10 tags found; listed 10 most recent
gave up search at 648f4e3e50c4793d9dbf9a09afa193631f76fa26
v2.6.33-5445-ge7c84ee

real    0m0.509s
user    0m0.470s
sys     0m0.037s

18k+ commits traversed in half a second here, so I really don't know
what is going on.
