X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb TODO
Date: Fri, 17 Nov 2006 21:30:11 +0100
Message-ID: <200611172130.11631.jnareb@gmail.com>
References: <200611171901.40839.jnareb@gmail.com> <7vwt5tlvy5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 17 Nov 2006 20:33:26 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NokD7LGMFpSJyBVn6DCBIfgn0uikTpw3A1PsIV/xIOkuIaE8cFd5eS4zYGeRC/9hX8jZqUveSirb5P52mlhLIM9cRIokXjwmpQuVRFz1uxk0AGyaKY9OGvHl29FbvnmQV5N06rPU9x35ayrkpsorU+JxMoUlRjQSP5cupz4ag0s=
User-Agent: KMail/1.9.3
In-Reply-To: <7vwt5tlvy5.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31729>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlAO8-0007J6-LI for gcvg-git@gmane.org; Fri, 17 Nov
 2006 21:32:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932487AbWKQU2x (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 15:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755879AbWKQU2w
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 15:28:52 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:20333 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1755873AbWKQU2u
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 15:28:50 -0500
Received: by ug-out-1314.google.com with SMTP id m3so806739ugc for
 <git@vger.kernel.org>; Fri, 17 Nov 2006 12:28:48 -0800 (PST)
Received: by 10.67.19.13 with SMTP id w13mr3299627ugi.1163795328103; Fri, 17
 Nov 2006 12:28:48 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id w40sm599506ugc.2006.11.17.12.28.47; Fri, 17 Nov
 2006 12:28:47 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> These are a few gitweb issues and features I'm currently working on 
>> (or plan working on).
>>
>> 1. New patchset view (commitdiff, blobdiff)
>>
>>  c. "Cache" git diff header, or the whole patch, or the whole patchset.
>>     It is enough to cache (write lines to "buffer"/"cache" array) up to
>>     the extended header "^index" line, which can be used to check if to
>>     go to the next dofftree "raw" line (or wven which of "raw" difftree
>>     lines this particular patch corresponds to). Does not require
>>     changes in diff core, and is less fragile, less susceptible to
>>     breakage.
> 
> This is the most appropriate.  Right now it is not independently
> controllable but it is not so inplausible for somebody to want
> to get non recursive view of 'raw' part along with textual diffs
> when running "--raw -p" diff and your solution c. is robust
> against even such changes.

What about the fact that git-diff -M is _not_ patch-compatibile;
does creating two patches for one difftree raw format line for
mode change/'T' status (I guess only for "type" mode changes, i.e.
file to/from symlink, file to/from directory) helps understanding
the change? If not, perhaps it would be better to introduce option
to not break the patch...
 
> I would probably not call that "caching" but keeping track of
> where you are, and you would need to know in which filepair you
> are in anyway when you want to implement links to blob view from
> the hunk header lines.

I'd say "buffering" rather than "caching". The problem is that
you have to read up to the "index <hash>..<hash>[ <mode>]" to
check if you have to go to the next raw difftree line or not.
And the info from difftree line is needed to hyperlink parts
of extended git diff header (and also to hyperlink parts of
patch).

>> 2. Difftree combined diff gitweb "raw" format
>>...
>> I have though about using one of the combined diff outputs for merge 
>> commits. The problem is how to represent the whatchanged part. Which 
>> parts of gitweb difftree output to leave? And what about the fact that 
>> we have raw output for -c/--combined diff format, but not for chunk 
>> simplifying --cc (compact combined) output?
> 
> I am not sure what's more useful to show there.  The part of the
> output shows "the list of files that have changed by this
> commit" for non-merge commits, so "the list of files that have
> changed in this merge" is what you would want to show, but there
> are three ways you can define "what changed" for a merge (see
> the message that explains --cc to linux@horizontal I sent
> yesterday).  I find "diff --name-status $it^1 $it" the most
> natural semantics for the most of the time, and that is what we
> do for --stat output.
> 
> If you want to treat all the parents equally, you could read
> from "diff-tree -c --raw $it" which would show list of files
> that needed file-level merges, along with the blob object names
> from all parents.

We should have whatchanged part corresponding to the patchset
part at least in "commitdiff" view, which means '-c' (and for
the time being perhaps mean '-c' also in patchset part). '--cc'
which uses '-c' for the raw part would be nice...

"Commit" view could use "diff --name-status $hash^1 $hash", 
(i.e. I think the same what it does now), even if it is not
compatibile with "commitdiff" view.

-- 
Jakub Narebski
