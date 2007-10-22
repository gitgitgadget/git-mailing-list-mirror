From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: .gittattributes handling has deficiencies
Date: Mon, 22 Oct 2007 07:45:36 +0200
Message-ID: <565E1D52-59C4-4EB8-AA81-FF94F346FE61@zib.de>
References: <1192956535617-git-send-email-prohaska@zib.de> <Pine.LNX.4.64.0710210204580.4818@asgard> <20071022050111.GL14735@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: david@lang.hm, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 07:44:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijq5W-00082p-0l
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 07:44:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650AbXJVFoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 01:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754671AbXJVFoN
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 01:44:13 -0400
Received: from mailer.zib.de ([130.73.108.11]:42889 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751998AbXJVFoM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 01:44:12 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9M5i8aK009931;
	Mon, 22 Oct 2007 07:44:08 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db11d6f.pool.einsundeins.de [77.177.29.111])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9M5i76u027878
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 22 Oct 2007 07:44:07 +0200 (MEST)
In-Reply-To: <20071022050111.GL14735@spearce.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61948>


On Oct 22, 2007, at 7:01 AM, Shawn O. Pearce wrote:

> david@lang.hm wrote:
>> On Sun, 21 Oct 2007, Steffen Prohaska wrote:
>>> If a .gitattributes is in the work tree and we checkout a
>>> different head, the .gitattributes of the head we are switching
>>> to must have precedence.
>>>
>>> Maybe the gitattributes of a file should be part of the per-file
>>> flags in the index. Thus we could verify if the flags changed and
>>> if so, adjust the work tree accordig to the new flags.  I'm
>>> lacking a deeper insight into the git internals.  Therefore, I
>>> can't really say if the index is the right place.  But it looks
>>> to me as if changing an attribute should be treated similar to a
>>> changing sha1, as far as the work tree is concerned.
>>
>> the problem with this is that each attribute ends up needing it's own
>> flag, which severely limits extending things (see the discussions  
>> on file
>> permissions for examples). it's also much harder to manipulate  
>> them then
>> in a file.
>
> Yea, you really don't want to copy .gitattributes into the per-file
> records in the index.  That's not going to scale as more types of
> attributes are defined.
>
> Fortunately the .gitattributes file format was designed to be
> readable even when there's merge conflicts; that is it is a
> very simple line-oriented record format.  One could difference
> the old .gitattributes currently found in the index against the
> .gitattributes we are switching to (from the target tree-ish),
> scan the lines removed/added, find which files those match against
> in the target tree-ish, and just add those files to the list of
> things we need to checkout.
>
> If any of those files is dirty then we just refuse the checkout,
> just as if the file was modified and we were switching branches.
> The user then needs to decide how to continue (probably stash the
> file and then restart the checkout).

Sounds like a reasonable plan. I have no time to look into this
right away.


> Rather simple IMHO.  Of course I haven't gone into that part of
> read-tree recently, and the .gitattribute parser reads from the
> working directory, so you need to make sure you checkout the target
> .gitattributes file before anything else in the "to process list".

.gitattributes is first looked for in the working directory,
and if not there, .gitattributes is read from the index.

	Steffen
