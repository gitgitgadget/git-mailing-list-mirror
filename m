From: David Turner <dturner@twopensource.com>
Subject: Re: [BUG] t7063-status-untracked-cache flaky?
Date: Fri, 16 Oct 2015 16:11:38 -0400
Organization: Twitter
Message-ID: <1445026298.20887.28.camel@twopensource.com>
References: <326E1A8B-3612-4771-80B8-77346C0D762D@gmail.com>
	 <56211619.3090907@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Git List <git@vger.kernel.org>, pclouds@gmail.com
To: Torsten =?ISO-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Oct 16 22:11:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnBLt-0006L3-LA
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 22:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbbJPULl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Oct 2015 16:11:41 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35063 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106AbbJPULl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 16:11:41 -0400
Received: by qkap81 with SMTP id p81so59471131qka.2
        for <git@vger.kernel.org>; Fri, 16 Oct 2015 13:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=HcXZOXBlF/k9iRosDzeH6eNZ4ZLN62+BrdPZ7CTTfXU=;
        b=jaJHtkw6mo+xnRo6aplK6H2SHPY+0PPl1PZ3FaAnB4VhvVNX1NwTD3PjJNXdaFdIbi
         5zVkd2yWNooZ9rdUlk94okp4iYY7xsB+BAUgS7BIiRfZxAttT5hHOYZ9H9OGDVO1K1aw
         QJdvayZhpIUAfCf2SEYjKni3t9qxuPZZZ9Csrb64YmYZ/3csV9XMeLv/jIV5/CQYutGi
         E7ddk7YAJ1jPRty1wYl2n2AUxaxwTa2wE20bu5Kc+UA8npyr+gf7c66WlOjMSOgkk8z6
         LkKop5o73xJwkbWTkc+xhe0lgMya5/HTyJyIjhEL7o5HMmGmYQPDHCGdlwJFfH3xJ489
         uXag==
X-Gm-Message-State: ALoCoQkcPHPpDcvR0GBxg7ntW3Fv9XGUBKx5O2ewFJrzfuMVimgHqWOTPIaY5B9l0zgMDDPBpXtt
X-Received: by 10.55.195.198 with SMTP id r67mr21359309qkl.10.1445026300327;
        Fri, 16 Oct 2015 13:11:40 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id f189sm8435937qhe.1.2015.10.16.13.11.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Oct 2015 13:11:39 -0700 (PDT)
In-Reply-To: <56211619.3090907@web.de>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279764>

On Fri, 2015-10-16 at 17:22 +0200, Torsten B=C3=B6gershausen wrote:
> On 15.10.15 09:52, Lars Schneider wrote:
> > Hi,
> >=20
> > I noticed that "t7063-status-untracked-cache.sh" occasionally fails=
 with "not ok 24 - test sparse status with untracked cache".
>
> I can't reproduce it here.
> Do you want to give us some info about your setup ?
> OS ?
> Harddisk, SSD, Fusion ?
> Does "debug=3Dt verbose=3Dt ./t7063-status-untracked-cache.sh >xx.txt
2>&1"=20
> give any more information ?

(rearranged to bottom-post)

The problem is:

trash directory.t7063-status-untracked-cache$ diff trace trace.expect=20
3,4c3,4
< directory invalidation: 1
< opendir: 1
---
> directory invalidation: 2
> opendir: 2


I can repro on a SSD.

I had to try many times to reproduce (I think even more the second
time). I just ran the test in a while loop until it failed.

I suspect that the kernel might be a bit slow to update the mtime on th=
e
directory, but I have not yet been able to repro, and I don't understan=
d
why it only happens in this one test, since sparseness should be
completely unrelated.
