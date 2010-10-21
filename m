From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 0/3] Teach fetch and pull to recursively fetch
 submodules too
Date: Thu, 21 Oct 2010 13:29:16 -0500
Message-ID: <20101021182916.GB11501@burratino>
References: <4C953DE5.6020900@web.de>
 <DD3654D9-46B9-4980-9138-38FDC33A383C@sb.org>
 <4C963D00.9050207@web.de>
 <28BC3A45-D3CF-4A8C-A818-B92A9827C8FB@sb.org>
 <4CAB8DDF.8080004@web.de>
 <FB03A7DB-67D2-4EAE-A0F0-2F3E3CEA9878@sb.org>
 <20101006232243.GA30302@burratino>
 <4CB0C279.8050407@web.de>
 <20101009200232.GB19064@burratino>
 <4CB0D28A.10506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Ballard <kevin@sb.org>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Oct 21 20:33:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8zwt-00046m-5y
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 20:33:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756995Ab0JUSdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 14:33:05 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:64420 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756738Ab0JUSdE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 14:33:04 -0400
Received: by gxk3 with SMTP id 3so291469gxk.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 11:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ZMJJJ7EjvHeNE9FM8z7o4u7CP+zmkewFGOEg1BFfktk=;
        b=BgyPdhg/2e7ULN073h/HpPXRRe2/+YKr/Mguo59cT5lIulCOIhl50e5HLihiWFUu95
         2z4SVPANYuvxixWuYxqGUo/c1zrYn+YIQIMKd1Xy86O5PBc/ROxobJuMdUM7LlBbtBLt
         WJZl1AmjfANspo/Ez7dG9mvmXcypEKfiTAf6M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=urbAGGqRF8zR4sIo0trSI86+1dWH+4V/m9frKP2TxPFl7b38Urpgvk7lA+JitmW6r7
         W4iIP+mQcNQH6/iyBkSQ0O3unoFtKc39Nicpmz4CaTIeM3GYybZAtQjAr/tAiEy7fjgu
         +EYEwjroEZ1KXljoGhdhZFgbpv0/b8Vrncg+4=
Received: by 10.239.152.12 with SMTP id t12mr559136hbb.7.1287685981946;
        Thu, 21 Oct 2010 11:33:01 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id l14sm700743vcr.42.2010.10.21.11.32.59
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 11:33:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4CB0D28A.10506@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159530>

Jens Lehmann wrote:
> Am 09.10.2010 22:02, schrieb Jonathan Nieder:
>> Jens Lehmann wrote:

>>>                  And configuring that via .gitmodules has the advantage
>>> that every clone inherits that setting
>> 
>> I certainly do _not_ want that property.
[...]
> Ok, I take that as a vote to remove the parsing of .gitmodules in patch
> 2/3. But I assume you are fine with being able to configure that for
> each submodule via .git/config?

I've lost track of the thread, unfortunately.

But here are my thoughts, quickly:

The place of .gitmodules
------------------------
I think of .gitmodules as a place where upstream places information
about the submodules contained in a repository, what they are about,
and how to get them.  So ideally it would look like this:

	[submodule "gnulib"]
		path = lib/gnulib
		description = GNU Portability Library
		url = ../gnulib.git
		checkout = true

meaning the gnulib is stored at lib/gnulib, can be acquired from
that URL, and needs to be checked out in all but unusual
configurations to build this program.

Already the '[submodule "gnulib"] update' setting goes beyond this
expectation, by including information about policy that has nothing
to do with the superproject.  If we were starting over, I think
"git submodule update" might benefit from being split into two
operations:

	git checkout --recursive

for the update = checkout behavior, and

	git submodule update --pull

for the update = merge/rebase behavior.  The choice between merge and
rebase for the latter would use the usual '[branch "master"] rebase'
configuration, with defaults taken from '[branch] autosetuprebase'.
Maybe a superproject could override that choice in .git/config using
[submodule "foo"] configuration.

Well, it should be obvious by now that I think submodule.<foo>.fetch
does not belong in .gitmodules.

Automatic fetching of submodules
--------------------------------
A '[submodule "<foo>"] fetch' tweakable in .git/config like you
propose makes perfect sense.  But what should the default be?

 1. A conservative answer is "never fetch by default".

 2. A simple but less conservative answer is "fetch the modules
    with checkout = true by default".  (Of course I am not attached to
    the names; this is just a sketch.)

 3. There are other more complicated answers, but I'm a strong
    believer in "keep it simple, especially when the code doesn't
    exist yet".

Hope that helps.
