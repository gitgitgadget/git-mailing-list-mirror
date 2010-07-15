From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2] Add svnrdump
Date: Thu, 15 Jul 2010 14:07:32 +0200
Message-ID: <20100715120732.GF22574@debian>
References: <20100709142910.GB20383@debian>
 <20100713201105.GN13310@ted.stsp.name>
 <20100714153206.GH25630@jack.stsp.name>
 <20100714160149.GA7561@debian>
 <000101cb238a$5b2bfea0$1183fbe0$@collab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: 'Stefan Sperling' <stsp@elego.de>, dev@subversion.apache.org,
	'Daniel Shahaf' <d.s@daniel.shahaf.name>,
	'Will Palmer' <wmpalmer@gmail.com>,
	'David Michael Barr' <david.barr@cordelta.com>,
	'Jonathan Nieder' <jrnieder@gmail.com>,
	'Sverre Rabbelier' <srabbelier@gmail.com>,
	'Git Mailing List' <git@vger.kernel.org>
To: Bert Huijben <rhuijben@collab.net>
X-From: git-owner@vger.kernel.org Thu Jul 15 14:06:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZNCf-00013B-Nw
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 14:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933130Ab0GOMFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 08:05:50 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54276 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933127Ab0GOMFs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 08:05:48 -0400
Received: by eya25 with SMTP id 25so134939eya.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 05:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=32j+9GLECxvg+AxzY/iQSennJUxVAy9r7xlIQcFEVgQ=;
        b=sAxOOj0hMUAspZTfGbR+0Fx+MEgzkQokO5fn1dqcA/BYH+c+6X2SYjuJJ04rzl39Ky
         6E5PdztWM6Wpp26thulJCoRA8+0VgTXJPIwDm5tYpbUG2fdUPKPqcGUHISHH6PXhEVAG
         BPLwNd0DWGGpN0/Wmp37+bEYTtWMjNRIonWPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TbAobIL3tAxRzLUQjgxxmY/ryyOGrtvA1fqPMjmilSIYwqJPJKRYijuPcBIxej9e3E
         9mf9NEsPAJE7COK2e0VnfwijuKKU0A5TicHD5V86yJKnCaxycqXw22Thl07fnGVXa2P4
         MFXdNLMVlwOKD+k7bxUSvzOTMaLLO3mHS0CDs=
Received: by 10.213.34.140 with SMTP id l12mr4792695ebd.31.1279195546411;
        Thu, 15 Jul 2010 05:05:46 -0700 (PDT)
Received: from debian (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id a48sm7586248eei.19.2010.07.15.05.05.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 05:05:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <000101cb238a$5b2bfea0$1183fbe0$@collab.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151077>

Hi Bert,

Bert Huijben writes:
> > >  - I've seen a "Prop-delta: true" line which svnadmin dump does not
> print.
> > 
> > Correct. `svnadmin dump` has a logic for determining when the prop is
> > really a delta (as opposed to a delta against /dev/null). Since
> > there's no harm printing extra Prop-delta headers, I decided not to
> > implement this logic.
> 
> Do you know if this is this something as simple as: 'Is this a new node?' or
> if this is some advanced scheme?

The former actually; although the task looks deceptively simple, it's
a little more involved than that: I'm a little worried about messing
up the node-action-handling logic, as it might break something. Once
we have a large server constantly running validations against my
latest changes, I can change stuff more confidently.

> > gawk '$0 !~ "Prop-delta: true|Text-delta-base-|sha1|Text-copy-source-|^-
> > $" && $0 ~ "^+|^-" { print; }'
> 
> Your mail explains Prop-delta, sha1, but what about these Text-delta-base
> and Text-copy-source lines?

These headers are also not strictly necessary, and I haven't found out
where this information is hidden. I'll dig through the API and find
out where this information and print it later.

-- Ram
