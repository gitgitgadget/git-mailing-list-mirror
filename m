From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 2/2] submodule: only preserve flags across recursive
 status/update invocations
Date: Wed, 3 Nov 2010 00:38:27 -0500
Message-ID: <20101103053827.GD10631@burratino>
References: <5BE96A08-B8AB-4041-ABF2-7095EB5DD585@sb.org>
 <1288760740-10075-2-git-send-email-kevin@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Nov 03 06:38:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDW3f-0001DT-OX
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 06:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768Ab0KCFis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 01:38:48 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63424 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab0KCFiq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 01:38:46 -0400
Received: by gxk23 with SMTP id 23so217120gxk.19
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 22:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=EE107UNeb5Fj65tAD7mvTiQl4NmrLDM3wXbz8BhZWsc=;
        b=YKYR0AK29bJeKHbfsX1yUTdEwq+D/ClLA4ZLB3z+IWQ3KNCBtkJ5a4XyKE60awiKdu
         Bi5LmE7FvSVuP6yY6B85WXYwdnGBS+4W8tzMZuDzSbawaYYPyVA+rlXi/uGIsoTIJpZE
         hI1H4nNMDHn7WaEpZXXWW7tVFv/GNBgRA1/m4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nnrJbjJDrU2InNKxRyTK1qwB2bUG0oLyml2CUmbLzBhYUyADUEbjq3Y411f4zQF7EF
         yv+5dYZDXwOQmDw4lvNvLLPM3JG8W0hbXyUKkdidmyuQG9GOVhdwRhQ+ZeuoEPV8oHcx
         DXJoP4fUqnCJ0Lz6HUzhLqXMBMvanfirZ/pL4=
Received: by 10.151.112.16 with SMTP id p16mr546851ybm.199.1288762726016;
        Tue, 02 Nov 2010 22:38:46 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id q5sm270343ybe.6.2010.11.02.22.38.42
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 02 Nov 2010 22:38:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1288760740-10075-2-git-send-email-kevin@sb.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160583>

Kevin Ballard wrote:

> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -374,41 +374,35 @@ cmd_init()
[...]
>  		--reference)
>  			case "$2" in '') usage ;; esac
>  			reference="--reference=$2"
> -			shift 2
> +			orig_flags="$orig_flags $(git rev-parse --sq-quote "$1")"
> +			shift

Hmm.  Maybe a helper would make it clearer.

	save_arg () {
		orig_flags="$orig_flags $(git rev-parse --sq-quote "$1")"
	}

making this

 +			save_arg --reference
 +			shift

> --- a/t/t7407-submodule-foreach.sh
> +++ b/t/t7407-submodule-foreach.sh
> @@ -238,4 +238,23 @@ test_expect_success 'use "git clone --recursive" to checkout all submodules' '
>  	test -d clone4/nested1/nested2/nested3/submodule/.git
>  '
>  
> +test_expect_success 'use "update --recursive nested1" to checkout all submodules rooted in nested1' '

Maybe a submodule status --cached --recursive -- <files> test, too?

Sleepily,
Jonathan
