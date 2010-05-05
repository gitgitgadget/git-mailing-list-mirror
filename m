From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Set GIT_PATHNAME_PREFIX with aliases.
Date: Wed, 05 May 2010 08:53:35 +0200
Message-ID: <4BE115EF.8010306@viscovery.net>
References: <1273019122.16093.6.camel@ubuntu.ubuntu-domain> <20100505005153.GC25390@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jared Hance <jaredhance@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 05 08:54:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9YUo-0002u8-Td
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 08:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754871Ab0EEGx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 02:53:56 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:40794 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996Ab0EEGxz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 02:53:55 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1O9YUQ-0007MK-QD; Wed, 05 May 2010 08:53:51 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 8851C1660F;
	Wed,  5 May 2010 08:53:50 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <20100505005153.GC25390@coredump.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146378>

Am 5/5/2010 2:51, schrieb Jeff King:
> On Tue, May 04, 2010 at 08:25:22PM -0400, Jared Hance wrote:
> 
>> The environment variable GIT_PATHNAME_PREFIX passes on the
>> current working directory (where the git command was called from)
>> to shell aliases (aliases that begin with "!"). This allows these
>> shell aliases to know the directory that the git command was called
>> from.
> 
> Seems like a reasonable goal, but...

Sorry, I disagree.

The availability of this environment variable doesn't help the alias
writer a lot:

1. The alias is still burdened with the task to check *when* to use the
variable, i.e., whether an argument passed is absolute or relative, and
apply the variable only to a relative argument.

2. When more than one pathspec is passed to the alias, it is tedious to
apply $GIT_PATHNAME_PREFIX to each of them.

The only way where this variable could be used in a useful manner is to
write the alias as

   !cd "${GIT_PATHNAME_PREFIX:-.}" && { do stuff... ; }

which is something that git should do before it invokes the alias.

-- Hannes
