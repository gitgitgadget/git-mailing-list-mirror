From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] remote: use remote_is_configured() for add and
 rename
Date: Wed, 17 Feb 2016 14:54:05 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602171451030.6516@virtualbox>
References: <1455558150-30267-1-git-send-email-t.gummerer@gmail.com> <1455558150-30267-5-git-send-email-t.gummerer@gmail.com> <20160215183334.GH26443@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 17 14:54:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW2Z3-0007KO-4V
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 14:54:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423184AbcBQNyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 08:54:24 -0500
Received: from mout.gmx.net ([212.227.17.22]:58555 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423127AbcBQNyW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 08:54:22 -0500
Received: from virtualbox ([37.24.143.97]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Mh5h7-1aJ1sn0IT3-00MNEc; Wed, 17 Feb 2016 14:54:08
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160215183334.GH26443@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:pCyTJXptokJfdbIBHdw2vbHm5TVVSsaQOeSjwk2uR5Sd7/5/lfT
 fYtWzFwIpdNJOg7oHxxisq8lL/DkO4cPF26UEv1JkolDiu8COHVkBY6xqbA/JkXPIpq0c82
 bySn/TU04SdyKXX0MvFCo2JDuKooAk1r5lfLCjVxNs682gGtO5HEC4G4M8LdCGnvgPaPhYB
 O7AH4zQe/NcDJVe2sNkxg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bMnmed6nnW4=:OJipo6yp6W8RCSqPFWNHXP
 8MZygdACeK37DBrbJe52BL7cW2IvHFjo8yUStj7s7ITU0BCAXGMKMCMsBLoIbdsGONafGcbHz
 WfgyQkXmobpBdzW2nfNhq1fSWbhNwozElacW180OfGafnqHrH77bvMjpdRTL9Pg2FtcuYOKIz
 rHd4IrazUlAEvCrTY830sNrzyqgdafeR+GBgyYae3FVhuvMhdraYptE/3UIy4fGfY0KHy/YvE
 /oy0Ibtb+6Qq/24c6vYIdEqVSf2w63Tvj9GcAlKolExudbq4M2/UKk0bXRDrAI4D2ftVGF++1
 FjA5FxbxjnBfEg1orae52mhwZtVLL7l2RVZBqxLXsWjm4h2o2mmut3xPDOkpxBDino5nqFw5H
 kWtGCki8IoIXK7xZvslfGUChDKdauGIrxytKSSOu7sjC1szGC17365uEZ2i5T02I3lDCdY5ZG
 tNyAzFT85h0hNVHT7MgvCnAdSa5XmKbiAKlOmvnK9FTboma79YSlE0LBTdW68iMMtnaF2SqBb
 j3wZEcZrWlXXfrE177QyovIFxw/p0ww9ic/Uc3qKzg33OMGx8QJbep5I0Ve6UoKD16vlYDBlm
 tvTbzBcBiQ+S06+N/uXuG5yu4HcOd9mbu4ORJaNQ+1348H34tVVvBgvYKKVeOb6YmJLmDcT4h
 NScqNYVJD9BnDtABqrEYpbThS9hSs2Q/mAiukcV7meuzK7rf5uL5QZgr8HoQT9fUfZ6IT8Ot2
 Vk/I8bEq4OQ3lq4yTSl0NdMuMdmLEw6hkexBU1HfutV/aeGH654wxIO6t5TkUnNOOHxrxyr9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286502>

Hi Peff & Thomas,

On Mon, 15 Feb 2016, Jeff King wrote:

> On Mon, Feb 15, 2016 at 06:42:30PM +0100, Thomas Gummerer wrote:
> 
> > Both remote add and remote rename use a slightly different hand-rolled
> > check if the remote exits.  The hand-rolled check may have some subtle
> > cases in which it might fail to detect when a remote already exists.
> > One such case was fixed in fb86e32 ("git remote: allow adding remotes
> > agreeing with url.<...>.insteadOf").  Another case is when a remote is
> > configured as follows:
> > 
> >   [remote "foo"]
> >     vcs = bar
> > 
> > If we try to run `git remote add foo bar` with the above remote
> > configuration, git segfaults.  This change fixes it.
> > 
> > In addition, git remote rename $existing foo with the configuration for
> > foo as above silently succeeds, even though foo already exists,
> > modifying its configuration.  With this patch it fails with "remote foo
> > already exists".
> 
> Checking is_configured() certainly sounds like a better test, but...
> 
> > diff --git a/builtin/remote.c b/builtin/remote.c
> > index 981c487..bd57f1b 100644
> > --- a/builtin/remote.c
> > +++ b/builtin/remote.c
> > @@ -186,10 +186,7 @@ static int add(int argc, const char **argv)
> >  	url = argv[1];
> >  
> >  	remote = remote_get(name);
> > -	if (remote && (remote->url_nr > 1 ||
> > -			(strcmp(name, remote->url[0]) &&
> > -				strcmp(url, remote->url[0])) ||
> > -			remote->fetch_refspec_nr))
> > +	if (remote_is_configured(remote))
> >  		die(_("remote %s already exists."), name);
> 
> This original is quite confusing. I thought at first that there was
> perhaps something going on with allowing repeated re-configuration of
> the same remote, as long as some parameters matched. I.e., I am
> wondering if there is a case here that does _not_ segfault, that we
> would be breaking.
> 
> But reading over fb86e32dcc, I think I have convinced myself that it was
> merely an ad-hoc check for "is_configured", and using that function is a
> better replacement.

Yes, yes, yes. Y'all are absolutely correct. I shoulda added a test case
right away, to make sure not only that what I fixed does not get broken in
the future, but also to document *what* was fixed, exactly.

So, belatedly, here goes a patch that verifies what that commit was
supposed to fix, and yes, it passes with Thomas' changes (Junio, would you
please apply this on top of tg/git-remote?):

-- snipsnap --
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Wed, 17 Feb 2016 14:45:59 +0100
Subject: [PATCH] t5505: 'remote add x y' should work when url.y.insteadOf = x

This is the test missing from fb86e32 (git remote: allow adding
remotes agreeing with url.<...>.insteadOf, 2014-12-23): we should
allow adding a remote with the URL when it agrees with the
url.<...>.insteadOf setting.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5505-remote.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 94079a0..19e8e34 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -51,6 +51,11 @@ test_expect_success setup '
 	git clone one test
 '
 
+test_expect_success 'add remote whose URL agrees with url.<...>.insteadOf' '
+	git config url.git@host.com:team/repo.git.insteadOf myremote &&
+	git remote add myremote git@host.com:team/repo.git
+'
+
 test_expect_success C_LOCALE_OUTPUT 'remote information for the origin' '
 	(
 		cd test &&
-- 
2.7.1.windows.2
