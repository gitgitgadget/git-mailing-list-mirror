From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] fast-import: Allow filemodify to set the root
Date: Fri, 08 Oct 2010 09:23:18 +0200
Message-ID: <4CAEC6E6.5000305@viscovery.net>
References: <1286448906-1424-1-git-send-email-david.barr@cordelta.com> <AANLkTikjzQ09XBxYZXXQf6XCme3FiLKtusZ0MLTa--mM@mail.gmail.com> <20101007202847.GA13234@burratino> <4CAEBF2E.8020206@viscovery.net> <20101008070511.GA4671@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 08 09:23:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P47Ia-0007Eu-0r
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 09:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182Ab0JHHXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 03:23:21 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:3590 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754076Ab0JHHXU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 03:23:20 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1P47IU-0000Pg-MR; Fri, 08 Oct 2010 09:23:18 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 65BD01660F;
	Fri,  8 Oct 2010 09:23:18 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <20101008070511.GA4671@burratino>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158480>

Am 10/8/2010 9:05, schrieb Jonathan Nieder:
> Johannes Sixt wrote:
>> Am 10/7/2010 22:28, schrieb Jonathan Nieder:
> 
>>> | For a command (like filter-branch --subdirectory-filter) that wants
>>> | to commit a lot of trees that already exist in the object db, writing
>>> | undeltified objects as loose files only to repack them later can
>>> | involve a significant amount[*] of overhead.
>>
>> 1. But when an object already exists in the db, it won't be written again,
>> will it?
> 
> In David's application, the trees already exist, but the commits are new.

But then what has this to do with "allow filemodify to set the root"?

> I suppose supporting M 040000 <tree> "" and C <path> "" could still
> be a good idea in that case anyway, for the convenience of front-end
> authors.

What is the special new thing here? That "" means 'empty string' == 'tree
at the root'? If so:

1. Then this is the missing piece in the justification. Then I could buy
that the observed speed-up is due to the reuse of an existing tree object
(which avoids parsing it and re-constructing it from its pieces because
fast-imports syntax didn't allow it otherwise). But it has nothing to do
with new loose objects (the re-constructed object would be identical to an
existing one).

2. Without this patch, would this syntax create a tree object with a name
consisting of two double-quotes in the root? Or would it be a syntax
error? How would one construct such an entry with this patch?

-- Hannes
