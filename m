From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Intricacies of submodules
Date: Thu, 17 Apr 2008 23:00:54 +0200
Message-ID: <bd6139dc0804171400x515b3c8br3cb1501cca8a6d0a@mail.gmail.com>
References: <47F15094.5050808@et.gatech.edu> <1207970038.10408.8.camel@ginkgo>
	 <7vlk3jlkrr.fsf@gitster.siamese.dyndns.org>
	 <1208202740.25663.69.camel@work.sfbay.sun.com>
	 <7vd4or7wdt.fsf@gitster.siamese.dyndns.org>
	 <1208317795.26863.91.camel@goose.sun.com>
	 <87lk3c4ali.fsf@jeremyms.com>
	 <1208461808.26863.129.camel@goose.sun.com>
	 <46a038f90804171306t22491685p87d7445d44f00879@mail.gmail.com>
	 <7vabjsnrda.fsf@gitster.siamese.dyndns.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>,
	"Roman V. Shaposhnik" <rvs@sun.com>,
	"Jeremy Maitin-Shepard" <jbms@cmu.edu>,
	"Ping Yin" <pkufranky@gmail.com>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 23:15:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmbEk-0001Pn-6z
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 23:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546AbYDQVA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 17:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753450AbYDQVA5
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 17:00:57 -0400
Received: from el-out-1112.google.com ([209.85.162.180]:57819 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237AbYDQVA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 17:00:56 -0400
Received: by el-out-1112.google.com with SMTP id n30so181621elf.21
        for <git@vger.kernel.org>; Thu, 17 Apr 2008 14:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=XqSdg0HDnXtF6Otdn4bWU/uzjHGG/tsnS/cB81T6axQ=;
        b=p8aftOsWhV4t4Yeu5S75gqC6SSyUuWcyAUjKy/J5+/LDCidV5fxoncdIQyn/NexlS09JlRVTaXKzczhNeL+X1UYeAZufFRsfMU4+qjN0feTv1QjG71DrUfgK3AHGEMnZbr9M69InmtRwf20A5W6rEv1/4eVduSJloAo9CjH92Q0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PfSCmhGVSXO6pGwLx/3pUGq++NRb5EBSdPl/dh43dZliKYl6a/GfgqzEgI5AnbOo2yqIqpPKpHPqLe4PeaGkw1LjbZEFmNsHQqM8UtDkozDjcEavCQowYXg005DQxIgPHKVhBCtAKXiEOlsMJIKqKXLu8FKRMzZuOmk4Xr3F/mM=
Received: by 10.142.225.11 with SMTP id x11mr527885wfg.204.1208466054869;
        Thu, 17 Apr 2008 14:00:54 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Thu, 17 Apr 2008 14:00:54 -0700 (PDT)
In-Reply-To: <7vabjsnrda.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79824>

On Thu, Apr 17, 2008 at 10:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
>  Having said that, the current "clone" implementation may happen to ignore
>  in-tree anything,

<snip>

>  But I consider that is not by design, but is a limitation of the current
>  implementation that can be improved.

I think it -should- be by design that it ignores everything unless we
are certain that it is safe to do so. So as long as an in-tree doesn't
provide any hooks to execute things (which of course includes changing
the environment) it should be fine, but if it is, it should be ignored
till after clone has finished.

Because of that an in-tree '.gitconfig' would have no security risks
as long as it is not 'used' until after the clone. This would be easy
to make sure of by not syncing it with the real '.gitconfig' until
after cloning. (That is assuming there will be some sort of syncing to
the real 'gitconfig' from the in-tree '.gitconfig', if a fall-back
type of mechanism is chosen that might be more difficult)

Cheers,

Sverre Rabbelier
