From: "Vincent Kergonna" <git@kergonna.fr>
Subject: Re: git remote rename, why dosen't it exists?
Date: Thu, 5 Jun 2008 10:55:07 +0200 (CEST)
Message-ID: <1666.78.153.224.34.1212656107.squirrel@mail.kergonna.fr>
References: <1212497390.30731.3.camel@omicron.ep.petrobras.com.br>
    <alpine.DEB.1.00.0806031449010.13507@racer.site.net>
    <1212503641.30731.11.camel@omicron.ep.petrobras.com.br>
    <alpine.DEB.1.00.0806032102350.13507@racer.site.net>
    <1212591245.30731.17.camel@omicron.ep.petrobras.com.br>
    <alpine.DEB.1.00.0806041649270.13507@racer.site.net>
    <1212634394.13109.10.camel@mithrandir.bogado.net>
    <alpine.DEB.1.00.0806050529350.21190@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Victor Bogado da Silva Lins" <victor@bogado.net>,
	git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 05 11:34:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Bro-0001fQ-MZ
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 11:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322AbYFEJdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 05:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753189AbYFEJdw
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 05:33:52 -0400
Received: from tulipe.kergonna.fr ([91.121.105.123]:57396 "EHLO
	tulipe.kergonna.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432AbYFEJdv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 05:33:51 -0400
X-Greylist: delayed 2819 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Jun 2008 05:33:51 EDT
Received: from localhost ([127.0.0.1] helo=mail.kergonna.fr)
	by tulipe.kergonna.fr with esmtp (Exim 4.63)
	(envelope-from <git@kergonna.fr>)
	id 1K4BFT-0005u8-2B; Thu, 05 Jun 2008 10:55:07 +0200
Received: from 78.153.224.34
        (SquirrelMail authenticated user git@kergonna.fr)
        by mail.kergonna.fr with HTTP;
        Thu, 5 Jun 2008 10:55:07 +0200 (CEST)
In-Reply-To: <alpine.DEB.1.00.0806050529350.21190@racer>
User-Agent: SquirrelMail/1.4.9a
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83889>

> Hi,
>
> On Wed, 4 Jun 2008, Victor Bogado da Silva Lins wrote:
>
>> On Wed, 2008-06-04 at 16:51 +0100, Johannes Schindelin wrote:
>>
>> > On Wed, 4 Jun 2008, Victor Bogado da Silva Lins wrote:
>> >
>> > > I trying to refactor [in builtin-remote.c] rm into rm_or_rename, but
>> > > I stumbled into a problem, how do I free a remote struct obtained
>> > > with "remote_get"?
>>
>> It seems that git-remote thinks that remote_get will return NULL if
>> there is no such remote, but in fact it does not do this, it always
>> alloc a new remote struct and returns that newly allocated.
>
> From remote.c, remote_get(), line 601--602 in my checkout:
>
>         if (!ret->url)
>                 return NULL;
>

In fact, I think Victor is right. If you do a simple test (assuming you
don't have a remote named foo):

vincent:git$ git remote rm foo
error: Could not remove config section 'remote.foo'

You notice that it is trying to remove the configuration section for this
remote. We have hit the line 372 of builtin-remote.c:

if (git_config_rename_section(buf.buf, NULL) < 1)
    return error("Could not remove config section '%s'", buf.buf);

instead of exiting at line 364:

if (!remote)
    die("No such remote: %s", argv[1]);


-- 
Vincent
