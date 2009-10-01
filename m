From: Peter <vmail@mycircuit.org>
Subject: Re: gitignore: how to exclude a directory tree from being ignored
Date: Thu, 01 Oct 2009 15:00:31 +0200
Message-ID: <4AC4A7EF.9030002@mycircuit.org>
References: <4AC48D5F.6060401@mycircuit.org> <4AC4A310.8000507@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 01 16:00:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtMD3-0002Y3-BY
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 16:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756511AbZJAOAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2009 10:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756406AbZJAOAc
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 10:00:32 -0400
Received: from mailfe15.tele2.ch ([212.247.155.200]:44511 "EHLO swip.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756320AbZJAOAb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2009 10:00:31 -0400
X-Greylist: delayed 3602 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Oct 2009 10:00:31 EDT
X-Cloudmark-Score: 0.000000 []
X-Cloudmark-Analysis: v=1.0 c=1 a=L3Mu2x56dNAA:10 a=vWKxTcPCt1ggqAQrsOHYvw==:17 a=9guTWiVscJgOhmfUHwQA:9 a=bzNHKMUAyxqyawpYIg2aW3AqlaUA:4
Received: from mail.mycircuit.org (account cxu-8g8-ypb@tele2.ch [188.155.226.135] verified)
  by mailfe15.swip.net (CommuniGate Pro SMTP 5.2.16)
  with ESMTPA id 570507902; Thu, 01 Oct 2009 15:00:32 +0200
Received-SPF: none
 receiver=mailfe15.swip.net; client-ip=188.155.226.135; envelope-from=vmail@mycircuit.org
Received: from [192.168.1.192] (unknown [192.168.1.192])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "p_email", Issuer "192.168.2.2" (verified OK))
	by mail.mycircuit.org (Postfix) with ESMTP id 2598FCFA43;
	Thu,  1 Oct 2009 15:00:32 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.22 (X11/20090605)
In-Reply-To: <4AC4A310.8000507@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129393>

Johannes Sixt wrote:
> Peter schrieb:
>   
>> Hi
>> I want to exclude binaries except in a dir tree that I do not control.
>>
>> In .gitignore  I have:
>>
>>
>> I would expect that all *.exe and *.o are ignored except those somewhere
>> in the vendor dir tree.
>> However, the *.exe and *.o in the vendor dir tree are also ignored.
>>     
>
> This works for me:
>
>  *.exe
>  *.o
>  !vendor/*.exe
>  !vendor/*.o
>
> Note that git-status does not descend into directories from which no files
> are tracked. Therefore, this will work only after you have git-added at
> least one file from vendor/.
>
> git ls-files -o --exclude-standard does descend into the directory.
>
> Furthermore, the !vendor/*.exe patterns are not recursive. Perhaps it is
> easier for you to have a separate vendor/.gitignore that has:
>
>  !*.exe
>  !*.o
>
> These _are_ recursive.
>
> -- Hannes
>   
Thanks a lot, that clarifies the problem for me. As far as I understand now:

1) I can't have just one .gitignore file in the root dir, if I want to 
_recursively_ inverse the exclude pattern for a sub dir tree.
In this case, I have to put individual .gitignore files in the sub trees 
I want to re-include.

2) In order to see what will be staged, I have to use the :
git ls-files -o --exclude-standard
instead of :
git ls-files -o -i --exclude-from=.gitignore
because the latter won't consider .gitignore patterns in subtree

Peter
