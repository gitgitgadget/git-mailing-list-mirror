From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv20 00/12] Expose submodule parallelism to the user
Date: Mon, 29 Feb 2016 11:32:22 -0800
Message-ID: <20160229193222.GX28749@google.com>
References: <1456773250-5510-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, pclouds@gmail.com, git@vger.kernel.org,
	Jens.Lehmann@web.de, peff@peff.net, sunshine@sunshineco.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 20:32:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaTYU-0006wQ-DR
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 20:32:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193AbcB2Tc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 14:32:26 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33990 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142AbcB2TcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 14:32:25 -0500
Received: by mail-pa0-f52.google.com with SMTP id fy10so96863190pac.1
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 11:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1CPn3mmG5DotMeio7c2lp4EJ/KWJzFBrbCCVVck9mbg=;
        b=sgQ2pb/ErVgm7THbWaipTkeROj/SOkR6K/z1TWjAb2b1p5Zkdjl0lSE+YlJgn7bCrI
         DSwlfXfXCPhnrE6oeZJ7RCjJ59C2Ce5eWk1P2z+8mXhFIYEbeO0WuQ9dwxJ7zjnSmoMo
         2d4GcELXuGsn9sm+4ezEjbJC0b9P9yktkpplAx4RuckI6/zNSM2Dqs/Olben5qdRrmN4
         u4U/RIaD8HbeWDojGNaFYbg7ipvbIGv2L08NpS+AKNLwcnN1aFIwy7RWL2Cfk5sYM6/y
         CA1qtN1jOfxddO0LyYklROEc/JNwoas2nGD8SbtcU8ax6nGhfeKGlk6ZVOea3acoezKR
         5Bhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1CPn3mmG5DotMeio7c2lp4EJ/KWJzFBrbCCVVck9mbg=;
        b=cFt+F/FfV9zuVJqdKmHx6BM1D4MJ8/qrRpdPL7NfDYAywYa8jvFahSQ0eqQGQmNrHd
         gapj/YHEVsWpjIYN6y6AvRW+3bXuA0k9mm0Nw45QmPoUKZDDwGsP7g4Fwgc2fzvnMEW9
         pPz+nkkEnFjwVNxxr5GGHTLtt8imE8Eu+2WSZpA3weP6eyYMzQwCKtAS1w4CfaxWSAoM
         azfCZBjyPC4i1vwhRMYVvov9ociPypmmz7SEoaQcSW2cEYAbjMSnEujk3pzvt2y7o3Mi
         Vjk5gegXEF296GSD4B5FwzvUun0QHRG51WSGHo18gnC+6bk7TGFwWLlzQXORpmP3Lo2k
         F5LA==
X-Gm-Message-State: AD7BkJJ99IEOqCKmssNyrGkf0pEeVQHZ6R2J3gtnNqkrKzab8tmDx4ZNuZ9X3eDXfAkbdQ==
X-Received: by 10.67.3.67 with SMTP id bu3mr24162308pad.39.1456774345127;
        Mon, 29 Feb 2016 11:32:25 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:6025:7a8f:271c:ff15])
        by smtp.gmail.com with ESMTPSA id 27sm39910293pfh.48.2016.02.29.11.32.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 11:32:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1456773250-5510-1-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287889>

Stefan Beller wrote:

> I added your suggestions as amending and as a new patch.

I think we're at the point where patches on top would work better.  I
admit I was a little scared to see another reroll.

[...]
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -299,10 +299,10 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
>  
>  	if (ce_stage(ce)) {
>  		if (suc->recursive_prefix) {
> -			strbuf_addf(out, "Skipping unmerged submodule %s/%s\n",
> +			strbuf_addf(out,_("Skipping unmerged submodule %s/%s\n"),

Missing space after comma.

Usual practice for i18n would be something like

	struct strbuf path = STRBUF_INIT;
	if (suc->recursive_prefix)
		strbuf_addf(&path, "%s/%s", suc->recursive_prefix, ce->name);
	else
		strbuf_addstr(&path, ce->name);

	strbuf_addf(out, _("Skipping unmerged submodule %s"), path.buf);
	strbuf_addch(out, '\n');
	strbuf_release(&path);

Reasons:
 - translators shouldn't have to worry about the trailing newline
 - minimizing number of strings to translate
 - minimizing the chance that a translator typo produces an invalid path

[...]
> @@ -319,7 +319,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
>  	if (suc->update.type == SM_UPDATE_NONE
>  	    || (suc->update.type == SM_UPDATE_UNSPECIFIED
>  		&& sub->update_strategy.type == SM_UPDATE_NONE)) {
> -		strbuf_addf(out, "Skipping submodule '%s'\n",
> +		strbuf_addf(out, _("Skipping submodule '%s'\n"),
>  			    displaypath);

Same issue here with the trailing \n.

If the strbuf_addf + strbuf_addch('\n') pattern is common enough, we
could introduce a helper (e.g. strbuf_addf_nl) to save typing.

Thanks and hope that helps,
Jonathan
