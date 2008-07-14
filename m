From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/4] Honor core.deltaBaseCacheLimit during index-pack
Date: Mon, 14 Jul 2008 04:54:38 -0700 (PDT)
Message-ID: <m31w1wu1hc.fsf@localhost.localdomain>
References: <20080713011512.GB31050@spearce.org>
	<1216001267-33235-1-git-send-email-spearce@spearce.org>
	<alpine.LFD.1.10.0807132220570.12484@xanadu.home>
	<20080714031242.GA14542@spearce.org>
	<alpine.LSU.1.00.0807141216390.32392@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephan Hennig <mailing_list@arcor.de>,
	Andreas Ericsson <ae@op5.se>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 14 13:55:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIMeZ-0002RB-NO
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 13:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802AbYGNLym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 07:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752851AbYGNLyl
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 07:54:41 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:42880 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291AbYGNLyl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 07:54:41 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2837856fkq.5
        for <git@vger.kernel.org>; Mon, 14 Jul 2008 04:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=hE5T5pziVB5uokOzY4MLQi9nX9diAZyH4LfzFODn8cM=;
        b=INaBYvBUZKDqLTBLLDQ78Gsi0o0oWrpFH+hIe5jBo8esw7KQc1Us1ZqfDp63CPf/Wh
         gZ0gJkQLVaMuBynmH6hFrUE3mNP+vjeHJ4L78NtCtVaBGnExFcpTcR2ZxNObMbIfoIiH
         jGBn4BlywqWPdK9szSO8SdA8v8cxRSYso9S08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=dvo2/CoNxrqSMnkFtll4KGN+N7vIac1s5/2uUZMKvKeghMGfLk9xNvYAU08fwkksjI
         bQtgUSGcChmWm5UiktXRNh3jDEdWmTZobLROcc5ISFcSyonntQaW55sNdZeau2u0WKSc
         dW7kl+IizVjWqAoyfVH0i85weYRzTmL2lJx60=
Received: by 10.187.226.1 with SMTP id d1mr1626132far.97.1216036479461;
        Mon, 14 Jul 2008 04:54:39 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.211.66])
        by mx.google.com with ESMTPS id 28sm11105901fkx.1.2008.07.14.04.54.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Jul 2008 04:54:38 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6EBrKPp006959;
	Mon, 14 Jul 2008 13:53:30 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m6EBqVeF006949;
	Mon, 14 Jul 2008 13:52:31 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LSU.1.00.0807141216390.32392@wbgn129.biozentrum.uni-wuerzburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88413>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> On Mon, 14 Jul 2008, Shawn O. Pearce wrote:

> > The only other alternative I can come up with is to change pack-objects 
> > (or at least its defaults) so we don't generate these massive delta 
> > chains.  But there are already packs in the wild that use these chains, 
> > resulting in performance problems for clients.
> 
> But the long chains make the pack actually as efficient as it is...

Perhaps Shawn thought here about limiting delta chain not by its
*length*, but by its *size* (as required when unpacking last object
in a delta chanin).

What do you think about this idea?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
