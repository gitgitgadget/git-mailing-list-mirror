From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: Question about 'branch -d' safety
Date: Mon, 19 Jul 2010 20:45:44 +0100
Message-ID: <1279568744.3009.14.camel@dreddbeard>
References: <20091230065442.6117@nanako3.lavabit.com>
	 <201007181355.36691.jnareb@gmail.com> <1279484847.8999.22.camel@dreddbeard>
	 <201007190119.04873.jnareb@gmail.com> <1279523523.3077.8.camel@dreddbeard>
	 <4C448879.4040202@workspacewhiz.com>
Reply-To: wmpalmer@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Mon Jul 19 21:46:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OawI7-0005Na-W5
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 21:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966411Ab0GSTqB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jul 2010 15:46:01 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:33354 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966388Ab0GSTqA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 15:46:00 -0400
Received: by wwf26 with SMTP id 26so542315wwf.1
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 12:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=3nyzjUyl4aFwoxio9gO/QVc4Ma883hZCdQefP0T+OpE=;
        b=Nlvb5/AWWptKEhnjxnjXqt8WBpsU8wQmUAQd+d8IfIN06tgc/hS8744uTzRb5ag5tm
         hqm7iWfJ76Y3Q7qAfqpzDFQe3B94RRlNqiXlER2LtfucoAAxofOgTotploc+YfCqmO6x
         hRXzj/g6jexmPrcjDNaSTuJ4jwCEh6zN8ZGLk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=MgphFGhbXGEdfSTL1AP02pOFgYcB9HGuvnojRRg1HnJ0wnRHMvdiuPr/Owruf5Jf3Q
         Gj65ULahQvlgmphEJIzePDWvSuofutxBJ/b0+wt3o1GO/S2MkIa3l88G69+nT4beF/3I
         xrdvMxgjYa0Wmck+FWmwcRfw9/g/sIoY2S0VQ=
Received: by 10.216.52.197 with SMTP id e47mr4355640wec.99.1279568747852;
        Mon, 19 Jul 2010 12:45:47 -0700 (PDT)
Received: from [192.168.0.129] (5acc3a9a.bb.sky.com [90.204.58.154])
        by mx.google.com with ESMTPS id v44sm2483356weq.4.2010.07.19.12.45.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Jul 2010 12:45:46 -0700 (PDT)
In-Reply-To: <4C448879.4040202@workspacewhiz.com>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151272>

On Mon, 2010-07-19 at 11:16 -0600, Joshua Jensen wrote:
> My brain has become muddied with all the ~2 stuff.  Explain again why it 
> can't be as simple as this?
...snip...
> git checkout -b integration HEAD@{1}  (or 8000000)
> 
> -Josh

Because:
 1) The HEAD reflog is the wrong place to stick things which weren't
recently checked-out.
 and 2) the previous tip is currently the easiest-to-recover part of a
deleted branch. What's lost is all the reflog data: order of states, and
how they were reached.

However, I /do/ think it's as simple as "don't delete the reflog right
away when you delete a branch", and other edge-cases and niceties in
terms of UI (such as ref renaming, resurrection of refs for tracking
unrelated data, etc) can be taken care of later, if there's actually a
need for them.

-- 
-- Will
