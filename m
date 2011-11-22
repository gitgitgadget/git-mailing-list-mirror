From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: How to deal with mixed tree?
Date: Tue, 22 Nov 2011 16:08:04 +0100
Message-ID: <4ECBBAD4.6080206@ira.uka.de>
References: <CA+9ZNic-9U0nP1NGL0shUijnxdhaoEHwyxWM8rOzR2B6Qjq6zQ@mail.gmail.com> <4ECB8917.8010305@ira.uka.de> <4ECBAFB7.9040505@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Tue Nov 22 16:07:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSrwn-0003v4-3M
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 16:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757188Ab1KVPH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Nov 2011 10:07:27 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:48531 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757209Ab1KVPHY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2011 10:07:24 -0500
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1RSrwM-0004Ru-BH; Tue, 22 Nov 2011 16:07:23 +0100
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1RSrwM-0002Dl-51; Tue, 22 Nov 2011 16:07:18 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <4ECBAFB7.9040505@obry.net>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1321974443.542766000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185795>

On 22.11.2011 15:20, Pascal Obry wrote:
>
> Holger,
>
>> Remove SD in P1, make a logical link from P2 to SD, add SD to
>> .git/info/exclude
>
> Thanks for your quick reply. That's what I have tested but...
>
>> (see "Bug report - local (and git ignored) file silently removed after
>> checkout" on the mailing list why exclude is better than .gitignore at
>> the moment)
>
> Seems like this is working only if file names are different. This is not
> my case as the replacement is very similar. With the following script
> I'm expecting empty status and no diff:
>
> <<
> #!/bin/sh
>
> # create sd (directory that will replace src2)
> mkdir sd
> echo sd1>  sd/file1
> echo sd2>  sd/file2
>
> # create Git repo
> mkdir repo
> cd repo
> git init
> mkdir src1
> mkdir src2
> echo file>  src1/file
> echo 3>  src2/file3
> git add .
> git ci -a -m "first"
>
> # let's replace src2 by sd
>
> rm -fr src2
> # ln -s ../sd src2
> cp -r ../sd src2
>
> # make sure src2 is excluded
>
> echo 'src2/*'>>  .git/info/exclude
>
> # the following output should be clean

You should also remove src2 and all files in it from the git repository. 
Something like

git rm -r src2
git ci
echo 'src2' >> .git/info/exclude

instead of

rm -fr src2
echo 'src2/*' >> .git/info/exclude
