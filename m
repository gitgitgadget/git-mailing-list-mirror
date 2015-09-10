From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v17 05/14] ref-filter: introduce match_atom_name()
Date: Thu, 10 Sep 2015 10:23:41 -0700
Message-ID: <xmqqpp1q428y.fsf@gitster.mtv.corp.google.com>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
	<1441900110-4015-6-git-send-email-Karthik.188@gmail.com>
	<vpqbndap6d1.fsf@scolette.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 10 19:23:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za5Zc-0005Mu-U5
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 19:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753948AbbIJRXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 13:23:45 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33689 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753377AbbIJRXn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 13:23:43 -0400
Received: by pacex6 with SMTP id ex6so48733330pac.0
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 10:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ONY0FlNSA7d/U1EJ/8wmnHx1Imyzz90axYmSrfdShiU=;
        b=GzxcdskPksofjoOQGOJDXKjJHIt+EkgmU2GHu6+tX+zDkuwSke/YKnHRnMnSD7CHOn
         47079wj4mUv/VHDroeaS7xSB6Xifn/NBndJOt1rF8Wkao7vZvHX6txMNMh7sApdiglEC
         DqCBJ3Ql7xvpjPJ7lnNd3m25GNMUCpu3WuNdP04y5NqHunpogQWJEwcfwLYuIye3SFAO
         4r+/SFjbwayKWCzW0flC/W7V+VUNXLsLZSCozq0oT3UbXK20zRV/tHWCuzmFWB18DSLA
         pakrYjEDL2Nu0bcmzDedTuvfNFuU1juAVo7k2gVAIeJcAzcHKzJ4Rl/hUOyf/eWIZMYU
         jFQQ==
X-Received: by 10.68.250.5 with SMTP id yy5mr85228960pbc.34.1441905823233;
        Thu, 10 Sep 2015 10:23:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:8419:5a5:3940:dfa0])
        by smtp.gmail.com with ESMTPSA id fk8sm13152222pab.33.2015.09.10.10.23.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 10 Sep 2015 10:23:42 -0700 (PDT)
In-Reply-To: <vpqbndap6d1.fsf@scolette.imag.fr> (Matthieu Moy's message of
	"Thu, 10 Sep 2015 18:49:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277609>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> OTOH, you are now accepting %(atom:) as a synonym to %(atom), and it's
> not clear whether this is a deliberate decition.

I would say so.  When the caller wants to reject %(atom:), the
caller can tell it by checking val[0] == '\0' and reject that.

So it is better if you did not do this:

> 	if (!body[1]) {
> 		/* "atom_name:" */
> 		*val = NULL;
> 		return 1;
> 	}

which robs that information from the caller.  It should be
sufficient to just drop the check that allows "colorx" when
expecting "color" without making any other change, I would think.
