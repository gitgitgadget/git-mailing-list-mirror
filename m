From: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
Subject: Re: Repo corrupted somehow?
Date: Wed, 5 Nov 2008 13:26:59 +0100
Message-ID: <77005B51-0170-42EC-BBA7-DCF39C7CFC5E@orakel.ntnu.no>
References: <216e54900811032309s51c8cb1fr64054ff18c450b1d@mail.gmail.com>  <alpine.LNX.1.00.0811042241450.19665@iabervon.org> <216e54900811042127id69b61fqbd9d001b8bc17a6a@mail.gmail.com> <alpine.LNX.1.00.0811050043030.19665@iabervon.org>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Andrew Arnott <andrewarnott@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 05 13:54:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kxhty-00016C-UJ
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 13:54:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141AbYKEMxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 07:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753689AbYKEMxK
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 07:53:10 -0500
Received: from eyvind.bernhardsens.net ([84.49.228.97]:56190 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641AbYKEMxK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 07:53:10 -0500
X-Greylist: delayed 1566 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Nov 2008 07:53:09 EST
Received: from [192.168.2.108] (pat-gw.osl.fast.no [217.144.235.5])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id 03B571EEF8D;
	Wed,  5 Nov 2008 13:27:00 +0100 (CET)
In-Reply-To: <alpine.LNX.1.00.0811050043030.19665@iabervon.org>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100157>

On 5. nov.. 2008, at 06.56, Daniel Barkalow wrote:

> On Tue, 4 Nov 2008, Andrew Arnott wrote:
>
>> It was the CRLF conversion.  When I played around with
>> git config --global core.autocrlf true/false
>> I got the problem to eventually go away.
>>
>> Thanks for all your responses.
>
> It's still worth debugging further, because git should know that it  
> wrote
> the files differently and not see that as changes. It's not too  
> helpful to
> have autocrlf if it causes this problem.

I think I know what this is.  If a repository contains files with  
CRLFs, those files will show as modified when core.autcorlf is true  
(if you commit them, the CRLFs will be converted to CRs in the  
repository, so in a sense they _are_ modified).  Try turning autocrlf  
back on, cloning the repository, then touching all the files (to make  
git check them for changes) and see if you get the same problem.

I proposed an alternative autocrlf implementation on the list a while  
back: making it an attribute instead of a configuration setting and  
adding a configuration setting to tell git which line ending is  
preferred when the autocrlf attribute is set.

That would allow you to turn on autocrlf and let git convert all CRLFs  
to CRs in a single commit, thus converting a repository with CRLFs to  
one that can be used with autocrlf in a versioned way.  In theory that  
lets you check out new commits with EOL conversion while old commits  
will be left alone (avoiding the problem you saw), but  
since .gitattributes is read from the working directory and not the  
tree to be checked out, it doesn't work perfectly.

I implemented the easy bit (reading autocrlf from .gitattributes), but  
for various reasons the patch has just been gathering dust in my  
private git.git repo.  Maybe I should dust it off :)
-- 
Eyvind
