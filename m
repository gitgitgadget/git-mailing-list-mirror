From: Shaun Cutts <shaun@cuttshome.net>
Subject: Re: git index: how does it work?
Date: Wed, 5 Aug 2009 21:31:50 +0200
Message-ID: <C2C8DCE2-388B-49F4-A231-CD52779CDF48@cuttshome.net>
References: <loom.20090805T160528-69@post.gmane.org> <fabb9a1e0908051121m6efafc02gd468a92784a73ecd@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 21:38:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYmK0-0006NX-LP
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 21:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbZHETil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 15:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbZHETik
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 15:38:40 -0400
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:37295 "EHLO
	mail1.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbZHETik (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 15:38:40 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Aug 2009 15:38:40 EDT
Received: (qmail 7574 invoked from network); 5 Aug 2009 19:32:01 -0000
Received: from apn-95-40-13-37.dynamic.gprs.plus.pl (shaunc@[95.40.13.37])
          (envelope-sender <shaun@cuttshome.net>)
          by mail1.sea5.speakeasy.net (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 5 Aug 2009 19:31:57 -0000
In-Reply-To: <fabb9a1e0908051121m6efafc02gd468a92784a73ecd@mail.gmail.com>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124956>

I'll be happy to keep you posted....

... I'll put up a description once I get things worked out a bit more.  
It will take me a month or two, though, probably.

... but as a quickie... :)

The general idea is to use actual syntax parsing to understand what  
happens in particular files, but be able to fall back on text if  
necessary. (Maybe "smarter text" as described by Daniel would be an  
intermediate fallback step.)

No matter what the target language, files have a hierarchical  
organization (at least as far as I am going to care about :)). My idea  
is to write a "delta" in yaml with the tree-edit operations, as a  
universal representation of changes. This could be edited by the user  
if necessary -- for example: a move with edits in it might not be  
detected, but the user could explicitly replace the delete/add pair  
with the move/edit. Tools would be provided to verify that the edited  
deltas actually produce the changes stated (& update them to capture  
the next set of deltas, etc.)

Suggestions from you guys as to the best way to tie this in would be  
greatly appreciated. I think the analysis of particular file types  
should only be loosely coupled with the rest of the system, though, as  
otherwise it will create a rats' nest.

Ideally, there would be a mechanism for an outside diff tool to  
specify "these are the hunks", and to register a utility to apply  
them... the smart diff tool would use the yaml tree-operation format  
and have its own registry (or config section) for how to analyze  
particular file types.

The diff tool would also be coupled with a merge tool... in general,  
it would be nice if there were more hooks for providing specialized  
diff & merge.

-- Shaun

On Aug 5, 2009, at 8:21 PM, Sverre Rabbelier wrote:

> Heya,
>
> On Wed, Aug 5, 2009 at 09:21, Shaun Cutts<shaun@cuttshome.net> wrote:
>> PS I'm considering writing an extension to git where the "diff"  
>> understands the
>> semantics of certain types of files: hunks wouldn't just be textual  
>> blobs but
>> would try to represent a minimal change from one version to the  
>> next based on an
>> edit distance, so that, e.g. changing the location of a function  
>> would be
>> represented by a "move" edit, rather than two text changes.
>
> This sounds very similar to what Daniel was discussing in "[PATCH 2/3
> v3] Use an external program to implement fetching with curl git" [0],
> if you're truly interested in doing this, please do keep me posted
> (and I suspect Dscho might also be interested in being cc-ed) :).
>
> [0] http://thread.gmane.org/gmane.comp.version-control.git/124503
>
> -- 
> Cheers,
>
> Sverre Rabbelier
>
