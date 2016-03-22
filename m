From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/4] Make t1300-repo-config resilient to being run via
 'sh -x'
Date: Tue, 22 Mar 2016 16:45:24 -0700
Message-ID: <20160322234524.GJ28749@google.com>
References: <cover.1458668543.git.johannes.schindelin@gmx.de>
 <b4df45088aa68d8410895f66a814dd6780e2e451.1458668543.git.johannes.schindelin@gmx.de>
 <20160322175948.GG28749@google.com>
 <xmqqfuvigsl6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 00:45:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiVzR-0001Ut-7x
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 00:45:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbcCVXp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 19:45:28 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34963 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbcCVXp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 19:45:27 -0400
Received: by mail-pf0-f196.google.com with SMTP id u190so38512471pfb.2
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 16:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZA9qILW8L2eowoJzOovvzdnwimc7EzmBy5TFvCqHBkE=;
        b=NZsS6UKst0KF03gebawbHq4kuE2W7Ip6XzJPkfLOKFCu5YvTVosCjlirLF5Uyv8dhS
         O9ZFZU9+aG9apL8N+T5MwjHrklf0dTDSlpH+rdRfmJpmmlkSeWyhKaU+SOS0NTelosfn
         aYJ+tE2m310AtEiHNiiEABI5QoWo2zvqTfrQu1RIRQ+36rivulAsuP+4xwerCIw8Ixup
         PKZBA1/I9R12e2tVXVj23yU4XP59lqmhQbNkwbYNhgPwR3cQrDFghF+gT5KGu+lQ2ISt
         taRGt+u88LMOicCrlT0v3EF6oofE65qSOsQVytkzWvw8CgBI94io/xpHuqbFxt2HP5Ud
         rc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZA9qILW8L2eowoJzOovvzdnwimc7EzmBy5TFvCqHBkE=;
        b=CalaWE8qpkKjZVcBTOTE82/yeN8W+FylVV2R0o2GRfOD0QtxvdHUsvVibUELUmYv2/
         G0uVBGNG9MVvuAzVPPhpmNZIZSOlil50K2+IaQW56feJBQpvwm3oE7uSRFKubAvrghLs
         R+wmm+idN7fCz9lO6Lm6cqKj5JywgAxqn8TyhiaAOtVbgIh/NB0jq+JUMZr5oIbts4/o
         /XDkq7UCR010UcIU/KymvrkzTX6Lp6dKVdqDC+q8eVH1KpkTgmX/Avr80BYCfYeBcNN+
         ysYdDrp2CxiEPeB/e/98bHPebIGA6UfmnfwAXQJUl4JJff5j1KaGgWG5Is/5JfpSHMG9
         RSlA==
X-Gm-Message-State: AD7BkJKXoSghD/95F1EyNGqg5ouWOzACXF1689d65OuEF2fpzeEwJvs2lBWOMlKYi1kMeg==
X-Received: by 10.66.102.37 with SMTP id fl5mr58181521pab.32.1458690327124;
        Tue, 22 Mar 2016 16:45:27 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:694a:ddce:573a:2ea8])
        by smtp.gmail.com with ESMTPSA id v9sm50820563pfi.50.2016.03.22.16.45.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Mar 2016 16:45:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqfuvigsl6.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289588>

Junio C Hamano wrote:

> Both sounds sensible.  Should we squash this in, then?
>
>  t/t1300-repo-config.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
