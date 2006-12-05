X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] merge-recursive: configurable 'merge' program
Date: Tue, 5 Dec 2006 15:26:11 +0100
Message-ID: <200612051526.12636.jnareb@gmail.com>
References: <20061204235647.9BA8B139B0E@magnus.utsl.gen.nz> <200612051123.33210.jnareb@gmail.com> <Pine.LNX.4.63.0612051459380.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 5 Dec 2006 14:24:40 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=eEUQPBXU9wNQjzNEgEeqrOuq6dOfQSbFF5Nbq8Zw6PNp+vFJsWudxhuBlsz8BNakcpPzLQP/qWi1zw8MULwdv3EbogOiASG9CVlwiEmanflLttCSWaNMcLCcFRKgJyVY157SRRGYKhQktWw4b4rUM4RDQ0w63TPB72zgFQ0RbGE=
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0612051459380.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33343>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrbDf-0005jE-Hf for gcvg-git@gmane.org; Tue, 05 Dec
 2006 15:24:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937457AbWLEOYP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 09:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937443AbWLEOYO
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 09:24:14 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:48504 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S937376AbWLEOYN (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec
 2006 09:24:13 -0500
Received: by ug-out-1314.google.com with SMTP id 44so3341060uga for
 <git@vger.kernel.org>; Tue, 05 Dec 2006 06:24:09 -0800 (PST)
Received: by 10.67.19.17 with SMTP id w17mr13777085ugi.1165328648584; Tue, 05
 Dec 2006 06:24:08 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id x37sm9019973ugc.2006.12.05.06.24.07; Tue, 05 Dec
 2006 06:24:08 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Hi!

On Tue 5 Dec 2006 Johannes Schindelin wrote:
> 
> On Tue 5 Dec 2006 Jakub Narebski wrote:
> 
>> By the way is it [ed: xdl_merge()] replacement for RCS merge i.e. is 
>> it file-level merge tool merge.onefile rather than merge.tool?

Actually by "it" I meant here the value of merge.tool configuration
variable. I think the name of configuration variable should be
merge.onefile and not merge.tool, but this are just details.
 
> It is a C function but yes it does what RCS merge does.

And more if I remember correctly.

>> What happens if there are multiple merge [contents] conflicts: is 
>> merge.tool invoked in parallel for each conflict or is it waiting for 
>> earlier merge.tool to finish (well in which case we can always do set 
>> merge.tool to "<program> &")?
> 
> Recursively. It is merge-recursive so the merges are done sequentially. 
> (Have to be since the result of one merge is reused as one input for the 
> next merge.)

Hmmm... is there a way to pass merge.tool / merge.onefile program the
info if it is invoked in final stage (here it is nice to invoke graphical
merge tool to resolve conflicts in working area before commiting merge
result) and in recursive stage (here it would be better to leave conflict
markers to be resolved later)?

>> And is merge.tool invoked for recursive part of recursive merge 
>> strategy?
> 
> Yes.

Hmmm... would it be possible to use xdl_merge() for recursion, and
graphical merge tool for result? <Checks out earlier discussion>.
I think yes, because of exposing xdl_merge() in git-merge-onefile...

>> This merge startegy depended on resolving conflict markers i.e. had 
>> built-in knowledge of 'merge'/'diff3 -E' output.
> 
> No. git-merge-recursive never resolved conflict markers but treated them 
> as text.

Hmmm... I wonder if anyone get in real life example conflict markers
to be resolved (in final file)...

>> Besides it would be useful not only to spawn interactive merge tools 
>> but also to use mergers specific for file-type for example 3DM or 
>> xmlcmp tools for merging XML files.
> 
> If you need that write a wrapper script which detects the file type and 
> execs the corresponding merge program.

That was meant as an example why one might want to use 
merge.tool / merge.onefile feature.

-- 
Jakub Narebski
