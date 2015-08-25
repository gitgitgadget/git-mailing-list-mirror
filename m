From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/3] untracked cache: fix entry invalidation
Date: Tue, 25 Aug 2015 13:12:56 -0700
Message-ID: <xmqqr3mrxh2v.fsf@gitster.dls.corp.google.com>
References: <1439702227-15453-1-git-send-email-dturner@twopensource.com>
	<1439989286-24355-1-git-send-email-pclouds@gmail.com>
	<1439989286-24355-4-git-send-email-pclouds@gmail.com>
	<1440530701.7859.3.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 22:13:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUKaf-000625-Fh
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 22:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756152AbbHYUM7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Aug 2015 16:12:59 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33053 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755761AbbHYUM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 16:12:58 -0400
Received: by pacti10 with SMTP id ti10so61371268pac.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 13:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=aHEO+vS2e2Nk09GxQcjw60FGpanKFEQMfAZ42gjvYu4=;
        b=R1l5DkS+waEbkYLyhM2F0bWUXtojqFBYjJKVEazGDiJKY6hR2FNOhbynkcLtmv1h4w
         NpEPnlJbUJXUNQAKdRJF8EVj/4gugsoxGZo4oNN6v0hbwyPf7qhm8dF3kpd2Ny6SQyLl
         zE7Svk/9MqfVWwwZUGCoBo4LevSoJVLqtppibMw23Z2ZZOpXuFaQjqb3fuOSrFBt4d1m
         RfW3hGLYNxySgAXAMH2KBgaDOUWriKGiNOAugZ2s6c1+wsCa0gV4WN+CkoYaBzxtpMY9
         VLq1Hg10WmEj8BO+B7+Y+GnHnDBvtyLZ3ZWoX203UAdAdLtI9WeGdw1xTxzf4prYGTYc
         Zw6g==
X-Received: by 10.68.168.161 with SMTP id zx1mr60770210pbb.35.1440533577523;
        Tue, 25 Aug 2015 13:12:57 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:cdc0:fd6d:4069:6223])
        by smtp.gmail.com with ESMTPSA id nv8sm20156624pdb.92.2015.08.25.13.12.56
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 25 Aug 2015 13:12:56 -0700 (PDT)
In-Reply-To: <1440530701.7859.3.camel@twopensource.com> (David Turner's
	message of "Tue, 25 Aug 2015 15:25:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276569>

David Turner <dturner@twopensource.com> writes:

> On Wed, 2015-08-19 at 20:01 +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy wrote:
>> First, the current code in untracked_cache_invalidate_path() is wron=
g
>> because it can only handle paths "a" or "a/b", not "a/b/c" because
>> lookup_untracked() only looks for entries directly under the given
>> directory. In the last case, it will look for the entry "b/c" in
>> directory "a" instead. This means if you delete or add an entry in a
>> subdirectory, untracked cache may become out of date because it does=
 not
>> invalidate properly. This is noticed by David Turner.
>>=20
>> The second problem is about invalidation inside a fully untracked/ex=
cluded
>> directory. In this case we may have to invalidate back to root. See =
the
>> comment block for detail.
>
> LGTM.

Thanks, both.  Let's move this forward.
