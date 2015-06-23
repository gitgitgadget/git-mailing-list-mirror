From: David Turner <dturner@twopensource.com>
Subject: Re: RFC/Pull Request: Refs db backend
Date: Tue, 23 Jun 2015 16:04:55 -0400
Organization: Twitter
Message-ID: <1435089895.28466.65.camel@twopensource.com>
References: <1435020656.28466.8.camel@twopensource.com>
	 <CAGZ79kap++fZx3X0D95d35XioRURU468xATDZpWHDOAPapAh+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>,
	ronnie sahlberg <ronniesahlberg@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 22:05:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7URM-0002Gg-7Y
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 22:05:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932986AbbFWUE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 16:04:58 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33725 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932187AbbFWUE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 16:04:58 -0400
Received: by qkhu186 with SMTP id u186so10931473qkh.0
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 13:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=bsvabk4+hGqJBTxruW1OI6RuzINANE1r1nm/36EXSjI=;
        b=WKWOwA1jQrqgYfVStDNa02y8kfM9wz/eGe3FW3/7aCWm2itxUM4wZq+SDMyAI7rAB+
         6FDCk4CKr6FMCpQiCdz8oKd2Sbyb4r4JYNPsb0r2Re4AZFkRZkEL5N+HKjPy3UNyctpU
         dVY6NgvoaCjBRyfLASrAJhW4M4/GfZ9ZJNOkYv5AoF158z2b3Iqz5sbzVlo2mzPT+e5d
         Zes0xxaP5bjYxsiH6N6ZfseCUTjKFqAetydNSIA9HcS0GXB9S7eePtbySAaa+mwcwFAk
         KwufOHkGi4D7ELy4vE6TSsFVTV6q0ucoL9zekkn+HFKz2isEIBbXa2NKxT/QKTsOToTt
         68qA==
X-Gm-Message-State: ALoCoQly1yTy5OCjC7r1zlJO4s5/zc2CNFijEW5A/knW8dMlWtHheABrGYNRqu7SUwC3+/Hew33q
X-Received: by 10.55.17.26 with SMTP id b26mr70865150qkh.93.1435089897396;
        Tue, 23 Jun 2015 13:04:57 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by mx.google.com with ESMTPSA id 35sm2000967qkq.41.2015.06.23.13.04.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2015 13:04:56 -0700 (PDT)
In-Reply-To: <CAGZ79kap++fZx3X0D95d35XioRURU468xATDZpWHDOAPapAh+Q@mail.gmail.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272490>

On Tue, 2015-06-23 at 10:16 -0700, Stefan Beller wrote:
> > The db backend code was added in the penultimate commit; the rest is
> > just code rearrangement and minor changes to make alternate backends
> > possible.  There ended up being a fair amount of this 
> > rearrangement,  but the end result is that almost the entire git 
> > test suite runs under the db backend without error (see below for 
> details).
> 
> Looking at the end result in refs-be-db.c it feels like there are more
> functions in the refs_be_db struct, did this originate from other 
> design choices? IIRC Ronnie wanted to have as least functions in 
> there as possible, and share as much of the code between the 
> databases, such that the glue between the db and the refs code is 
> minimal.

I didn't actually spend that much time reading Ronnie's backend code.
My code aims to be extremely thoroughly compatible.  I spent a ton of
time making sure that the git test suite passed.  I don't know if an
alternate approach would have been as compatible.

The requirement for reflog storage did complicate things a bit.

I also didn't see a strong need to abstract the database, since LMDB is
common, widely compatible, and tiny.  

> Some random comments from looking over the branch briefly:
> 
> In the latest commit, (refs: tests for db backend), I am unsure about 
> the copyright annotations. At least a sole "Copyright (c) 2007 Junio C
> Hamano" doesn't make sense to me. ;)

Will fix, thanks.

> Typo in commit message "bisect: use refs insfrastructure for 
> BISECT_START"

Will fix, thanks.

> Some commits contain a ChangeId, which is a Gerrit leftover. :(

Those were leftover from Ronnie's patches; since you are a Googler and
you think we don't need them, I'll remove them. 
