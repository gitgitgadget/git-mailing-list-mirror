From: Victor Bogado da Silva Lins <victor@bogado.net>
Subject: Re: git remote rename, why dosen't it exists?
Date: Wed, 04 Jun 2008 23:53:14 -0300
Message-ID: <1212634394.13109.10.camel@mithrandir.bogado.net>
References: <1212497390.30731.3.camel@omicron.ep.petrobras.com.br>
	 <alpine.DEB.1.00.0806031449010.13507@racer.site.net>
	 <1212503641.30731.11.camel@omicron.ep.petrobras.com.br>
	 <alpine.DEB.1.00.0806032102350.13507@racer.site.net>
	 <1212591245.30731.17.camel@omicron.ep.petrobras.com.br>
	 <alpine.DEB.1.00.0806041649270.13507@racer.site.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 05 04:54:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K45cD-0005Sy-4U
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 04:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329AbYFECxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 22:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753325AbYFECxU
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 22:53:20 -0400
Received: from sd-green-bigip-74.dreamhost.com ([208.97.132.74]:47645 "EHLO
	spunkymail-a19.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752788AbYFECxT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jun 2008 22:53:19 -0400
Received: from [10.0.0.2] (unknown [189.25.20.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by spunkymail-a19.g.dreamhost.com (Postfix) with ESMTP id E4D5011FFB;
	Wed,  4 Jun 2008 19:53:17 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0806041649270.13507@racer.site.net>
X-Mailer: Evolution 2.22.1 (2.22.1-2.fc9) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83846>

On Wed, 2008-06-04 at 16:51 +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 4 Jun 2008, Victor Bogado da Silva Lins wrote:
> 
> > I trying to refactor [in builtin-remote.c] rm into rm_or_rename, but I 
> > stumbled into a problem, how do I free a remote struct obtained with 
> > "remote_get"?

It seems that git-remote thinks that remote_get will return NULL if
there is no such remote, but in fact it does not do this, it always
alloc a new remote struct and returns that newly allocated. This makes
the check useless. In fact that check always succeed, and if you feed a
non-existent remote name, the remote-rm will fail later when it tries to
remove a non-existent configuration.

The problem now is, how to reliably check if a remote exists or not. The
obvious exit is checking if the git configuration has the appropriated
key, but I was not able to find out how, the internal git api have no
documentation :P. Is there a simple way to check the existence of a key
in the git configuration? 
