From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v5 25/27] refs: add LMDB refs storage backend
Date: Wed, 24 Feb 2016 15:41:50 -0500
Organization: Twitter
Message-ID: <1456346510.18017.21.camel@twopensource.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
	 <1455772670-21142-26-git-send-email-dturner@twopensource.com>
	 <20160218085023.GA30049@lanh> <1455827001.7528.87.camel@twopensource.com>
	 <CACsJy8Ci_U+=Nw+9mzebQ1w3xtvb_=TZKyKC4nkRMPjhwDQ-mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 21:42:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYgFx-0004NM-JH
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 21:41:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757030AbcBXUly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 15:41:54 -0500
Received: from mail-qg0-f52.google.com ([209.85.192.52]:33639 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbcBXUlx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 15:41:53 -0500
Received: by mail-qg0-f52.google.com with SMTP id b35so24194314qge.0
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 12:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=Q/mxwtAvAsqlW04SuFRmj3IdSdiZwkJf+vcTlMlmZ84=;
        b=VWc1VJ7JjzULX0Pi2f9moFfa0iYN/HkHnkDzCFzy4lB6opYSxdpBqpNZ+Qa7wYglIq
         5Dp2QBO4+ot0f7/fNw1gYlsFek4Hst/sLRtlIdkxUSwpI/xkpmMr9HibWYpz1dbQnOog
         HnPIixREO2rMTaTBFazJAoTEF2W2Wf0kPz3cAufcD4jCo3uewI1DiXRzjQOQTcIOcaBQ
         RE/SIDsGCJRMqrNm7UWtsMXZ/LlbQifvR6Fb2+8D/XiC2o5TCY2r5xUji59v2cwE7nV7
         4Ak6iJsQWyKXY9GmyMrjQi+PsVfT88IwahYs/f1Cyq+uYCKSVmZ1YG/cYMa9HnhgGjFg
         6SnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=Q/mxwtAvAsqlW04SuFRmj3IdSdiZwkJf+vcTlMlmZ84=;
        b=Z2NpNGscg1/Hp55zyYtXZJmAdMqjnayy7RK8DuLmBvfLtCB5vsiBC32sCN2MjlA14U
         4K9NvUaFCCVna7aLGaZkVO7lcT39aVh+HEbh4+gBTZVfWrLq5ypUc4jy4AZTSbBQ07qJ
         yKFdwn2lXUsTZjmLSz3ud3oL86PMK1tC5kvZLDFDBGibY6zR9cqdGoG5d/Ph0I79/d/J
         QxOBg8C+LlOKmDYeIWTVzzt1dZS2K1R2oPMa5+5HLHNwgzuGKy1Ny5btfXSm3EGL4oeW
         JJrWR3P70iQsOgNQbMex6nilvBOg/fGFfisAjyzdlrYb/Igw1GS/q1mwVNlMzLqEo7JG
         umhQ==
X-Gm-Message-State: AG10YOS0QwqOpM4eHU1ToZGKIPmyNj38XrFKtAd68PQshMe77915v7BPNBnPzT8Qnvr47w==
X-Received: by 10.141.3.11 with SMTP id f11mr33660299qhd.90.1456346512143;
        Wed, 24 Feb 2016 12:41:52 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id t64sm1357408qki.10.2016.02.24.12.41.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 12:41:51 -0800 (PST)
In-Reply-To: <CACsJy8Ci_U+=Nw+9mzebQ1w3xtvb_=TZKyKC4nkRMPjhwDQ-mg@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287224>

On Sat, 2016-02-20 at 20:14 +0700, Duy Nguyen wrote:
> On Fri, Feb 19, 2016 at 3:23 AM, David Turner <
> dturner@twopensource.com> wrote:
> > On Thu, 2016-02-18 at 15:50 +0700, Duy Nguyen wrote:
> > 
> > [snip]
> > 
> > Thanks; applied the above
> > 
> > > This permission makes me wonder if we need adjust_shared_perm()
> > > here
> > > and some other places.
> > 
> > So just add this after every mkdir?
> > 
> >         if (shared_repository)
> >                 adjust_shared_perm(db_path);
> > 
> 
> Another option is avoid mkdir entirely. Getting started page [1] says
> if you do mdb_open_env(.., "refs.lmdb", MDB_NOSUBDIR,..) then it will
> create two files refs.lmdb and refs.lmdb.lock. No need for the
> directory "refs.lmdb" just to contain two files.
> 
> [1] http://symas.com/mdb/doc/starting.html

Good idea.
