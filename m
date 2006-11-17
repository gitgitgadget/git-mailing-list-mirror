X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb TODO
Date: Fri, 17 Nov 2006 22:24:39 +0100
Message-ID: <200611172224.40252.jnareb@gmail.com>
References: <200611171901.40839.jnareb@gmail.com> <200611172130.11631.jnareb@gmail.com> <7vu00xixxk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 17 Nov 2006 21:23:54 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Vdliqy+uqt88Sju3eirQtUeYtWZoFUQ/Ol5zWkbPekkh3nAf+JZHfkPQo9OAfVNH3GIR/UGua+5+55LyNaSGUkPVF1OskZw9Gn8EI+TYn2ZemlbicVO1s0ZMILXQfXqQ43EJqixWOTuRUrLTD5S2/2aKDDiDkZdjeKPLoT2usjY=
User-Agent: KMail/1.9.3
In-Reply-To: <7vu00xixxk.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31732>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlBBR-0000gy-Hg for gcvg-git@gmane.org; Fri, 17 Nov
 2006 22:23:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755946AbWKQVXS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 16:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755945AbWKQVXS
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 16:23:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:43632 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1755947AbWKQVXR
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 16:23:17 -0500
Received: by ug-out-1314.google.com with SMTP id m3so818772ugc for
 <git@vger.kernel.org>; Fri, 17 Nov 2006 13:23:16 -0800 (PST)
Received: by 10.67.103.7 with SMTP id f7mr2817024ugm.1163798596256; Fri, 17
 Nov 2006 13:23:16 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id l40sm4080204ugc.2006.11.17.13.23.15; Fri, 17 Nov
 2006 13:23:15 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> What about the fact that git-diff -M is _not_ patch-compatibile;
> 
> What about it?  I've never said patch compatibility is an issue.
> We have something patch cannot represent or understand and you
> should admit it.  The point is to make it easier to massage by
> hand, when the recipient does not have git handy.
> 
> With -M, the recipient can read and understand the patch text
> better than "remove this oldfile and create this newfile that
> the diff output does not tell you is related" diff.  And we say
> "rename" in plain language so the recipient _can_ do "mv A B"
> then "patch -p1".  Similarly, with -T that changes a symlink
> into a real file, if we do not do the current "remove the old
> and then create the new" and did instead "show the textual diff
> that can be applied", a non-git tool that does not understand
> the typechange can mistakenly muck with the target of the
> symlink, which is a disaster.  "Remove the target and then
> create this" at least would have lesser damage -- the object
> left as the result is incorrect nevertheless, but reading the
> contents and creating a symlink that has that contents by hand
> is easily done in a pinch.

So we split patch for "type change" mode change for patch -p1
safety. But for gitweb more important than producing safe patch
is producing _readable_ patch[*1*]. Hence request for -T option 
(or under other, better name) to git-diff which would _not_
split patch (not create two patches for one raw difftree line).
 
[*1*] Well, as far as diff for symlink is readable anyway.

>> We should have whatchanged part corresponding to the patchset
>> part at least in "commitdiff" view, which means '-c' (and for
>> the time being perhaps mean '-c' also in patchset part). '--cc'
>> which uses '-c' for the raw part would be nice...
> 
> I am not sure what you mean by patchset part, but if you are
> talking about the multiway diff text, I think most of the time
> output from "-c -p" is much less interesting than "--cc".

Sorry, perhaps I was not clear. I'd like for git-diff-tree --cc
--raw -p to output both raw part (perhaps taken from -c) and
patch part[*2*]. Gitweb needs raw part for both whatchanged 
and also for creating hyperlinks and gitweb quoted filenames
in the patch part (although with git diff headers buffering
and git diff extended headers parsing we could get the information
needed for hyperlinks and gitweb quoting of filenames for patch
part from patch part).

[*2*] I'm wondering why we don't have --patch long version of -p
option to git-diff[-tree].

-- 
Jakub Narebski
