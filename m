From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] builtin/fetch.c: ignore merge config when not
 fetching from branch's remote
Date: Wed, 25 Aug 2010 16:16:41 -0500
Message-ID: <20100825211641.GC2319@burratino>
References: <pzml8liT3RErVlMrdxbSkHmhBs1RMvwYma9UXgvG6WY@cipher.nrlssc.navy.mil>
 <O7UxM6KEqdDAhjJAF7ODSlo_kZavb8gBCJ6laH3QPOlG9a1q29koMQOkS7wDMj0BpyrLYfAcEh4@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, galak@kernel.crashing.org,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Aug 25 23:18:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoNMx-00070D-Ci
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 23:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754384Ab0HYVSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 17:18:40 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:65304 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474Ab0HYVS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 17:18:28 -0400
Received: by vws3 with SMTP id 3so998009vws.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 14:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Shyl+KleHMFY4+6lra40RVtzxa3JnM9sH+QrnfnhYek=;
        b=mICaAm5oOC/CyKd/Ac5ZlF2v506qjsFM30r/2Q7MwrVctUYuYugPFPmiGYgVk1+b75
         3OeTLhErciHxenTZWOEpsMcNfa56Cnaq3AJg4ZVc3+DuyigjFSJni93Z99kZpSfb6uD9
         2PrW87GnXr6gcFELErjkHQAXN6RCOdgXuuAtM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=F3c9hSEK4lTYkzVnH+M/wx18N/u1W/Q2beuAoENjpWGqrtx6xOfUuLLB413vDYO6GT
         9hoMZEBSMCgBOIrI/s4TJx/X9+98MGPCpM1TxXlvbTH0rmzgZalhPjp4BoVp2ULFw71C
         fx/QgLv+j8BDapp+Z1DXkAleGPsfipKDvmoUc=
Received: by 10.220.59.202 with SMTP id m10mr5703058vch.193.1282771107619;
        Wed, 25 Aug 2010 14:18:27 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id w31sm1135619vbs.15.2010.08.25.14.18.25
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 25 Aug 2010 14:18:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <O7UxM6KEqdDAhjJAF7ODSlo_kZavb8gBCJ6laH3QPOlG9a1q29koMQOkS7wDMj0BpyrLYfAcEh4@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154476>

Brandon Casey wrote:

> If the argument to fetch does not specify a named remote, or if the name
> supplied does not match the remote configured for the current branch, then
> the current branch's merge configuration should not be considered.

Thanks for a fix.

> +++ b/builtin/fetch.c
> @@ -146,7 +146,8 @@ static struct ref *get_ref_map(struct transport *transport,
>  		struct remote *remote = transport->remote;
>  		struct branch *branch = branch_get(NULL);
>  		int has_merge = branch_has_merge_config(branch);
> -		if (remote && (remote->fetch_refspec_nr || has_merge)) {
> +		if (remote && (remote->fetch_refspec_nr || (has_merge &&
> +				!strcmp(branch->remote_name, remote->name)))) {

What will happen with this (invalid) branch?

	[branch "tmp"]
		merge = refs/heads/tmp
