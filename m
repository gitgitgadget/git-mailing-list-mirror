From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 1/3] cache-tree: Create/update cache-tree on checkout
Date: Tue, 01 Jul 2014 15:09:47 -0700
Organization: Twitter
Message-ID: <1404252587.3109.1.camel@stross>
References: <1404173597-24713-1-git-send-email-dturner@twitter.com>
	 <53B23605.40705@web.de> <1404242126.6112.7.camel@stross>
	 <xmqq4mz0x04l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?ISO-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 00:09:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X26FP-0007Uk-RQ
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 00:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965101AbaGAWJw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jul 2014 18:09:52 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:65275 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964973AbaGAWJv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 18:09:51 -0400
Received: by mail-qa0-f53.google.com with SMTP id j15so8357882qaq.12
        for <git@vger.kernel.org>; Tue, 01 Jul 2014 15:09:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=r9P6zWsEd8FVGlfhpHS5MchYIXlfTK3h7zGu6P589TE=;
        b=dSfiDqvxL35OyvytEw5VrEUe0jbWL5K0gM58sOr/eG3A420LvP5TUKjQakzBNfZifX
         uYIAicBC4ly5zdMvEswUcahsOQj9f+TA9Ms7EMW4iTNW4hntw5M1KBgk7sXC/dQJH6fz
         y3SgE9Kki45feNv54Vg9iKMbJkzPNlpfm+zY4in2azM+4/6lpKd4mBcP2b9w6yEXzGcr
         VK4Po68xyli04CRmFdQubKyzufgTscmyxPZI9rFIHSPirsjzyO5+JYoYroPSe3m+MYel
         wyAl6jbrwmsGw61MlIKdZ+KhaHXEJitD0OkSLclrMypmhV3KZXU+RDXuoYyOLhPqjipf
         /Q4w==
X-Gm-Message-State: ALoCoQlaaqiRvBxpBsv3jzazXOf3J0MCmCYBeMql7AR3+aGt1LDQe9rnFuky1C0Z7aEaCSmqfj+K
X-Received: by 10.229.117.136 with SMTP id r8mr74475942qcq.17.1404252590581;
        Tue, 01 Jul 2014 15:09:50 -0700 (PDT)
Received: from [172.25.140.220] ([8.25.197.27])
        by mx.google.com with ESMTPSA id m1sm39417398qaz.27.2014.07.01.15.09.48
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 15:09:49 -0700 (PDT)
In-Reply-To: <xmqq4mz0x04l.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252746>

On Tue, 2014-07-01 at 14:03 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
>=20
> > On Tue, 2014-07-01 at 06:16 +0200, Torsten B=C3=B6gershausen wrote:
> >> diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
> >> index 6c33e28..7c60675 100755
> >> --- a/t/t0090-cache-tree.sh
> >> +++ b/t/t0090-cache-tree.sh
> >> @@ -85,9 +85,22 @@ test_expect_success 'reset --hard without index=
 gives cache-tree' '
> >>   	test_shallow_cache_tree
> >>   '
> >>  =20
> >> -test_expect_failure 'checkout gives cache-tree' '
> >> +test_expect_success 'checkout gives cache-tree' '
> >> +	git tag current
> >>   	git checkout HEAD^ &&
> >>   	test_shallow_cache_tree
> >>=20
> >> The && chainis broken here.
> >> Does the test now pass, because "git tag" is added ?
> >
> > The tag does not cause the cache-tree to be created, so git tag doe=
s not
> > cause the test to pass.
>=20
> That does not explain why it is a good idea to declare success of
> this test if this new "git tag current" fails here for whatever
> reason (e.g. somebody updated "git tag" for a reason that is
> completely unrelated to cache-tree and made it segfault without
> creating the "current" tag).

Indeed; that's why the latest version includes &&.
