From: Sam Vilain <sam@vilain.net>
Subject: Re: Tracking and committing back to Subversion?
Date: Tue, 07 Feb 2006 12:12:25 +1300
Message-ID: <43E7D7D9.1000507@vilain.net>
References: <1138834301.21899.40.camel@wilber.wgtn.cat-it.co.nz> <20060204054056.GB24314@Muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 07 00:13:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6FXg-0002Gx-CL
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 00:13:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWBFXNE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Feb 2006 18:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbWBFXNE
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Feb 2006 18:13:04 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:37533 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S964861AbWBFXNA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2006 18:13:00 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id C00BE2AF8; Tue,  7 Feb 2006 12:12:48 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 0406A1AFB;
	Tue,  7 Feb 2006 12:12:36 +1300 (NZDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20060204054056.GB24314@Muzzle>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15669>

Eric Wong wrote:
>>  1. file properties - such as mime type, ignores and custom properties.
>>     Linus, when I asked you about this in Dunedin, you mentioned that
>>     there is a place at the end of the directory entry where this could
>>     fit without breaking backwards compatibility.  Perhaps this could
>>     be an optional pointer to another directory node;
> Mostly ignore-able, imho.  svn:executable is the one that makes the most
> sense (and is easiest) to support.
  [...]
> svn:keywords: I don't think there's a way to disable this like there
> is with CVS, is there?  keywords are evil imho.
> I don't use or know much about the other properties...

Right, but it is also possible to hang directory or file properties,
with any name, off any file or directory.  It is often important to
at least preserve or be able to update these when dealing with some SVN
repositories, where people are using them for their own purpose.

Perhaps a "standard" mapping to dotfiles would be the best solution
then.  A .svnprops file or something like that.

>>  2. "forensic" file movement history - as opposed to the uncached,
>>     (and unversioned), automatic "analytical" file movement history.
>>
>>     It would be easy for a tool to provide 100% interface compatibility
>>     with SVN client/SVK using properties, but properties that hang off
>>     the head rather than the file itself (so that they don't stuff up
>>     the ability to merge identical trees reached via independent
>>     paths).  SVN calls these "revision properties".  If a good
>>     convention is adopted for this, it could be used as a nice way to
>>     supplement git's automatic analysis of the revision history.

> Just parsing the output of diff-tree -C and marking them in SVN as
> copies/renames should be sufficient for letting SVN do its thing.
> 
> Doing this kind of file movement history on the git side sounds like
> overkill to me.  I was a _huge_ fan of logical file-identities in GNU
> Arch in the past, but the complexity destroyed it from both a UI and
> performance perspective.

Right now, tagging gets an exemption from this requirement, as does the
extra state required by tools like StGIT.  I think this could be
generalised to support this kind of application; however we will see
whether this has any real effect or just operational side effect (eg, to
make sure renames are tracked correctly then commit before changing the
copied version, etc).

Sam.
