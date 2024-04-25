Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF5E8627D
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 10:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714040481; cv=none; b=bmPwoi0TSFlLnq6A2MfSURTIS2fj/sKhN1NJYJgLeSybecYHbo/lS1h3VQNthyGjAIn0a5VU3Urh6ler+ug8Gd35NVNfbuhl7hLkobI40Tl+v7hE3r01Ai0GTbdVv1Fj5nlJs+B2e2zKMEWBwGHQtNcCFpl8mCOJlhAWZbA548k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714040481; c=relaxed/simple;
	bh=FwY2RynezYxq1+ADIgusjAYrmSDFNWuHfOpQgpg5IGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTCbKAGBWMopAOeplcryxvM7fWBwCG3J220+u3733KcyLNQtuZXqzgDqMVQliv/51Y0mnYDp5gxZtnvJLvMZB81ObPTUe2weAH+Vkp14NWf7lYl4M4WlsZambe6T/T4fwUO9ydQecP2h6Bkog0jCWa4XHGWIVTnJDyJSKU8Kuks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <rhi@pengutronix.de>)
	id 1rzwE9-0006ul-IG; Thu, 25 Apr 2024 12:21:17 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <rhi@pengutronix.de>)
	id 1rzwE8-00EFFV-LN; Thu, 25 Apr 2024 12:21:16 +0200
Received: from rhi by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <rhi@pengutronix.de>)
	id 1rzwE8-00DGOp-1r;
	Thu, 25 Apr 2024 12:21:16 +0200
Date: Thu, 25 Apr 2024 12:21:16 +0200
From: Roland Hieber <rhi@pengutronix.de>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] completion: add 'symbolic-ref'
Message-ID: <20240425102116.fgis3qqhi7y5uh3q@pengutronix.de>
References: <20240424215019.268208-1-rhi@pengutronix.de>
 <Zin1nOSfckSt-H0J@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zin1nOSfckSt-H0J@tanuki>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: rhi@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org

On Thu, Apr 25, 2024 at 08:18:04AM +0200, Patrick Steinhardt wrote:
> On Wed, Apr 24, 2024 at 11:50:17PM +0200, Roland Hieber wrote:
> > Even 'symbolic-ref' is only completed when
> > GIT_COMPLETION_SHOW_ALL_COMMANDS=1 is set, it currently defaults to
> > completing file names, which is not very helpful. Add a simple
> > completion function which completes options and refs.
> > 
> > Signed-off-by: Roland Hieber <rhi@pengutronix.de>
> > ---
> > PATCH v2:
> >  - no changes
> > 
> > PATCH v1: https://lore.kernel.org/git/20240424210549.256256-1-rhi@pengutronix.de/
> > ---
> >  contrib/completion/git-completion.bash | 11 +++++++++++
> >  t/t9902-completion.sh                  | 16 ++++++++++++++++
> >  2 files changed, 27 insertions(+)
> > 
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> > index 75193ded4bde..ffcc55484bcd 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -3581,6 +3581,17 @@ _git_svn ()
> >  	fi
> >  }
> >  
> > +_git_symbolic_ref () {
> > +	case "$cur" in
> > +	--*)
> > +		__gitcomp "--delete --quiet --short --recurse --no-recurse"
> > +		return
> > +		;;
> 
> Instead of hardcoding these we may use the `--git-completion-helper`
> option, which outputs the options for us. We have `__gitcomp_builtin ()`
> to do this.

Ahh thanks, I didn't know there was automagic for it! Fixed in v3:
<https://lore.kernel.org/git/20240425101845.708554-1-rhi@pengutronix.de/>

 - Roland

> > +	esac
> > +	
> > +	__git_complete_refs
> > +}
> > +
> >  _git_tag ()
> >  {
> >  	local i c="$__git_cmd_idx" f=0
> > diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> > index 569cf2310434..a34953da6c96 100755
> > --- a/t/t9902-completion.sh
> > +++ b/t/t9902-completion.sh
> > @@ -2518,6 +2518,22 @@ test_expect_success 'complete tree filename with metacharacters' '
> >  	EOF
> >  '
> >  
> > +test_expect_success 'symbolic-ref completes short ref names ' '
> > +	test_completion "git symbolic-ref foo m" <<-\EOF
> > +	main Z
> > +	mybranch Z
> > +	mytag Z
> > +	EOF
> > +'
> 
> Nit: let's add a newline between those two test cases.
> 
> Patrick
> 
> > +test_expect_success 'symbolic-ref completes full ref names' '
> > +	test_completion "git symbolic-ref foo refs/" <<-\EOF
> > +	refs/heads/main Z
> > +	refs/heads/mybranch Z
> > +	refs/tags/mytag Z
> > +	refs/tags/A Z
> > +	EOF
> > +'
> > +
> >  test_expect_success PERL 'send-email' '
> >  	test_completion "git send-email --cov" <<-\EOF &&
> >  	--cover-from-description=Z
> > -- 
> > 2.39.2
> > 
> > 



-- 
Roland Hieber, Pengutronix e.K.          | r.hieber@pengutronix.de     |
Steuerwalder Str. 21                     | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686         | Fax:   +49-5121-206917-5555 |
