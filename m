From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git-am: handling unborn branches
Date: Fri, 05 Jun 2015 09:33:33 -0700
Message-ID: <xmqq3826t8rm.fsf@gitster.dls.corp.google.com>
References: <CACRoPnSmF0ym7ONnLAfL=o5ouSrP2Ucxdh40k6Ps-hnTsSUx4w@mail.gmail.com>
	<xmqqpp5bv0z9.fsf@gitster.dls.corp.google.com>
	<CACRoPnS9UK0ebD2JdSfun8+F0MXj6Loza4Y07whqbO6tV4_APQ@mail.gmail.com>
	<xmqqfv66tbei.fsf@gitster.dls.corp.google.com>
	<CACRoPnTjqWrhS0UArSevjp6kUbQL8YYEvvobmykssoo05wjbow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 18:33:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0uYv-0001iq-Mx
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 18:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422741AbbFEQdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 12:33:37 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38392 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422669AbbFEQdf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 12:33:35 -0400
Received: by igblz2 with SMTP id lz2so18584001igb.1
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 09:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=aki1Yq/T7B77dIVGHK4qz9RWcdm5joys/cF0Edykxeo=;
        b=Hk8DXlEKRaqcgE1SESbyKuT3eR7EdQfyDVZvLwjHYd2nOWzO+I6UGZ0lnVta1d7No7
         lywDFjUnDsF1YbIWHcrwj4MrAuYLkOxzhXGQvZK8I07i0dzmQ+rpXlo3lXkodq36TKJu
         kRtm4/B1xKPInx42glxWvNHe3sNqUxjiPp9wvvikfrcepAiM9m2UPq7RW7jRh/5Qn/XI
         2k9HFmy5CWi1Xut7NXKCkG4Yp8sSd5JYfNpkKPpoOq+vDZ9vLsr+pYoMBhC31V36pj1Y
         DXaIe7quKVBQqANGjvEJ9nrpJNC8xhc7+KEWcnfsvqz4WqGDjBXpwSmbvbbR5og++39k
         NFpw==
X-Received: by 10.107.131.81 with SMTP id f78mr5612087iod.42.1433522014865;
        Fri, 05 Jun 2015 09:33:34 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:8c50:e66f:fc40:1825])
        by mx.google.com with ESMTPSA id rj5sm1625042igc.2.2015.06.05.09.33.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jun 2015 09:33:34 -0700 (PDT)
In-Reply-To: <CACRoPnTjqWrhS0UArSevjp6kUbQL8YYEvvobmykssoo05wjbow@mail.gmail.com>
	(Paul Tan's message of "Sat, 6 Jun 2015 00:26:43 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270851>

Paul Tan <pyokagan@gmail.com> writes:

> Hmm, thinking about it, the equivalent C code would be greatly
> affected by whatever behavior we go with, so I think we should try
> fixing the behavior first.

I am glad to see that sometimes people see the light when I say
one of the greatest strength in scripted Porcelains is that they are
far easier to modify than those writtein in C ;-)

> This was done really quickly, but I think this may fix it:
> ...
> However, it assumes that the contents of the index are from the failed
> merge. If the user modified the index before running git-am --skip,
> e.g. the user added a file, then that file would be deleted, which may
> not be desired...

I do not think that is worth worrying about; if users made changes
unrelated to what "git am" asked them to help it apply by modifying
the working tree and updating the index, don't they "lose" their
changes the same way anyway, whether it is a new file or an existing
one?
