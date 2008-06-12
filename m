From: "Eric Raible" <raible@gmail.com>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Thu, 12 Jun 2008 14:36:58 -0700
Message-ID: <279b37b20806121436w4f09c8f7n1009ef2f77b66f87@mail.gmail.com>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil>
	 <20080611213648.GA13362@glandium.org>
	 <alpine.DEB.1.00.0806112242370.1783@racer>
	 <20080611230344.GD19474@sigill.intra.peff.net>
	 <alpine.LFD.1.10.0806111918300.23110@xanadu.home>
	 <loom.20080612T042942-698@post.gmane.org>
	 <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com>
	 <7vzlpqza0t.fsf@gitster.siamese.dyndns.org>
	 <279b37b20806121335p90a6d40qb39b73f71dae990b@mail.gmail.com>
	 <7vlk1az8aa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Wincent Colaiuta" <win@wincent.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Nicolas Pitre" <nico@cam.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 23:38:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6uUp-0004cu-Hg
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 23:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756811AbYFLVhT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 17:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756756AbYFLVhS
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 17:37:18 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:62115 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756638AbYFLVhP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 17:37:15 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2340266ywe.1
        for <git@vger.kernel.org>; Thu, 12 Jun 2008 14:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=WGTlnf/iQLbi0HyGp6fvwrfSmqkOeM1lMuDBoX4xl9c=;
        b=uDAgc9lTPMSQKjlwtRA0p+7vF2bH8BTtQ+YCZonJrY4m81FEAL5J7bzdTY0SlRr6lh
         VS5LNEkCBgw5kQij9vD5zW9W3oAlgzIlE9uleRglFF+Egjm1udvFSylRUKwrOf+NDdkH
         XzgNeRKak8mB44hNd9C+iUR3p2lPbXz7YuWrk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=vIJn+bd4IOXVHvgFxBOodWbdrIexEiD7CXN2hf+lLYBXu6oaQKzVvqtk4MaK7T4wnH
         WW8LUlfBI4f7yDPO7XiNHzL5kL9ZDHmWds5z93oa/yOaFNFH+8NDbFce063hIJ734t7V
         c08NwE1cg32qe/6uODENOaT8TDozJE+UnxHSs=
Received: by 10.150.84.41 with SMTP id h41mr3039674ybb.215.1213306618953;
        Thu, 12 Jun 2008 14:36:58 -0700 (PDT)
Received: by 10.151.113.10 with HTTP; Thu, 12 Jun 2008 14:36:58 -0700 (PDT)
In-Reply-To: <7vlk1az8aa.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84801>

On Thu, Jun 12, 2008 at 1:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Perhaps
>
>  http://thread.gmane.org/gmane.comp.version-control.git/84665/focus=84670
>
> The user explicitly asks to stash it for a while, where the definition of
> the "while" comes from reflog's retention period.

But that doesn't answer the basic question as to why it's ok
to trash data that the user explicitly asked git to save?

The fact that stash is implemented in terms of reflogs seems irrelevant to me.
If stash were implemented via branches and cherry picking would it still be
natural to automatically expire them?

At the very least the man page might want to mention the temporary nature
of stashes.  Better yet when 'git stash' could print that out when creating
the stash, eh?

- Eric
