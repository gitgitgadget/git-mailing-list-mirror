X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Use git-show-ref instead of git-peek-remote
Date: Fri, 24 Nov 2006 23:35:15 +0100
Message-ID: <200611242335.15964.jnareb@gmail.com>
References: <11644056823095-git-send-email-jnareb@gmail.com> <7vhcwoa3mx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 24 Nov 2006 22:33:43 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=G3Yzsi1tgZ1U0WBxsBf7Vd8odVE0ALkN3e2pEs15DdCQ1XDRz6dINwifxhPUtTa2bvycpSSDpqQfs3cRxd5nRHUKOmd5DOmpxTe+wbWxyF2vrOzvdF35OraiOBerJY/j0KBpjlacKta+5ciKxtSl79L3UGrNkMb2cbWs4IqVyQA=
User-Agent: KMail/1.9.3
In-Reply-To: <7vhcwoa3mx.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32244>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gnjc2-0006NW-Pn for gcvg-git@gmane.org; Fri, 24 Nov
 2006 23:33:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934636AbWKXWdg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 17:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934638AbWKXWdg
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 17:33:36 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:65328 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S934636AbWKXWdf
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 17:33:35 -0500
Received: by ug-out-1314.google.com with SMTP id 44so777969uga for
 <git@vger.kernel.org>; Fri, 24 Nov 2006 14:33:34 -0800 (PST)
Received: by 10.66.232.10 with SMTP id e10mr7897227ugh.1164407613913; Fri, 24
 Nov 2006 14:33:33 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id k2sm9113571ugf.2006.11.24.14.33.33; Fri, 24 Nov
 2006 14:33:33 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Use "git show-ref --dereference" instead of "git peek-remote ." in

It should be 
   Use "git show-ref --dereference" instead of "git peek-remote <project>"

>> git_get_references. git-show-ref is faster than git-peek-remote; even
>> faster is reading info/refs file (if it exists), but the information
>> in info/refs can be stale.
> 
> More importantly, it is for dumb protocol transports, not for gitweb.

Yes, but if it is there, why not make use of it? Especially that it
is used only (I think) for refs markers, and not for anything important.
On the other side a bit of performance here doesn't matter much.

> You forgot to mention that you fixed the last place that
> directly used "$GIT" to invoke the command, bypassing sub
> git_cmd.  That is a consistency clean-up worth mentioning.

This is not fix, this is change of style. The style was to use
  git peek-remote $projectroot/$project
instead of equivalent
  git --git-dir=$projectroot/$project peek-remote .

We don't have this choice with git-show-ref.

On the other hand that makes all command invocation (except the one
used for getting git core version) pass through git_cmd() subroutine.

>> git-show-ref is available since v1.4.4; the output format is slightly
>> different than git-peek-remote output format.
> 
>> -		if ($line =~ m/^([0-9a-fA-F]{40})\trefs\/($type\/?[^\^]+)/) {
>> +		if ($line =~ m/^([0-9a-fA-F]{40}) refs\/($type\/?[^\^]+)/) {
> 
> I would rather do:
> 
> 	m|^([0-9a-f]{40})\srefs/($type/?[^^]+)|
> 
> which would catch both space and tab.

Feel free to do that (one nitpick: is [^^] more readable than [^\^]?).

Should I resend the patch?
-- 
Jakub Narebski
