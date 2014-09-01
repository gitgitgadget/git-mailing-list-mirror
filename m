From: David Turner <dturner@twopensource.com>
Subject: Re: git fsck exit code?
Date: Mon, 01 Sep 2014 14:17:43 -0400
Organization: Twitter
Message-ID: <1409595463.3057.3.camel@leckie>
References: <1409177412.15185.3.camel@leckie>
	 <20140829185325.GC29456@peff.net>
	 <xmqqha0v5cgn.fsf@gitster.dls.corp.google.com>
	 <1409343480.19256.2.camel@leckie>
	 <CAA787rmf7aNJ+ErXk6Lc_hLVDxMV8s2Lx_YmZud83yia4n0VKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git mailing list <git@vger.kernel.org>
To: =?ISO-8859-1?Q?=D8yvind?= "A. Holm" <sunny@sunbase.org>
X-From: git-owner@vger.kernel.org Mon Sep 01 20:17:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOWAp-0006Eh-As
	for gcvg-git-2@plane.gmane.org; Mon, 01 Sep 2014 20:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754581AbaIASRs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Sep 2014 14:17:48 -0400
Received: from mail-qa0-f50.google.com ([209.85.216.50]:38050 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754252AbaIASRq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2014 14:17:46 -0400
Received: by mail-qa0-f50.google.com with SMTP id cm18so5157845qab.23
        for <git@vger.kernel.org>; Mon, 01 Sep 2014 11:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=VuHO+yRI8IksZMHkxuaEiddXhMFjoC8ONrzO5OomRkA=;
        b=XYF2D5YS8l+RxWl8IrhMeR1ZDl3FLDFNeMLlOgvlcjY++7VyovAtqaV/Z8bAaSzSBF
         ZR8gi+xxNv8A37lZuKGmhXxAG9VDv8m3ZHQ7cjK4mrKOFIq0XHzgrdJBDTcZwE/nIJjl
         UZaTwbpLjS+GTXLnQIE+E/aR64y8nnqp7NoYt56LdXh4rFr9sdrIoC9qSSyWggeu18dd
         pwJiQyV8DsBu6Ea7ohKkALV53uY2oPbCO8PH7P2kxpJ6bL8KJH6Z+IeoCe7e5JlDiGYq
         AYLj3xhQuioRURDE/xQ76tUOYRuusgvoLEyeInXjHVE3ik7A3mQ2w9u93ziboQkoKBWE
         k++g==
X-Gm-Message-State: ALoCoQlo1n3SvTY+YmOoiE/VWJsqwlfGu/RINKYzR9h0YgKwFFeYucVEGfPlfJbahS1qZUbyYisD
X-Received: by 10.140.82.242 with SMTP id h105mr45252683qgd.98.1409595466208;
        Mon, 01 Sep 2014 11:17:46 -0700 (PDT)
Received: from [172.18.25.133] ([8.25.196.26])
        by mx.google.com with ESMTPSA id 96sm1838274qgf.20.2014.09.01.11.17.44
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Mon, 01 Sep 2014 11:17:45 -0700 (PDT)
In-Reply-To: <CAA787rmf7aNJ+ErXk6Lc_hLVDxMV8s2Lx_YmZud83yia4n0VKA@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256310>

On Sun, 2014-08-31 at 20:54 +0200, =C3=98yvind A. Holm wrote:
> On 29 August 2014 22:18, David Turner <dturner@twopensource.com> wrot=
e:
> > On Fri, 2014-08-29 at 12:21 -0700, Junio C Hamano wrote:
> > > Jeff King <peff@peff.net> writes:
> > > > On Wed, Aug 27, 2014 at 06:10:12PM -0400, David Turner wrote:
> > > > > It looks like git fsck exits with 0 status even if there are
> > > > > some errors. The only case where there's a non-zero exit code=
 is
> > > > > if verify_pack reports errors -- but not e.g. fsck_object_dir=
=2E
> > > >
> > > > It will also bail non-zero with _certain_ tree errors that caus=
e
> > > > git to die() rather than fscking more completely.
> > >
> > > Even if git does not die, whenever it says broken link, missing
> > > object, or object corrupt, we set errors_found and that variable
> > > affects the exit status of fsck.  What does "some errors" exactly
> > > mean in the original report?  Dangling objects are *not* errors a=
nd
> > > should not cause fsck to report an error with its exit status.
> >
> > error in tree 9f50addba2b4e9e928d9c6a7056bdf71b36fba90: contains
> > duplicate file entries
>=20
> I don't think git fsck should return !0 in this case. Yes, it's an
> inconsistency in the repo, but it's sometimes due to erroneous
> conversions from another SCM or some other (non-standard) implementat=
ion
> of the git client. I've seen things like this (and other inconsistenc=
ies
> in repos, like wrong date formats, non-standard Author fields, unsort=
ed
> trees, zero-padded file modes and so on), and the thing is, owners of
> public repos with these errors tend to avoid fixing it because it
> changes the commit SHAs. If git fsck starts to return !0 on these
> errors, it will always return error on that repo, which in practise
> means that the error code is rendered useless. IMHO git fsck should o=
nly
> return !0 on errors that can be fixed without changing the commit
> history, for example missing or invalid objects.

We could have one exit code for errors which can be fixed without
rewriting history, and another for errors that can't.  Or different
command-line arguments to suppress errors of this sort.

In my case, I actually could fix the issue, because it was in a
newly-created branch; I just rewrote the script that created the branch
to be a little smarter.
