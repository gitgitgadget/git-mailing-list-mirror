From: Stefan Beller <sbeller@google.com>
Subject: Re: fetching from an hg remote fails with bare git repositories
Date: Tue, 4 Aug 2015 11:56:47 -0700
Message-ID: <CAGZ79kawh0himmR+DuvcQB0O1rRVBhkg9ycCLvPdbp1m0sHKtQ@mail.gmail.com>
References: <CAKfKJYuuO+eak-L2SUVUEmoOj16bgV6LL0S=g-LzFjTxZUcRzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Taylor Braun-Jones <taylor@braun-jones.org>
X-From: git-owner@vger.kernel.org Tue Aug 04 20:57:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMhOS-0007kf-4I
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 20:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316AbbHDS4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 14:56:48 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:36788 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbbHDS4r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 14:56:47 -0400
Received: by ykeo23 with SMTP id o23so16040411yke.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 11:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=42g2zisPfeDum+0QKxZy/NFI4GJ4JEdREZU5YeU4CFw=;
        b=Dtxc5CKd3i25BSC6BsdSZWb+Gp9DGxyh09A0yM8NI3bjEDJXPRCOvZwu8bjGpkcSIr
         i3X2Ac7ucaj0ShOjHH/tC+wB0QkXgG8q0PQUDb9vbvD9YKo5EzEHZvNaP/CrUA7+BJl8
         eso8VU/GOMmsem1wI7IBFpH2pADJIFFe+wH+N91HIpnGuzwIxoijV2M+cvokU8hZK5jY
         YjYtvnLsIwosqPdDRYoF8lCUi7o9gMouK0oGfU1BEVpGiekfcseAUfsG16meUB6+yk1x
         tJyVpAgCj8VWdnGlCZf9Ewa+brUgVOQVaJyOTeF2xRJA+OrA9dtDbuiKvIAnZKjQlrCM
         7mCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=42g2zisPfeDum+0QKxZy/NFI4GJ4JEdREZU5YeU4CFw=;
        b=bI9ZvV63cXxhk+9gMt25VMEPH6RcJDiSuiF7OvUapwX3GkgkXxWXbBQMIqOxX6qMCd
         bfqu7SDpgMuyDsUSxbvyPpNv3FpBfsUK8Ldyp8ydXbjGiTafOR7kdPlBi5hHVG2p4lNa
         Y7LU68HlCFerR/YmtByToajBrXvuIvYD05Zg9ngKlGEiezS/yAxVkC7nPGn7ien//MF5
         8ukBVTzQtoZq35EazQpD8+HBP3j94yVOEb1mQk8S6iSNxXRBOx3YHrowRTgXBka2l044
         zc6IapFKFl+9bMRU94A9A3Ck5uW0I4lduoDHTIXHDgUG1wpsLNTSc2wzrHq+XxJ0tJ42
         qOPQ==
X-Gm-Message-State: ALoCoQmaC8SgY8eR59QLT5cupI5br8wiE0SVsyPivTos83d6+PE6cU3XmYs3GUTeJ8sVePdCwqL5
X-Received: by 10.170.212.65 with SMTP id d62mr5404258ykf.115.1438714607349;
 Tue, 04 Aug 2015 11:56:47 -0700 (PDT)
Received: by 10.37.21.129 with HTTP; Tue, 4 Aug 2015 11:56:47 -0700 (PDT)
In-Reply-To: <CAKfKJYuuO+eak-L2SUVUEmoOj16bgV6LL0S=g-LzFjTxZUcRzQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275333>

On Tue, Aug 4, 2015 at 10:45 AM, Taylor Braun-Jones
<taylor@braun-jones.org> wrote:
> Fetching from an hg remote fails with bare git repositories. Non-bare
> repositories work fine.
>
> Steps to reproduce:
>
> mkdir /tmp/hgrepo
> cd /tmp/hgrepo
> hg init
> echo foo > foo.txt
> hg add foo.txt
> hg commit -m "add foo.txt" foo.txt
> git clone hg::/tmp/hgrepo/ /tmp/gitrepo
> cd /tmp/gitrepo/
> git fetch # WORKS
> git clone --bare hg::/tmp/hgrepo/ /tmp/gitrepo.git
> cd /tmp/gitrepo.git/
> git fetch # FAILS
>
> The error message from the last line is:
>
> fatal: bad object 0000000000000000000000000000000000000000
> error: hg::/tmp/hgrepo/ did not send all necessary objects
>
> Taylor

Which version of git did you test this with? Does it also happen on
the latest version?

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
