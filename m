X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Sun, 3 Dec 2006 19:33:41 +0000
Message-ID: <200612031933.42968.andyparkins@gmail.com>
References: <20061130170625.GH18810@admingilde.org> <e7bda7770612021057mc9f3eb9q7fc047dd1b5c235f@mail.gmail.com> <Pine.LNX.4.64.0612021114270.3476@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 3 Dec 2006 19:36:38 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RLF1BKfhuQToRNZg6lITBnBdd75XnsLo/XgFULmLV/8UIrELs97zB1lAuJ2P60VOsms5ZUR3N0LpDmZhUrFlC933kQ/2EMzTivKek6+FpyE7nyWtJjAWbuV4kEAHYHV/IjldP9VF6TfoxGnPKsjUYEDOH9gvyWufRDE2ffxSpYg=
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0612021114270.3476@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33131>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gqx8d-0007NL-2J for gcvg-git@gmane.org; Sun, 03 Dec
 2006 20:36:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760034AbWLCTgc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 14:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760035AbWLCTgc
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 14:36:32 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:36789 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1760034AbWLCTgb
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 14:36:31 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2816137uga for
 <git@vger.kernel.org>; Sun, 03 Dec 2006 11:36:30 -0800 (PST)
Received: by 10.78.157.8 with SMTP id f8mr6937806hue.1165174589824; Sun, 03
 Dec 2006 11:36:29 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id 37sm31687439hub.2006.12.03.11.36.28; Sun, 03 Dec
 2006 11:36:29 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Saturday 2006, December 02 19:41, Linus Torvalds wrote:

> Now, I'm not exactly sure who wants to use git modules, so this is the
> time to ask: did you hate the CVS/modules file? Or was it something you
> set up once, and then basically forgot about? People clearly use the
> ability to mark certain modules as depending on each other, and aliases to
> say "if you ask for this module, you actually get a set of _these_
> modules".

Never used CVS/modules, but I used svn:externals.  I have a few projects that 
are libraries that I use in many other projects.  So, my directory tree looks 
like this:

 projects/
   libX/
   projectP/
    libX/
   projectQ/
    libX/

The nightmare I had was that I would add a feature to projectP/libX, and 
commit it.  Great.  Then later I'd do "svn update" in projectQ - HAVING MADE 
NO CHANGES TO IT - and libX would update to the latest version, which turns 
out to be incompatible with projectQ, and I can no longer even build 
projectQ.  If only libX would stay where it was put.  The worst of it is if 
you check out an older version, say "stable-release" that you tagged last 
year, the svn:external would always just check out the latest version, so 
you'd have to go back through the logs to find out what approximate submodule 
revision you should really check out, check it out and then remember not to 
do svn update, because that would just reset the external to the latest 
version.  AHHHHHHH!  Maddening to say the least.

This fits exactly with what you have described as the primary reason for 
wanting submodules.  I didn't want seamless integration, I was happy to 
change into projectP/libX to make libX commits.  All I actually wanted was 
the particular checkout of libX for a particular checkin of projectP to be 
remembered.  That's it.  Anything else is just gravy.

I'm doing exactly the same sort of thing now but with git.  git hasn't fixed 
the problem (yet) but certainly hasn't made it any worse than it was.  
svn:externals were nothing more than a way of storing a URL in the 
repository - who cares, I wish now I'd never bothered, they serve no version 
control purpose and are merely a UI convenience.




Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
